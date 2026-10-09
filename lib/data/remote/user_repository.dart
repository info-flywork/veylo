import 'package:veylo/data/remote/api_client.dart';
import 'package:veylo/data/remote/session_store.dart';
import 'package:veylo/models/profile/me.dart';

class UsernameAvailability {
  const UsernameAvailability({
    required this.available,
    required this.suggestions,
  });

  final bool available;
  final List<String> suggestions;
}

class UserRepository {
  UserRepository._();

  static final UserRepository instance = UserRepository._();

  final _api = ApiClient.instance;

  Future<UsernameAvailability> usernameAvailability(String username) async {
    final res =
        await _api.get(
              '/users/username-available',
              query: {'username': username},
            )
            as Map;
    return UsernameAvailability(
      available: res['available'] as bool,
      suggestions: (res['suggestions'] as List).cast<String>(),
    );
  }

  /// Profil fotoğrafı (onboarding sırasında da çalışır). Güncel kullanıcıyı döner.
  Future<Me> uploadAvatar(String filePath) async {
    final res = await _api.upload('/media/avatar', filePath, method: 'PUT');
    final me = Me.fromJson(res as Map<String, dynamic>);
    SessionStore.instance.setMe(me);
    return me;
  }

  /// Edit Profile: sadece gönderilen alanlar güncellenir.
  Future<Me> updateProfile(Map<String, Object?> fields) async {
    final res = await _api.patch('/users/me', body: fields);
    final me = Me.fromJson(res as Map<String, dynamic>);
    SessionStore.instance.setMe(me);
    return me;
  }

  /// Çerçeveyi token ile satın alır (zaten sahipse sadece takar). Yetersizse 402.
  Future<void> purchaseBorder(String borderId) async {
    final res = await _api.post('/store/borders/$borderId/purchase') as Map;
    SessionStore.instance.updateTokenBalance((res['balance'] as num).toInt());
    await SessionStore.instance.refreshMe();
  }

  /// Sahip olunan çerçeveler ve fiyatlar.
  Future<List<({String id, int price, bool owned})>> borders() async {
    final res = await _api.get('/store/borders') as Map;
    return [
      for (final b in (res['items'] as List).cast<Map>())
        (
          id: b['id'] as String,
          price: (b['price'] as num).toInt(),
          owned: b['owned'] as bool,
        ),
    ];
  }

  /// gender: FEMALE | MALE | NON_BINARY | PREFER_NOT_TO_SAY
  Future<Me> completeOnboarding({
    required String fullName,
    required String username,
    required String gender,
    required List<String> interests,
    required String chatGoal,
  }) async {
    final res = await _api.post(
      '/users/me/onboarding',
      body: {
        'fullName': fullName,
        'username': username,
        'gender': gender,
        'interests': interests,
        'chatGoal': chatGoal,
      },
    );
    final me = Me.fromJson(res as Map<String, dynamic>);
    SessionStore.instance.setMe(me);
    return me;
  }
}
