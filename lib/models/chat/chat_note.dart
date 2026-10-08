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
  });

  final String id;
  final String userId;
  final String displayName;
  final String statusText;
  /// Network URL veya `assets/...` yolu.
  final String avatarUrl;
  final bool isSelf;
  final bool showAddBadge;
}
