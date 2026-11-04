import { randomUUID } from 'node:crypto';
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
import { maskName } from '../utils/mask';
import { notificationService } from './notification.service';
import { safetyService } from './safety.service';
import { tokenService } from './token.service';

export const CALL = {
  /** Anonim sesli görüşme süresi (testte kısaltılabilir). */
  anonSeconds: !env.isProd && env.CALL_ANON_SECONDS ? env.CALL_ANON_SECONDS : 60,
  /** Süre dolunca "devam" oyları için bekleme. */
  voteSeconds: 10,
  /** Uygulama arkadayken de yetişilsin diye çalma süresi. */
  ringSeconds: 45,
  /** Sohbetten başlatılan birebir aramanın çalma süresi. */
  directRingSeconds: 30,
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
  persona?: boolean;
  /** Bu aramada daha önce teklif giden kullanıcılar. */
  asked?: Set<string>;
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
  /** Karşı taraf AI karakterse oyunu kendisi vermiş sayılır. */
  personaId: string | null;
  /** Sohbetten başlatılan birebir arama: süre/oy/ücret yok. */
  direct: boolean;
}

/** Sohbet başlığından başlatılan, karşı tarafta çalan birebir arama. */
interface DirectInvite {
  id: string;
  callerId: string;
  calleeId: string;
  conversationId: string;
  video: boolean;
  videoAllowed: boolean;
  timer: NodeJS.Timeout;
}

/** startCall seçeneği: birebir aramada 60 sn sınırı, oy, ücret ve tekrar eşleşme beklemesi yok. */
interface DirectStart {
  inviteId: string;
  conversationId: string;
  video: boolean;
  videoAllowed: boolean;
}

interface PendingInvite {
  id: string;
  caller: Ticket;
  calleeId: string;
  timer: NodeJS.Timeout;
}

const queue: Ticket[] = [];
const personaWait = new Map<string, NodeJS.Timeout>();
const invites = new Map<string, PendingInvite>();
const calls = new Map<string, LiveCall>();
const userCall = new Map<string, string>();
const recentPair = new Map<string, number>();
const graceTimers = new Map<string, NodeJS.Timeout>();
/** inviteId → çalan birebir arama. */
const directInvites = new Map<string, DirectInvite>();

/** Birebir araması çalan (arayan ya da aranan) kullanıcı. */
const isRinging = (userId: string) =>
  [...directInvites.values()].some((d) => d.callerId === userId || d.calleeId === userId);

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
  if (isRinging(me.userId) || isRinging(other.userId)) return false;
  if (me.target !== 'any' && other.gender !== TARGET_GENDER[me.target]) return false;
  if (other.target !== 'any' && me.gender !== TARGET_GENDER[other.target]) return false;
  return true;
}

const cooledDown = (x: string, y: string) => {
  const last = recentPair.get(pairKey(x, y));
  return !last || Date.now() - last > CALL.rematchCooldownMs;
};

/**
 * Sırada bekleyen uygun biri. Az önce konuşulan kişi ancak başka uygun kimse yoksa seçilir
 * (az kullanıcı varken aynı iki kişi beklemeden tekrar eşleşebilsin).
 */
function findQueuedPeer(me: Ticket): Ticket | undefined {
  const ok = queue.filter((t) => compatible(me, t));
  return ok.find((t) => cooledDown(me.userId, t.userId)) ?? ok[0];
}

function removeFromQueue(userId: string) {
  const i = queue.findIndex((t) => t.userId === userId);
  if (i >= 0) queue.splice(i, 1);
}

/**
 * Eşleşme sırasına girer. Uygun biri bekliyorsa hemen görüşme başlar, yoksa beklenir.
 * Cinsiyet seçen kişi eşleşince 10 token öder (iptal ederse ödemez).
 */
async function joinQueue(userId: string, target: CallTarget) {
  if (userCall.has(userId) || isRinging(userId)) throw AppError.conflict('ALREADY_IN_CALL');
  leaveQueue(userId);

  const user = await prisma.user.findUniqueOrThrow({ where: { id: userId } });
  if (!env.SKIP_TOKEN_SPEND && target !== 'any' && user.tokenBalance < TOKENS.callGenderFilter) {
    throw AppError.insufficientTokens(TOKENS.callGenderFilter, user.tokenBalance);
  }
  const me: Ticket = { userId, gender: user.gender, target, blocked: await safetyService.blockedIdsFor(userId) };

  const other = findQueuedPeer(me);
  if (!other) {
    queue.push(me);
    schedulePersonaMatch(userId);
    return { status: 'searching' as const, onlineCount: presence.onlineCount };
  }
  removeFromQueue(other.userId);
  clearPersonaWait(other.userId);
  clearPersonaWait(userId);
  cancelInvite(other.userId, false);
  cancelInvite(userId, false);
  await startCall(other, me);
  return { status: 'matched' as const };
}

function clearPersonaWait(userId: string) {
  const timer = personaWait.get(userId);
  if (!timer) return;
  clearTimeout(timer);
  personaWait.delete(userId);
}

/** Başka arayan yoksa kısa süre bekle, sonra çevrimiçi gerçek kullanıcıya bak. O da yoksa AI. */
function schedulePersonaMatch(userId: string) {
  clearPersonaWait(userId);
  personaWait.set(
    userId,
    setTimeout(() => {
      personaWait.delete(userId);
      void matchWaiting(userId).catch((err) => logger.warn({ err, userId }, 'Eşleşme başarısız'));
    }, 2500),
  );
}

async function matchWaiting(userId: string) {
  const me = queue.find((t) => t.userId === userId);
  if (!me || userCall.has(userId)) return;
  // Önce sırada bekleyen başka biri: sıraya girdikleri an kaçırılmış olabilir
  // (ör. biri bağlantısı kopup geri döndü). İkisi de arıyorsa onay beklemeden başlar.
  const other = findQueuedPeer(me);
  if (other) {
    removeFromQueue(userId);
    removeFromQueue(other.userId);
    clearPersonaWait(other.userId);
    cancelInvite(userId, false);
    cancelInvite(other.userId, false);
    await startCall(other, me);
    return;
  }
  const human = await matchOnlineHuman(userId);
  // AI karakter eşleşmesi kapalı. Gerçek kullanıcı yoksa aramaya devam edilir.
  // if (!human) await matchPersona(userId);
  if (!human && queue.some((t) => t.userId === userId)) schedulePersonaMatch(userId);
}

/** Uygulaması açık gerçek kullanıcıyı aramaya alır. Sırada araması gerekmez. */
async function matchOnlineHuman(userId: string) {
  if (invites.has(userId)) return true;
  const i = queue.findIndex((t) => t.userId === userId);
  if (i === -1 || userCall.has(userId)) return false;
  const me = queue[i]!;
  const busy = new Set([
    ...userCall.keys(),
    ...queue.map((t) => t.userId),
    ...[...directInvites.values()].flatMap((d) => [d.callerId, d.calleeId]),
  ]);
  const gender = me.target === 'any' ? undefined : TARGET_GENDER[me.target];
  let ids = presence
    .onlineUserIds()
    .filter((id) => id !== userId && !me.blocked.has(id) && !busy.has(id));
  // Soket kopuk olsa da (uygulama arkada) gerçek kullanıcıya ara.
  if (ids.length === 0) {
    const recent = await prisma.user.findMany({
      where: {
        id: { not: userId },
        isPersona: false,
        status: 'ACTIVE',
        onboardingCompleted: true,
        ...(gender ? { gender } : {}),
      },
      select: { id: true },
      orderBy: { lastSeenAt: 'desc' },
      take: 20,
    });
    ids = recent.map((u) => u.id).filter((id) => !me.blocked.has(id) && !busy.has(id));
  }
  if (ids.length === 0) return false;
  const users = await prisma.user.findMany({
    where: {
      id: { in: ids },
      isPersona: false,
      status: 'ACTIVE',
      onboardingCompleted: true,
      ...(gender ? { gender } : {}),
    },
    select: { id: true, gender: true },
  });
  const open: typeof users = [];
  for (const u of users) {
    if (await safetyService.isBlockedBetween(userId, u.id)) continue;
    open.push(u);
  }
  const fresh = open.filter((u) => {
    const last = recentPair.get(pairKey(userId, u.id));
    return !last || Date.now() - last > CALL.rematchCooldownMs;
  });
  const pool = fresh.length ? fresh : open;
  const pick = pool.find((u) => !me.asked?.has(u.id) && !invites.has(u.id) && ![...invites.values()].some((v) => v.calleeId === u.id));
  if (!pick) return false;

  me.asked ??= new Set();
  me.asked.add(pick.id);
  const invite: PendingInvite = {
    id: randomUUID(),
    caller: me,
    calleeId: pick.id,
    timer: setTimeout(() => cancelInvite(userId, true), CALL.ringSeconds * 1000),
  };
  invites.set(userId, invite);
  emitToUser(pick.id, 'call:incoming', { inviteId: invite.id });
  void notificationService.pushToUser(
    pick.id,
    (t) => ({
      title: t.incomingCallTitle,
      body: t.incomingCallBody,
      data: { type: 'call', inviteId: invite.id },
    }),
    { evenIfOnline: true },
  );
  logger.info({ caller: userId, callee: pick.id }, 'Anonim arama onayı istendi');
  return true;
}

function cancelInvite(callerId: string, resumeSearch: boolean) {
  const inv = invites.get(callerId);
  if (!inv) return;
  clearTimeout(inv.timer);
  invites.delete(callerId);
  emitToUser(inv.calleeId, 'call:invite_ended', { inviteId: inv.id });
  if (!resumeSearch || userCall.has(callerId)) return;
  if (!queue.some((t) => t.userId === callerId) && presence.isOnline(callerId)) queue.unshift(inv.caller);
  if (queue.some((t) => t.userId === callerId)) schedulePersonaMatch(callerId);
}

async function acceptInvite(userId: string, inviteId: string) {
  if (directInvites.has(inviteId)) return acceptDirect(userId, inviteId);
  const inv = [...invites.values()].find((v) => v.id === inviteId && v.calleeId === userId);
  if (!inv) throw AppError.notFound('INVITE_NOT_FOUND');
  clearTimeout(inv.timer);
  invites.delete(inv.caller.userId);
  clearPersonaWait(inv.caller.userId);
  const i = queue.findIndex((t) => t.userId === inv.caller.userId);
  if (i >= 0) queue.splice(i, 1);
  await startCall(inv.caller, {
    userId,
    gender: null,
    target: 'any',
    blocked: new Set(),
  });
  return { accepted: true };
}

function declineInvite(userId: string, inviteId: string) {
  const direct = directInvites.get(inviteId);
  if (direct) {
    if (direct.calleeId !== userId) return { declined: true };
    endDirectInvite(direct, 'DECLINED');
    return { declined: true };
  }
  const inv = [...invites.values()].find((v) => v.id === inviteId && v.calleeId === userId);
  if (!inv) return { declined: true };
  cancelInvite(inv.caller.userId, true);
  return { declined: true };
}

// AI karakter eşleşmesi kapalı.
// async function matchPersona(userId: string) {
//   const i = queue.findIndex((t) => t.userId === userId);
//   if (i === -1 || userCall.has(userId)) return;
//   const me = queue[i]!;
//   const gender = me.target === 'any' ? undefined : TARGET_GENDER[me.target];
//   const personas = await prisma.user.findMany({
//     where: {
//       isPersona: true,
//       status: 'ACTIVE',
//       ...(gender ? { gender } : {}),
//       id: { notIn: [userId, ...me.blocked] },
//     },
//     select: { id: true, gender: true },
//   });
//   const free = personas.filter((p) => !userCall.has(p.id));
//   const fresh = free.filter((p) => {
//     const last = recentPair.get(pairKey(userId, p.id));
//     return !last || Date.now() - last > CALL.rematchCooldownMs;
//   });
//   const pool = fresh.length ? fresh : free;
//   const pick = pool[Math.floor(Math.random() * pool.length)];
//   if (!pick) return;
//   queue.splice(i, 1);
//   await startCall(me, { userId: pick.id, gender: pick.gender, target: 'any', blocked: new Set(), persona: true });
// }

function leaveQueue(userId: string) {
  clearPersonaWait(userId);
  cancelInvite(userId, false);
  const i = queue.findIndex((t) => t.userId === userId);
  if (i >= 0) queue.splice(i, 1);
}

async function startCall(a: Ticket, b: Ticket, direct?: DirectStart) {
  const call = await prisma.call.create({
    data: {
      userAId: a.userId,
      userBId: b.userId,
      aFilter: a.target === 'any' ? null : a.target,
      bFilter: b.target === 'any' ? null : b.target,
      conversationId: direct?.conversationId ?? null,
    },
  });

  // Cinsiyet filtresi ücreti: eşleşme anında. Bakiye o arada yetmezse görüşme başlamaz.
  for (const t of [a, b]) {
    if (direct || t.target === 'any') continue;
    try {
      const { balance } = await prisma.$transaction((tx) =>
        tokenService.spend(tx, t.userId, TOKENS.callGenderFilter, 'CALL_GENDER_FILTER', call.id),
      );
      emitToUser(t.userId, 'tokens:updated', { balance, delta: -TOKENS.callGenderFilter, reason: 'CALL_GENDER_FILTER' });
    } catch (err) {
      await prisma.call.update({ where: { id: call.id }, data: { endedAt: new Date(), endReason: 'HANGUP' } });
      emitToUser(t.userId, 'call:error', { code: err instanceof AppError ? err.code : 'INTERNAL' });
      const other = t === a ? b : a;
      if (presence.isOnline(other.userId)) {
        queue.unshift(other);
        if (!other.persona) schedulePersonaMatch(other.userId);
      }
      return;
    }
  }

  const live: LiveCall = {
    id: call.id,
    a: a.userId,
    b: b.userId,
    channel: `call_${call.id}`,
    phase: direct ? 'revealed' : 'anon',
    keep: new Set(),
    timers: [],
    videoRequestedBy: null,
    videoUntil: null,
    videoTimer: null,
    personaId: a.persona ? a.userId : b.persona ? b.userId : null,
    direct: Boolean(direct),
  };
  calls.set(call.id, live);
  userCall.set(a.userId, call.id);
  userCall.set(b.userId, call.id);

  if (direct) {
    for (const [me, peer] of [
      [a.userId, b.userId],
      [b.userId, a.userId],
    ] as const) {
      emitToUser(me, 'call:direct_started', {
        callId: call.id,
        inviteId: direct.inviteId,
        conversationId: direct.conversationId,
        video: direct.video,
        videoAllowed: direct.videoAllowed,
        rtc: rtcCredentials(live.channel, me),
        peerUid: agoraUid(peer),
      });
    }
    logger.info({ callId: call.id, conversationId: direct.conversationId }, 'Birebir arama başladı');
    return;
  }

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
  if (c.personaId) c.keep.add(c.personaId);
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
  // Birebir aramada görüntü ücretsiz; kamera istemciden açılır.
  if (c.direct) throw AppError.badRequest('DIRECT_CALL');
  if (c.phase !== 'revealed') throw AppError.badRequest('NOT_REVEALED');
  if (c.videoUntil && c.videoUntil > new Date()) throw AppError.conflict('VIDEO_ACTIVE');
  const user = await prisma.user.findUniqueOrThrow({ where: { id: userId }, select: { tokenBalance: true } });
  if (!env.SKIP_TOKEN_SPEND && user.tokenBalance < TOKENS.videoCallPer15Min) {
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

// ───────────────────────────── birebir (sohbetten) ─────────────────────────────

type DirectEndReason = 'CANCELLED' | 'TIMEOUT' | 'DECLINED';

function endDirectInvite(d: DirectInvite, reason: DirectEndReason) {
  if (directInvites.get(d.id) !== d) return;
  clearTimeout(d.timer);
  directInvites.delete(d.id);
  emitToUser(d.calleeId, 'call:invite_ended', { inviteId: d.id, reason });
  if (reason === 'DECLINED') emitToUser(d.callerId, 'call:direct_declined', { inviteId: d.id });
  if (reason === 'TIMEOUT') emitToUser(d.callerId, 'call:direct_no_answer', { inviteId: d.id });
}

/** Aramada, sırada ya da çalan bir aramada mı. */
function isBusy(userId: string) {
  return (
    userCall.has(userId) ||
    queue.some((t) => t.userId === userId) ||
    invites.has(userId) ||
    [...invites.values()].some((v) => v.calleeId === userId) ||
    isRinging(userId)
  );
}

/** Sohbet başlığından birebir sesli/görüntülü arama başlatır; karşı tarafta 30 sn çalar. */
async function startDirect(userId: string, conversationId: string, video: boolean) {
  const c = await prisma.conversation.findUnique({
    where: { id: conversationId },
    include: { members: { include: { user: true } } },
  });
  const me = c?.members.find((m) => m.userId === userId);
  if (!c || !me) throw AppError.notFound('CONVERSATION_NOT_FOUND');
  if (c.type !== 'DIRECT' && c.type !== 'ANONYMOUS') throw AppError.badRequest('NOT_CALLABLE');
  if (c.status !== 'ACCEPTED') throw AppError.forbidden('REQUEST_NOT_ACCEPTED');
  const peer = c.members.find((m) => m.userId !== userId);
  if (!peer || peer.user.status !== 'ACTIVE' || peer.user.isPersona) throw AppError.badRequest('PEER_UNAVAILABLE');
  if (await safetyService.isBlockedBetween(userId, peer.userId)) throw AppError.forbidden('BLOCKED');
  const videoAllowed = c.type === 'DIRECT' || Boolean(c.revealedAt);
  if (video && !videoAllowed) throw AppError.forbidden('VIDEO_LOCKED');
  if (userCall.has(userId) || isRinging(userId)) throw AppError.conflict('ALREADY_IN_CALL');
  if (isBusy(peer.userId)) throw AppError.conflict('PEER_BUSY');
  // Rastgele arama sırasındaysa oradan çıkar.
  leaveQueue(userId);

  const anonymous = c.type === 'ANONYMOUS' && !c.revealedAt;
  const fullName = me.user.displayName ?? me.user.username ?? '';
  const name = anonymous && !me.nameShared && !me.profileShared ? maskName(fullName) : fullName;
  const avatarUrl = anonymous ? null : me.user.avatarUrl;

  const invite: DirectInvite = {
    id: randomUUID(),
    callerId: userId,
    calleeId: peer.userId,
    conversationId: c.id,
    video,
    videoAllowed,
    timer: setTimeout(() => {
      const cur = directInvites.get(invite.id);
      if (cur) endDirectInvite(cur, 'TIMEOUT');
    }, CALL.directRingSeconds * 1000),
  };
  directInvites.set(invite.id, invite);

  emitToUser(peer.userId, 'call:incoming', {
    inviteId: invite.id,
    kind: 'direct',
    conversationId: c.id,
    video,
    caller: { displayName: name, avatarUrl, isAi: me.user.isPersona },
  });
  void notificationService.pushToUser(
    peer.userId,
    (t) => ({
      title: t.incomingCallTitle,
      body: video ? t.directVideoCallBody(name) : t.directCallBody(name),
      data: {
        type: 'call',
        kind: 'direct',
        inviteId: invite.id,
        conversationId: c.id,
        video: video ? '1' : '0',
        name,
        avatarUrl: avatarUrl ?? '',
      },
    }),
    { evenIfOnline: true },
  );
  logger.info({ caller: userId, callee: peer.userId, conversationId: c.id, video }, 'Birebir arama çalıyor');
  return { inviteId: invite.id, ringSeconds: CALL.directRingSeconds };
}

/** Arayan vazgeçti. */
function cancelDirect(userId: string, inviteId: string) {
  const d = directInvites.get(inviteId);
  if (d && d.callerId === userId) endDirectInvite(d, 'CANCELLED');
  return { cancelled: true };
}

async function acceptDirect(userId: string, inviteId: string) {
  const d = directInvites.get(inviteId);
  if (!d || d.calleeId !== userId) throw AppError.notFound('INVITE_NOT_FOUND');
  if (userCall.has(userId)) throw AppError.conflict('ALREADY_IN_CALL');
  clearTimeout(d.timer);
  directInvites.delete(d.id);
  if (userCall.has(d.callerId)) {
    emitToUser(d.calleeId, 'call:invite_ended', { inviteId: d.id, reason: 'CANCELLED' });
    throw AppError.notFound('INVITE_NOT_FOUND');
  }
  // Aranan rastgele aramadaydıysa / ona başka arama çalıyorsa bırakılır.
  leaveQueue(userId);
  for (const inv of [...invites.values()]) {
    if (inv.calleeId === userId) cancelInvite(inv.caller.userId, true);
  }
  const ticket = (id: string): Ticket => ({ userId: id, gender: null, target: 'any', blocked: new Set() });
  await startCall(ticket(d.callerId), ticket(d.calleeId), {
    inviteId: d.id,
    conversationId: d.conversationId,
    video: d.video && d.videoAllowed,
    videoAllowed: d.videoAllowed,
  });
  return { accepted: true };
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
  // Arayanın bağlantısı koptu: çalma durur. Aranan çevrimdışıysa bildirimle çalmaya devam eder.
  for (const d of [...directInvites.values()]) {
    if (d.callerId === userId) endDirectInvite(d, 'CANCELLED');
  }
  for (const inv of [...invites.values()]) {
    if (inv.calleeId === userId) cancelInvite(inv.caller.userId, true);
  }
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
  acceptInvite,
  declineInvite,
  startDirect,
  cancelDirect,
  keepTalking,
  requestVideo,
  respondVideo,
  hangUp,
  onDisconnect,
  onConnect,
  /** Testler ve durum ekranı için. */
  stats: () => ({ waiting: queue.length, active: calls.size }),
};
