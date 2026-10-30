import { ENUMS } from '../config/constants';

type Locale = (typeof ENUMS.languages)[number];

export interface UnlockNotice {
  title: string;
  body: string;
}

const EN: Record<string, UnlockNotice> = {
  'unlock:initial': {
    title: 'Name request',
    body: 'This person requested to see your name.',
  },
  'unlock:initial:approved': {
    title: 'Name shared',
    body: 'They approved. Their name stays visible.',
  },
  'unlock:initial:rejected': {
    title: 'Name request declined',
    body: 'They declined the name request.',
  },
  'unlock:photo': {
    title: 'Blurred photo',
    body: 'This person requested to see your blurred photo.',
  },
  'unlock:photo:approved': {
    title: 'Photo shared',
    body: 'They approved. You can see their blurred photo.',
  },
  'unlock:photo:rejected': {
    title: 'Photo request declined',
    body: 'They declined the blurred photo request.',
  },
  'unlock:full': {
    title: 'Full profile',
    body: 'This person requested to see your full profile.',
  },
  'unlock:full:approved': {
    title: 'Profile shared',
    body: 'They approved. You can see their full profile.',
  },
  'unlock:full:rejected': {
    title: 'Profile request declined',
    body: 'They declined the full profile request.',
  },
};

const TEXTS: Record<Locale, Record<string, UnlockNotice>> = {
  en: EN,
  tr: {
    'unlock:initial': { title: 'İsim isteği', body: 'Adını görmek için istek gönderdi.' },
    'unlock:initial:approved': { title: 'İsim paylaşıldı', body: 'Onayladı. Adı görünür kaldı.' },
    'unlock:initial:rejected': { title: 'İsim isteği reddedildi', body: 'İsim isteğini reddetti.' },
    'unlock:photo': { title: 'Bulanık fotoğraf', body: 'Bulanık fotoğrafını görmek için istek gönderdi.' },
    'unlock:photo:approved': { title: 'Fotoğraf paylaşıldı', body: 'Onayladı. Bulanık fotoğrafını görebilirsin.' },
    'unlock:photo:rejected': { title: 'Fotoğraf isteği reddedildi', body: 'Bulanık fotoğraf isteğini reddetti.' },
    'unlock:full': { title: 'Tam profil', body: 'Tam profilini görmek için istek gönderdi.' },
    'unlock:full:approved': { title: 'Profil paylaşıldı', body: 'Onayladı. Tam profilini görebilirsin.' },
    'unlock:full:rejected': { title: 'Profil isteği reddedildi', body: 'Tam profil isteğini reddetti.' },
  },
  de: {
    'unlock:initial': { title: 'Namensanfrage', body: 'Diese Person möchte deinen Namen sehen.' },
    'unlock:initial:approved': { title: 'Name geteilt', body: 'Angenommen. Der Name bleibt sichtbar.' },
    'unlock:initial:rejected': { title: 'Namensanfrage abgelehnt', body: 'Die Namensanfrage wurde abgelehnt.' },
    'unlock:photo': { title: 'Unscharfes Foto', body: 'Diese Person möchte dein unscharfes Foto sehen.' },
    'unlock:photo:approved': { title: 'Foto geteilt', body: 'Angenommen. Du siehst das unscharfe Foto.' },
    'unlock:photo:rejected': { title: 'Fotoanfrage abgelehnt', body: 'Die Anfrage zum unscharfen Foto wurde abgelehnt.' },
    'unlock:full': { title: 'Vollständiges Profil', body: 'Diese Person möchte dein vollständiges Profil sehen.' },
    'unlock:full:approved': { title: 'Profil geteilt', body: 'Angenommen. Du siehst das vollständige Profil.' },
    'unlock:full:rejected': { title: 'Profilanfrage abgelehnt', body: 'Die Anfrage zum vollständigen Profil wurde abgelehnt.' },
  },
  it: {
    'unlock:initial': { title: 'Richiesta del nome', body: 'Questa persona vuole vedere il tuo nome.' },
    'unlock:initial:approved': { title: 'Nome condiviso', body: 'Ha approvato. Il nome resta visibile.' },
    'unlock:initial:rejected': { title: 'Richiesta del nome rifiutata', body: 'Ha rifiutato la richiesta del nome.' },
    'unlock:photo': { title: 'Foto sfocata', body: 'Questa persona vuole vedere la tua foto sfocata.' },
    'unlock:photo:approved': { title: 'Foto condivisa', body: 'Ha approvato. Puoi vedere la foto sfocata.' },
    'unlock:photo:rejected': { title: 'Richiesta foto rifiutata', body: 'Ha rifiutato la richiesta della foto sfocata.' },
    'unlock:full': { title: 'Profilo completo', body: 'Questa persona vuole vedere il tuo profilo completo.' },
    'unlock:full:approved': { title: 'Profilo condiviso', body: 'Ha approvato. Puoi vedere il profilo completo.' },
    'unlock:full:rejected': { title: 'Richiesta profilo rifiutata', body: 'Ha rifiutato la richiesta del profilo completo.' },
  },
  fr: {
    'unlock:initial': { title: 'Demande de nom', body: 'Cette personne veut voir ton nom.' },
    'unlock:initial:approved': { title: 'Nom partagé', body: 'C’est approuvé. Le nom reste visible.' },
    'unlock:initial:rejected': { title: 'Demande de nom refusée', body: 'La demande de nom a été refusée.' },
    'unlock:photo': { title: 'Photo floue', body: 'Cette personne veut voir ta photo floue.' },
    'unlock:photo:approved': { title: 'Photo partagée', body: 'C’est approuvé. Tu peux voir la photo floue.' },
    'unlock:photo:rejected': { title: 'Demande de photo refusée', body: 'La demande de photo floue a été refusée.' },
    'unlock:full': { title: 'Profil complet', body: 'Cette personne veut voir ton profil complet.' },
    'unlock:full:approved': { title: 'Profil partagé', body: 'C’est approuvé. Tu peux voir le profil complet.' },
    'unlock:full:rejected': { title: 'Demande de profil refusée', body: 'La demande de profil complet a été refusée.' },
  },
  ja: {
    'unlock:initial': { title: '名前のリクエスト', body: 'あなたの名前を見たいというリクエストが届きました。' },
    'unlock:initial:approved': { title: '名前を共有しました', body: '承認されました。名前が表示されたままになります。' },
    'unlock:initial:rejected': { title: '名前のリクエストは拒否されました', body: '名前のリクエストは拒否されました。' },
    'unlock:photo': { title: 'ぼかし写真', body: 'ぼかし写真を見たいというリクエストが届きました。' },
    'unlock:photo:approved': { title: '写真を共有しました', body: '承認されました。ぼかし写真を見られます。' },
    'unlock:photo:rejected': { title: '写真のリクエストは拒否されました', body: 'ぼかし写真のリクエストは拒否されました。' },
    'unlock:full': { title: 'プロフィール全体', body: 'プロフィール全体を見たいというリクエストが届きました。' },
    'unlock:full:approved': { title: 'プロフィールを共有しました', body: '承認されました。プロフィール全体を見られます。' },
    'unlock:full:rejected': { title: 'プロフィールのリクエストは拒否されました', body: 'プロフィール全体のリクエストは拒否されました。' },
  },
  es: {
    'unlock:initial': { title: 'Solicitud de nombre', body: 'Esta persona quiere ver tu nombre.' },
    'unlock:initial:approved': { title: 'Nombre compartido', body: 'Lo aprobó. El nombre sigue visible.' },
    'unlock:initial:rejected': { title: 'Solicitud de nombre rechazada', body: 'Rechazó la solicitud de nombre.' },
    'unlock:photo': { title: 'Foto borrosa', body: 'Esta persona quiere ver tu foto borrosa.' },
    'unlock:photo:approved': { title: 'Foto compartida', body: 'Lo aprobó. Puedes ver su foto borrosa.' },
    'unlock:photo:rejected': { title: 'Solicitud de foto rechazada', body: 'Rechazó la solicitud de la foto borrosa.' },
    'unlock:full': { title: 'Perfil completo', body: 'Esta persona quiere ver tu perfil completo.' },
    'unlock:full:approved': { title: 'Perfil compartido', body: 'Lo aprobó. Puedes ver su perfil completo.' },
    'unlock:full:rejected': { title: 'Solicitud de perfil rechazada', body: 'Rechazó la solicitud del perfil completo.' },
  },
  ru: {
    'unlock:initial': { title: 'Запрос имени', body: 'Этот человек хочет увидеть твоё имя.' },
    'unlock:initial:approved': { title: 'Имя открыто', body: 'Запрос принят. Имя остаётся видимым.' },
    'unlock:initial:rejected': { title: 'Запрос имени отклонён', body: 'Запрос имени отклонён.' },
    'unlock:photo': { title: 'Размытое фото', body: 'Этот человек хочет увидеть твоё размытое фото.' },
    'unlock:photo:approved': { title: 'Фото открыто', body: 'Запрос принят. Размытое фото видно.' },
    'unlock:photo:rejected': { title: 'Запрос фото отклонён', body: 'Запрос размытого фото отклонён.' },
    'unlock:full': { title: 'Полный профиль', body: 'Этот человек хочет увидеть твой полный профиль.' },
    'unlock:full:approved': { title: 'Профиль открыт', body: 'Запрос принят. Полный профиль видно.' },
    'unlock:full:rejected': { title: 'Запрос профиля отклонён', body: 'Запрос полного профиля отклонён.' },
  },
  ko: {
    'unlock:initial': { title: '이름 요청', body: '이름을 보고 싶다는 요청이 도착했어요.' },
    'unlock:initial:approved': { title: '이름 공개', body: '승인했어요. 이름이 계속 보여요.' },
    'unlock:initial:rejected': { title: '이름 요청 거절', body: '이름 요청을 거절했어요.' },
    'unlock:photo': { title: '흐린 사진', body: '흐린 사진을 보고 싶다는 요청이 도착했어요.' },
    'unlock:photo:approved': { title: '사진 공개', body: '승인했어요. 흐린 사진을 볼 수 있어요.' },
    'unlock:photo:rejected': { title: '사진 요청 거절', body: '흐린 사진 요청을 거절했어요.' },
    'unlock:full': { title: '전체 프로필', body: '전체 프로필을 보고 싶다는 요청이 도착했어요.' },
    'unlock:full:approved': { title: '프로필 공개', body: '승인했어요. 전체 프로필을 볼 수 있어요.' },
    'unlock:full:rejected': { title: '프로필 요청 거절', body: '전체 프로필 요청을 거절했어요.' },
  },
  hi: {
    'unlock:initial': { title: 'नाम का अनुरोध', body: 'यह व्यक्ति आपका नाम देखना चाहता है।' },
    'unlock:initial:approved': { title: 'नाम साझा हुआ', body: 'स्वीकार हो गया। नाम दिखाई देता रहेगा।' },
    'unlock:initial:rejected': { title: 'नाम का अनुरोध अस्वीकार', body: 'नाम का अनुरोध अस्वीकार कर दिया गया।' },
    'unlock:photo': { title: 'धुंधली फ़ोटो', body: 'यह व्यक्ति आपकी धुंधली फ़ोटो देखना चाहता है।' },
    'unlock:photo:approved': { title: 'फ़ोटो साझा हुई', body: 'स्वीकार हो गया। धुंधली फ़ोटो देख सकते हैं।' },
    'unlock:photo:rejected': { title: 'फ़ोटो अनुरोध अस्वीकार', body: 'धुंधली फ़ोटो का अनुरोध अस्वीकार कर दिया गया।' },
    'unlock:full': { title: 'पूरी प्रोफ़ाइल', body: 'यह व्यक्ति आपकी पूरी प्रोफ़ाइल देखना चाहता है।' },
    'unlock:full:approved': { title: 'प्रोफ़ाइल साझा हुई', body: 'स्वीकार हो गया। पूरी प्रोफ़ाइल देख सकते हैं।' },
    'unlock:full:rejected': { title: 'प्रोफ़ाइल अनुरोध अस्वीकार', body: 'पूरी प्रोफ़ाइल का अनुरोध अस्वीकार कर दिया गया।' },
  },
  pt: {
    'unlock:initial': { title: 'Pedido de nome', body: 'Esta pessoa pediu para ver seu nome.' },
    'unlock:initial:approved': { title: 'Nome compartilhado', body: 'Aprovado. O nome continua visível.' },
    'unlock:initial:rejected': { title: 'Pedido de nome recusado', body: 'O pedido de nome foi recusado.' },
    'unlock:photo': { title: 'Foto desfocada', body: 'Esta pessoa pediu para ver sua foto desfocada.' },
    'unlock:photo:approved': { title: 'Foto compartilhada', body: 'Aprovado. Você pode ver a foto desfocada.' },
    'unlock:photo:rejected': { title: 'Pedido de foto recusado', body: 'O pedido da foto desfocada foi recusado.' },
    'unlock:full': { title: 'Perfil completo', body: 'Esta pessoa pediu para ver seu perfil completo.' },
    'unlock:full:approved': { title: 'Perfil compartilhado', body: 'Aprovado. Você pode ver o perfil completo.' },
    'unlock:full:rejected': { title: 'Pedido de perfil recusado', body: 'O pedido do perfil completo foi recusado.' },
  },
  zh: {
    'unlock:initial': { title: '姓名请求', body: '对方请求查看你的名字。' },
    'unlock:initial:approved': { title: '已共享姓名', body: '已同意。名字会一直显示。' },
    'unlock:initial:rejected': { title: '姓名请求已拒绝', body: '对方拒绝了姓名请求。' },
    'unlock:photo': { title: '模糊照片', body: '对方请求查看你的模糊照片。' },
    'unlock:photo:approved': { title: '已共享照片', body: '已同意。你可以查看模糊照片。' },
    'unlock:photo:rejected': { title: '照片请求已拒绝', body: '对方拒绝了模糊照片请求。' },
    'unlock:full': { title: '完整资料', body: '对方请求查看你的完整资料。' },
    'unlock:full:approved': { title: '已共享资料', body: '已同意。你可以查看完整资料。' },
    'unlock:full:rejected': { title: '资料请求已拒绝', body: '对方拒绝了完整资料请求。' },
  },
};

export function unlockNotice(locale: string | null | undefined, messageBody: string | null | undefined): UnlockNotice | null {
  if (!messageBody) return null;
  const table = TEXTS[(locale ?? 'en') as Locale] ?? EN;
  return table[messageBody] ?? EN[messageBody] ?? null;
}
