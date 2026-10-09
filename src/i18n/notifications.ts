import { ENUMS } from '../config/constants';

export type Locale = (typeof ENUMS.languages)[number];

export interface NotificationTexts {
  messageRequestTitle: string;
  messageRequestBody: (name: string) => string;
  photo: string;
  voice: string;
  group: string;
  revealTitle: string;
  revealBody: string;
}

/** Push bildirim metinleri: uygulamadaki 12 dil (Profil > Languages). */
const TEXTS: Record<Locale, NotificationTexts> = {
  en: {
    messageRequestTitle: 'New message request',
    messageRequestBody: (n) => `${n} wants to chat with you`,
    photo: '📷 Photo',
    voice: '🎤 Voice message',
    group: 'Group',
    revealTitle: 'Profiles revealed 🎉',
    revealBody: 'You can now see each other’s full profiles.',
  },
  tr: {
    messageRequestTitle: 'Yeni mesaj isteği',
    messageRequestBody: (n) => `${n} seninle sohbet etmek istiyor`,
    photo: '📷 Fotoğraf',
    voice: '🎤 Sesli mesaj',
    group: 'Grup',
    revealTitle: 'Profiller açıldı 🎉',
    revealBody: 'Artık birbirinizin tüm profilini görebilirsiniz.',
  },
  de: {
    messageRequestTitle: 'Neue Nachrichtenanfrage',
    messageRequestBody: (n) => `${n} möchte mit dir chatten`,
    photo: '📷 Foto',
    voice: '🎤 Sprachnachricht',
    group: 'Gruppe',
    revealTitle: 'Profile aufgedeckt 🎉',
    revealBody: 'Ihr könnt jetzt gegenseitig eure vollständigen Profile sehen.',
  },
  it: {
    messageRequestTitle: 'Nuova richiesta di messaggio',
    messageRequestBody: (n) => `${n} vuole chattare con te`,
    photo: '📷 Foto',
    voice: '🎤 Messaggio vocale',
    group: 'Gruppo',
    revealTitle: 'Profili svelati 🎉',
    revealBody: 'Ora potete vedere i vostri profili completi.',
  },
  fr: {
    messageRequestTitle: 'Nouvelle demande de message',
    messageRequestBody: (n) => `${n} veut discuter avec toi`,
    photo: '📷 Photo',
    voice: '🎤 Message vocal',
    group: 'Groupe',
    revealTitle: 'Profils dévoilés 🎉',
    revealBody: 'Vous pouvez maintenant voir vos profils complets.',
  },
  ja: {
    messageRequestTitle: '新しいメッセージリクエスト',
    messageRequestBody: (n) => `${n}さんがあなたとチャットしたがっています`,
    photo: '📷 写真',
    voice: '🎤 ボイスメッセージ',
    group: 'グループ',
    revealTitle: 'プロフィールが公開されました 🎉',
    revealBody: 'お互いのプロフィールをすべて見られるようになりました。',
  },
  es: {
    messageRequestTitle: 'Nueva solicitud de mensaje',
    messageRequestBody: (n) => `${n} quiere chatear contigo`,
    photo: '📷 Foto',
    voice: '🎤 Mensaje de voz',
    group: 'Grupo',
    revealTitle: 'Perfiles revelados 🎉',
    revealBody: 'Ahora podéis ver vuestros perfiles completos.',
  },
  ru: {
    messageRequestTitle: 'Новый запрос на переписку',
    messageRequestBody: (n) => `${n} хочет пообщаться с тобой`,
    photo: '📷 Фото',
    voice: '🎤 Голосовое сообщение',
    group: 'Группа',
    revealTitle: 'Профили открыты 🎉',
    revealBody: 'Теперь вы видите полные профили друг друга.',
  },
  ko: {
    messageRequestTitle: '새 메시지 요청',
    messageRequestBody: (n) => `${n}님이 대화를 원해요`,
    photo: '📷 사진',
    voice: '🎤 음성 메시지',
    group: '그룹',
    revealTitle: '프로필 공개 완료 🎉',
    revealBody: '이제 서로의 전체 프로필을 볼 수 있어요.',
  },
  hi: {
    messageRequestTitle: 'नया मैसेज अनुरोध',
    messageRequestBody: (n) => `${n} आपसे चैट करना चाहते हैं`,
    photo: '📷 फ़ोटो',
    voice: '🎤 वॉइस मैसेज',
    group: 'ग्रुप',
    revealTitle: 'प्रोफ़ाइल खुल गई 🎉',
    revealBody: 'अब आप एक-दूसरे की पूरी प्रोफ़ाइल देख सकते हैं।',
  },
  pt: {
    messageRequestTitle: 'Nova solicitação de mensagem',
    messageRequestBody: (n) => `${n} quer conversar com você`,
    photo: '📷 Foto',
    voice: '🎤 Mensagem de voz',
    group: 'Grupo',
    revealTitle: 'Perfis revelados 🎉',
    revealBody: 'Agora vocês podem ver os perfis completos um do outro.',
  },
  zh: {
    messageRequestTitle: '新的消息请求',
    messageRequestBody: (n) => `${n} 想和你聊天`,
    photo: '📷 照片',
    voice: '🎤 语音消息',
    group: '群组',
    revealTitle: '资料已公开 🎉',
    revealBody: '现在你们可以看到彼此的完整资料了。',
  },
};

export function notificationTexts(locale: string | null | undefined): NotificationTexts {
  return TEXTS[(locale ?? 'en') as Locale] ?? TEXTS.en;
}
