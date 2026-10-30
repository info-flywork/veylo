import { randomUUID } from 'node:crypto';
import { Prisma, type ConversationType, type Message, type MessageType, type User } from '@prisma/client';
import { CHAT, CONNECTION } from '../config/constants';
import { AppError } from '../errors/AppError';
import { chatEvents } from '../events/chat.events';
import { logger } from '../lib/logger';
import { prisma } from '../lib/prisma';
import { emitToUser } from '../realtime/emitter';
import { presence } from '../realtime/presence.store';
import {
  isIdentityHidden,
  peerOf,
  serializeConversation,
  serializeMessage,
  type ConversationFull,
} from '../serializers/conversation.serializer';
import { maskName, pairKey } from '../utils/mask';
import { mediaService } from './media.service';
import { notificationService } from './notification.service';
import { safetyService } from './safety.service';

const include = { members: { include: { user: true } } } as const;

/**
 * Aynı sohbete gelen mesajlar satır kilidiyle sırayla yazılır. Kalabalık anlarda (ör. grup)
 * sıradaki işlemler bekleyebilsin diye Prisma'nın 2 sn / 5 sn varsayılanları yükseltildi.
 */
const TX_OPTIONS = { maxWait: 10_000, timeout: 15_000 } as const;

// ───────────────────────────── yardımcılar ─────────────────────────────

async function loadForMember(conversationId: string, viewerId: string): Promise<ConversationFull> {
  const c = await prisma.conversation.findUnique({ where: { id: conversationId }, include });
  if (!c || !c.members.some((m) => m.userId === viewerId)) throw AppError.notFound('CONVERSATION_NOT_FOUND');
  return c;
}

async function contextFor(c: ConversationFull, viewerId: string) {
  const peer = c.type === 'GROUP' ? null : peerOf(c, viewerId);
  return {
    restrictedByPeer: peer ? await safetyService.restrictedBy(peer.userId, viewerId) : false,
    isOnline: (id: string) => presence.isOnline(id),
  };
}

async function serializeFor(c: ConversationFull, viewerId: string) {
  return serializeConversation(c, viewerId, await contextFor(c, viewerId));
}

/** Sohbetin güncel halini her üyeye kendi bakış açısıyla gönderir. */
async function broadcastConversation(c: ConversationFull) {
  await Promise.all(
    c.members.map(async (m) => emitToUser(m.userId, 'conversation:updated', await serializeFor(c, m.userId))),
  );
}

function previewOf(type: MessageType, body?: string | null) {
  if (type === 'IMAGE') return '📷 Photo';
  if (type === 'VOICE') return '🎤 Voice message';
  if (type === 'SYSTEM') {
    if (body === 'unlock:initial:approved') return 'Name shared';
    if (body === 'unlock:initial:rejected') return 'Name request declined';
    return 'Unlock request';
  }
  return (body ?? '').slice(0, 120);
}

function nextProgress(current: number, lastSenderId: string | null, senderId: string) {
  const gain = lastSenderId && lastSenderId !== senderId ? CONNECTION.turnGain : CONNECTION.sameSenderGain;
  return Math.min(100, current + gain);
}

// ───────────────────────────── listeleme ─────────────────────────────

async function list(viewerId: string, box: 'inbox' | 'requests') {
  const requestSince = new Date(Date.now() - CHAT.requestTtlDays * 24 * 60 * 60 * 1000);
  const boxFilter: Prisma.ConversationWhereInput =
    box === 'inbox'
      ? { OR: [{ status: 'ACCEPTED' }, { status: 'PENDING', initiatorId: viewerId }] }
      : { status: 'PENDING', initiatorId: { not: viewerId }, createdAt: { gte: requestSince } };

  const rows = await prisma.conversation.findMany({
    where: { members: { some: { userId: viewerId, hidden: false } }, ...boxFilter },
    include,
    orderBy: [{ lastMessageAt: 'desc' }, { createdAt: 'desc' }],
    take: 200,
  });

  const blocked = await safetyService.blockedIdsFor(viewerId);
  const visible = rows.filter((c) => {
    if (c.type === 'GROUP') return true;
    const peer = peerOf(c, viewerId);
    // Mesajı olmayan birebir sohbetler listede görünmez.
    return peer && !peer.user.isPersona && !blocked.has(peer.userId) && c.lastSeq > 0;
  });

  // Beni kısıtlayan karşı taraflar (tek sorguda).
  const peerIds = visible.map((c) => peerOf(c, viewerId)?.userId).filter((id): id is string => Boolean(id));
  const restricting = new Set(
    (
      await prisma.block.findMany({
        where: { type: 'RESTRICT', blockedId: viewerId, blockerId: { in: peerIds } },
        select: { blockerId: true },
      })
    ).map((r) => r.blockerId),
  );

  const items = visible.map((c) => {
    const peerId = peerOf(c, viewerId)?.userId;
    return serializeConversation(c, viewerId, {
      restrictedByPeer: peerId ? restricting.has(peerId) : false,
      isOnline: (id) => presence.isOnline(id),
    });
  });
  // Sabitlenenler en üstte.
  items.sort((a, b) => Number(b.pinned) - Number(a.pinned));
  return items;
}

async function get(viewerId: string, conversationId: string) {
  return serializeFor(await loadForMember(conversationId, viewerId), viewerId);
}

// ───────────────────────────── başlatma ─────────────────────────────

async function openPair(
  viewerId: string,
  targetId: string,
  type: Extract<ConversationType, 'DIRECT' | 'ANONYMOUS'>,
  contextQuote?: string,
) {
  if (viewerId === targetId) throw AppError.badRequest('CANNOT_CHAT_SELF');
  const target = await prisma.user.findUnique({ where: { id: targetId }, select: { status: true } });
  if (!target || target.status !== 'ACTIVE' || (await safetyService.isBlockedBetween(viewerId, targetId))) {
    throw AppError.notFound('USER_NOT_FOUND');
  }

  const key = pairKey(viewerId, targetId);
  const existing = await prisma.conversation.findUnique({ where: { type_pairKey: { type, pairKey: key } } });
  if (existing) {
    await prisma.conversationMember.update({
      where: { conversationId_userId: { conversationId: existing.id, userId: viewerId } },
      data: { hidden: false },
    });
    return get(viewerId, existing.id);
  }

  // Karşı taraf beni takip ediyorsa direkt sohbet hemen açılır, değilse mesaj isteği olur.
  // Anonim sohbetler her zaman istek olarak başlar.
  let status: 'ACCEPTED' | 'PENDING' = 'PENDING';
  if (type === 'DIRECT') {
    const followsMe = await prisma.follow.findUnique({
      where: { followerId_followingId: { followerId: targetId, followingId: viewerId } },
    });
    if (followsMe) status = 'ACCEPTED';
  }

  try {
    const created = await prisma.conversation.create({
      data: {
        type,
        status,
        pairKey: key,
        initiatorId: viewerId,
        contextQuote,
        members: { create: [{ userId: viewerId }, { userId: targetId }] },
      },
    });
    return get(viewerId, created.id);
  } catch (err) {
    // Aynı anda iki taraf da başlattıysa ikinci istek mevcut sohbeti alır.
    if (err instanceof Prisma.PrismaClientKnownRequestError && err.code === 'P2002') {
      const again = await prisma.conversation.findUniqueOrThrow({ where: { type_pairKey: { type, pairKey: key } } });
      return get(viewerId, again.id);
    }
    throw err;
  }
}

const createDirect = (viewerId: string, targetId: string) => openPair(viewerId, targetId, 'DIRECT');
const createAnonymous = (viewerId: string, targetId: string, contextQuote?: string) =>
  openPair(viewerId, targetId, 'ANONYMOUS', contextQuote);

// ───────────────────────────── mesajlar ─────────────────────────────

interface SendInput {
  clientMsgId: string;
  type: 'TEXT' | 'IMAGE' | 'VOICE';
  body?: string;
  mediaId?: string;
}

/**
 * Tek mesaj gönderme yolu (REST ve Socket.IO ikisi de bunu çağırır).
 * Aynı clientMsgId tekrar gelirse yeni mesaj yazılmaz, ilki döner.
 */
async function send(viewerId: string, conversationId: string, input: SendInput, asSystem = false) {
  // Tekrar gönderim: aynı clientMsgId'li mesaj zaten yazıldıysa onu döndür.
  const dup = await prisma.message.findUnique({
    where: { senderId_clientMsgId: { senderId: viewerId, clientMsgId: input.clientMsgId } },
    include: { conversation: { select: { type: true, revealedAt: true } } },
  });
  if (dup) return { message: serializeMessage(dup, dup.conversation, viewerId), duplicate: true };

  const c = await loadForMember(conversationId, viewerId);
  await assertCanSend(c, viewerId);
  const media =
    input.type !== 'TEXT' && input.mediaId
      ? await mediaService.resolveForMessage(viewerId, input.mediaId, input.type)
      : null;

  const storedType = asSystem ? 'SYSTEM' : input.type;
  const preview = asSystem ? 'Unlock request' : previewOf(input.type, input.body);
  const growsConnection = !asSystem && c.type === 'ANONYMOUS' && !c.revealedAt && c.status === 'ACCEPTED';
  let message: Message;
  let progress = c.connectionProgress;

  // Veritabanı uzaktaysa her sorgu gidip geliyor; bu yüzden işlem içindeki sorgu sayısı az tutuluyor.
  try {
    message = await prisma.$transaction(async (tx) => {
      // Satır kilidi: aynı sohbete eşzamanlı mesajlar sırayla seq alır.
      const [row] = await tx.$queryRaw<
        { last_seq: number; last_sender_id: string | null; connection_progress: number }[]
      >`SELECT last_seq, last_sender_id, connection_progress FROM conversations WHERE id = ${c.id} FOR UPDATE`;
      const seq = Number(row!.last_seq) + 1;
      if (growsConnection) progress = nextProgress(Number(row!.connection_progress), row!.last_sender_id, viewerId);

      const msg: Message = {
        id: randomUUID(),
        conversationId: c.id,
        seq,
        senderId: viewerId,
        clientMsgId: input.clientMsgId,
        type: storedType,
        body: input.body ?? null,
        mediaId: media?.id ?? null,
        mediaUrl: media?.url ?? null,
        createdAt: new Date(),
      };
      await tx.message.createMany({ data: [msg] });
      await tx.conversation.updateMany({
        where: { id: c.id },
        data: {
          lastSeq: seq,
          lastSenderId: viewerId,
          lastMessageAt: msg.createdAt,
          lastMessagePreview: preview,
          ...(growsConnection ? { connectionProgress: progress } : {}),
        },
      });
      return msg;
    }, TX_OPTIONS);
  } catch (err) {
    if (err instanceof Prisma.PrismaClientKnownRequestError && err.code === 'P2002') {
      const existing = await prisma.message.findUniqueOrThrow({
        where: { senderId_clientMsgId: { senderId: viewerId, clientMsgId: input.clientMsgId } },
      });
      return { message: serializeMessage(existing, c, viewerId), duplicate: true };
    }
    throw err;
  }

  // Kilit dışında ve kritik değil: mesaj zaten kaydedildi, bunlar başarısız olsa da gönderim geçerli.
  // Kendi mesajım okunmuş sayılır (tek satır, birincil anahtarla).
  await prisma.conversationMember
    .updateMany({
      where: { conversationId: c.id, userId: viewerId, lastReadSeq: { lt: message.seq } },
      data: { lastReadSeq: message.seq },
    })
    .catch((err) => logger.warn({ err }, 'lastReadSeq güncellenemedi'));
  // Sohbeti silmiş üye varsa yeni mesajla tekrar görünür olur.
  const hiddenIds = c.members.filter((m) => m.hidden).map((m) => m.userId);
  if (hiddenIds.length) {
    await prisma.conversationMember
      .updateMany({ where: { conversationId: c.id, userId: { in: hiddenIds } }, data: { hidden: false } })
      .catch((err) => logger.warn({ err }, 'Sohbet görünür yapılamadı'));
  }

  // Sohbetin güncel hali: veritabanından tekrar okumak yerine bellekte güncellenir.
  const fresh: ConversationFull = {
    ...c,
    lastSeq: message.seq,
    lastSenderId: viewerId,
    lastMessageAt: message.createdAt,
    lastMessagePreview: preview,
    connectionProgress: progress,
    members: c.members.map((m) => ({
      ...m,
      hidden: false,
      lastReadSeq: m.userId === viewerId ? message.seq : m.lastReadSeq,
    })),
  };
  // İletim ve push arka planda: gönderenin onayı bunları beklemez.
  void fanOutMessage(fresh, message, viewerId).catch((err) => logger.warn({ err }, 'Mesaj iletimi başarısız'));
  chatEvents.emit('message:sent', { conversation: fresh, message, senderId: viewerId });
  return { message: serializeMessage(message, fresh, viewerId), duplicate: false };
}

/** Anonim sohbette bir kilidi erkenden istemek. Karşı tarafın sohbetinde bir satır olarak durur. */
async function requestUnlock(
  viewerId: string,
  conversationId: string,
  milestone: 'initial' | 'photo' | 'full',
) {
  const c = await loadForMember(conversationId, viewerId);
  if (c.type !== 'ANONYMOUS') throw AppError.badRequest('NOT_ANONYMOUS');
  if (milestone === 'initial') {
    const peer = peerOf(c, viewerId);
    if (peer?.nameShared) throw AppError.badRequest('NAME_ALREADY_SHARED');
    const pending = await prisma.message.findFirst({
      where: { conversationId, senderId: viewerId, type: 'SYSTEM', body: 'unlock:initial' },
    });
    if (pending) return serializeMessage(pending, c, viewerId);
  }
  const { message } = await send(
    viewerId,
    conversationId,
    { clientMsgId: randomUUID(), type: 'TEXT', body: `unlock:${milestone}` },
    true,
  );
  return message;
}

/** İsim isteğini karşı taraf onaylar veya reddeder. Onayda adı kalıcı açılır. */
async function respondUnlock(
  viewerId: string,
  conversationId: string,
  messageId: string,
  decision: 'approve' | 'reject',
) {
  const c = await loadForMember(conversationId, viewerId);
  if (c.type !== 'ANONYMOUS') throw AppError.badRequest('NOT_ANONYMOUS');
  const msg = await prisma.message.findFirst({ where: { id: messageId, conversationId: c.id } });
  if (!msg || msg.type !== 'SYSTEM' || msg.body !== 'unlock:initial') {
    throw AppError.badRequest('UNLOCK_NOT_PENDING');
  }
  if (msg.senderId === viewerId) throw AppError.forbidden('CANNOT_RESPOND_OWN_REQUEST');

  const approved = decision === 'approve';
  const body = approved ? 'unlock:initial:approved' : 'unlock:initial:rejected';
  const preview = approved ? 'Name shared' : 'Name request declined';
  await prisma.$transaction([
    prisma.message.update({ where: { id: msg.id }, data: { body } }),
    ...(approved
      ? [
          prisma.conversationMember.update({
            where: { conversationId_userId: { conversationId: c.id, userId: viewerId } },
            data: { nameShared: true },
          }),
        ]
      : []),
    ...(c.lastSeq === msg.seq
      ? [prisma.conversation.update({ where: { id: c.id }, data: { lastMessagePreview: preview } })]
      : []),
  ]);

  const fresh = await loadForMember(conversationId, viewerId);
  const updated = { ...msg, body };
  await fanOutMessage(fresh, updated, viewerId);
  return {
    message: serializeMessage(updated, fresh, viewerId),
    conversation: await serializeFor(fresh, viewerId),
  };
}

async function assertCanSend(c: ConversationFull, viewerId: string) {
  if (c.status === 'REJECTED') throw AppError.forbidden('CONVERSATION_REJECTED');

  if (c.type !== 'GROUP') {
    const peer = peerOf(c, viewerId);
    if (!peer || peer.user.status !== 'ACTIVE') throw AppError.forbidden('PEER_UNAVAILABLE');
    if (await safetyService.isBlockedBetween(viewerId, peer.userId)) throw AppError.forbidden('BLOCKED');
  }

  if (c.status === 'PENDING') {
    if (c.initiatorId !== viewerId) throw AppError.forbidden('REQUEST_NOT_ACCEPTED', 'Önce isteği onayla');
    const sent = await prisma.message.count({ where: { conversationId: c.id, senderId: viewerId } });
    if (sent >= CHAT.pendingMessageLimit) {
      throw AppError.forbidden('REQUEST_PENDING_LIMIT', 'Karşı taraf onaylayana kadar başka mesaj gönderilemez');
    }
  }
}

/** Mesajı üyelere iletir (her biri kendi bakış açısıyla), çevrimdışı olanlara push atar. */
async function fanOutMessage(c: ConversationFull, message: Parameters<typeof serializeMessage>[0], senderId: string) {
  const senderMember = c.members.find((m) => m.userId === senderId)!;
  const sender = senderMember.user;
  // Anonim sohbet ya da grupta "Hesabımı gizle": bildirimde de maskeli ad.
  const hidden = isIdentityHidden(c) || senderMember.anonymous;
  // Üyeler arasındaki kısıtlamalar tek sorguda (üye başına ayrı sorgu yerine).
  const memberIds = c.members.map((m) => m.userId);
  const restrictions = await prisma.block.findMany({
    where: { type: 'RESTRICT', blockerId: { in: memberIds }, blockedId: { in: memberIds } },
    select: { blockerId: true, blockedId: true },
  });
  const restricted = (by: string, viewer: string) =>
    restrictions.some((r) => r.blockerId === by && r.blockedId === viewer);
  const ctxFor = (viewer: string) => {
    const peer = c.type === 'GROUP' ? null : peerOf(c, viewer);
    return {
      restrictedByPeer: peer ? restricted(peer.userId, viewer) : false,
      isOnline: (id: string) => presence.isOnline(id),
    };
  };

  await Promise.all(
    c.members.map(async (m) => {
      emitToUser(m.userId, 'message:new', {
        message: serializeMessage(message, c, m.userId),
        conversation: serializeConversation(c, m.userId, ctxFor(m.userId)),
      });
      if (m.userId === senderId || m.muted) return;

      const name = hidden ? maskName(sender.displayName ?? sender.username) : (sender.displayName ?? sender.username ?? 'Veylo');
      const isRequest = c.status === 'PENDING';
      await notificationService.pushToUser(m.userId, (t) => {
        const title = c.type === 'GROUP' ? `${name} · ${c.title ?? t.group}` : name;
        const body =
          message.type === 'IMAGE' ? t.photo : message.type === 'VOICE' ? t.voice : previewOf(message.type, message.body);
        return {
          title: isRequest ? t.messageRequestTitle : title,
          body: isRequest ? t.messageRequestBody(title) : body,
          data: { type: 'message', conversationId: c.id },
          threadId: c.id,
        };
      });
    }),
  );
}

async function messages(
  viewerId: string,
  conversationId: string,
  q: { beforeSeq?: number; afterSeq?: number; limit: number },
) {
  const c = await loadForMember(conversationId, viewerId);
  const me = c.members.find((m) => m.userId === viewerId)!;
  const floor = me.clearedSeq;

  let rows;
  if (q.afterSeq !== undefined) {
    rows = await prisma.message.findMany({
      where: { conversationId: c.id, seq: { gt: Math.max(q.afterSeq, floor) } },
      orderBy: { seq: 'asc' },
      take: q.limit,
    });
  } else {
    rows = await prisma.message.findMany({
      where: {
        conversationId: c.id,
        seq: { gt: floor, ...(q.beforeSeq ? { lt: q.beforeSeq } : {}) },
      },
      orderBy: { seq: 'desc' },
      take: q.limit,
    });
    rows.reverse();
  }

  // Grupta ayrılmış üyelerin eski mesajları da gönderen bilgisiyle (maskeli) gösterilir.
  let former: Map<string, User> | undefined;
  if (c.type === 'GROUP') {
    const memberIds = new Set(c.members.map((m) => m.userId));
    const missing = [...new Set(rows.map((m) => m.senderId))].filter((id) => !memberIds.has(id));
    if (missing.length) {
      former = new Map((await prisma.user.findMany({ where: { id: { in: missing } } })).map((u) => [u.id, u]));
    }
  }

  return {
    items: rows.map((m) => serializeMessage(m, c, viewerId, former)),
    lastSeq: c.lastSeq,
    hasMore: q.afterSeq !== undefined ? rows.length === q.limit : (rows[0]?.seq ?? 0) > floor + 1,
  };
}

async function markRead(viewerId: string, conversationId: string, seq: number) {
  const c = await loadForMember(conversationId, viewerId);
  const target = Math.min(seq, c.lastSeq);
  const res = await prisma.conversationMember.updateMany({
    where: { conversationId: c.id, userId: viewerId, lastReadSeq: { lt: target } },
    data: { lastReadSeq: target },
  });
  if (res.count === 0) return { seq: target };

  // "Görüldü" bilgisi: kısıtladığım kişiye gönderilmez.
  await Promise.all(
    c.members
      .filter((m) => m.userId !== viewerId)
      .map(async (m) => {
        if (await safetyService.restrictedBy(viewerId, m.userId)) return;
        emitToUser(m.userId, 'conversation:read', { conversationId: c.id, seq: target });
      }),
  );
  return { seq: target };
}

// ───────────────────────────── istekler ─────────────────────────────

async function approve(viewerId: string, conversationId: string) {
  const c = await loadForMember(conversationId, viewerId);
  if (c.status !== 'PENDING' || c.initiatorId === viewerId) throw AppError.badRequest('NOT_A_PENDING_REQUEST');
  await prisma.conversation.update({ where: { id: c.id }, data: { status: 'ACCEPTED' } });
  const fresh = await loadForMember(conversationId, viewerId);
  await broadcastConversation(fresh);
  return serializeFor(fresh, viewerId);
}

async function reject(viewerId: string, conversationId: string) {
  const c = await loadForMember(conversationId, viewerId);
  if (c.status !== 'PENDING' || c.initiatorId === viewerId) throw AppError.badRequest('NOT_A_PENDING_REQUEST');
  await prisma.$transaction([
    prisma.conversation.update({ where: { id: c.id }, data: { status: 'REJECTED' } }),
    prisma.conversationMember.update({
      where: { conversationId_userId: { conversationId: c.id, userId: viewerId } },
      data: { hidden: true },
    }),
  ]);
  // Gönderen tarafa "reddedildi" demek yerine sessizce durumu güncelliyoruz.
  const fresh = await loadForMember(conversationId, viewerId);
  await broadcastConversation(fresh);
}

// ───────────────────────────── anonim → açılma ─────────────────────────────

async function reveal(viewerId: string, conversationId: string) {
  const c = await loadForMember(conversationId, viewerId);
  if (c.type !== 'ANONYMOUS') throw AppError.badRequest('NOT_ANONYMOUS');
  if (c.revealedAt) return serializeFor(c, viewerId);
  if (c.connectionProgress < CONNECTION.milestones.reveal) throw AppError.forbidden('CONNECTION_NOT_READY');

  await prisma.$transaction(async (tx) => {
    await tx.conversationMember.update({
      where: { conversationId_userId: { conversationId: c.id, userId: viewerId } },
      data: { revealConsent: true },
    });
    const members = await tx.conversationMember.findMany({ where: { conversationId: c.id } });
    if (members.every((m) => m.revealConsent)) {
      await tx.conversation.update({ where: { id: c.id }, data: { revealedAt: new Date() } });
    }
  });

  const fresh = await loadForMember(conversationId, viewerId);
  await broadcastConversation(fresh);
  if (!fresh.revealedAt) chatEvents.emit('reveal:consent', { conversationId: c.id, userId: viewerId });
  if (fresh.revealedAt) {
    await Promise.all(
      fresh.members.map((m) =>
        notificationService.pushToUser(m.userId, (t) => ({
          title: t.revealTitle,
          body: t.revealBody,
          data: { type: 'reveal', conversationId: fresh.id },
          threadId: fresh.id,
        })),
      ),
    );
  }
  return serializeFor(fresh, viewerId);
}

// ───────────────────────────── ayarlar / silme ─────────────────────────────

async function updateSettings(viewerId: string, conversationId: string, data: { pinned?: boolean; muted?: boolean }) {
  await loadForMember(conversationId, viewerId);
  await prisma.conversationMember.update({
    where: { conversationId_userId: { conversationId, userId: viewerId } },
    data,
  });
  return get(viewerId, conversationId);
}

/** Sadece benim için siler: geçmiş gizlenir, yeni mesaj gelirse sohbet tekrar görünür. */
async function deleteForMe(viewerId: string, conversationId: string) {
  const c = await loadForMember(conversationId, viewerId);
  await prisma.conversationMember.update({
    where: { conversationId_userId: { conversationId: c.id, userId: viewerId } },
    data: { clearedSeq: c.lastSeq, lastReadSeq: c.lastSeq, hidden: true, pinned: false },
  });
}

/** Ayarlar > "Delete Conversation": tüm sohbetler. */
async function deleteAllForMe(viewerId: string) {
  const memberships = await prisma.conversationMember.findMany({
    where: { userId: viewerId },
    select: { conversationId: true, conversation: { select: { lastSeq: true } } },
  });
  await prisma.$transaction(
    memberships.map((m) =>
      prisma.conversationMember.update({
        where: { conversationId_userId: { conversationId: m.conversationId, userId: viewerId } },
        data: { clearedSeq: m.conversation.lastSeq, lastReadSeq: m.conversation.lastSeq, hidden: true, pinned: false },
      }),
    ),
  );
  return { deleted: memberships.length };
}

// ───────────────────────────── güvenlik (sohbet içinden) ─────────────────────────────

/** Anonim sohbette istemci karşı tarafın id'sini bilmez; engelleme sohbet üzerinden yapılır. */
async function blockPeer(viewerId: string, conversationId: string) {
  const c = await loadForMember(conversationId, viewerId);
  const peer = c.type === 'GROUP' ? null : peerOf(c, viewerId);
  if (!peer) throw AppError.badRequest('NO_PEER');
  await safetyService.setBlock(viewerId, peer.userId, 'BLOCK', isIdentityHidden(c));
  await prisma.conversationMember.update({
    where: { conversationId_userId: { conversationId: c.id, userId: viewerId } },
    data: { hidden: true },
  });
}

async function reportPeer(
  viewerId: string,
  conversationId: string,
  input: { reason: Prisma.ReportCreateInput['reason']; details?: string; alsoBlock: boolean },
) {
  const c = await loadForMember(conversationId, viewerId);
  const peer = c.type === 'GROUP' ? null : peerOf(c, viewerId);
  if (!peer) throw AppError.badRequest('NO_PEER');
  const result = await safetyService.report({
    reporterId: viewerId,
    targetUserId: peer.userId,
    context: 'CHAT',
    conversationId: c.id,
    reason: input.reason,
    details: input.details,
  });
  if (input.alsoBlock) await blockPeer(viewerId, conversationId);
  return result;
}

/** "Yazıyor…" gibi geçici olaylar için: viewer üye mi, kime iletilmeli? */
async function recipientsFor(viewerId: string, conversationId: string): Promise<string[]> {
  const members = await prisma.conversationMember.findMany({
    where: { conversationId },
    select: { userId: true },
  });
  if (!members.some((m) => m.userId === viewerId)) return [];
  return members.map((m) => m.userId).filter((id) => id !== viewerId);
}

export const conversationService = {
  loadForMember,
  serializeFor,
  broadcastConversation,
  list,
  get,
  createDirect,
  createAnonymous,
  send,
  requestUnlock,
  respondUnlock,
  messages,
  markRead,
  approve,
  reject,
  reveal,
  updateSettings,
  deleteForMe,
  deleteAllForMe,
  blockPeer,
  reportPeer,
  recipientsFor,
};
