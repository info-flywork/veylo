import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veylo/models/profile/profile_user.dart';

/// Backend gelene kadar profil düzenlemelerini local tutar.
///
/// Uygulama yeniden açılınca SharedPreferences’ten yüklenir.
class LocalProfileStore extends ChangeNotifier {
  LocalProfileStore._();

  static final LocalProfileStore instance = LocalProfileStore._();

  static const _kBorderId = 'local_profile.border_id';
  static const _kDisplayName = 'local_profile.display_name';
  static const _kBio = 'local_profile.bio';

  SharedPreferences? _prefs;
  String? _borderId;
  String? _displayName;
  String? _bio;
  bool _ready = false;

  bool get isReady => _ready;
  String? get borderId => _borderId;
  String? get displayName => _displayName;
  String? get bio => _bio;

  Future<void> init() async {
    if (_ready) return;
    _prefs = await SharedPreferences.getInstance();
    _borderId = _prefs!.getString(_kBorderId);
    _displayName = _prefs!.getString(_kDisplayName);
    _bio = _prefs!.getString(_kBio);
    _ready = true;
    notifyListeners();
  }

  /// Mock / API kullanıcısına local override uygular.
  ProfileUser apply(ProfileUser base) {
    return ProfileUser(
      id: base.id,
      displayName: _displayName ?? base.displayName,
      username: base.username,
      avatarUrl: base.avatarUrl,
      bio: _bio ?? base.bio,
      likeCount: base.likeCount,
      followCount: base.followCount,
      followerCount: base.followerCount,
      tokenBalance: base.tokenBalance,
      isSelf: base.isSelf,
      borderId: base.isSelf ? (_borderId ?? base.borderId) : base.borderId,
      voiceIntroUrl: base.voiceIntroUrl,
    );
  }

  /// Çıkışta: bir sonraki kullanıcıya önceki kullanıcının yerel düzenlemeleri taşınmasın.
  Future<void> clear() async {
    _borderId = null;
    _displayName = null;
    _bio = null;
    final prefs = _prefs ?? await SharedPreferences.getInstance();
    _prefs = prefs;
    await prefs.remove(_kBorderId);
    await prefs.remove(_kDisplayName);
    await prefs.remove(_kBio);
    notifyListeners();
  }

  Future<void> setBorderId(String? id) async {
    _borderId = id;
    final prefs = _prefs ?? await SharedPreferences.getInstance();
    _prefs = prefs;
    if (id == null || id.isEmpty) {
      await prefs.remove(_kBorderId);
    } else {
      await prefs.setString(_kBorderId, id);
    }
    notifyListeners();
  }

  Future<void> setDisplayName(String name) async {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return;
    _displayName = trimmed;
    final prefs = _prefs ?? await SharedPreferences.getInstance();
    _prefs = prefs;
    await prefs.setString(_kDisplayName, trimmed);
    notifyListeners();
  }

  Future<void> setBio(String value) async {
    _bio = value;
    final prefs = _prefs ?? await SharedPreferences.getInstance();
    _prefs = prefs;
    await prefs.setString(_kBio, value);
    notifyListeners();
  }

  /// Edit Profile Save — birden fazla alanı tek seferde yazar.
  Future<void> patch({
    String? displayName,
    String? bio,
    String? borderId,
    bool clearBorder = false,
  }) async {
    final prefs = _prefs ?? await SharedPreferences.getInstance();
    _prefs = prefs;

    if (displayName != null) {
      final trimmed = displayName.trim();
      if (trimmed.isNotEmpty) {
        _displayName = trimmed;
        await prefs.setString(_kDisplayName, trimmed);
      }
    }
    if (bio != null) {
      _bio = bio;
      await prefs.setString(_kBio, bio);
    }
    if (clearBorder) {
      _borderId = null;
      await prefs.remove(_kBorderId);
    } else if (borderId != null) {
      _borderId = borderId;
      await prefs.setString(_kBorderId, borderId);
    }
    notifyListeners();
  }
}
