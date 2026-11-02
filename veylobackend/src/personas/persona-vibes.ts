import { VIBE } from '../config/constants';
import { logger } from '../lib/logger';
import { prisma } from '../lib/prisma';
import { PERSONAS, type PersonaDef } from './catalog';
import { complete } from './openai';
import { vibeSystemPrompt } from './prompts';

/** Harita dolu kalsın: bu kadar yayındaki vibe hedeflenir. */
const TARGET = 28;
const MAX_ACTIVE = 36;
const TICK_MS = 3 * 60 * 1000;
const MIN_GAP_MS = 25 * 60 * 1000;
const LIVE_MS = 48 * 60 * 60 * 1000;

/** Karakterine göre değişen, tekrar etmeyen kısa düşünceler. */
const LINES: Record<string, string[]> = {
  natalie_pnk: [
    'gece kahvesi bitti, düşünce bitmedi',
    'eski bir şarkı açıldı ve durdum',
    'şehir ışıkları bugün daha yakın',
    'yarın her şeyi düzeltirim diyorum, yine',
    'biriyle uzun uzun konuşasım var',
    'fotoğraf çekmeden geçemediğim bir sokak',
  ],
  'lyra.moon': [
    'uyuyamıyorum, cümleler uyumuyor',
    'kafamda kurduğum senaryo yine kazandı',
    'yağmur varsa dışarı çıkasım geliyor',
    'bir şiir yarım kaldı',
    'sessiz bir gün, kafam değil',
    'aynı soruyu üçüncü kez düşündüm',
  ],
  adnan___adn: [
    'gece sürüşü, playlist karışık',
    'bugün idman iyi geldi',
    'iş bitti ama kafa bitmedi',
    'halı saha planı olan var mı',
    'valla bugün biraz yorgunum',
    'trafikte tek iyi şey müzik',
  ],
  sophievargas: [
    'sıradaki şehir hangisi olsun',
    'havaalanı kahvesi her yerde aynı',
    'yeni bir yer, eski bir his',
    'valiz yine yarım hazır',
    'bugün sadece yürüyesim var',
    'fotoğraf çektim ama paylaşmadım',
  ],
  'clara.clr': [
    'sadece arkadaşız demek yetmiyor bazen',
    'bu gece bir dizi, yarın pişmanlık',
    'tiyatro bitti, sokak devam etti',
    'ince bir espri, kimse anlamadı',
    'paris aklımda, ben burada',
    'biri sorsa anlatamam',
  ],
  sam_black: [
    'kötü bir espri geldi, tutamadım',
    'kutu oyunu isteyen var mı',
    'kamp ateşi hayali, balkon gerçeği',
    'bugün kod yazdım, cümle yazamadım',
    'gülmek için sebep aramıyorum',
    'bir gün sahilde kafe açacağım',
  ],
  'kyrie.lee': [
    'şehir ışıkları her şeyi örtüyor',
    'yeni bir beat, eski bir his',
    'gece yürüyüşü, kulaklıkta tek şarkı',
    'kalabalık güzel, konuşmak değil',
    'müzik bitince oda büyüyor',
    'bugün az konuştum, iyi geldi',
  ],
  'lara.wtson': [
    'yağmur ve bitmeyen bir kitap',
    'playlist bugün benden daha dürüst',
    'bazen sadece biri dinlese yeter',
    'gece düşüncesi gündüz mantıksız gelir',
    'çay soğudu, sayfa ilerlemedi',
    'iyi hissetmek için sebep şart değil',
  ],
};

type PersonaUser = { id: string; username: string | null };

function lineFor(username: string | null, used: Set<string>) {
  const pool = (username && LINES[username]) || Object.values(LINES).flat();
  const fresh = pool.filter((line) => !used.has(line));
  const pickFrom = fresh.length ? fresh : pool;
  return pickFrom[Math.floor(Math.random() * pickFrom.length)]!;
}

async function activeVibes(ids: string[]) {
  return prisma.vibe.findMany({
    where: { authorId: { in: ids }, deletedAt: null, expiresAt: { gt: new Date() } },
    select: { authorId: true, body: true, createdAt: true },
  });
}

async function postOne(users: PersonaUser[], used: Set<string>, createdAt: Date, fresh: boolean) {
  const recent = await activeVibes(users.map((u) => u.id));
  const eligible = users.filter((u) => {
    if (!fresh) return true;
    const last = Math.max(0, ...recent.filter((v) => v.authorId === u.id).map((v) => v.createdAt.getTime()));
    return Date.now() - last > MIN_GAP_MS;
  });
  const pool = eligible.length ? eligible : fresh ? [] : users;
  if (pool.length === 0) return false;
  const least = Math.min(...pool.map((u) => recent.filter((v) => v.authorId === u.id).length));
  const balanced = pool.filter((u) => recent.filter((v) => v.authorId === u.id).length === least);
  const pick = balanced[Math.floor(Math.random() * balanced.length)];
  if (!pick) return false;
  const def = PERSONAS.find((p) => p.username === pick.username);
  const generated = fresh && def ? await writeVibe(def) : null;
  const body = generated && !used.has(generated) ? generated : lineFor(pick.username, used);
  if (used.has(body)) return false;
  const anonymous = Math.random() < 0.35;
  await prisma.vibe.create({
    data: {
      authorId: pick.id,
      body,
      anonymous,
      createdAt,
      expiresAt: new Date(createdAt.getTime() + LIVE_MS),
    },
  });
  used.add(body);
  logger.info({ persona: pick.username, anonymous }, 'AI karakter vibe paylaştı');
  return true;
}

/** Açılışta haritayı doldurur. Sonra aralıklarla yeni ve farklı vibe ekler. */
async function fill(forceOne: boolean) {
  const users = await prisma.user.findMany({
    where: { isPersona: true, status: 'ACTIVE' },
    select: { id: true, username: true },
  });
  if (users.length === 0) return;
  const current = await activeVibes(users.map((u) => u.id));
  const used = new Set(current.map((v) => v.body));
  if (current.length >= MAX_ACTIVE) return;
  if (current.length >= TARGET && !forceOne) return;

  let left = Math.max(forceOne ? 1 : 0, TARGET - current.length);
  if (forceOne && current.length >= TARGET) left = 1;
  const cap = forceOne ? 1 : TARGET;
  for (let i = 0; i < cap && left > 0; i++) {
    const ago = forceOne ? 0 : (left + i) * 20 * 60 * 1000;
    const ok = await postOne(users, used, new Date(Date.now() - ago), forceOne);
    if (!ok) break;
    left--;
  }
}

async function writeVibe(def: PersonaDef) {
  const theme = def.vibeThemes[Math.floor(Math.random() * def.vibeThemes.length)];
  const raw = await complete(
    [
      { role: 'system', content: vibeSystemPrompt(def) },
      { role: 'user', content: `Konu: ${theme}. Şimdi bir vibe yaz.` },
    ],
    { maxTokens: 60, temperature: 1 },
  );
  const text = raw?.trim().replace(/^["“”']+|["“”']+$/g, '').split('\n')[0]?.trim();
  if (!text || text.length < 4) return null;
  return text.slice(0, VIBE.maxLength);
}

export function startPersonaVibes() {
  const backfill = () => void fill(false).catch((err) => logger.warn({ err }, 'AI karakter vibe doldurma başarısız'));
  const tick = () => void fill(true).catch((err) => logger.warn({ err }, 'AI karakter vibe turu başarısız'));
  setTimeout(backfill, 8_000);
  setInterval(tick, TICK_MS).unref();
}
