import { AppError } from '../errors/AppError';

/**
 * Basit küfür / müstehcenlik / taciz kelime filtresi (TR + EN).
 * App Store Guideline 1.2 — UGC gönderilmeden önce sunucu tarafı engeli.
 */
const BLOCKED = [
  // TR
  'amk',
  'aq',
  'a.q',
  'a.q.',
  'orospu',
  'siktir',
  'sikeyim',
  'sikerim',
  'sikik',
  'amına',
  'amina',
  'götün',
  'gotun',
  'götü',
  'pic',
  'piç',
  'yarrak',
  'yarak',
  'daşşak',
  'dassak',
  'porno',
  'porn',
  'sex',
  'seks',
  'nude',
  'çıplak',
  'ciplak',
  'sakso',
  'malafat',
  'kahpe',
  'gavat',
  'ibne',
  'top',
  // EN
  'fuck',
  'fucker',
  'fucking',
  'shit',
  'bitch',
  'asshole',
  'dick',
  'cock',
  'pussy',
  'cunt',
  'slut',
  'whore',
  'nigger',
  'nigga',
  'faggot',
  'retard',
  'rape',
  'rapist',
  'onlyfans',
  'nsfw',
].map((w) => w.trim().toLowerCase()).filter(Boolean);

const PATTERN = new RegExp(
  `(?:^|[^\\p{L}\\p{N}])(${BLOCKED.map((w) => w.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')).join('|')})(?:$|[^\\p{L}\\p{N}])`,
  'iu',
);

/** Metinde yasaklı ifade varsa true. */
export function containsObjectionableContent(text: string | null | undefined): boolean {
  if (!text) return false;
  const normalized = text
    .normalize('NFKC')
    .replace(/[\u200B-\u200D\uFEFF]/g, '')
    .toLowerCase();
  return PATTERN.test(` ${normalized} `);
}

/** Yasaklı içerikte AppError fırlatır. */
export function assertCleanContent(text: string | null | undefined): void {
  if (containsObjectionableContent(text)) {
    throw AppError.badRequest('CONTENT_BLOCKED');
  }
}
