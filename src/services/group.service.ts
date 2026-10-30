import { createHash } from 'node:crypto';
import { Prisma, type MemberRole } from '@prisma/client';
import { GROUP } from '../config/constants';
import { AppError } from '../errors/AppError';
import { logger } from '../lib/logger';
import { prisma } from '../lib/prisma';
import { emitToUser } from '../realtime/emitter';
import { presence } from '../realtime/presence.store';
import {
  serializeGroupMember,
  type ConversationFull,
} from '../serializers/conversation.serializer';
import { conversationService } from './conversation.service';
import { notificationService } from './notification.service';
import { safetyService } from './safety.service';

const include = { members: { include: { user: true } } } as const;

const ROLE_ORDER: Record<MemberRole, number> = { OWNER: 0, ADMIN: 1, MEMBER: 2 };

/**
 * Üyeyi işaretleyen, gruba özel opak id. Anonim üyelerin kullanıcı id'si istemciye hiç
 * gönderilmediği için yönetici işlemleri bununla yapılır.
 */
function memberKey(conversationId: string, userId: string) {
  return createHash('sha256').update(`${conversationId}:${userId}`).digest('hex').slice(0, 24);
}

async function loadGroup(conversationId: string): Promise<ConversationFull> {
  const c = await prisma.conversation.findUnique({ where: { id: conversationId }, include });
  if (!c || c.type !== 'GROUP') throw AppError.notFound('GROUP_NOT_FOUND');
  return c;
}

function memberOf(c: ConversationFull, userId: string) {
  return c.members.find((m) => m.userId === userId) ?? null;
}

async function loadAsMember(conversationId: string, viewerId: string) {
  const c = await loadGroup(conversationId);
  const me = memberOf(c, viewerId);
  if (!me) throw AppError.notFound('GROUP_NOT_FOUND');
  return { c, me };
}

async function loadAsAdmin(conversationId: string, viewerId: string) {
  const { c, me } = await loadAsMember(conversationId, viewerId);
  if (me.role === 'MEMBER') throw AppError.forbidden('NOT_GROUP_ADMIN');
  return { c, me };
}

function resolveMember(c: ConversationFull, key: string) {
  const m = c.members.find((x) => memberKey(c.id, x.userId) === key);
  if (!m) throw AppError.notFound('MEMBER_NOT_FOUND');
  return m;
}

function assertCapacity(c: ConversationFull, adding = 1) {
  if (c.members.length + adding > GROUP.maxMembers) throw AppError.conflict('GROUP_FULL');
}

const titleOf = (c: { title: string | null }) => c.title ?? 'Group';

// ───────────────────────────── keşfet ─────────────────────────────

/** Rooms > All Groups: herkese açık ve gizli gruplar (gizlilerin içeriği görünmez). */
async function discover(viewerId: string, q?: string) {
  const rows = await prisma.conversation.findMany({
    where: { type: 'GROUP', ...(q ? { title: { contains: q } } : {}) },
    include: {
      members: { take: 5, orderBy: { joinedAt: 'asc' }, include: { user: true } },
      _count: { select: { members: true } },
    },
    orderBy: [{ lastMessageAt: 'desc' }, { createdAt: 'desc' }],
    take: GROUP.listLimit,
  });
  const ids = rows.map((r) => r.id);
  const [mine, requests, allMembers] = await Promise.all([
    prisma.conversationMember.findMany({ where: { userId: viewerId, conversationId: { in: ids } }, select: { conversationId: true } }),
    prisma.groupJoinRequest.findMany({
      where: { userId: viewerId, conversationId: { in: ids }, status: 'PENDING' },
      select: { conversationId: true },
    }),
    // Kartta "X aktif": şu an bağlı üye sayısı (bellekteki presence).
    prisma.conversationMember.findMany({ where: { conversationId: { in: ids } }, select: { conversationId: true, userId: true } }),
  ]);
  const active = new Map<string, number>();
  for (const m of allMembers) {
    if (presence.isOnline(m.userId)) active.set(m.conversationId, (active.get(m.conversationId) ?? 0) + 1);
  }
  const memberOfSet = new Set(mine.map((m) => m.conversationId));
  const requested = new Set(requests.map((r) => r.conversationId));

  return rows.map((c) => ({
    id: c.id,
    title: titleOf(c),
    isPrivate: c.isPrivate,
    memberCount: c._count.members,
    activeCount: active.get(c.id) ?? 0,
    avatars: c.members.map((m) => serializeGroupMember(m).avatarUrl).filter((u): u is string => Boolean(u)),
    isMember: memberOfSet.has(c.id),
    requested: requested.has(c.id),
    lastMessageAt: c.lastMessageAt,
  }));
}

// ───────────────────────────── oluşturma / bilgi ─────────────────────────────

async function create(viewerId: string, input: { title: string; anonymous: boolean; isPrivate: boolean }) {
  const since = new Date(Date.now() - 24 * 60 * 60 * 1000);
  const recent = await prisma.conversation.count({ where: { type: 'GROUP', initiatorId: viewerId, createdAt: { gte: since } } });
  if (recent >= 10) throw AppError.forbidden('GROUP_CREATE_LIMIT');

  const created = await prisma.conversation.create({
    data: {
      type: 'GROUP',
      status: 'ACCEPTED',
      initiatorId: viewerId,
      title: input.title,
      isPrivate: input.isPrivate,
      members: { create: [{ userId: viewerId, role: 'OWNER', anonymous: input.anonymous }] },
    },
  });
  return conversationService.get(viewerId, created.id);
}

/** Grup bilgi ekranı: üyeler, roller, ayarlar. */
async function info(viewerId: string, conversationId: string) {
  const { c, me } = await loadAsMember(conversationId, viewerId);
  const pendingRequests =
    me.role === 'MEMBER' ? 0 : await prisma.groupJoinRequest.count({ where: { conversationId: c.id, status: 'PENDING' } });
  const members = [...c.members].sort(
    (a, b) =>
      Number(b.userId === viewerId) - Number(a.userId === viewerId) ||
      ROLE_ORDER[a.role] - ROLE_ORDER[b.role] ||
      a.joinedAt.getTime() - b.joinedAt.getTime(),
  );
  return {
    id: c.id,
    title: titleOf(c),
    isPrivate: c.isPrivate,
    memberCount: c.members.length,
    myRole: me.role,
    muted: me.muted,
    anonymous: me.anonymous,
    pendingRequests,
    members: members.map((m) => ({
      memberId: memberKey(c.id, m.userId),
      ...serializeGroupMember(m),
      role: m.role,
      isYou: m.userId === viewerId,
    })),
  };
}

async function update(viewerId: string, conversationId: string, data: { title?: string; isPrivate?: boolean }) {
  const { c } = await loadAsAdmin(conversationId, viewerId);
  await prisma.conversation.update({ where: { id: c.id }, data });
  await conversationService.broadcastConversation(await loadGroup(c.id));
  return info(viewerId, c.id);
}

// ───────────────────────────── katılma ─────────────────────────────

async function addMember(c: ConversationFull, userId: string, anonymous: boolean) {
  try {
    await prisma.conversationMember.create({ data: { conversationId: c.id, userId, anonymous } });
  } catch (err) {
    // Aynı anda iki istek: zaten üye.
    if (!(err instanceof Prisma.PrismaClientKnownRequestError && err.code === 'P2002')) throw err;
  }
}

/** Herkese açık gruba katıl. */
async function join(viewerId: string, conversationId: string, anonymous: boolean) {
  const c = await loadGroup(conversationId);
  if (memberOf(c, viewerId)) return conversationService.get(viewerId, c.id);
  if (c.isPrivate) throw AppError.forbidden('GROUP_PRIVATE');
  assertCapacity(c);
  await addMember(c, viewerId, anonymous);
  await conversationService.broadcastConversation(await loadGroup(c.id));
  return conversationService.get(viewerId, c.id);
}

/** Gizli gruba katılma isteği; yöneticilere bildirim gider. */
async function requestJoin(viewerId: string, conversationId: string, input: { message?: string; anonymous: boolean }) {
  const c = await loadGroup(conversationId);
  if (memberOf(c, viewerId)) throw AppError.conflict('ALREADY_MEMBER');
  if (!c.isPrivate) throw AppError.badRequest('GROUP_IS_PUBLIC');

  const request = await prisma.groupJoinRequest.upsert({
    where: { conversationId_userId: { conversationId: c.id, userId: viewerId } },
    create: { conversationId: c.id, userId: viewerId, message: input.message, anonymous: input.anonymous },
    update: { message: input.message, anonymous: input.anonymous, status: 'PENDING', decidedById: null },
    include: { user: true },
  });

  const requester = serializeGroupMember({ anonymous: request.anonymous, user: request.user });
  const admins = c.members.filter((m) => m.role !== 'MEMBER');
  await Promise.all(
    admins.map(async (a) => {
      emitToUser(a.userId, 'group:request', {
        conversationId: c.id,
        title: titleOf(c),
        name: requester.displayName,
      });
      await notificationService.pushToUser(
        a.userId,
        (t) => ({
          title: t.groupRequestTitle(titleOf(c)),
          body: t.groupRequestBody(requester.displayName ?? '?'),
          data: { type: 'groupRequest', conversationId: c.id },
          threadId: c.id,
        }),
        { evenIfOnline: false },
      );
    }),
  );
  return { status: request.status };
}

async function listRequests(viewerId: string, conversationId: string) {
  const { c } = await loadAsAdmin(conversationId, viewerId);
  const rows = await prisma.groupJoinRequest.findMany({
    where: { conversationId: c.id, status: 'PENDING' },
    include: { user: true },
    orderBy: { createdAt: 'asc' },
  });
  return rows.map((r) => ({
    id: r.id,
    message: r.message,
    createdAt: r.createdAt,
    user: serializeGroupMember({ anonymous: r.anonymous, user: r.user }),
  }));
}

async function decideRequest(viewerId: string, conversationId: string, requestId: string, approve: boolean) {
  const { c } = await loadAsAdmin(conversationId, viewerId);
  const request = await prisma.groupJoinRequest.findFirst({
    where: { id: requestId, conversationId: c.id, status: 'PENDING' },
  });
  if (!request) throw AppError.notFound('REQUEST_NOT_FOUND');

  if (approve) {
    assertCapacity(c);
    await addMember(c, request.userId, request.anonymous);
  }
  await prisma.groupJoinRequest.update({
    where: { id: request.id },
    data: { status: approve ? 'APPROVED' : 'REJECTED', decidedById: viewerId },
  });

  if (approve) {
    const fresh = await loadGroup(c.id);
    await conversationService.broadcastConversation(fresh);
    emitToUser(request.userId, 'group:approved', { conversationId: c.id, title: titleOf(c) });
    await notificationService.pushToUser(
      request.userId,
      (t) => ({
        title: t.groupApprovedTitle,
        body: t.groupApprovedBody(titleOf(c)),
        data: { type: 'groupApproved', conversationId: c.id },
        threadId: c.id,
      }),
      { evenIfOnline: false },
    );
  }
  return listRequests(viewerId, c.id);
}

// ───────────────────────────── üyeler ─────────────────────────────

/** Yönetici kişi ekler (engelleşilmiş kişiler atlanır). */
async function addMembers(viewerId: string, conversationId: string, userIds: string[]) {
  const { c } = await loadAsAdmin(conversationId, viewerId);
  const candidates = [...new Set(userIds)].filter((id) => id !== viewerId && !memberOf(c, id));
  const users = await prisma.user.findMany({
    where: { id: { in: candidates }, status: 'ACTIVE', isPersona: false },
    select: { id: true },
  });
  const allowed: string[] = [];
  for (const u of users) {
    if (!(await safetyService.isBlockedBetween(viewerId, u.id))) allowed.push(u.id);
  }
  assertCapacity(c, allowed.length);
  for (const id of allowed) await addMember(c, id, false);

  if (allowed.length) {
    await conversationService.broadcastConversation(await loadGroup(c.id));
    await Promise.all(
      allowed.map((id) =>
        notificationService.pushToUser(id, (t) => ({
          title: t.groupAddedTitle,
          body: t.groupAddedBody(titleOf(c)),
          data: { type: 'message', conversationId: c.id },
          threadId: c.id,
        })),
      ),
    );
  }
  return info(viewerId, c.id);
}

/** Yönetici üye çıkarır. Sahip çıkarılamaz; yöneticiyi sadece sahip çıkarabilir. */
async function removeMember(viewerId: string, conversationId: string, key: string) {
  const { c, me } = await loadAsAdmin(conversationId, viewerId);
  const target = resolveMember(c, key);
  if (target.userId === viewerId) return leave(viewerId, conversationId);
  if (target.role === 'OWNER' || (target.role === 'ADMIN' && me.role !== 'OWNER')) {
    throw AppError.forbidden('CANNOT_REMOVE_MEMBER');
  }
  await prisma.conversationMember.delete({
    where: { conversationId_userId: { conversationId: c.id, userId: target.userId } },
  });
  emitToUser(target.userId, 'conversation:removed', { conversationId: c.id });
  await conversationService.broadcastConversation(await loadGroup(c.id));
  return info(viewerId, c.id);
}

/** Sahip bir üyeyi yönetici yapar ya da yöneticiliğini alır. */
async function setRole(viewerId: string, conversationId: string, key: string, role: 'ADMIN' | 'MEMBER') {
  const { c, me } = await loadAsMember(conversationId, viewerId);
  if (me.role !== 'OWNER') throw AppError.forbidden('NOT_GROUP_OWNER');
  const target = resolveMember(c, key);
  if (target.role === 'OWNER') throw AppError.forbidden('CANNOT_CHANGE_OWNER');
  await prisma.conversationMember.update({
    where: { conversationId_userId: { conversationId: c.id, userId: target.userId } },
    data: { role },
  });
  await conversationService.broadcastConversation(await loadGroup(c.id));
  return info(viewerId, c.id);
}

/** Gruptan ayrıl. Sahip ayrılırsa en eski yönetici, yoksa en eski üye sahip olur; son kişiyse grup silinir. */
async function leave(viewerId: string, conversationId: string) {
  const { c, me } = await loadAsMember(conversationId, viewerId);
  const rest = c.members
    .filter((m) => m.userId !== viewerId)
    .sort((a, b) => ROLE_ORDER[a.role] - ROLE_ORDER[b.role] || a.joinedAt.getTime() - b.joinedAt.getTime());

  if (rest.length === 0) {
    await prisma.conversation.delete({ where: { id: c.id } });
    return { left: true };
  }
  await prisma.$transaction(async (tx) => {
    await tx.conversationMember.delete({ where: { conversationId_userId: { conversationId: c.id, userId: viewerId } } });
    if (me.role === 'OWNER') {
      await tx.conversationMember.update({
        where: { conversationId_userId: { conversationId: c.id, userId: rest[0]!.userId } },
        data: { role: 'OWNER' },
      });
    }
  });
  await conversationService
    .broadcastConversation(await loadGroup(c.id))
    .catch((err) => logger.warn({ err }, 'Grup güncellemesi iletilemedi'));
  return { left: true };
}

export const groupService = {
  discover,
  create,
  info,
  update,
  join,
  requestJoin,
  listRequests,
  decideRequest,
  addMembers,
  removeMember,
  setRole,
  leave,
};
