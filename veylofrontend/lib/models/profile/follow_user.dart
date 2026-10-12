/// Follow listesi satırı — badge tipi local/mock.
enum FollowBadge { goldenDiamond, crown }

/// Sırala bottom sheet seçenekleri.
enum FollowSortFilter {
  /// En son takip ettiğim kişiler
  recent,
  /// Beni takip etmeyenler (ben takip ederim, onlar etmez)
  notFollowingMeBack,
  /// Benim takip etmediklerim (onlar takip eder, ben etmem)
  notFollowedByMe,
}

class FollowUser {
  const FollowUser({
    required this.id,
    required this.displayName,
    required this.avatarUrl,
    required this.badge,
    this.followsMe = true,
    this.iFollow = true,
    this.followedAt,
    this.username,
    this.isAi = false,
  });

  /// `GET /users/:id/followers|following` satırı. Rozet: profil çerçevesi alanlarda.
  factory FollowUser.fromApi(Map<String, dynamic> j) {
    final border = j['borderId'] as String?;
    return FollowUser(
      id: j['id'] as String,
      displayName: (j['displayName'] ?? j['username'] ?? '') as String,
      avatarUrl: (j['avatarUrl'] as String?) ?? '',
      badge: border == null
          ? null
          : (_premiumBorders.contains(border)
                ? FollowBadge.crown
                : FollowBadge.goldenDiamond),
      followsMe: j['followsMe'] as bool? ?? false,
      iFollow: j['iFollow'] as bool? ?? false,
      followedAt: DateTime.tryParse(j['followedAt'] as String? ?? ''),
      username: j['username'] as String?,
      isAi: j['isAi'] as bool? ?? false,
    );
  }

  /// En pahalı çerçeveler taç rozeti alır.
  static const _premiumBorders = {'phoenix', 'starlit', 'crimson', 'sapphire'};

  FollowUser copyWith({bool? iFollow}) => FollowUser(
    id: id,
    displayName: displayName,
    avatarUrl: avatarUrl,
    badge: badge,
    followsMe: followsMe,
    iFollow: iFollow ?? this.iFollow,
    followedAt: followedAt,
    username: username,
    isAi: isAi,
  );

  final String id;
  final String displayName;
  final String avatarUrl;
  /// Profil çerçevesi olan kullanıcıda rozet; yoksa null (rozet gösterilmez).
  final FollowBadge? badge;
  final String? username;
  final bool isAi;

  /// Karşı taraf beni takip ediyor mu.
  final bool followsMe;

  /// Ben onu takip ediyor muyum.
  final bool iFollow;

  /// Takip tarihi — “en son” sıralaması için.
  final DateTime? followedAt;
}
