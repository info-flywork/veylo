/// Profil ekranı kullanıcı özeti — backend alanlarıyla eşleşir.
class ProfileUser {
  const ProfileUser({
    required this.id,
    required this.displayName,
    required this.avatarUrl,
    required this.bio,
    required this.likeCount,
    required this.followCount,
    required this.followerCount,
    this.username,
    this.tokenBalance = 0,
    this.isSelf = false,
    this.borderId,
    this.iFollow = false,
    this.followsMe = false,
    this.isAi = false,
    this.loaded = false,
    this.voiceIntroUrl,
  });

  /// `GET /users/:id` cevabı.
  factory ProfileUser.fromPublicJson(Map<String, dynamic> j) {
    final stats = j['stats'] as Map<String, dynamic>? ?? const {};
    final details = j['details'] as Map<String, dynamic>?;
    return ProfileUser(
      id: j['id'] as String,
      displayName:
          (j['displayName'] as String?) ?? (j['username'] as String?) ?? '',
      username: j['username'] as String?,
      avatarUrl: (j['avatarUrl'] as String?) ?? '',
      bio: (j['bio'] as String?) ?? '',
      likeCount: (stats['likeCount'] as num?)?.toInt() ?? 0,
      followCount: (stats['followingCount'] as num?)?.toInt() ?? 0,
      followerCount: (stats['followerCount'] as num?)?.toInt() ?? 0,
      borderId: j['borderId'] as String?,
      iFollow: j['iFollow'] as bool? ?? false,
      followsMe: j['followsMe'] as bool? ?? false,
      isAi: j['isAi'] as bool? ?? false,
      loaded: true,
      voiceIntroUrl: details?['voiceIntroUrl'] as String?,
    );
  }

  ProfileUser copyWith({bool? iFollow, int? followerCount}) => ProfileUser(
    id: id,
    displayName: displayName,
    avatarUrl: avatarUrl,
    bio: bio,
    likeCount: likeCount,
    followCount: followCount,
    followerCount: followerCount ?? this.followerCount,
    username: username,
    tokenBalance: tokenBalance,
    isSelf: isSelf,
    borderId: borderId,
    iFollow: iFollow ?? this.iFollow,
    followsMe: followsMe,
    isAi: isAi,
    loaded: loaded,
    voiceIntroUrl: voiceIntroUrl,
  );

  final String id;
  final String displayName;
  /// `@handle` — başkasının profilinde ismin altında.
  final String? username;
  /// Network URL veya `assets/...` yolu.
  final String avatarUrl;
  final String bio;
  final int likeCount;
  final int followCount;
  final int followerCount;
  final int tokenBalance;
  final bool isSelf;
  /// Dekoratif çerçeve id (`ProfileBorder.catalog`) — null = yok.
  final String? borderId;

  /// Ben onu takip ediyorum / o beni takip ediyor.
  final bool iFollow;
  final bool followsMe;

  /// Veylo'nun AI karakteri ("AI" rozeti).
  final bool isAi;

  /// Sunucudan yüklendi (false: ekran açılırken eldeki özet).
  final bool loaded;

  /// Profilde paylaşılan ses kaydı. Yoksa profilde gösterilmez.
  final String? voiceIntroUrl;
}
