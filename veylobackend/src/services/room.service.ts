import { randomUUID } from 'node:crypto';
import type { Room, User } from '@prisma/client';
import { TOKENS } from '../config/constants';
import { AppError } from '../errors/AppError';
import { agoraUid, rtcCredentials } from '../lib/agora';
import { logger } from '../lib/logger';
import { prisma } from '../lib/prisma';
import { emitToChannel, emitToUser, joinChannel, leaveChannel } from '../realtime/emitter';
import { presence } from '../realtime/presence.store';
import { maskName } from '../utils/mask';
import { safetyService } from './safety.service';
import { tokenService } from './token.service';

export const ROOM = {
  titleMaxLength: 60,
  messageMaxLength: 300,
  /** Odada tutulan son sohbet mesajları (yeni gelen bunları görür). */
  historySize: 50,
  maxParticipants: 100,
  /** Sahip bağlantısı koparsa oda hemen kapanmaz. */
  hostGraceMs: 30_000,
} as const;

interface Participant {
  userId: string;
  anonymous: boolean;
  micOn: boolean;
  joinedAt: number;
  user: User;
}

interface ChatLine {
  id: string;
  sender: ReturnType<typeof publicParticipant>;
  body: string;
  at: Date;
}

interface LiveRoom {
  room: Room;
  participants: Map<string, Participant>;
  messages: ChatLine[];
  hostGrace: NodeJS.Timeout | null;
}

const live = new Map<string, LiveRoom>();
const channelOf = (roomId: string) => `live:${roomId}`;

/** Katılımcının herkese görünen hali. Anonimde id yok, ad maskeli, foto bulanık. */
function publicParticipant(p: Pick<Participant, 'anonymous' | 'micOn' | 'user'>, hostId: string) {
  const name = p.user.displayName ?? p.user.username;
  return {
    /** Agora kanalındaki uid: konuşan göstergesi bununla eşleşir. */
    uid: agoraUid(p.user.id),
    userId: p.anonymous ? null : p.user.id,
    username: p.anonymous ? null : p.user.username,
    displayName: p.anonymous ? maskName(name) : name,
    avatarUrl: p.anonymous ? p.user.avatarBlurUrl : p.user.avatarUrl,
    blurred: p.anonymous,
    isAi: p.user.isPersona,
    micOn: p.micOn,
    isHost: p.user.id === hostId,
  };
}

async function loadLive(roomId: string) {
  let r = live.get(roomId);
  if (r) return r;
  const room = await prisma.room.findUnique({ where: { id: roomId } });
  if (!room || room.endedAt) throw AppError.notFound('ROOM_NOT_FOUND');
  r = { room, participants: new Map(), messages: [], hostGrace: null };
  live.set(roomId, r);
  return r;
}

async function hasAccess(room: Room, userId: string) {
  if (!room.isPrivate || room.hostId === userId) return true;
  const req = await prisma.roomJoinRequest.findUnique({ where: { roomId_userId: { roomId: room.id, userId } } });
  return req?.status === 'APPROVED';
}

// ───────────────────────────── liste / oluşturma ─────────────────────────────

/** Rooms > canlı odalar: en kalabalık önce. */
async function list(viewerId: string) {
  const blocked = await safetyService.blockedIdsFor(viewerId);
  const rooms = await prisma.room.findMany({
    where: { endedAt: null, ...(blocked.size ? { hostId: { notIn: [...blocked] } } : {}) },
    include: { host: true },
    orderBy: { createdAt: 'desc' },
    take: 50,
  });
  const requests = await prisma.roomJoinRequest.findMany({
    where: { userId: viewerId, roomId: { in: rooms.map((r) => r.id) } },
  });
  const reqOf = new Map(requests.map((r) => [r.roomId, r.status]));

  const items = rooms.map((room) => {
    const lr = live.get(room.id);
    const people = lr ? [...lr.participants.values()] : [];
    const host = publicParticipant({ anonymous: room.hostAnonymous, micOn: true, user: room.host }, room.hostId);
    return {
      id: room.id,
      title: room.title,
      isPrivate: room.isPrivate,
      host,
      participantCount: people.length,
      avatars: people
        .slice(0, 5)
        .map((p) => publicParticipant(p, room.hostId).avatarUrl)
        .filter((u): u is string => Boolean(u)),
      isHost: room.hostId === viewerId,
      hasAccess: !room.isPrivate || room.hostId === viewerId || reqOf.get(room.id) === 'APPROVED',
      requested: reqOf.get(room.id) === 'PENDING',
      createdAt: room.createdAt,
    };
  });
  // Sahibi bağlı olmayan (henüz girmemiş) eski odaları gösterme.
  return items
    .filter((r) => r.participantCount > 0 || r.isHost)
    .sort((a, b) => b.participantCount - a.participantCount);
}

/** Oda açmak 50 token. Kişi başına aynı anda bir canlı oda. */
async function create(viewerId: string, input: { title: string; anonymous: boolean; isPrivate: boolean }) {
  const existing = await prisma.room.findFirst({ where: { hostId: viewerId, endedAt: null } });
  if (existing) await endRoom(existing.id, 'REPLACED');

  const room = await prisma.$transaction(async (tx) => {
    const created = await tx.room.create({
      data: { hostId: viewerId, title: input.title, isPrivate: input.isPrivate, hostAnonymous: input.anonymous },
    });
    const { balance } = await tokenService.spend(tx, viewerId, TOKENS.roomCreate, 'ROOM_CREATE', created.id);
    emitToUser(viewerId, 'tokens:updated', { balance, delta: -TOKENS.roomCreate, reason: 'ROOM_CREATE' });
    return created;
  });
  return { id: room.id, title: room.title, isPrivate: room.isPrivate };
}

// ───────────────────────────── canlı katılım (socket) ─────────────────────────────

/** Odaya gir: ses kanalı bilgisi + katılımcılar + son mesajlar. */
async function join(viewerId: string, roomId: string, anonymous: boolean) {
  const r = await loadLive(roomId);
  const { room } = r;
  if (room.hostId !== viewerId && (await safetyService.isBlockedBetween(viewerId, room.hostId))) {
    throw AppError.notFound('ROOM_NOT_FOUND');
  }
  if (!(await hasAccess(room, viewerId))) throw AppError.forbidden('ROOM_PRIVATE');
  if (!r.participants.has(viewerId) && r.participants.size >= ROOM.maxParticipants) throw AppError.conflict('ROOM_FULL');

  if (room.hostId === viewerId && r.hostGrace) {
    clearTimeout(r.hostGrace);
    r.hostGrace = null;
  }
  const user = await prisma.user.findUniqueOrThrow({ where: { id: viewerId } });
  const isHost = room.hostId === viewerId;
  const prev = r.participants.get(viewerId);
  const p: Participant = {
    userId: viewerId,
    anonymous: isHost ? room.hostAnonymous : (prev?.anonymous ?? anonymous),
    // Sahip mikrofonu açık girer, diğerleri kapalı.
    micOn: prev?.micOn ?? isHost,
    joinedAt: prev?.joinedAt ?? Date.now(),
    user,
  };
  r.participants.set(viewerId, p);
  joinChannel(viewerId, channelOf(roomId));
  if (!prev) emitToChannel(channelOf(roomId), 'room:participant_joined', { roomId, participant: publicParticipant(p, room.hostId) });

  return {
    room: { id: room.id, title: room.title, isPrivate: room.isPrivate, isHost },
    rtc: rtcCredentials(`room_${room.id}`, viewerId),
    me: publicParticipant(p, room.hostId),
    participants: [...r.participants.values()]
      .sort((a, b) => Number(b.userId === room.hostId) - Number(a.userId === room.hostId) || a.joinedAt - b.joinedAt)
      .map((x) => publicParticipant(x, room.hostId)),
    messages: r.messages,
  };
}

async function leave(viewerId: string, roomId: string) {
  const r = live.get(roomId);
  if (!r) return;
  if (r.hostGrace && r.room.hostId === viewerId) {
    clearTimeout(r.hostGrace);
    r.hostGrace = null;
  }
  const p = r.participants.get(viewerId);
  if (!p) return;
  const isHost = r.room.hostId === viewerId;
  r.participants.delete(viewerId);
  leaveChannel(viewerId, channelOf(roomId));
  emitToChannel(channelOf(roomId), 'room:participant_left', { roomId, uid: agoraUid(viewerId) });
  // İçeride biri varken oda açık kalır. Son kişi çıkınca kapanır.
  if (r.participants.size === 0) await endRoom(roomId, isHost ? 'HOST_LEFT' : 'EMPTY');
}

function setMic(viewerId: string, roomId: string, on: boolean) {
  const r = live.get(roomId);
  const p = r?.participants.get(viewerId);
  if (!r || !p) throw AppError.notFound('NOT_IN_ROOM');
  p.micOn = on;
  emitToChannel(channelOf(roomId), 'room:participant_updated', { roomId, participant: publicParticipant(p, r.room.hostId) });
  return { micOn: on };
}

function sendMessage(viewerId: string, roomId: string, body: string) {
  const r = live.get(roomId);
  const p = r?.participants.get(viewerId);
  if (!r || !p) throw AppError.notFound('NOT_IN_ROOM');
  const line: ChatLine = { id: randomUUID(), sender: publicParticipant(p, r.room.hostId), body, at: new Date() };
  r.messages = [...r.messages, line].slice(-ROOM.historySize);
  emitToChannel(channelOf(roomId), 'room:message', { roomId, message: line });
  return line;
}

async function endRoom(roomId: string, reason: 'HOST_LEFT' | 'REPLACED' | 'EMPTY') {
  const r = live.get(roomId);
  live.delete(roomId);
  if (r?.hostGrace) clearTimeout(r.hostGrace);
  emitToChannel(channelOf(roomId), 'room:ended', { roomId, reason });
  for (const userId of r?.participants.keys() ?? []) leaveChannel(userId, channelOf(roomId));
  await prisma.room.updateMany({ where: { id: roomId, endedAt: null }, data: { endedAt: new Date() } });
  logger.info({ roomId, reason }, 'Oda kapandı');
}

/** Son bağlantısı koptu. Sahip kısa süre geri gelebilir; oda, içinde biri varken kapanmaz. */
function onDisconnect(userId: string) {
  for (const [roomId, r] of live) {
    if (!r.participants.has(userId)) continue;
    if (r.room.hostId !== userId) {
      void leave(userId, roomId);
      continue;
    }
    if (r.hostGrace) clearTimeout(r.hostGrace);
    r.hostGrace = setTimeout(() => {
      r.hostGrace = null;
      if (presence.isOnline(userId)) return;
      void leave(userId, roomId);
    }, ROOM.hostGraceMs);
  }
}

// ───────────────────────────── gizli oda istekleri ─────────────────────────────

async function requestJoin(viewerId: string, roomId: string, input: { message?: string; anonymous: boolean }) {
  const room = await prisma.room.findUnique({ where: { id: roomId }, include: { host: true } });
  if (!room || room.endedAt) throw AppError.notFound('ROOM_NOT_FOUND');
  if (!room.isPrivate) throw AppError.badRequest('ROOM_IS_PUBLIC');
  const req = await prisma.roomJoinRequest.upsert({
    where: { roomId_userId: { roomId, userId: viewerId } },
    create: { roomId, userId: viewerId, message: input.message, anonymous: input.anonymous },
    update: { message: input.message, anonymous: input.anonymous, status: 'PENDING' },
    include: { user: true },
  });
  const who = publicParticipant({ anonymous: req.anonymous, micOn: false, user: req.user }, room.hostId);
  emitToUser(room.hostId, 'room:request', { roomId, requestId: req.id, title: room.title, name: who.displayName });
  return { status: req.status };
}

async function listRequests(viewerId: string, roomId: string) {
  const room = await prisma.room.findUnique({ where: { id: roomId } });
  if (!room || room.hostId !== viewerId) throw AppError.forbidden('NOT_ROOM_HOST');
  const rows = await prisma.roomJoinRequest.findMany({
    where: { roomId, status: 'PENDING' },
    include: { user: true },
    orderBy: { createdAt: 'asc' },
  });
  return rows.map((r) => ({
    id: r.id,
    message: r.message,
    user: publicParticipant({ anonymous: r.anonymous, micOn: false, user: r.user }, room.hostId),
  }));
}

async function decideRequest(viewerId: string, roomId: string, requestId: string, approve: boolean) {
  const room = await prisma.room.findUnique({ where: { id: roomId } });
  if (!room || room.hostId !== viewerId) throw AppError.forbidden('NOT_ROOM_HOST');
  const req = await prisma.roomJoinRequest.findFirst({ where: { id: requestId, roomId, status: 'PENDING' } });
  if (!req) throw AppError.notFound('REQUEST_NOT_FOUND');
  await prisma.roomJoinRequest.update({ where: { id: req.id }, data: { status: approve ? 'APPROVED' : 'REJECTED' } });
  if (approve) emitToUser(req.userId, 'room:approved', { roomId, title: room.title });
  return listRequests(viewerId, roomId);
}

export const roomService = {
  list,
  create,
  join,
  leave,
  setMic,
  sendMessage,
  requestJoin,
  listRequests,
  decideRequest,
  onDisconnect,
};
