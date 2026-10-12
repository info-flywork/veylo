import type { BlockType, ReportContext, ReportReason } from '@prisma/client';
import { AppError } from '../errors/AppError';
import { prisma } from '../lib/prisma';
import { serializeUserSummary } from '../serializers/user.serializer';

/** İki kullanıcıdan biri diğerini BLOCK ettiyse true (yön fark etmez). */
async function isBlockedBetween(a: string, b: string): Promise<boolean> {
  const row = await prisma.block.findFirst({
    where: {
      type: 'BLOCK',
      OR: [
        { blockerId: a, blockedId: b },
        { blockerId: b, blockedId: a },
      ],
    },
    select: { blockerId: true },
  });
  return Boolean(row);
}

/** viewer, target tarafından kısıtlandı mı? (Kısıtlanan kişi çevrimiçi/okundu bilgisini göremez.) */
async function restrictedBy(targetId: string, viewerId: string): Promise<boolean> {
  const row = await prisma.block.findUnique({
    where: { blockerId_blockedId: { blockerId: targetId, blockedId: viewerId } },
  });
  return row?.type === 'RESTRICT';
}

/** viewer'ın BLOCK ettiği ve viewer'ı BLOCK eden herkes. Listeleri filtrelemek için. */
async function blockedIdsFor(viewerId: string): Promise<Set<string>> {
  const rows = await prisma.block.findMany({
    where: { type: 'BLOCK', OR: [{ blockerId: viewerId }, { blockedId: viewerId }] },
    select: { blockerId: true, blockedId: true },
  });
  return new Set(rows.map((r) => (r.blockerId === viewerId ? r.blockedId : r.blockerId)));
}

async function setBlock(viewerId: string, targetId: string, type: BlockType, anonymous = false) {
  if (viewerId === targetId) throw AppError.badRequest('CANNOT_BLOCK_SELF');
  const target = await prisma.user.findUnique({ where: { id: targetId }, select: { id: true } });
  if (!target) throw AppError.notFound('USER_NOT_FOUND');

  await prisma.$transaction(async (tx) => {
    await tx.block.upsert({
      where: { blockerId_blockedId: { blockerId: viewerId, blockedId: targetId } },
      create: { blockerId: viewerId, blockedId: targetId, type, anonymous },
      update: { type, anonymous },
    });
    if (type === 'BLOCK') {
      // Engelleme takip ilişkisini iki yönde de koparır.
      await tx.follow.deleteMany({
        where: {
          OR: [
            { followerId: viewerId, followingId: targetId },
            { followerId: targetId, followingId: viewerId },
          ],
        },
      });
    }
  });
}

async function removeBlock(viewerId: string, targetId: string) {
  await prisma.block.deleteMany({ where: { blockerId: viewerId, blockedId: targetId } });
}

async function listBlocks(viewerId: string) {
  const rows = await prisma.block.findMany({
    where: { blockerId: viewerId },
    orderBy: { createdAt: 'desc' },
    include: { blocked: true },
  });
  return rows.map((r) => ({
    type: r.type,
    createdAt: r.createdAt,
    // Anonim sohbetten engellenen kişinin kimliği burada da açığa çıkmaz.
    user: r.anonymous ? null : serializeUserSummary(r.blocked),
    userId: r.anonymous ? null : r.blockedId,
    anonymous: r.anonymous,
  }));
}

async function report(input: {
  reporterId: string;
  targetUserId: string;
  context: ReportContext;
  reason: ReportReason;
  details?: string;
  conversationId?: string;
  contentId?: string;
}) {
  if (input.reporterId === input.targetUserId) throw AppError.badRequest('CANNOT_REPORT_SELF');
  const target = await prisma.user.findUnique({ where: { id: input.targetUserId }, select: { id: true } });
  if (!target) throw AppError.notFound('USER_NOT_FOUND');
  const { reporterId, targetUserId, context, reason, details, conversationId, contentId } = input;
  const created = await prisma.report.create({
    data: { reporterId, targetUserId, context, reason, details, conversationId, contentId },
  });
  return { id: created.id, status: created.status };
}

export const safetyService = {
  isBlockedBetween,
  restrictedBy,
  blockedIdsFor,
  setBlock,
  removeBlock,
  listBlocks,
  report,
};
