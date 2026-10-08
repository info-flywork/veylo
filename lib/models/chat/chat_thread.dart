/// Sohbet listesi satırı — backend `conversationId` ile eşleşir.
class ChatThread {
  const ChatThread({
    required this.id,
    required this.title,
    required this.lastMessagePreview,
    required this.avatarUrl,
    this.peerUserId,
    this.lastMessageAt,
    this.unreadCount = 0,
    bool isGroup = false,
    this.memberCount = 2,
    this.groupAvatarUrls,
    bool isAnonymous = false,
    this.maskedName,
    /// Karşı taraf kullanıcı adı (reveal waiting metni).
    this.peerUsername,
    int connectionProgress = 0,
    bool isOnline = false,
    /// Takip edilmeyen kişiden gelen mesaj — Approve / Block / Reject.
    bool isStrangerRequest = false,
  })  : _isGroup = isGroup,
        _isAnonymous = isAnonymous,
        _connectionProgress = connectionProgress,
        _isOnline = isOnline,
        _isStrangerRequest = isStrangerRequest;

  final String id;
  final String title;
  final String lastMessagePreview;
  final String avatarUrl;
  final String? peerUserId;
  final DateTime? lastMessageAt;
  final int unreadCount;
  final int memberCount;
  final List<String>? groupAvatarUrls;
  final String? maskedName;
  final String? peerUsername;

  final bool? _isGroup;
  final bool? _isAnonymous;
  final int? _connectionProgress;
  final bool? _isOnline;
  final bool? _isStrangerRequest;

  bool get isGroup => _isGroup ?? false;
  bool get isAnonymous => _isAnonymous ?? false;
  int get connectionProgress => _connectionProgress ?? 0;
  bool get isOnline => _isOnline ?? false;
  bool get isStrangerRequest => _isStrangerRequest ?? false;
}
