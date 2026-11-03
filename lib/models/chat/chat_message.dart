/// Gönderim durumu: ekranda hemen gösterilir, sunucu onaylayınca `sent` olur.
enum ChatMessageStatus { sending, sent, failed }

/// Mesaj tepkisi özeti (emoji + sayı).
class ChatReaction {
  const ChatReaction({
    required this.emoji,
    required this.count,
    this.mine = false,
  });

  final String emoji;
  final int count;
  final bool mine;

  factory ChatReaction.fromJson(Map<String, dynamic> j) => ChatReaction(
    emoji: j['emoji'] as String? ?? '',
    count: (j['count'] as num?)?.toInt() ?? 0,
    mine: j['mine'] as bool? ?? false,
  );
}

/// Yanıtlanan mesajın kısa önizlemesi.
class ChatReplyPreview {
  const ChatReplyPreview({
    required this.id,
    required this.type,
    this.body,
    this.isMine = false,
  });

  final String id;
  final String type;
  final String? body;
  final bool isMine;

  factory ChatReplyPreview.fromJson(Map<String, dynamic> j) => ChatReplyPreview(
    id: j['id'] as String,
    type: j['type'] as String? ?? 'TEXT',
    body: j['body'] as String?,
    isMine: j['isMine'] as bool? ?? false,
  );
}

/// Sohbet mesajı (`/conversations/:id/messages` ve socket `message:new`).
class ChatMessage {
  const ChatMessage({
    required this.clientMsgId,
    required this.isMine,
    required this.createdAt,
    this.id,
    this.seq,
    this.type = 'TEXT',
    this.body,
    this.mediaUrl,
    this.mediaId,
    this.status = ChatMessageStatus.sent,
    this.senderId,
    this.senderName,
    this.senderAvatarUrl,
    this.senderBlurred = false,
    this.senderIsAi = false,
    this.editedAt,
    this.replyTo,
    this.replyToId,
    this.reactions = const [],
  });

  /// Sunucu kaydı oluşmadan (gönderiliyor) null.
  final String? id;
  final int? seq;

  /// Kendi mesajlarımda istemcinin ürettiği id; tekrar gönderimde aynı kalır.
  final String clientMsgId;
  final bool isMine;
  final String type;
  final String? body;
  final String? mediaUrl;

  /// Yükleme bitince sunucunun verdiği id. Gönderim yarım kalırsa tekrar yüklenmez.
  final String? mediaId;
  final DateTime createdAt;
  final ChatMessageStatus status;

  /// Grup mesajında gönderen. Anonim üyede [senderId] null, ad maskeli, foto bulanık.
  final String? senderId;
  final String? senderName;
  final String? senderAvatarUrl;
  final bool senderBlurred;
  final bool senderIsAi;

  final DateTime? editedAt;
  final ChatReplyPreview? replyTo;

  /// Gönderilirken seçilen yanıt hedefi (henüz sunucu onayı yokken).
  final String? replyToId;
  final List<ChatReaction> reactions;

  factory ChatMessage.fromJson(Map<String, dynamic> j) {
    final sender = j['sender'] as Map<String, dynamic>?;
    final reply = j['replyTo'] as Map<String, dynamic>?;
    final rawReactions = j['reactions'] as List? ?? const [];
    return ChatMessage(
      id: j['id'] as String?,
      seq: (j['seq'] as num?)?.toInt(),
      clientMsgId: (j['clientMsgId'] ?? j['id']) as String,
      isMine: j['isMine'] as bool? ?? false,
      type: j['type'] as String? ?? 'TEXT',
      body: j['body'] as String?,
      mediaUrl: j['mediaUrl'] as String?,
      mediaId: j['mediaId'] as String?,
      createdAt:
          DateTime.tryParse(j['createdAt'] as String? ?? '')?.toLocal() ??
          DateTime.now(),
      senderId: sender?['id'] as String?,
      senderName: sender?['displayName'] as String?,
      senderAvatarUrl: sender?['avatarUrl'] as String?,
      senderBlurred: sender?['avatarBlurred'] as bool? ?? false,
      senderIsAi: sender?['isAi'] as bool? ?? false,
      editedAt: DateTime.tryParse(j['editedAt'] as String? ?? '')?.toLocal(),
      replyTo: reply == null
          ? null
          : ChatReplyPreview.fromJson(Map<String, dynamic>.from(reply)),
      replyToId: reply?['id'] as String?,
      reactions: [
        for (final r in rawReactions)
          if (r is Map)
            ChatReaction.fromJson(Map<String, dynamic>.from(r)),
      ],
    );
  }

  ChatMessage copyWith({
    ChatMessageStatus? status,
    String? mediaUrl,
    String? mediaId,
    String? body,
    DateTime? editedAt,
    List<ChatReaction>? reactions,
    ChatReplyPreview? replyTo,
    String? replyToId,
    bool clearReply = false,
  }) => ChatMessage(
    id: id,
    seq: seq,
    clientMsgId: clientMsgId,
    isMine: isMine,
    type: type,
    body: body ?? this.body,
    mediaUrl: mediaUrl ?? this.mediaUrl,
    mediaId: mediaId ?? this.mediaId,
    createdAt: createdAt,
    status: status ?? this.status,
    senderId: senderId,
    senderName: senderName,
    senderAvatarUrl: senderAvatarUrl,
    senderBlurred: senderBlurred,
    senderIsAi: senderIsAi,
    editedAt: editedAt ?? this.editedAt,
    replyTo: clearReply ? null : (replyTo ?? this.replyTo),
    replyToId: clearReply ? null : (replyToId ?? this.replyToId),
    reactions: reactions ?? this.reactions,
  );

  /// Balonda gösterilecek metin (görsel/ses için kısa etiket).
  String get displayText => switch (type) {
    'IMAGE' => '📷 Photo',
    'VOICE' => '🎤 Voice message',
    _ => body ?? '',
  };

  bool get canEdit =>
      isMine &&
      type == 'TEXT' &&
      id != null &&
      status == ChatMessageStatus.sent &&
      !(body?.startsWith('sticker:') ?? false);
}

/// Hızlı tepki emojileri (sunucu whitelist ile aynı).
const kChatReactionEmojis = ['❤️', '😂', '😮', '😢', '😡', '👍'];
