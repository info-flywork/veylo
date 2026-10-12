/// Üstteki yatay “note / status” kartı — backend `noteId` ile eşleşir.
class ChatNote {
  const ChatNote({
    required this.id,
    required this.userId,
    required this.displayName,
    required this.statusText,
    required this.avatarUrl,
    this.isSelf = false,
    this.showAddBadge = false,
    this.isAi = false,
    this.username,
  });

  /// `GET /notes` satırı.
  factory ChatNote.fromApi(Map<String, dynamic> j, {bool isSelf = false}) {
    final user = j['user'] as Map<String, dynamic>? ?? const {};
    final id = user['id'] as String? ?? '';
    return ChatNote(
      id: 'note_$id',
      userId: id,
      displayName: (user['displayName'] ?? user['username'] ?? '') as String,
      statusText: j['text'] as String? ?? '',
      avatarUrl: (user['avatarUrl'] as String?) ?? '',
      isSelf: isSelf,
      isAi: user['isAi'] as bool? ?? false,
      username: user['username'] as String?,
    );
  }

  final String id;
  final String userId;
  final String displayName;
  final String statusText;

  /// Network URL veya `assets/...` yolu.
  final String avatarUrl;
  final bool isSelf;
  final bool showAddBadge;

  /// Veylo'nun AI karakteri ("AI" rozeti).
  final bool isAi;
  final String? username;
}
