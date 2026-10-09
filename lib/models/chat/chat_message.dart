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

  factory ChatMessage.fromJson(Map<String, dynamic> j) {
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
  );

  /// Balonda gösterilecek metin (görsel/ses için kısa etiket).
  String get displayText => switch (type) {
    'IMAGE' => '📷 Photo',
    'VOICE' => '🎤 Voice message',
    _ => body ?? '',
  };
}
