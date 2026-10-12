/**
 * Uygulama kuralları ve fiyatlar. Fiyatlar Figma notundan alındı; değiştirmek için tek yer burası.
 */

export const TOKENS = {
  welcomeBonus: 100,
  roomCreate: 50,
  callGenderFilter: 10,
  videoCallPer15Min: 20,
  postBoost1Day: 100,
} as const;

/** Mağaza ürün id'si → verilecek token. RevenueCat/App Store/Play ürün id'leri birebir aynı olmalı. */
export const TOKEN_PRODUCTS: Record<string, number> = {
  'veylo.tokens.100': 100,
  'veylo.tokens.400': 400,
  'veylo.tokens.1000': 1000,
};

/** Flutter'daki ProfileBorder.catalog ile aynı. */
export const BORDER_CATALOG: Record<string, number> = {
  amethyst: 30,
  phoenix: 50,
  frost: 30,
  emerald: 40,
  rose: 40,
  starlit: 50,
  crimson: 60,
  sapphire: 70,
};

export const GROUP = {
  titleMaxLength: 50,
  maxMembers: 200,
  requestMessageMaxLength: 200,
  /** Keşfet listesinde gösterilen grup sayısı. */
  listLimit: 50,
} as const;

export const VIBE = {
  maxLength: 280,
  ttlHours: 24,
  /** Kullanıcı başına 24 saatte en fazla paylaşım. */
  dailyLimit: 10,
  pageSize: 30,
} as const;

export const POST = {
  captionMaxLength: 500,
  commentMaxLength: 500,
  imageMaxPx: 1600,
  /** Discover ızgarası ve profil sekmeleri için küçük görsel. */
  thumbPx: 480,
  feedPageSize: 30,
  boostCost: 100,
  boostHours: 24,
  /** Kullanıcı başına 24 saatte en fazla paylaşım. */
  dailyLimit: 20,
} as const;

export const NOTE = {
  maxLength: 60,
  ttlHours: 24,
} as const;

export const CHAT = {
  maxMessageLength: 2000,
  /** Mesaj isteği onaylanmadan başlatanın atabileceği mesaj sayısı. */
  pendingMessageLimit: 1,
  /** Bu süreden eski bekleyen istekler listede gösterilmez. */
  requestTtlDays: 30,
  pageSize: 30,
} as const;

export const MEDIA = {
  /** Gelen dosyanın üst sınırı (işlenmeden önce). */
  maxUploadBytes: 10 * 1024 * 1024,
  maxAudioBytes: 5 * 1024 * 1024,
  uploadsPer10Min: 40,
  /** Görsellerin uzun kenarı en fazla bu kadar piksele küçültülür. */
  avatarMaxPx: 1080,
  chatImageMaxPx: 1600,
  /** Anonim önizleme: çok küçük boyut + güçlü bulanıklık (geri döndürülemez). */
  blurPx: 96,
  blurSigma: 8,
  webpQuality: 82,
} as const;

/** Anonim sohbette bağlantı yüzdesi. */
export const CONNECTION = {
  /** Sıra değiştiğinde (karşılıklı konuşma) eklenen puan. */
  turnGain: 4,
  /** Aynı kişi art arda yazarsa eklenen puan. */
  sameSenderGain: 1,
  milestones: { initial: 25, blurredPhoto: 70, reveal: 100 },
} as const;

export const ENUMS = {
  interests: [
    'music', 'movies', 'tvShows', 'reading', 'painting', 'photography', 'theatre', 'fitness',
    'swimming', 'football', 'basketball', 'coffee', 'travel', 'camping', 'meditation',
    'videoGames', 'boardGames', 'standUp', 'tech', 'coding', 'ai', 'podcast',
  ],
  chatGoals: ['quickMatch', 'flirtyChat', 'moodMatch', 'lateNight', 'meetSomeoneNew'],
  relationshipGoals: [
    'longTermOpenToShort', 'longTermRelationship', 'newFriends', 'shortTermFun', 'stillFiguringItOut',
  ],
  languages: ['en', 'de', 'it', 'fr', 'tr', 'ja', 'es', 'ru', 'ko', 'hi', 'pt', 'zh'],
  zodiac: [
    'aries', 'taurus', 'gemini', 'cancer', 'leo', 'virgo',
    'libra', 'scorpio', 'sagittarius', 'capricorn', 'aquarius', 'pisces',
  ],
  education: ['highSchool', 'associates', 'bachelors', 'masters', 'phd'],
  pets: ['dontWant', 'allergic', 'haveCat', 'haveDog', 'haveCatsAndDogs', 'haveOther'],
  drinking: ['never', 'specialOccasions', 'socially', 'frequently', 'sober', 'preferNotToSay'],
  smoking: ['nonSmoker', 'socialSmoker', 'smoker', 'tryingToQuit', 'smokerWhenDrinking', 'preferNotToSay'],
} as const;

export const RESERVED_USERNAMES = new Set(['admin', 'veylo', 'support', 'root', 'system', 'moderator']);
