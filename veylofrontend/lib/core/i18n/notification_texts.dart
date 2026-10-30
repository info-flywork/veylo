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

class UnlockNotice {
  const UnlockNotice(this.title, this.body);

  final String title;
  final String body;
}

/// İsim, bulanık fotoğraf ve tam profil isteklerinin bildirim metni. 12 dil.
UnlockNotice? unlockNotice(String language, String? body) {
  if (body == null || body.isEmpty) return null;
  final table = _unlock[language] ?? _unlock['en']!;
  return table[body] ?? _unlock['en']![body];
}

const _unlock = <String, Map<String, UnlockNotice>>{
  'en': {
    'unlock:initial': UnlockNotice('Name request', 'This person requested to see your name.'),
    'unlock:initial:approved': UnlockNotice('Name shared', 'They approved. Their name stays visible.'),
    'unlock:initial:rejected': UnlockNotice('Name request declined', 'They declined the name request.'),
    'unlock:photo': UnlockNotice('Blurred photo', 'This person requested to see your blurred photo.'),
    'unlock:photo:approved': UnlockNotice('Photo shared', 'They approved. You can see their blurred photo.'),
    'unlock:photo:rejected': UnlockNotice('Photo request declined', 'They declined the blurred photo request.'),
    'unlock:full': UnlockNotice('Full profile', 'This person requested to see your full profile.'),
    'unlock:full:approved': UnlockNotice('Profile shared', 'They approved. You can see their full profile.'),
    'unlock:full:rejected': UnlockNotice('Profile request declined', 'They declined the full profile request.'),
  },
  'tr': {
    'unlock:initial': UnlockNotice('İsim isteği', 'Adını görmek için istek gönderdi.'),
    'unlock:initial:approved': UnlockNotice('İsim paylaşıldı', 'Onayladı. Adı görünür kaldı.'),
    'unlock:initial:rejected': UnlockNotice('İsim isteği reddedildi', 'İsim isteğini reddetti.'),
    'unlock:photo': UnlockNotice('Bulanık fotoğraf', 'Bulanık fotoğrafını görmek için istek gönderdi.'),
    'unlock:photo:approved': UnlockNotice('Fotoğraf paylaşıldı', 'Onayladı. Bulanık fotoğrafını görebilirsin.'),
    'unlock:photo:rejected': UnlockNotice('Fotoğraf isteği reddedildi', 'Bulanık fotoğraf isteğini reddetti.'),
    'unlock:full': UnlockNotice('Tam profil', 'Tam profilini görmek için istek gönderdi.'),
    'unlock:full:approved': UnlockNotice('Profil paylaşıldı', 'Onayladı. Tam profilini görebilirsin.'),
    'unlock:full:rejected': UnlockNotice('Profil isteği reddedildi', 'Tam profil isteğini reddetti.'),
  },
  'de': {
    'unlock:initial': UnlockNotice('Namensanfrage', 'Diese Person möchte deinen Namen sehen.'),
    'unlock:initial:approved': UnlockNotice('Name geteilt', 'Angenommen. Der Name bleibt sichtbar.'),
    'unlock:initial:rejected': UnlockNotice('Namensanfrage abgelehnt', 'Die Namensanfrage wurde abgelehnt.'),
    'unlock:photo': UnlockNotice('Unscharfes Foto', 'Diese Person möchte dein unscharfes Foto sehen.'),
    'unlock:photo:approved': UnlockNotice('Foto geteilt', 'Angenommen. Du siehst das unscharfe Foto.'),
    'unlock:photo:rejected': UnlockNotice('Fotoanfrage abgelehnt', 'Die Anfrage zum unscharfen Foto wurde abgelehnt.'),
    'unlock:full': UnlockNotice('Vollständiges Profil', 'Diese Person möchte dein vollständiges Profil sehen.'),
    'unlock:full:approved': UnlockNotice('Profil geteilt', 'Angenommen. Du siehst das vollständige Profil.'),
    'unlock:full:rejected': UnlockNotice('Profilanfrage abgelehnt', 'Die Anfrage zum vollständigen Profil wurde abgelehnt.'),
  },
  'it': {
    'unlock:initial': UnlockNotice('Richiesta del nome', 'Questa persona vuole vedere il tuo nome.'),
    'unlock:initial:approved': UnlockNotice('Nome condiviso', 'Ha approvato. Il nome resta visibile.'),
    'unlock:initial:rejected': UnlockNotice('Richiesta del nome rifiutata', 'Ha rifiutato la richiesta del nome.'),
    'unlock:photo': UnlockNotice('Foto sfocata', 'Questa persona vuole vedere la tua foto sfocata.'),
    'unlock:photo:approved': UnlockNotice('Foto condivisa', 'Ha approvato. Puoi vedere la foto sfocata.'),
    'unlock:photo:rejected': UnlockNotice('Richiesta foto rifiutata', 'Ha rifiutato la richiesta della foto sfocata.'),
    'unlock:full': UnlockNotice('Profilo completo', 'Questa persona vuole vedere il tuo profilo completo.'),
    'unlock:full:approved': UnlockNotice('Profilo condiviso', 'Ha approvato. Puoi vedere il profilo completo.'),
    'unlock:full:rejected': UnlockNotice('Richiesta profilo rifiutata', 'Ha rifiutato la richiesta del profilo completo.'),
  },
  'fr': {
    'unlock:initial': UnlockNotice('Demande de nom', 'Cette personne veut voir ton nom.'),
    'unlock:initial:approved': UnlockNotice('Nom partagé', 'C’est approuvé. Le nom reste visible.'),
    'unlock:initial:rejected': UnlockNotice('Demande de nom refusée', 'La demande de nom a été refusée.'),
    'unlock:photo': UnlockNotice('Photo floue', 'Cette personne veut voir ta photo floue.'),
    'unlock:photo:approved': UnlockNotice('Photo partagée', 'C’est approuvé. Tu peux voir la photo floue.'),
    'unlock:photo:rejected': UnlockNotice('Demande de photo refusée', 'La demande de photo floue a été refusée.'),
    'unlock:full': UnlockNotice('Profil complet', 'Cette personne veut voir ton profil complet.'),
    'unlock:full:approved': UnlockNotice('Profil partagé', 'C’est approuvé. Tu peux voir le profil complet.'),
    'unlock:full:rejected': UnlockNotice('Demande de profil refusée', 'La demande de profil complet a été refusée.'),
  },
  'ja': {
    'unlock:initial': UnlockNotice('名前のリクエスト', 'あなたの名前を見たいというリクエストが届きました。'),
    'unlock:initial:approved': UnlockNotice('名前を共有しました', '承認されました。名前が表示されたままになります。'),
    'unlock:initial:rejected': UnlockNotice('名前のリクエストは拒否されました', '名前のリクエストは拒否されました。'),
    'unlock:photo': UnlockNotice('ぼかし写真', 'ぼかし写真を見たいというリクエストが届きました。'),
    'unlock:photo:approved': UnlockNotice('写真を共有しました', '承認されました。ぼかし写真を見られます。'),
    'unlock:photo:rejected': UnlockNotice('写真のリクエストは拒否されました', 'ぼかし写真のリクエストは拒否されました。'),
    'unlock:full': UnlockNotice('プロフィール全体', 'プロフィール全体を見たいというリクエストが届きました。'),
    'unlock:full:approved': UnlockNotice('プロフィールを共有しました', '承認されました。プロフィール全体を見られます。'),
    'unlock:full:rejected': UnlockNotice('プロフィールのリクエストは拒否されました', 'プロフィール全体のリクエストは拒否されました。'),
  },
  'es': {
    'unlock:initial': UnlockNotice('Solicitud de nombre', 'Esta persona quiere ver tu nombre.'),
    'unlock:initial:approved': UnlockNotice('Nombre compartido', 'Lo aprobó. El nombre sigue visible.'),
    'unlock:initial:rejected': UnlockNotice('Solicitud de nombre rechazada', 'Rechazó la solicitud de nombre.'),
    'unlock:photo': UnlockNotice('Foto borrosa', 'Esta persona quiere ver tu foto borrosa.'),
    'unlock:photo:approved': UnlockNotice('Foto compartida', 'Lo aprobó. Puedes ver su foto borrosa.'),
    'unlock:photo:rejected': UnlockNotice('Solicitud de foto rechazada', 'Rechazó la solicitud de la foto borrosa.'),
    'unlock:full': UnlockNotice('Perfil completo', 'Esta persona quiere ver tu perfil completo.'),
    'unlock:full:approved': UnlockNotice('Perfil compartido', 'Lo aprobó. Puedes ver su perfil completo.'),
    'unlock:full:rejected': UnlockNotice('Solicitud de perfil rechazada', 'Rechazó la solicitud del perfil completo.'),
  },
  'ru': {
    'unlock:initial': UnlockNotice('Запрос имени', 'Этот человек хочет увидеть твоё имя.'),
    'unlock:initial:approved': UnlockNotice('Имя открыто', 'Запрос принят. Имя остаётся видимым.'),
    'unlock:initial:rejected': UnlockNotice('Запрос имени отклонён', 'Запрос имени отклонён.'),
    'unlock:photo': UnlockNotice('Размытое фото', 'Этот человек хочет увидеть твоё размытое фото.'),
    'unlock:photo:approved': UnlockNotice('Фото открыто', 'Запрос принят. Размытое фото видно.'),
    'unlock:photo:rejected': UnlockNotice('Запрос фото отклонён', 'Запрос размытого фото отклонён.'),
    'unlock:full': UnlockNotice('Полный профиль', 'Этот человек хочет увидеть твой полный профиль.'),
    'unlock:full:approved': UnlockNotice('Профиль открыт', 'Запрос принят. Полный профиль видно.'),
    'unlock:full:rejected': UnlockNotice('Запрос профиля отклонён', 'Запрос полного профиля отклонён.'),
  },
  'ko': {
    'unlock:initial': UnlockNotice('이름 요청', '이름을 보고 싶다는 요청이 도착했어요.'),
    'unlock:initial:approved': UnlockNotice('이름 공개', '승인했어요. 이름이 계속 보여요.'),
    'unlock:initial:rejected': UnlockNotice('이름 요청 거절', '이름 요청을 거절했어요.'),
    'unlock:photo': UnlockNotice('흐린 사진', '흐린 사진을 보고 싶다는 요청이 도착했어요.'),
    'unlock:photo:approved': UnlockNotice('사진 공개', '승인했어요. 흐린 사진을 볼 수 있어요.'),
    'unlock:photo:rejected': UnlockNotice('사진 요청 거절', '흐린 사진 요청을 거절했어요.'),
    'unlock:full': UnlockNotice('전체 프로필', '전체 프로필을 보고 싶다는 요청이 도착했어요.'),
    'unlock:full:approved': UnlockNotice('프로필 공개', '승인했어요. 전체 프로필을 볼 수 있어요.'),
    'unlock:full:rejected': UnlockNotice('프로필 요청 거절', '전체 프로필 요청을 거절했어요.'),
  },
  'hi': {
    'unlock:initial': UnlockNotice('नाम का अनुरोध', 'यह व्यक्ति आपका नाम देखना चाहता है।'),
    'unlock:initial:approved': UnlockNotice('नाम साझा हुआ', 'स्वीकार हो गया। नाम दिखाई देता रहेगा।'),
    'unlock:initial:rejected': UnlockNotice('नाम का अनुरोध अस्वीकार', 'नाम का अनुरोध अस्वीकार कर दिया गया।'),
    'unlock:photo': UnlockNotice('धुंधली फ़ोटो', 'यह व्यक्ति आपकी धुंधली फ़ोटो देखना चाहता है।'),
    'unlock:photo:approved': UnlockNotice('फ़ोटो साझा हुई', 'स्वीकार हो गया। धुंधली फ़ोटो देख सकते हैं।'),
    'unlock:photo:rejected': UnlockNotice('फ़ोटो अनुरोध अस्वीकार', 'धुंधली फ़ोटो का अनुरोध अस्वीकार कर दिया गया।'),
    'unlock:full': UnlockNotice('पूरी प्रोफ़ाइल', 'यह व्यक्ति आपकी पूरी प्रोफ़ाइल देखना चाहता है।'),
    'unlock:full:approved': UnlockNotice('प्रोफ़ाइल साझा हुई', 'स्वीकार हो गया। पूरी प्रोफ़ाइल देख सकते हैं।'),
    'unlock:full:rejected': UnlockNotice('प्रोफ़ाइल अनुरोध अस्वीकार', 'पूरी प्रोफ़ाइल का अनुरोध अस्वीकार कर दिया गया।'),
  },
  'pt': {
    'unlock:initial': UnlockNotice('Pedido de nome', 'Esta pessoa pediu para ver seu nome.'),
    'unlock:initial:approved': UnlockNotice('Nome compartilhado', 'Aprovado. O nome continua visível.'),
    'unlock:initial:rejected': UnlockNotice('Pedido de nome recusado', 'O pedido de nome foi recusado.'),
    'unlock:photo': UnlockNotice('Foto desfocada', 'Esta pessoa pediu para ver sua foto desfocada.'),
    'unlock:photo:approved': UnlockNotice('Foto compartilhada', 'Aprovado. Você pode ver a foto desfocada.'),
    'unlock:photo:rejected': UnlockNotice('Pedido de foto recusado', 'O pedido da foto desfocada foi recusado.'),
    'unlock:full': UnlockNotice('Perfil completo', 'Esta pessoa pediu para ver seu perfil completo.'),
    'unlock:full:approved': UnlockNotice('Perfil compartilhado', 'Aprovado. Você pode ver o perfil completo.'),
    'unlock:full:rejected': UnlockNotice('Pedido de perfil recusado', 'O pedido do perfil completo foi recusado.'),
  },
  'zh': {
    'unlock:initial': UnlockNotice('姓名请求', '对方请求查看你的名字。'),
    'unlock:initial:approved': UnlockNotice('已共享姓名', '已同意。名字会一直显示。'),
    'unlock:initial:rejected': UnlockNotice('姓名请求已拒绝', '对方拒绝了姓名请求。'),
    'unlock:photo': UnlockNotice('模糊照片', '对方请求查看你的模糊照片。'),
    'unlock:photo:approved': UnlockNotice('已共享照片', '已同意。你可以查看模糊照片。'),
    'unlock:photo:rejected': UnlockNotice('照片请求已拒绝', '对方拒绝了模糊照片请求。'),
    'unlock:full': UnlockNotice('完整资料', '对方请求查看你的完整资料。'),
    'unlock:full:approved': UnlockNotice('已共享资料', '已同意。你可以查看完整资料。'),
    'unlock:full:rejected': UnlockNotice('资料请求已拒绝', '对方拒绝了完整资料请求。'),
  },
};
