import { logger } from '../lib/logger';
import { prisma } from '../lib/prisma';
import { turkishVibeLines } from './vibe-lines';

/** Harita seyrek kalsın; aynı avatar tekrar etmesin. */
const TARGET = 5;
const MAX_ACTIVE = 5;
/** Aynı karakterin haritada birden fazla pin'i olmasın. */
const MAX_PER_AUTHOR = 1;
const TICK_MS = 12 * 60 * 1000;
const MIN_GAP_MS = 90 * 60 * 1000;
const LIVE_MS = 48 * 60 * 60 * 1000;

type PersonaUser = { id: string; username: string | null };

function lineFor(username: string | null, used: Set<string>) {
  const pool = turkishVibeLines(username);
  const fresh = pool.filter((line) => !used.has(line));
  const pickFrom = fresh.length ? fresh : pool;
  return pickFrom[Math.floor(Math.random() * pickFrom.length)]!;
}

async function activeVibes(ids: string[]) {
  return prisma.vibe.findMany({
    where: { authorId: { in: ids }, deletedAt: null, expiresAt: { gt: new Date() } },
    select: { id: true, authorId: true, body: true, createdAt: true },
    orderBy: { createdAt: 'desc' },
  });
}

/** Fazla / aynı yazardan tekrarlayan vibe'ları soft-delete et. */
async function prune(ids: string[]) {
  const current = await activeVibes(ids);
  const keep = new Set<string>();
  const drop: string[] = [];
  const perAuthor = new Map<string, number>();

  for (const v of current) {
    const count = perAuthor.get(v.authorId) ?? 0;
    if (count >= MAX_PER_AUTHOR || keep.size >= MAX_ACTIVE) {
      drop.push(v.id);
      continue;
    }
    perAuthor.set(v.authorId, count + 1);
    keep.add(v.id);
  }

  if (drop.length === 0) return;
  await prisma.vibe.updateMany({
    where: { id: { in: drop } },
    data: { deletedAt: new Date() },
  });
  logger.info({ removed: drop.length }, 'Fazla vibe budandı');
}

async function postOne(users: PersonaUser[], used: Set<string>, createdAt: Date, fresh: boolean) {
  const recent = await activeVibes(users.map((u) => u.id));
  const eligible = users.filter((u) => {
    const mine = recent.filter((v) => v.authorId === u.id);
    if (mine.length >= MAX_PER_AUTHOR) return false;
    if (!fresh) return true;
    const last = Math.max(0, ...mine.map((v) => v.createdAt.getTime()));
    return Date.now() - last > MIN_GAP_MS;
  });
  if (eligible.length === 0) return false;
  const least = Math.min(...eligible.map((u) => recent.filter((v) => v.authorId === u.id).length));
  const balanced = eligible.filter((u) => recent.filter((v) => v.authorId === u.id).length === least);
  const pick = balanced[Math.floor(Math.random() * balanced.length)];
  if (!pick) return false;
  const body = lineFor(pick.username, used);
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
  await prune(users.map((u) => u.id));
  const current = await activeVibes(users.map((u) => u.id));
  const used = new Set(current.map((v) => v.body));
  if (current.length >= MAX_ACTIVE) return;
  if (current.length >= TARGET && !forceOne) return;

  let left = Math.max(forceOne ? 1 : 0, TARGET - current.length);
  if (forceOne && current.length >= TARGET) left = 1;
  const cap = forceOne ? 1 : TARGET;
  for (let i = 0; i < cap && left > 0; i++) {
    const ago = forceOne ? 0 : (left + i) * 30 * 60 * 1000;
    const ok = await postOne(users, used, new Date(Date.now() - ago), forceOne);
    if (!ok) break;
    left--;
  }
}

export function startPersonaVibes() {
  const backfill = () => void fill(false).catch((err) => logger.warn({ err }, 'AI karakter vibe doldurma başarısız'));
  const tick = () => void fill(true).catch((err) => logger.warn({ err }, 'AI karakter vibe turu başarısız'));
  setTimeout(backfill, 8_000);
  setInterval(tick, TICK_MS).unref();
}
