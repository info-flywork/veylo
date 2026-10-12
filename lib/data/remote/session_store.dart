import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veylo/core/config/app_config.dart';
import 'package:veylo/data/local/local_profile_store.dart';
import 'package:veylo/data/remote/api_client.dart';
import 'package:veylo/data/remote/chat_store.dart';
import 'package:veylo/data/remote/discover_store.dart';
import 'package:veylo/data/remote/group_store.dart';
import 'package:veylo/data/remote/note_store.dart';
import 'package:veylo/data/remote/push_service.dart';
import 'package:veylo/data/remote/vibe_store.dart';
import 'package:veylo/models/profile/me.dart';

/// Girişten sonra nereye gidileceği.
enum SessionStatus { signedOut, needsOnboarding, ready }

/// Kullanıcı girişi iptal etti (hata gösterilmez).
class SignInCancelled implements Exception {
  const SignInCancelled();
}

/// Oturum: Firebase girişi + backend kullanıcısı (`Me`).
class SessionStore extends ChangeNotifier {
  SessionStore._();

  static final SessionStore instance = SessionStore._();

  static const _kDevUser = 'session.dev_user';
  static const _kInstalled = 'session.installed';

  final _api = ApiClient.instance;
  Me? _me;
  bool _googleReady = false;

  Me? get me => _me;

  SessionStatus get status {
    if (_me == null) return SessionStatus.signedOut;
    return _me!.onboardingCompleted
        ? SessionStatus.ready
        : SessionStatus.needsOnboarding;
  }

  /// Uygulama açılışı: Firebase'de oturum varsa backend kullanıcısını yükler.
  /// Ağ hatasında ApiException fırlatır (oturum silinmez).
  Future<SessionStatus> restore() async {
    await _signOutIfFreshInstall();
    if (kDebugMode && ApiClient.devUser == null) {
      ApiClient.devUser = (await SharedPreferences.getInstance()).getString(
        _kDevUser,
      );
    }
    if (FirebaseAuth.instance.currentUser == null &&
        ApiClient.devUser == null) {
      return SessionStatus.signedOut;
    }
    try {
      await _createSession();
    } on ApiException catch (e) {
      if (e.status == 401 || e.status == 403) {
        await signOut();
        return SessionStatus.signedOut;
      }
      rethrow;
    }
    return status;
  }

  /// iOS'ta Firebase oturumu Keychain'de saklanır ve uygulama silinip yeniden
  /// yüklense de kalır. Yeni kurulumda kullanıcı girişsiz başlamalı.
  Future<void> _signOutIfFreshInstall() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(_kInstalled) == true) return;
    await FirebaseAuth.instance.signOut();
    await prefs.setBool(_kInstalled, true);
  }

  Future<SessionStatus> signInWithGoogle() async {
    final google = GoogleSignIn.instance;
    if (!_googleReady) {
      await google.initialize(serverClientId: AppConfig.googleServerClientId);
      _googleReady = true;
    }
    final GoogleSignInAccount account;
    try {
      account = await google.authenticate(scopeHint: const ['email']);
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        throw const SignInCancelled();
      }
      rethrow;
    }
    final idToken = account.authentication.idToken;
    if (idToken == null) throw const ApiException(code: 'GOOGLE_NO_ID_TOKEN');

    await FirebaseAuth.instance.signInWithCredential(
      GoogleAuthProvider.credential(idToken: idToken),
    );
    return _afterFirebaseSignIn();
  }

  /// Sadece debug: Firebase'siz test girişi (backend AUTH_DEV_BYPASS=true olmalı).
  /// Aynı ad her seferinde aynı test kullanıcısına girer.
  Future<SessionStatus> signInAsDev(String name) async {
    assert(kDebugMode);
    ApiClient.devUser = name;
    await (await SharedPreferences.getInstance()).setString(_kDevUser, name);
    return _afterFirebaseSignIn();
  }

  /// E-posta veya kullanıcı adı + şifre. Kullanıcı adıyla girişte e-posta istemciye
  /// hiç gelmez: backend şifreyi doğrular ve custom token döner.
  Future<SessionStatus> signInWithPassword(
    String identifier,
    String password,
  ) async {
    final auth = FirebaseAuth.instance;
    if (identifier.contains('@')) {
      await auth.signInWithEmailAndPassword(
        email: identifier,
        password: password,
      );
    } else {
      final res =
          await _api.post(
                '/auth/username-login',
                body: {
                  'username': identifier
                      .replaceFirst(RegExp(r'^@+'), '')
                      .toLowerCase(),
                  'password': password,
                },
              )
              as Map;
      await auth.signInWithCustomToken(res['customToken'] as String);
    }
    return _afterFirebaseSignIn();
  }

  /// "Create your account": Firebase'de e-posta/şifre hesabı + backend kullanıcısı.
  /// Kullanıcı adı profil oluşturmanın ilk adımında kaydedilir.
  Future<SessionStatus> registerWithEmail(String email, String password) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _afterFirebaseSignIn();
  }

  /// Şifre girişli hesap mı (Google/Apple değil).
  bool get hasPasswordLogin =>
      FirebaseAuth.instance.currentUser?.providerData.any(
        (p) => p.providerId == 'password',
      ) ??
      false;

  /// Firebase şifresini değiştirir. Oturum eskiyse `requires-recent-login` fırlatır.
  Future<void> changePassword(String newPassword) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null || !hasPasswordLogin) {
      throw const ApiException(code: 'SOCIAL_ACCOUNT');
    }
    await user.updatePassword(newPassword);
  }

  /// Yeni adrese doğrulama bağlantısı gönderir; onaylanınca e-posta değişir
  /// (backend bir sonraki oturumda günceller).
  Future<void> changeEmail(String newEmail) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null || !hasPasswordLogin) {
      throw const ApiException(code: 'SOCIAL_ACCOUNT');
    }
    await user.verifyBeforeUpdateEmail(newEmail);
  }

  Future<void> sendPasswordReset(String email) =>
      FirebaseAuth.instance.sendPasswordResetEmail(email: email);

  /// iOS'ta yerel Apple girişi (Firebase AppleAuthProvider).
  Future<SessionStatus> signInWithApple() async {
    final provider = AppleAuthProvider()
      ..addScope('email')
      ..addScope('name');
    try {
      await FirebaseAuth.instance.signInWithProvider(provider);
    } on FirebaseAuthException catch (e) {
      final text = '${e.code} ${e.message}';
      if (text.contains('cancel') || text.contains('1001')) {
        throw const SignInCancelled();
      }
      rethrow;
    }
    return _afterFirebaseSignIn();
  }

  Future<SessionStatus> _afterFirebaseSignIn() async {
    try {
      await _createSession();
    } catch (_) {
      // Backend'e kaydedilemediyse yarım oturum bırakma.
      await signOut();
      rethrow;
    }
    return status;
  }

  Future<void> _createSession() async {
    final res = await _api.post('/auth/session') as Map<String, dynamic>;
    setMe(Me.fromJson(res['user'] as Map<String, dynamic>));
  }

  Future<void> refreshMe() async {
    setMe(Me.fromJson(await _api.get('/users/me') as Map<String, dynamic>));
  }

  void setMe(Me? me) {
    _me = me;
    notifyListeners();
  }

  void updateTokenBalance(int balance) {
    if (_me == null) return;
    setMe(_me!.copyWith(tokenBalance: balance));
  }

  Future<void> signOut() async {
    // Cihaz kaydı silinirken hâlâ oturum token'ı gerekiyor.
    await PushService.instance.stop();
    _me = null;
    ChatStore.instance.stop();
    VibeStore.instance.clear();
    GroupStore.instance.clear();
    NoteStore.instance.clear();
    DiscoverStore.instance.clear();
    try {
      if (_googleReady) await GoogleSignIn.instance.signOut();
    } catch (_) {}
    await FirebaseAuth.instance.signOut();
    if (ApiClient.devUser != null) {
      ApiClient.devUser = null;
      await (await SharedPreferences.getInstance()).remove(_kDevUser);
    }
    await LocalProfileStore.instance.clear();
    notifyListeners();
  }

  /// Ayarlar > hesap silme talebi. Talep kaydedilir, oturum kapanır.
  Future<void> requestAccountDeletion(String? reason) async {
    await _api.post(
      '/users/me/deletion-request',
      body: {if (reason != null && reason.isNotEmpty) 'reason': reason},
    );
    await signOut();
  }
}
