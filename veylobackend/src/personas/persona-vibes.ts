import { logger } from '../lib/logger';
import { prisma } from '../lib/prisma';
import { turkishVibeLines } from './vibe-lines';

/** Harita dolu kalsın: bu kadar yayındaki vibe hedeflenir. */
const TARGET = 12;
const MAX_ACTIVE = 16;
const TICK_MS = 6 * 60 * 1000;
const MIN_GAP_MS = 40 * 60 * 1000;
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

export function startPersonaVibes() {
  const backfill = () => void fill(false).catch((err) => logger.warn({ err }, 'AI karakter vibe doldurma başarısız'));
  const tick = () => void fill(true).catch((err) => logger.warn({ err }, 'AI karakter vibe turu başarısız'));
  setTimeout(backfill, 8_000);
  setInterval(tick, TICK_MS).unref();
}
