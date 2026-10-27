import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/data/remote/session_store.dart';
import 'package:veylo/models/profile/profile_user.dart';

class ProfileMockRepository {
  const ProfileMockRepository._();

  static const _bio =
      'Vintage fashion, Comoc-con, Fashion, Drawing, Art, Manga';

  /// Giriş yapan kullanıcı (backend). Oturum yoksa (önizleme/test) mock "Alex".
  static ProfileUser currentUser() {
    final me = SessionStore.instance.me;
    if (me == null) return _mockSelf();
    return ProfileUser(
      id: me.id,
      displayName: me.displayName ?? me.username ?? '',
      username: me.username,
      // Boş URL → avatar bileşeni yer tutucu ikon gösterir.
      avatarUrl: me.avatarUrl ?? '',
      bio: me.bio ?? '',
      likeCount: me.likeCount,
      followCount: me.followingCount,
      followerCount: me.followerCount,
      tokenBalance: me.tokenBalance,
      isSelf: true,
      borderId: me.borderId,
      voiceIntroUrl: me.voiceIntroUrl,
    );
  }

  static ProfileUser _mockSelf() => const ProfileUser(
        id: 'user_self',
        displayName: 'Alex',
        username: 'alex',
        avatarUrl: AppAssets.profileMaleAvatar,
        bio: _bio,
        likeCount: 200,
        followCount: 16,
        followerCount: 120,
        tokenBalance: 125,
        isSelf: true,
      );

  static ProfileUser victoria() => const ProfileUser(
        id: 'user_victoria',
        displayName: 'Victoria Blue',
        username: 'victoria1',
        avatarUrl: AppAssets.fakePerson05,
        bio: _bio,
        likeCount: 200,
        followCount: 16,
        followerCount: 120,
        isSelf: false,
      );

  static ProfileUser _peer({
    required String id,
    required String displayName,
    required String avatarUrl,
    String? username,
  }) {
    return ProfileUser(
      id: id,
      displayName: displayName,
      username: username ??
          displayName.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '_'),
      avatarUrl: avatarUrl,
      bio: _bio,
      likeCount: 120,
      followCount: 40,
      followerCount: 80,
      isSelf: false,
    );
  }

  static final Map<String, ProfileUser> _byId = {
    'user_self': currentUser(),
    'user_victoria': victoria(),
    'user_julia': _peer(
      id: 'user_julia',
      displayName: 'Julia Ivanova',
      avatarUrl: AppAssets.fakePerson06,
      username: 'julia_ivanova',
    ),
    'user_sona': _peer(
      id: 'user_sona',
      displayName: 'Sona Iglesias',
      avatarUrl: AppAssets.fakePerson03,
      username: 'sona',
    ),
    'user_jessica_blues': _peer(
      id: 'user_jessica_blues',
      displayName: 'Jessica Blues',
      avatarUrl: AppAssets.fakePerson05,
      username: 'jessica_blues',
    ),
    'user_jessica': _peer(
      id: 'user_jessica',
      displayName: 'Jessica',
      avatarUrl: AppAssets.fakePerson05,
      username: 'jessica',
    ),
    'user_lyra': _peer(
      id: 'user_lyra',
      displayName: 'Lyra',
      avatarUrl: AppAssets.fakePerson01,
      username: 'lyra',
    ),
    'user_sarah': _peer(
      id: 'user_sarah',
      displayName: 'Sarah',
      avatarUrl: AppAssets.fakePerson07,
      username: 'sarah',
    ),
    'user_ella': _peer(
      id: 'user_ella',
      displayName: 'Ella',
      avatarUrl: AppAssets.fakePerson02,
      username: 'ella',
    ),
    'user_mia': _peer(
      id: 'user_mia',
      displayName: 'Mia',
      avatarUrl: AppAssets.fakePerson04,
      username: 'mia',
    ),
    'user_clara': _peer(
      id: 'user_clara',
      displayName: 'Clara',
      avatarUrl: AppAssets.fakePerson06,
      username: 'clara',
    ),
    'user_anon_1': _peer(
      id: 'user_anon_1',
      displayName: 'Julia Ivanova',
      avatarUrl: AppAssets.fakePerson01,
      username: 'julia_ivanova',
    ),
    'user_anon_2': _peer(
      id: 'user_anon_2',
      displayName: 'Anonymous',
      avatarUrl: AppAssets.fakePerson07,
      username: 'mrdrls',
    ),
    'user_reveal': _peer(
      id: 'user_reveal',
      displayName: 'Maya Ross',
      avatarUrl: AppAssets.fakePerson08,
      username: 'maya_ross',
    ),
    'f1': _peer(
      id: 'f1',
      displayName: 'Julia Ivanova',
      avatarUrl: AppAssets.fakePerson01,
    ),
    'f2': _peer(
      id: 'f2',
      displayName: 'Sona Iglesias',
      avatarUrl: AppAssets.fakePerson02,
    ),
    'f3': _peer(
      id: 'f3',
      displayName: 'Jessica Blues',
      avatarUrl: AppAssets.fakePerson05,
    ),
    'f4': _peer(
      id: 'f4',
      displayName: 'Victoria',
      avatarUrl: AppAssets.fakePerson06,
    ),
    'r1': _peer(
      id: 'r1',
      displayName: 'Julia Ivanova',
      avatarUrl: AppAssets.fakePerson01,
    ),
    'r2': _peer(
      id: 'r2',
      displayName: 'Sona Iglesias',
      avatarUrl: AppAssets.fakePerson02,
    ),
    'r3': _peer(
      id: 'r3',
      displayName: 'Jessica Blues',
      avatarUrl: AppAssets.fakePerson05,
    ),
    'r4': _peer(
      id: 'r4',
      displayName: 'Victoria',
      avatarUrl: AppAssets.fakePerson06,
    ),
  };

  static ProfileUser? byId(String? id) {
    if (id == null || id.isEmpty) return null;
    if (id == 'user_self' || id == SessionStore.instance.me?.id) {
      return currentUser();
    }
    return _byId[id];
  }

  /// Id / isim / avatar ile mock profil bulur; yoksa sentetik üretir.
  static ProfileUser resolve({
    String? id,
    String? displayName,
    String? avatarUrl,
    String? username,
  }) {
    final byIdHit = byId(id);
    if (byIdHit != null) return byIdHit;

    final nameKey = displayName?.trim().toLowerCase();
    if (nameKey != null && nameKey.isNotEmpty) {
      for (final user in _byId.values) {
        if (user.displayName.toLowerCase() == nameKey) return user;
        if (user.username?.toLowerCase() == nameKey) return user;
        // "Victoria" → "Victoria Blue"
        if (user.displayName.toLowerCase().startsWith(nameKey)) return user;
      }
    }

    if (avatarUrl != null && avatarUrl.isNotEmpty) {
      for (final user in _byId.values) {
        if (user.avatarUrl == avatarUrl) return user;
      }
    }

    final syntheticId =
        id ?? 'user_${(displayName ?? avatarUrl ?? 'unknown').hashCode.abs()}';
    final self = syntheticId == 'user_self';
    return ProfileUser(
      id: syntheticId,
      displayName: (displayName?.trim().isNotEmpty ?? false)
          ? displayName!.trim()
          : 'User',
      username: username,
      avatarUrl: avatarUrl ?? AppAssets.fakePerson01,
      bio: _bio,
      likeCount: 50,
      followCount: 10,
      followerCount: 20,
      isSelf: self,
    );
  }

  /// Profil media grid — sekme adına göre mock görseller.
  static List<String> mediaFor(String tab) {
    switch (tab) {
      case 'posts':
        return const [
          AppAssets.fakePerson01,
          AppAssets.fakePerson02,
          AppAssets.fakePerson04,
        ];
      case 'saved':
        return const [
          AppAssets.fakePerson05,
          AppAssets.fakePerson06,
          AppAssets.fakePerson07,
        ];
      case 'video':
      default:
        return const [
          AppAssets.fakePerson01,
          AppAssets.fakePerson08,
          AppAssets.fakePerson04,
        ];
    }
  }
}
