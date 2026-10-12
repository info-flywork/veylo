import 'package:veylo/core/assets/app_assets.dart';

/// Vibes akışındaki tek kart (`GET /vibes`).
class VibePost {
  const VibePost({
    required this.id,
    required this.name,
    required this.body,
    required this.likeCount,
    required this.createdAt,
    this.avatarUrl,
    this.authorId,
    this.username,
    this.blurred = false,
    this.likedByMe = false,
    this.isMine = false,
    this.isAi = false,
  });

  final String id;
  final String name;
  final String body;
  final int likeCount;
  final DateTime createdAt;

  /// Anonim vibe'da sunucunun bulanık önizlemesi (yoksa null).
  final String? avatarUrl;

  /// Anonim vibe'da null: yazarın kimliği istemciye gelmez.
  final String? authorId;
  final String? username;
  final bool blurred;
  final bool likedByMe;
  final bool isMine;

  /// Yazar Veylo'nun AI karakteri ("AI" rozeti).
  final bool isAi;

  /// Avatar widget'ları için: fotoğraf yoksa varsayılan görsel.
  String get avatarAsset => (avatarUrl == null || avatarUrl!.isEmpty)
      ? AppAssets.strangerAvatar
      : avatarUrl!;

  /// Kartta gösterilen tarih (ör. "18 Feb 2026").
  String get dateLabel {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', //
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    final d = createdAt;
    return '${d.day} ${months[d.month - 1]} ${d.year}';
  }

  factory VibePost.fromJson(Map<String, dynamic> j) {
    final author = j['author'] as Map<String, dynamic>? ?? const {};
    return VibePost(
      id: j['id'] as String,
      name: author['displayName'] as String? ?? '',
      body: j['body'] as String? ?? '',
      likeCount: (j['likeCount'] as num?)?.toInt() ?? 0,
      createdAt:
          DateTime.tryParse(j['createdAt'] as String? ?? '')?.toLocal() ??
          DateTime.now(),
      avatarUrl: author['avatarUrl'] as String?,
      authorId: author['id'] as String?,
      username: author['username'] as String?,
      blurred: author['avatarBlurred'] as bool? ?? false,
      likedByMe: j['likedByMe'] as bool? ?? false,
      isMine: j['isMine'] as bool? ?? false,
      isAi: author['isAi'] as bool? ?? false,
    );
  }

  VibePost copyWith({int? likeCount, bool? likedByMe}) => VibePost(
    id: id,
    name: name,
    body: body,
    likeCount: likeCount ?? this.likeCount,
    createdAt: createdAt,
    avatarUrl: avatarUrl,
    authorId: authorId,
    username: username,
    blurred: blurred,
    likedByMe: likedByMe ?? this.likedByMe,
    isMine: isMine,
    isAi: isAi,
  );
}
