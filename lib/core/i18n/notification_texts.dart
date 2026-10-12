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
    required this.groupRequestTitle,
    required this.groupRequestBody,
  });

  final String messageRequestTitle;
  final String Function(String name) messageRequestBody;
  final String photo;
  final String voice;

  /// Android bildirim ayarlarında görünen kanal adı.
  final String channelName;

  /// Gizli gruba katılma isteği (yöneticiye).
  final String Function(String group) groupRequestTitle;
  final String Function(String name) groupRequestBody;

  static NotificationTexts of(String code) => _texts[code] ?? _texts['en']!;

  static final Map<String, NotificationTexts> _texts = {
    'en': NotificationTexts(
      messageRequestTitle: 'New message request',
      messageRequestBody: (n) => '$n wants to chat with you',
      photo: '📷 Photo',
      voice: '🎤 Voice message',
      channelName: 'Messages',
      groupRequestTitle: (g) => '$g: join request',
      groupRequestBody: (n) => '$n wants to join',
    ),
    'tr': NotificationTexts(
      messageRequestTitle: 'Yeni mesaj isteği',
      messageRequestBody: (n) => '$n seninle sohbet etmek istiyor',
      photo: '📷 Fotoğraf',
      voice: '🎤 Sesli mesaj',
      channelName: 'Mesajlar',
      groupRequestTitle: (g) => '$g: katılma isteği',
      groupRequestBody: (n) => '$n katılmak istiyor',
    ),
    'de': NotificationTexts(
      messageRequestTitle: 'Neue Nachrichtenanfrage',
      messageRequestBody: (n) => '$n möchte mit dir chatten',
      photo: '📷 Foto',
      voice: '🎤 Sprachnachricht',
      channelName: 'Nachrichten',
      groupRequestTitle: (g) => '$g: Beitrittsanfrage',
      groupRequestBody: (n) => '$n möchte beitreten',
    ),
    'it': NotificationTexts(
      messageRequestTitle: 'Nuova richiesta di messaggio',
      messageRequestBody: (n) => '$n vuole chattare con te',
      photo: '📷 Foto',
      voice: '🎤 Messaggio vocale',
      channelName: 'Messaggi',
      groupRequestTitle: (g) => '$g: richiesta di accesso',
      groupRequestBody: (n) => '$n vuole unirsi',
    ),
    'fr': NotificationTexts(
      messageRequestTitle: 'Nouvelle demande de message',
      messageRequestBody: (n) => '$n veut discuter avec toi',
      photo: '📷 Photo',
      voice: '🎤 Message vocal',
      channelName: 'Messages',
      groupRequestTitle: (g) => '$g : demande d’adhésion',
      groupRequestBody: (n) => '$n veut rejoindre le groupe',
    ),
    'ja': NotificationTexts(
      messageRequestTitle: '新しいメッセージリクエスト',
      messageRequestBody: (n) => '$nさんがあなたとチャットしたがっています',
      photo: '📷 写真',
      voice: '🎤 ボイスメッセージ',
      channelName: 'メッセージ',
      groupRequestTitle: (g) => '$g：参加リクエスト',
      groupRequestBody: (n) => '$nさんが参加を希望しています',
    ),
    'es': NotificationTexts(
      messageRequestTitle: 'Nueva solicitud de mensaje',
      messageRequestBody: (n) => '$n quiere chatear contigo',
      photo: '📷 Foto',
      voice: '🎤 Mensaje de voz',
      channelName: 'Mensajes',
      groupRequestTitle: (g) => '$g: solicitud para unirse',
      groupRequestBody: (n) => '$n quiere unirse',
    ),
    'ru': NotificationTexts(
      messageRequestTitle: 'Новый запрос на переписку',
      messageRequestBody: (n) => '$n хочет пообщаться с тобой',
      photo: '📷 Фото',
      voice: '🎤 Голосовое сообщение',
      channelName: 'Сообщения',
      groupRequestTitle: (g) => '$g: заявка на вступление',
      groupRequestBody: (n) => '$n хочет вступить',
    ),
    'ko': NotificationTexts(
      messageRequestTitle: '새 메시지 요청',
      messageRequestBody: (n) => '$n님이 대화를 원해요',
      photo: '📷 사진',
      voice: '🎤 음성 메시지',
      channelName: '메시지',
      groupRequestTitle: (g) => '$g: 가입 요청',
      groupRequestBody: (n) => '$n님이 참여를 원해요',
    ),
    'hi': NotificationTexts(
      messageRequestTitle: 'नया मैसेज अनुरोध',
      messageRequestBody: (n) => '$n आपसे चैट करना चाहते हैं',
      photo: '📷 फ़ोटो',
      voice: '🎤 वॉइस मैसेज',
      channelName: 'मैसेज',
      groupRequestTitle: (g) => '$g: जुड़ने का अनुरोध',
      groupRequestBody: (n) => '$n जुड़ना चाहते हैं',
    ),
    'pt': NotificationTexts(
      messageRequestTitle: 'Nova solicitação de mensagem',
      messageRequestBody: (n) => '$n quer conversar com você',
      photo: '📷 Foto',
      voice: '🎤 Mensagem de voz',
      channelName: 'Mensagens',
      groupRequestTitle: (g) => '$g: pedido para entrar',
      groupRequestBody: (n) => '$n quer entrar',
    ),
    'zh': NotificationTexts(
      messageRequestTitle: '新的消息请求',
      messageRequestBody: (n) => '$n 想和你聊天',
      photo: '📷 照片',
      voice: '🎤 语音消息',
      channelName: '消息',
      groupRequestTitle: (g) => '$g：入群申请',
      groupRequestBody: (n) => '$n 想加入群组',
    ),
  };
}
