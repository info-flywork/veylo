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
  });

  final String id;
  final String displayName;
  final String avatarUrl;
  final FollowBadge badge;

  /// Karşı taraf beni takip ediyor mu.
  final bool followsMe;

  /// Ben onu takip ediyor muyum.
  final bool iFollow;

  /// Takip tarihi — “en son” sıralaması için.
  final DateTime? followedAt;
}
