import type { Prisma, Report, ReportStatus, User, UserStatus } from '@prisma/client';
import { AppError } from '../errors/AppError';
import { logger } from '../lib/logger';
import { prisma } from '../lib/prisma';
import { disconnectUser } from '../realtime/emitter';
import { presence } from '../realtime/presence.store';
import { accountService } from './account.service';

/**
 * Yönetim paneli (ayrı bir uygulama) için işlemler. Her değişiklik admin_actions'a yazılır.
 * Panel sadece moderasyon için gerekeni görür: şikayet edilen sohbette son mesajlar, içerik, hesap durumu.
 */

type Page = { limit: number; cursor?: string };
const page = ({ limit, cursor }: Page) => ({
  take: limit + 1,
  ...(cursor ? { cursor: { id: cursor }, skip: 1 } : {}),
});
function paged<T extends { id: string }>(rows: T[], limit: number) {
  const more = rows.length > limit;
  const items = more ? rows.slice(0, limit) : rows;
  return { items, nextCursor: more ? items[items.length - 1]!.id : null };
}

/** Panelde kullanıcı satırı (e-posta dahil; uygulamada asla dönmeyen alanlar burada görünür). */
function adminUser(u: User) {
  return {
    id: u.id,
    username: u.username,
    displayName: u.displayName,
    email: u.email,
    avatarUrl: u.avatarUrl,
    authProvider: u.authProvider,
    status: u.status,
    suspendedUntil: u.suspendedUntil,
    suspendedReason: u.suspendedReason,
    isAi: u.isPersona,
    tokenBalance: u.tokenBalance,
    online: presence.isOnline(u.id),
    lastSeenAt: u.lastSeenAt,
    createdAt: u.createdAt,
  };
}

async function log(
  actor: string,
  action: string,
  target: Pick<User, 'id' | 'username'> | null,
  extra: { reportId?: string; note?: string } = {},
) {
  await prisma.adminAction.create({
    data: { actor, action, targetUserId: target?.id, targetLabel: target?.username ?? target?.id, ...extra },
  });
}

// ───────────────────────────── özet ─────────────────────────────

async function stats() {
  const dayAgo = new Date(Date.now() - 24 * 60 * 60 * 1000);
  const [byStatus, openReports, reviewing, reports24h, newUsers24h, pendingDeletions] = await Promise.all([
    prisma.user.groupBy({ by: ['status'], where: { isPersona: false }, _count: true }),
    prisma.report.count({ where: { status: 'OPEN' } }),
    prisma.report.count({ where: { status: 'REVIEWING' } }),
    prisma.report.count({ where: { createdAt: { gte: dayAgo } } }),
    prisma.user.count({ where: { isPersona: false, createdAt: { gte: dayAgo } } }),
    prisma.accountDeletionRequest.count({ where: { status: 'PENDING' } }),
  ]);
  const users = Object.fromEntries(byStatus.map((r) => [r.status, r._count])) as Partial<Record<UserStatus, number>>;
  return {
    users: { ...users, total: byStatus.reduce((n, r) => n + r._count, 0), new24h: newUsers24h, online: presence.onlineCount },
    reports: { open: openReports, reviewing, last24h: reports24h },
    pendingDeletions,
  };
}

// ───────────────────────────── şikayetler ─────────────────────────────

async function contentOf(r: Pick<Report, 'context' | 'contentId'>) {
  if (!r.contentId) return null;
  if (r.context === 'VIBE') {
    const v = await prisma.vibe.findUnique({ where: { id: r.contentId } });
    return v && { type: 'VIBE', id: v.id, body: v.body, anonymous: v.anonymous, createdAt: v.createdAt, removed: Boolean(v.deletedAt) };
  }
  if (r.context === 'POST') {
    const p = await prisma.post.findUnique({ where: { id: r.contentId } });
    return (
      p && {
        type: 'POST',
        id: p.id,
        caption: p.caption,
        mediaUrl: p.mediaUrl,
        thumbUrl: p.thumbUrl,
        createdAt: p.createdAt,
        removed: Boolean(p.deletedAt),
      }
    );
  }
  return null;
}

async function listReports(q: {
  status: ReportStatus | 'ALL';
  context?: Report['context'];
  targetUserId?: string;
  limit: number;
  cursor?: string;
}) {
  const rows = await prisma.report.findMany({
    where: {
      ...(q.status === 'ALL' ? {} : { status: q.status }),
      ...(q.context ? { context: q.context } : {}),
      ...(q.targetUserId ? { targetUserId: q.targetUserId } : {}),
    },
    include: { reporter: true, target: true },
    // Açık şikayetler: en eski önce (sıra bekleyen); diğerleri en yeni önce.
    orderBy: [{ createdAt: q.status === 'OPEN' ? 'asc' : 'desc' }, { id: 'asc' }],
    ...page(q),
  });
  const { items, nextCursor } = paged(rows, q.limit);
  const targetIds = [...new Set(items.map((r) => r.targetUserId))];
  const counts = await prisma.report.groupBy({
    by: ['targetUserId'],
    where: { targetUserId: { in: targetIds } },
    _count: true,
  });
  const countOf = new Map(counts.map((c) => [c.targetUserId, c._count]));
  return {
    items: await Promise.all(
      items.map(async (r) => ({
        ...serializeReport(r),
        reporter: adminUser(r.reporter),
        target: { ...adminUser(r.target), reportsReceived: countOf.get(r.targetUserId) ?? 0 },
        content: await contentOf(r),
      })),
    ),
    nextCursor,
  };
}

function serializeReport(r: Report) {
  return {
    id: r.id,
    context: r.context,
    reason: r.reason,
    details: r.details,
    status: r.status,
    conversationId: r.conversationId,
    contentId: r.contentId,
    resolution: r.resolution,
    adminNote: r.adminNote,
    resolvedAt: r.resolvedAt,
    createdAt: r.createdAt,
  };
}

/** Şikayet detayı: içerik, şikayet edilen sohbetin son mesajları ve kişinin geçmişi. */
async function getReport(id: string) {
  const r = await prisma.report.findUnique({ where: { id }, include: { reporter: true, target: true } });
  if (!r) throw AppError.notFound('REPORT_NOT_FOUND');

  const [content, messages, otherReports, actions] = await Promise.all([
    contentOf(r),
    r.conversationId
      ? prisma.message.findMany({
          where: { conversationId: r.conversationId },
          orderBy: { seq: 'desc' },
          take: 50,
          include: { sender: { select: { id: true, username: true } } },
        })
      : Promise.resolve([]),
    prisma.report.findMany({
      where: { targetUserId: r.targetUserId, id: { not: r.id } },
      orderBy: { createdAt: 'desc' },
      take: 20,
    }),
    prisma.adminAction.findMany({ where: { targetUserId: r.targetUserId }, orderBy: { createdAt: 'desc' }, take: 20 }),
  ]);

  return {
    ...serializeReport(r),
    reporter: adminUser(r.reporter),
    target: adminUser(r.target),
    content,
    messages: messages.reverse().map((m) => ({
      id: m.id,
      senderId: m.senderId,
      sender: m.sender.username,
      isTarget: m.senderId === r.targetUserId,
      type: m.type,
      body: m.body,
      mediaUrl: m.mediaUrl,
      createdAt: m.createdAt,
    })),
    otherReports: otherReports.map(serializeReport),
    actions,
  };
}

async function setReportStatus(actor: string, id: string, status: 'OPEN' | 'REVIEWING') {
  const r = await prisma.report.update({ where: { id }, data: { status } }).catch(() => null);
  if (!r) throw AppError.notFound('REPORT_NOT_FOUND');
  await log(actor, `REPORT_${status}`, { id: r.targetUserId, username: null }, { reportId: id });
  return serializeReport(r);
}

async function removeContent(r: Pick<Report, 'context' | 'contentId'>) {
  if (!r.contentId) throw AppError.badRequest('REPORT_HAS_NO_CONTENT');
  const now = new Date();
  if (r.context === 'VIBE') {
    await prisma.vibe.updateMany({ where: { id: r.contentId, deletedAt: null }, data: { deletedAt: now } });
  } else if (r.context === 'POST') {
    await prisma.post.updateMany({ where: { id: r.contentId, deletedAt: null }, data: { deletedAt: now } });
  } else {
    throw AppError.badRequest('REPORT_HAS_NO_CONTENT');
  }
}

/**
 * Şikayeti kapatır. ACTION: istenirse içerik kaldırılır ve/veya hesap askıya alınır.
 * İçerik kaldırılınca aynı içerik için açık diğer şikayetler de kapanır.
 */
async function resolveReport(
  actor: string,
  id: string,
  input: { decision: 'DISMISS' | 'ACTION'; removeContent: boolean; suspendDays?: number | null; note?: string },
) {
  const r = await prisma.report.findUnique({ where: { id }, include: { target: true } });
  if (!r) throw AppError.notFound('REPORT_NOT_FOUND');
  if (r.status === 'ACTIONED' || r.status === 'DISMISSED') throw AppError.conflict('REPORT_ALREADY_RESOLVED');

  const done: string[] = [];
  if (input.decision === 'ACTION') {
    if (input.removeContent) {
      await removeContent(r);
      done.push('CONTENT_REMOVED');
      await log(actor, 'CONTENT_REMOVED', r.target, { reportId: r.id, note: `${r.context}:${r.contentId}` });
    }
    if (input.suspendDays !== undefined) {
      await suspend(actor, r.targetUserId, input.suspendDays, input.note || `Şikayet: ${r.reason}`, r.id);
      done.push('SUSPENDED');
    }
    if (!done.length) done.push('WARNED');
  } else {
    done.push('DISMISSED');
  }

  const status: ReportStatus = input.decision === 'ACTION' ? 'ACTIONED' : 'DISMISSED';
  const data = { status, resolution: done.join('+'), adminNote: input.note, resolvedAt: new Date() };
  await prisma.report.update({ where: { id: r.id }, data });
  if (input.removeContent && r.contentId) {
    await prisma.report.updateMany({
      where: { contentId: r.contentId, status: { in: ['OPEN', 'REVIEWING'] } },
      data,
    });
  }
  await log(actor, `REPORT_${status}`, r.target, { reportId: r.id, note: input.note });
  return getReport(r.id);
}

// ───────────────────────────── kullanıcılar ─────────────────────────────

async function suspend(actor: string, userId: string, days: number | null, reason: string, reportId?: string) {
  const user = await prisma.user.findUnique({ where: { id: userId } });
  if (!user) throw AppError.notFound('USER_NOT_FOUND');
  if (user.isPersona) throw AppError.badRequest('CANNOT_SUSPEND_PERSONA');
  const suspendedUntil = days === null ? null : new Date(Date.now() + days * 24 * 60 * 60 * 1000);
  const updated = await prisma.user.update({
    where: { id: userId },
    data: { status: 'SUSPENDED', suspendedUntil, suspendedReason: reason },
  });
  // Açık bağlantılar kapanır; arama/oda temizliği bağlantı kopunca kendiliğinden olur.
  disconnectUser(userId);
  await prisma.deviceToken.deleteMany({ where: { userId } });
  await log(actor, 'USER_SUSPENDED', user, { reportId, note: `${days === null ? 'süresiz' : `${days} gün`}: ${reason}` });
  return adminUser(updated);
}

async function unsuspend(actor: string, userId: string, note?: string) {
  const user = await prisma.user.findUnique({ where: { id: userId } });
  if (!user) throw AppError.notFound('USER_NOT_FOUND');
  if (user.status !== 'SUSPENDED') throw AppError.conflict('USER_NOT_SUSPENDED');
  const updated = await prisma.user.update({
    where: { id: userId },
    data: { status: 'ACTIVE', suspendedUntil: null, suspendedReason: null },
  });
  await log(actor, 'USER_UNSUSPENDED', user, { note });
  return adminUser(updated);
}

async function listUsers(q: { q?: string; status?: UserStatus; limit: number; cursor?: string }) {
  const where: Prisma.UserWhereInput = {
    ...(q.status ? { status: q.status } : {}),
    ...(q.q
      ? {
          OR: [
            { id: q.q },
            { username: { contains: q.q } },
            { displayName: { contains: q.q } },
            { email: { contains: q.q } },
          ],
        }
      : {}),
  };
  const rows = await prisma.user.findMany({
    where,
    orderBy: [{ createdAt: 'desc' }, { id: 'asc' }],
    ...page(q),
  });
  const { items, nextCursor } = paged(rows, q.limit);
  return { items: items.map(adminUser), nextCursor };
}

async function getUser(id: string) {
  const u = await prisma.user.findUnique({ where: { id } });
  if (!u) throw AppError.notFound('USER_NOT_FOUND');
  const [counts, reportsReceived, reportsMade, deletionRequests, actions] = await Promise.all([
    prisma.user.findUniqueOrThrow({
      where: { id },
      select: {
        _count: {
          select: { posts: true, vibes: true, followers: true, following: true, messages: true, blocksReceived: true },
        },
      },
    }),
    prisma.report.findMany({ where: { targetUserId: id }, orderBy: { createdAt: 'desc' }, take: 50 }),
    prisma.report.count({ where: { reporterId: id } }),
    prisma.accountDeletionRequest.findMany({ where: { userId: id }, orderBy: { createdAt: 'desc' } }),
    prisma.adminAction.findMany({ where: { targetUserId: id }, orderBy: { createdAt: 'desc' }, take: 50 }),
  ]);
  return {
    ...adminUser(u),
    bio: u.bio,
    gender: u.gender,
    counts: { ...counts._count, reportsReceived: reportsReceived.length, reportsMade },
    reportsReceived: reportsReceived.map(serializeReport),
    deletionRequests,
    actions,
  };
}

// ───────────────────────────── hesap silme ─────────────────────────────

async function listDeletionRequests(q: { status: 'PENDING' | 'CANCELLED' | 'ALL'; limit: number; cursor?: string }) {
  const rows = await prisma.accountDeletionRequest.findMany({
    where: q.status === 'ALL' ? {} : { status: q.status },
    include: { user: true },
    orderBy: [{ purgeAt: 'asc' }, { id: 'asc' }],
    ...page(q),
  });
  const { items, nextCursor } = paged(rows, q.limit);
  return {
    items: items.map(({ user, ...r }) => ({ ...r, user: adminUser(user) })),
    nextCursor,
  };
}

/** Bekleme süresini beklemeden sil (ör. kullanıcı e-postayla hemen silinmesini istedi). */
async function purgeNow(actor: string, requestId: string, note?: string) {
  const r = await prisma.accountDeletionRequest.findUnique({ where: { id: requestId } });
  if (!r || r.status !== 'PENDING') throw AppError.notFound('DELETION_REQUEST_NOT_FOUND');
  try {
    return await accountService.purgeUser(r.userId, actor, note);
  } catch (err) {
    logger.error({ err, userId: r.userId }, 'Hesap hemen silinemedi');
    throw new AppError(502, 'PURGE_FAILED', err instanceof Error ? err.message : undefined);
  }
}

async function listActions(q: { targetUserId?: string; limit: number; cursor?: string }) {
  const rows = await prisma.adminAction.findMany({
    where: q.targetUserId ? { targetUserId: q.targetUserId } : {},
    orderBy: [{ createdAt: 'desc' }, { id: 'asc' }],
    ...page(q),
  });
  return paged(rows, q.limit);
}

export const adminService = {
  stats,
  listReports,
  getReport,
  setReportStatus,
  resolveReport,
  suspend,
  unsuspend,
  listUsers,
  getUser,
  listDeletionRequests,
  purgeNow,
  listActions,
};
