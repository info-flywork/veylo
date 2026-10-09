/// Uygulama içi (yerel) bildirim metinleri — 12 dil.
/// slang dosyaları şimdilik yalnızca en/tr içerdiği ve eksik dillerde base (tr)
/// diline düştüğü için bu birkaç metin burada tutulur. Backend'deki
/// `src/i18n/notifications.ts` ile aynı metinlerdir.
class NotificationTexts {
  const NotificationTexts({
    required this.messageRequestTitle,
    required this.messageRequestBody,
    required this.photo,
    required this.voice,
    required this.channelName,
  });

  final String messageRequestTitle;
  final String Function(String name) messageRequestBody;
  final String photo;
  final String voice;

  /// Android bildirim ayarlarında görünen kanal adı.
  final String channelName;

  static NotificationTexts of(String code) => _texts[code] ?? _texts['en']!;

  static final Map<String, NotificationTexts> _texts = {
    'en': NotificationTexts(
      messageRequestTitle: 'New message request',
      messageRequestBody: (n) => '$n wants to chat with you',
      photo: '📷 Photo',
      voice: '🎤 Voice message',
      channelName: 'Messages',
    ),
    'tr': NotificationTexts(
      messageRequestTitle: 'Yeni mesaj isteği',
      messageRequestBody: (n) => '$n seninle sohbet etmek istiyor',
      photo: '📷 Fotoğraf',
      voice: '🎤 Sesli mesaj',
      channelName: 'Mesajlar',
    ),
    'de': NotificationTexts(
      messageRequestTitle: 'Neue Nachrichtenanfrage',
      messageRequestBody: (n) => '$n möchte mit dir chatten',
      photo: '📷 Foto',
      voice: '🎤 Sprachnachricht',
      channelName: 'Nachrichten',
    ),
    'it': NotificationTexts(
      messageRequestTitle: 'Nuova richiesta di messaggio',
      messageRequestBody: (n) => '$n vuole chattare con te',
      photo: '📷 Foto',
      voice: '🎤 Messaggio vocale',
      channelName: 'Messaggi',
    ),
    'fr': NotificationTexts(
      messageRequestTitle: 'Nouvelle demande de message',
      messageRequestBody: (n) => '$n veut discuter avec toi',
      photo: '📷 Photo',
      voice: '🎤 Message vocal',
      channelName: 'Messages',
    ),
    'ja': NotificationTexts(
      messageRequestTitle: '新しいメッセージリクエスト',
      messageRequestBody: (n) => '$nさんがあなたとチャットしたがっています',
      photo: '📷 写真',
      voice: '🎤 ボイスメッセージ',
      channelName: 'メッセージ',
    ),
    'es': NotificationTexts(
      messageRequestTitle: 'Nueva solicitud de mensaje',
      messageRequestBody: (n) => '$n quiere chatear contigo',
      photo: '📷 Foto',
      voice: '🎤 Mensaje de voz',
      channelName: 'Mensajes',
    ),
    'ru': NotificationTexts(
      messageRequestTitle: 'Новый запрос на переписку',
      messageRequestBody: (n) => '$n хочет пообщаться с тобой',
      photo: '📷 Фото',
      voice: '🎤 Голосовое сообщение',
      channelName: 'Сообщения',
    ),
    'ko': NotificationTexts(
      messageRequestTitle: '새 메시지 요청',
      messageRequestBody: (n) => '$n님이 대화를 원해요',
      photo: '📷 사진',
      voice: '🎤 음성 메시지',
      channelName: '메시지',
    ),
    'hi': NotificationTexts(
      messageRequestTitle: 'नया मैसेज अनुरोध',
      messageRequestBody: (n) => '$n आपसे चैट करना चाहते हैं',
      photo: '📷 फ़ोटो',
      voice: '🎤 वॉइस मैसेज',
      channelName: 'मैसेज',
    ),
    'pt': NotificationTexts(
      messageRequestTitle: 'Nova solicitação de mensagem',
      messageRequestBody: (n) => '$n quer conversar com você',
      photo: '📷 Foto',
      voice: '🎤 Mensagem de voz',
      channelName: 'Mensagens',
    ),
    'zh': NotificationTexts(
      messageRequestTitle: '新的消息请求',
      messageRequestBody: (n) => '$n 想和你聊天',
      photo: '📷 照片',
      voice: '🎤 语音消息',
      channelName: '消息',
    ),
  };
}
