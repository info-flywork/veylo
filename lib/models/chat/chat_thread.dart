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
    this.status = 'ACCEPTED',
    this.isInitiator = false,
    this.revealed = false,
    this.myRevealConsent = false,
    this.peerRevealConsent = false,
    this.pinned = false,
    this.muted = false,
    this.peerLastReadSeq,
    this.contextQuote,
    this.groupIsPrivate = false,
    this.groupRole,
    this.peerIsAi = false,
    this.peerAvatarBlurred = true,
  }) : _isGroup = isGroup,
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

  /// PENDING (istek) | ACCEPTED | REJECTED
  final String status;

  /// Sohbeti ben başlattım (istek bende "gönderildi" olarak görünür).
  final bool isInitiator;

  /// Anonim sohbette iki taraf da onay verdi, profiller açıldı.
  final bool revealed;
  final bool myRevealConsent;
  final bool peerRevealConsent;
  final bool pinned;
  final bool muted;

  /// Karşı tarafın okuduğu son mesaj (görüldü). Kısıtlandıysam null.
  final int? peerLastReadSeq;

  /// Vibes'tan başladıysa paylaşım metni.
  final String? contextQuote;

  /// Grup: katılmak için yönetici onayı gerekiyor mu.
  final bool groupIsPrivate;

  /// Gruptaki rolüm: OWNER | ADMIN | MEMBER (grup değilse null).
  final String? groupRole;

  /// Karşı taraf Veylo'nun AI karakteri (anonimken de bilinir, "AI" rozeti).
  final bool peerIsAi;

  /// Anonim sohbette fotoğraf bulanık kalsın. Tam profil onayında false.
  final bool peerAvatarBlurred;

  bool get isGroupAdmin => groupRole == 'OWNER' || groupRole == 'ADMIN';

  /// Backend'de karşılığı olmayan yerel sohbet (ör. Vibes demo akışı).
  bool get isLocalOnly => id.startsWith('vibe_');

  /// `GET /conversations` satırı → liste modeli.
  factory ChatThread.fromApi(Map<String, dynamic> j) {
    final peer = j['peer'] as Map<String, dynamic>?;
    final connection = j['connection'] as Map<String, dynamic>?;
    final last = j['lastMessage'] as Map<String, dynamic>?;
    final group = j['group'] as Map<String, dynamic>?;
    final isAnonymous = j['type'] == 'ANONYMOUS';
    final revealed = connection?['revealed'] as bool? ?? false;
    final title =
        (j['title'] as String?) ?? (peer?['displayName'] as String?) ?? '';
    return ChatThread(
      id: j['id'] as String,
      title: title,
      lastMessagePreview: (last?['preview'] as String?) ?? '',
      avatarUrl: (peer?['avatarUrl'] as String?) ?? '',
      peerUserId: peer?['id'] as String?,
      peerUsername: peer?['username'] as String?,
      lastMessageAt: DateTime.tryParse(last?['at'] as String? ?? '')?.toLocal(),
      unreadCount: (j['unreadCount'] as num?)?.toInt() ?? 0,
      isGroup: j['type'] == 'GROUP',
      memberCount: (j['memberCount'] as num?)?.toInt() ?? 2,
      groupAvatarUrls: (group?['avatars'] as List?)?.cast<String>(),
      groupIsPrivate: group?['isPrivate'] as bool? ?? false,
      groupRole: group?['myRole'] as String?,
      peerIsAi: peer?['isAi'] as bool? ?? false,
      peerAvatarBlurred: peer?['avatarBlurred'] != false,
      // Profiller açılınca normal sohbet gibi gösterilir.
      isAnonymous: isAnonymous && !revealed,
      maskedName: isAnonymous && !revealed ? title : null,
      connectionProgress: (connection?['progress'] as num?)?.toInt() ?? 0,
      isOnline: j['isOnline'] as bool? ?? false,
      isStrangerRequest: j['isRequest'] as bool? ?? false,
      status: j['status'] as String? ?? 'ACCEPTED',
      isInitiator: j['isInitiator'] as bool? ?? false,
      revealed: revealed,
      myRevealConsent: connection?['myConsent'] as bool? ?? false,
      peerRevealConsent: connection?['peerConsent'] as bool? ?? false,
      pinned: j['pinned'] as bool? ?? false,
      muted: j['muted'] as bool? ?? false,
      peerLastReadSeq: (j['peerLastReadSeq'] as num?)?.toInt(),
      contextQuote: j['contextQuote'] as String?,
    );
  }

  ChatThread copyWith({
    bool? isOnline,
    int? peerLastReadSeq,
    int? unreadCount,
  }) => ChatThread(
    id: id,
    title: title,
    lastMessagePreview: lastMessagePreview,
    avatarUrl: avatarUrl,
    peerUserId: peerUserId,
    lastMessageAt: lastMessageAt,
    unreadCount: unreadCount ?? this.unreadCount,
    isGroup: isGroup,
    memberCount: memberCount,
    groupAvatarUrls: groupAvatarUrls,
    isAnonymous: isAnonymous,
    maskedName: maskedName,
    peerUsername: peerUsername,
    connectionProgress: connectionProgress,
    isOnline: isOnline ?? this.isOnline,
    isStrangerRequest: isStrangerRequest,
    status: status,
    isInitiator: isInitiator,
    revealed: revealed,
    myRevealConsent: myRevealConsent,
    peerRevealConsent: peerRevealConsent,
    pinned: pinned,
    muted: muted,
    peerLastReadSeq: peerLastReadSeq ?? this.peerLastReadSeq,
    contextQuote: contextQuote,
    groupIsPrivate: groupIsPrivate,
    groupRole: groupRole,
    peerIsAi: peerIsAi,
    peerAvatarBlurred: peerAvatarBlurred,
  );

  bool get isGroup => _isGroup ?? false;
  bool get isAnonymous => _isAnonymous ?? false;
  int get connectionProgress => _connectionProgress ?? 0;
  bool get isOnline => _isOnline ?? false;
  bool get isStrangerRequest => _isStrangerRequest ?? false;
}
