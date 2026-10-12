/// Discover gönderisi (`/posts`).
class Post {
  const Post({
    required this.id,
    required this.mediaUrl,
    required this.thumbUrl,
    required this.authorId,
    required this.authorName,
    required this.createdAt,
    this.authorUsername,
    this.authorAvatarUrl,
    this.authorIsAi = false,
    this.iFollowAuthor,
    this.caption,
    this.likeCount = 0,
    this.commentCount = 0,
    this.viewCount,
    this.likedByMe = false,
    this.savedByMe = false,
    this.isMine = false,
    this.boosted = false,
    this.boostedUntil,
    this.isDraft = false,
  });

  final String id;
  final String mediaUrl;

  /// Izgara için küçük görsel.
  final String thumbUrl;
  final String authorId;
  final String authorName;
  final String? authorUsername;
  final String? authorAvatarUrl;
  final bool authorIsAi;

  /// Sadece gönderi detayında gelir.
  final bool? iFollowAuthor;
  final String? caption;
  final int likeCount;
  final int commentCount;

  /// Sadece kendi gönderimde.
  final int? viewCount;
  final bool likedByMe;
  final bool savedByMe;
  final bool isMine;
  final bool boosted;
  final DateTime? boostedUntil;
  final bool isDraft;
  final DateTime createdAt;

  /// Kartta gösterilen kullanıcı adı.
  String get handle => authorUsername ?? authorName;

  factory Post.fromJson(Map<String, dynamic> j) {
    final a = j['author'] as Map<String, dynamic>? ?? const {};
    return Post(
      id: j['id'] as String,
      mediaUrl: j['mediaUrl'] as String? ?? '',
      thumbUrl: (j['thumbUrl'] ?? j['mediaUrl'] ?? '') as String,
      authorId: a['id'] as String? ?? '',
      authorName: (a['displayName'] ?? a['username'] ?? '') as String,
      authorUsername: a['username'] as String?,
      authorAvatarUrl: a['avatarUrl'] as String?,
      authorIsAi: a['isAi'] as bool? ?? false,
      iFollowAuthor: a['iFollow'] as bool?,
      caption: j['caption'] as String?,
      likeCount: (j['likeCount'] as num?)?.toInt() ?? 0,
      commentCount: (j['commentCount'] as num?)?.toInt() ?? 0,
      viewCount: (j['viewCount'] as num?)?.toInt(),
      likedByMe: j['likedByMe'] as bool? ?? false,
      savedByMe: j['savedByMe'] as bool? ?? false,
      isMine: j['isMine'] as bool? ?? false,
      boosted: j['boosted'] as bool? ?? false,
      boostedUntil: DateTime.tryParse(j['boostedUntil'] as String? ?? '')?.toLocal(),
      isDraft: j['status'] == 'DRAFT',
      createdAt:
          DateTime.tryParse(j['createdAt'] as String? ?? '')?.toLocal() ??
          DateTime.now(),
    );
  }
}

/// Gönderi yorumu.
class PostComment {
  const PostComment({
    required this.id,
    required this.body,
    required this.createdAt,
    required this.authorName,
    this.authorId,
    this.authorUsername,
    this.authorAvatarUrl,
    this.authorIsAi = false,
    this.isMine = false,
  });

  final String id;
  final String body;
  final DateTime createdAt;
  final String authorName;
  final String? authorId;
  final String? authorUsername;
  final String? authorAvatarUrl;
  final bool authorIsAi;
  final bool isMine;

  factory PostComment.fromJson(Map<String, dynamic> j) {
    final a = j['author'] as Map<String, dynamic>? ?? const {};
    return PostComment(
      id: j['id'] as String,
      body: j['body'] as String? ?? '',
      createdAt:
          DateTime.tryParse(j['createdAt'] as String? ?? '')?.toLocal() ??
          DateTime.now(),
      authorId: a['id'] as String?,
      authorName: (a['displayName'] ?? a['username'] ?? '') as String,
      authorUsername: a['username'] as String?,
      authorAvatarUrl: a['avatarUrl'] as String?,
      authorIsAi: a['isAi'] as bool? ?? false,
      isMine: j['isMine'] as bool? ?? false,
    );
  }
}

/// Discover filtreleri (Filters sheet). Yaş ve mesafe şimdilik sunucuda uygulanmaz.
class DiscoverFilters {
  const DiscoverFilters({
    this.gender = 'everyone',
    this.interests = const {},
    this.onlineOnly = false,
  });

  /// everyone | women | men
  final String gender;
  final Set<String> interests;
  final bool onlineOnly;

  Map<String, String> toQuery() => {
    if (gender != 'everyone') 'gender': gender,
    if (interests.isNotEmpty) 'interests': interests.join(','),
    if (onlineOnly) 'onlineOnly': 'true',
  };
}
