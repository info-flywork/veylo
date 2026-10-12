import type { Gender } from '@prisma/client';
import { TOKENS } from '../config/constants';
import { env } from '../config/env';
import { AppError } from '../errors/AppError';
import { agoraUid, rtcCredentials } from '../lib/agora';
import { logger } from '../lib/logger';
import { prisma } from '../lib/prisma';
import { emitToUser } from '../realtime/emitter';
import { presence } from '../realtime/presence.store';
import { serializeUserSummary } from '../serializers/user.serializer';
import { safetyService } from './safety.service';
import { tokenService } from './token.service';

export const CALL = {
  /** Anonim sesli görüşme süresi (testte kısaltılabilir). */
  anonSeconds: !env.isProd && env.CALL_ANON_SECONDS ? env.CALL_ANON_SECONDS : 60,
  /** Süre dolunca "devam" oyları için bekleme. */
  voteSeconds: 20,
  /** Bir görüntülü ödemenin süresi. */
  videoMinutes: 15,
  /** Az önce konuşulan kişiyle hemen tekrar eşleşilmez. */
  rematchCooldownMs: 5 * 60 * 1000,
  /** Bağlantı koparsa görüşme hemen bitmez (yeniden bağlanma payı). */
  disconnectGraceMs: 10_000,
} as const;

/** İstemcinin "kiminle konuşmak istiyorum" seçimi. any = rastgele (ücretsiz). */
export const CALL_TARGETS = ['any', 'female', 'male', 'nonBinary'] as const;
export type CallTarget = (typeof CALL_TARGETS)[number];

const TARGET_GENDER: Record<Exclude<CallTarget, 'any'>, Gender> = {
  female: 'FEMALE',
  male: 'MALE',
  nonBinary: 'NON_BINARY',
};

interface Ticket {
  userId: string;
  gender: Gender | null;
  target: CallTarget;
  blocked: Set<string>;
}

interface LiveCall {
  id: string;
  a: string;
  b: string;
  channel: string;
  phase: 'anon' | 'vote' | 'revealed';
  keep: Set<string>;
  timers: NodeJS.Timeout[];
  videoRequestedBy: string | null;
  videoUntil: Date | null;
  videoTimer: NodeJS.Timeout | null;
}

const queue: Ticket[] = [];
const calls = new Map<string, LiveCall>();
const userCall = new Map<string, string>();
const recentPair = new Map<string, number>();
const graceTimers = new Map<string, NodeJS.Timeout>();

const pairKey = (x: string, y: string) => (x < y ? `${x}:${y}` : `${y}:${x}`);
const peerOf = (c: LiveCall, userId: string) => (c.a === userId ? c.b : c.a);

function loadMine(userId: string, callId: string) {
  const c = calls.get(callId);
  if (!c || (c.a !== userId && c.b !== userId)) throw AppError.notFound('CALL_NOT_FOUND');
  return c;
}

function compatible(me: Ticket, other: Ticket) {
  if (me.userId === other.userId) return false;
  if (me.blocked.has(other.userId) || other.blocked.has(me.userId)) return false;
  if (!presence.isOnline(other.userId)) return false;
  if (me.target !== 'any' && other.gender !== TARGET_GENDER[me.target]) return false;
  if (other.target !== 'any' && me.gender !== TARGET_GENDER[other.target]) return false;
  const last = recentPair.get(pairKey(me.userId, other.userId));
  return !last || Date.now() - last > CALL.rematchCooldownMs;
}

/**
 * Eşleşme sırasına girer. Uygun biri bekliyorsa hemen görüşme başlar, yoksa beklenir.
 * Cinsiyet seçen kişi eşleşince 10 token öder (iptal ederse ödemez).
 */
async function joinQueue(userId: string, target: CallTarget) {
  if (userCall.has(userId)) throw AppError.conflict('ALREADY_IN_CALL');
  leaveQueue(userId);

  const user = await prisma.user.findUniqueOrThrow({ where: { id: userId } });
  if (target !== 'any' && user.tokenBalance < TOKENS.callGenderFilter) {
    throw AppError.insufficientTokens(TOKENS.callGenderFilter, user.tokenBalance);
  }
  const me: Ticket = { userId, gender: user.gender, target, blocked: await safetyService.blockedIdsFor(userId) };

  const idx = queue.findIndex((t) => compatible(me, t));
  if (idx === -1) {
    queue.push(me);
    return { status: 'searching' as const, onlineCount: presence.onlineCount };
  }
  const [other] = queue.splice(idx, 1);
  await startCall(other!, me);
  return { status: 'matched' as const };
}

function leaveQueue(userId: string) {
  const i = queue.findIndex((t) => t.userId === userId);
  if (i >= 0) queue.splice(i, 1);
}

async function startCall(a: Ticket, b: Ticket) {
  const call = await prisma.call.create({
    data: {
      userAId: a.userId,
      userBId: b.userId,
      aFilter: a.target === 'any' ? null : a.target,
      bFilter: b.target === 'any' ? null : b.target,
    },
  });

  // Cinsiyet filtresi ücreti: eşleşme anında. Bakiye o arada yetmezse görüşme başlamaz.
  for (const t of [a, b]) {
    if (t.target === 'any') continue;
    try {
      const { balance } = await prisma.$transaction((tx) =>
        tokenService.spend(tx, t.userId, TOKENS.callGenderFilter, 'CALL_GENDER_FILTER', call.id),
      );
      emitToUser(t.userId, 'tokens:updated', { balance, delta: -TOKENS.callGenderFilter, reason: 'CALL_GENDER_FILTER' });
    } catch (err) {
      await prisma.call.update({ where: { id: call.id }, data: { endedAt: new Date(), endReason: 'HANGUP' } });
      emitToUser(t.userId, 'call:error', { code: err instanceof AppError ? err.code : 'INTERNAL' });
      const other = t === a ? b : a;
      if (presence.isOnline(other.userId)) queue.unshift(other);
      return;
    }
  }

  const live: LiveCall = {
    id: call.id,
    a: a.userId,
    b: b.userId,
    channel: `call_${call.id}`,
    phase: 'anon',
    keep: new Set(),
    timers: [],
    videoRequestedBy: null,
    videoUntil: null,
    videoTimer: null,
  };
  calls.set(call.id, live);
  userCall.set(a.userId, call.id);
  userCall.set(b.userId, call.id);
  recentPair.set(pairKey(a.userId, b.userId), Date.now());

  const endsAt = new Date(call.startedAt.getTime() + CALL.anonSeconds * 1000);
  for (const [me, peer] of [
    [a.userId, b.userId],
    [b.userId, a.userId],
  ] as const) {
    // Anonim: karşı tarafın kimliği yok, sadece ses kanalındaki uid'si.
    emitToUser(me, 'call:matched', {
      callId: call.id,
      endsAt,
      rtc: rtcCredentials(live.channel, me),
      peerUid: agoraUid(peer),
    });
  }

  live.timers.push(setTimeout(() => timesUp(call.id), CALL.anonSeconds * 1000));
  logger.info({ callId: call.id }, 'Arama eşleşti');
}

function timesUp(callId: string) {
  const c = calls.get(callId);
  if (!c || c.phase !== 'anon') return;
  c.phase = 'vote';
  const voteEndsAt = new Date(Date.now() + CALL.voteSeconds * 1000);
  for (const u of [c.a, c.b]) emitToUser(u, 'call:times_up', { callId, voteEndsAt });
  c.timers.push(
    setTimeout(() => {
      const cur = calls.get(callId);
      if (cur && cur.phase === 'vote') void end(callId, 'NO_KEEP');
    }, CALL.voteSeconds * 1000),
  );
}

/** "Konuşmaya devam" oyu. İkisi de verirse kimlikler açılır ve sohbet oluşur. */
async function keepTalking(userId: string, callId: string) {
  const c = loadMine(userId, callId);
  if (c.phase !== 'vote') throw AppError.badRequest('NOT_VOTING');
  c.keep.add(userId);
  emitToUser(peerOf(c, userId), 'call:peer_kept', { callId });
  if (c.keep.size < 2) return { waiting: true };

  c.phase = 'revealed';
  c.timers.forEach(clearTimeout);
  c.timers = [];

  const [ua, ub] = await Promise.all([
    prisma.user.findUniqueOrThrow({ where: { id: c.a } }),
    prisma.user.findUniqueOrThrow({ where: { id: c.b } }),
  ]);
  const conversationId = await openDirect(c.a, c.b);
  await prisma.call.update({ where: { id: callId }, data: { revealedAt: new Date(), conversationId } });

  emitToUser(c.a, 'call:revealed', { callId, peer: serializeUserSummary(ub), conversationId });
  emitToUser(c.b, 'call:revealed', { callId, peer: serializeUserSummary(ua), conversationId });
  return { waiting: false };
}

/** İkisi de istedi: aralarında kabul edilmiş birebir sohbet (varsa onu kullanır). */
async function openDirect(a: string, b: string) {
  const key = a < b ? `${a}:${b}` : `${b}:${a}`;
  const existing = await prisma.conversation.findUnique({ where: { type_pairKey: { type: 'DIRECT', pairKey: key } } });
  if (existing) {
    if (existing.status !== 'ACCEPTED') {
      await prisma.conversation.update({ where: { id: existing.id }, data: { status: 'ACCEPTED' } });
    }
    await prisma.conversationMember.updateMany({ where: { conversationId: existing.id }, data: { hidden: false } });
    return existing.id;
  }
  const created = await prisma.conversation.create({
    data: {
      type: 'DIRECT',
      status: 'ACCEPTED',
      pairKey: key,
      initiatorId: a,
      members: { create: [{ userId: a }, { userId: b }] },
    },
  });
  return created.id;
}

// ───────────────────────────── görüntülü ─────────────────────────────

/** Kimlikler açıldıktan sonra görüntülüye geçme isteği (isteyen öder). */
async function requestVideo(userId: string, callId: string) {
  const c = loadMine(userId, callId);
  if (c.phase !== 'revealed') throw AppError.badRequest('NOT_REVEALED');
  if (c.videoUntil && c.videoUntil > new Date()) throw AppError.conflict('VIDEO_ACTIVE');
  const user = await prisma.user.findUniqueOrThrow({ where: { id: userId }, select: { tokenBalance: true } });
  if (user.tokenBalance < TOKENS.videoCallPer15Min) {
    throw AppError.insufficientTokens(TOKENS.videoCallPer15Min, user.tokenBalance);
  }
  c.videoRequestedBy = userId;
  emitToUser(peerOf(c, userId), 'call:video_requested', { callId });
  return { requested: true };
}

async function respondVideo(userId: string, callId: string, accept: boolean) {
  const c = loadMine(userId, callId);
  const requester = c.videoRequestedBy;
  if (!requester || requester === userId) throw AppError.badRequest('NO_VIDEO_REQUEST');
  c.videoRequestedBy = null;
  if (!accept) {
    emitToUser(requester, 'call:video_declined', { callId });
    return { started: false };
  }

  const until = new Date(Date.now() + CALL.videoMinutes * 60 * 1000);
  const { balance } = await prisma.$transaction(async (tx) => {
    const spent = await tokenService.spend(tx, requester, TOKENS.videoCallPer15Min, 'VIDEO_CALL', `${callId}:${until.toISOString()}`);
    await tx.call.update({ where: { id: callId }, data: { videoMinutes: { increment: CALL.videoMinutes } } });
    return spent;
  });
  emitToUser(requester, 'tokens:updated', { balance, delta: -TOKENS.videoCallPer15Min, reason: 'VIDEO_CALL' });

  c.videoUntil = until;
  if (c.videoTimer) clearTimeout(c.videoTimer);
  c.videoTimer = setTimeout(() => {
    const cur = calls.get(callId);
    if (!cur) return;
    cur.videoUntil = null;
    for (const u of [cur.a, cur.b]) emitToUser(u, 'call:video_ended', { callId });
  }, CALL.videoMinutes * 60 * 1000);
  for (const u of [c.a, c.b]) emitToUser(u, 'call:video_started', { callId, until });
  return { started: true };
}

// ───────────────────────────── bitirme ─────────────────────────────

async function end(callId: string, reason: 'HANGUP' | 'TIMEOUT' | 'DISCONNECT' | 'NO_KEEP', by?: string) {
  const c = calls.get(callId);
  if (!c) return;
  calls.delete(callId);
  c.timers.forEach(clearTimeout);
  if (c.videoTimer) clearTimeout(c.videoTimer);
  for (const u of [c.a, c.b]) {
    if (userCall.get(u) === callId) userCall.delete(u);
    emitToUser(u, 'call:ended', { callId, reason, byPeer: Boolean(by && by !== u) });
  }
  await prisma.call
    .update({ where: { id: callId }, data: { endedAt: new Date(), endReason: reason } })
    .catch((err) => logger.warn({ err }, 'Arama kaydı güncellenemedi'));
}

async function hangUp(userId: string, callId: string) {
  loadMine(userId, callId);
  await end(callId, 'HANGUP', userId);
}

/** Son bağlantısı koptu: sıradan çıkar, kısa bir süre içinde dönmezse görüşmeyi bitir. */
function onDisconnect(userId: string) {
  leaveQueue(userId);
  const callId = userCall.get(userId);
  if (!callId) return;
  clearTimeout(graceTimers.get(userId));
  graceTimers.set(
    userId,
    setTimeout(() => {
      graceTimers.delete(userId);
      if (!presence.isOnline(userId) && userCall.get(userId) === callId) void end(callId, 'DISCONNECT', userId);
    }, CALL.disconnectGraceMs),
  );
}

/** Yeniden bağlandı: süren görüşmesi varsa durumu (yeni token ile) tekrar gönder. */
function onConnect(userId: string) {
  clearTimeout(graceTimers.get(userId));
  graceTimers.delete(userId);
}

export const callService = {
  joinQueue,
  leaveQueue,
  keepTalking,
  requestVideo,
  respondVideo,
  hangUp,
  onDisconnect,
  onConnect,
  /** Testler ve durum ekranı için. */
  stats: () => ({ waiting: queue.length, active: calls.size }),
};
