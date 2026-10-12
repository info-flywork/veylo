import { VIBE } from '../config/constants';
import { logger } from '../lib/logger';
import { prisma } from '../lib/prisma';
import { PERSONAS, type PersonaDef } from './catalog';
import { complete, openAiEnabled } from './openai';
import { vibeSystemPrompt } from './prompts';

/** Kontrol aralığı ve her turda bir karakterin paylaşma olasılığı. */
const TICK_MS = 20 * 60 * 1000;
const SHARE_CHANCE = 0.4;
const MAX_PER_DAY = 2;
const MIN_GAP_MS = 6 * 60 * 60 * 1000;

/** Gece 02:00-08:00 (TR saati) arası paylaşım seyrek: gerçek bir akış gibi dalgalı. */
function quietHour() {
  const hour = (new Date().getUTCHours() + 3) % 24;
  return hour >= 2 && hour < 8;
}

async function tick() {
  if (!openAiEnabled()) return;
  if (Math.random() > (quietHour() ? SHARE_CHANCE / 4 : SHARE_CHANCE)) return;

  const users = await prisma.user.findMany({
    where: { isPersona: true, status: 'ACTIVE' },
    select: { id: true, username: true },
  });
  const since = new Date(Date.now() - 24 * 60 * 60 * 1000);
  const recent = await prisma.vibe.findMany({
    where: { authorId: { in: users.map((u) => u.id) }, createdAt: { gte: since } },
    select: { authorId: true, createdAt: true },
  });

  const candidates = users.filter((u) => {
    const mine = recent.filter((v) => v.authorId === u.id);
    const last = Math.max(0, ...mine.map((v) => v.createdAt.getTime()));
    return mine.length < MAX_PER_DAY && Date.now() - last > MIN_GAP_MS;
  });
  const pick = candidates[Math.floor(Math.random() * candidates.length)];
  const def = PERSONAS.find((p) => p.username === pick?.username);
  if (!pick || !def) return;

  const body = await writeVibe(def);
  if (!body) return;
  await prisma.vibe.create({
    data: {
      authorId: pick.id,
      body,
      anonymous: Math.random() < 0.7,
      expiresAt: new Date(Date.now() + VIBE.ttlHours * 60 * 60 * 1000),
    },
  });
  logger.info({ persona: def.username }, 'AI karakter vibe paylaştı');
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
  const run = () => void tick().catch((err) => logger.warn({ err }, 'AI karakter vibe turu başarısız'));
  setTimeout(run, 60_000);
  setInterval(run, TICK_MS).unref();
}
