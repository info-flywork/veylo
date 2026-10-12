/// Gönderim durumu: ekranda hemen gösterilir, sunucu onaylayınca `sent` olur.
enum ChatMessageStatus { sending, sent, failed }

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
    this.status = ChatMessageStatus.sent,
    this.senderId,
    this.senderName,
    this.senderAvatarUrl,
    this.senderBlurred = false,
    this.senderIsAi = false,
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
  final DateTime createdAt;
  final ChatMessageStatus status;

  /// Grup mesajında gönderen. Anonim üyede [senderId] null, ad maskeli, foto bulanık.
  final String? senderId;
  final String? senderName;
  final String? senderAvatarUrl;
  final bool senderBlurred;
  final bool senderIsAi;

  factory ChatMessage.fromJson(Map<String, dynamic> j) {
    final sender = j['sender'] as Map<String, dynamic>?;
    return ChatMessage(
      id: j['id'] as String?,
      seq: (j['seq'] as num?)?.toInt(),
      clientMsgId: (j['clientMsgId'] ?? j['id']) as String,
      isMine: j['isMine'] as bool? ?? false,
      type: j['type'] as String? ?? 'TEXT',
      body: j['body'] as String?,
      mediaUrl: j['mediaUrl'] as String?,
      createdAt:
          DateTime.tryParse(j['createdAt'] as String? ?? '')?.toLocal() ??
          DateTime.now(),
      senderId: sender?['id'] as String?,
      senderName: sender?['displayName'] as String?,
      senderAvatarUrl: sender?['avatarUrl'] as String?,
      senderBlurred: sender?['avatarBlurred'] as bool? ?? false,
      senderIsAi: sender?['isAi'] as bool? ?? false,
    );
  }

  ChatMessage copyWith({ChatMessageStatus? status}) => ChatMessage(
    id: id,
    seq: seq,
    clientMsgId: clientMsgId,
    isMine: isMine,
    type: type,
    body: body,
    mediaUrl: mediaUrl,
    createdAt: createdAt,
    status: status ?? this.status,
    senderId: senderId,
    senderName: senderName,
    senderAvatarUrl: senderAvatarUrl,
    senderBlurred: senderBlurred,
    senderIsAi: senderIsAi,
  );

  /// Balonda gösterilecek metin (görsel/ses için kısa etiket).
  String get displayText => switch (type) {
    'IMAGE' => '📷 Photo',
    'VOICE' => '🎤 Voice message',
    _ => body ?? '',
  };
}
