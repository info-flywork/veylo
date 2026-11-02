import { Prisma, type ReportReason, type User, type Vibe } from '@prisma/client';
import { ENUMS, VIBE } from '../config/constants';
import { AppError } from '../errors/AppError';
import { prisma } from '../lib/prisma';
import { personaVibeBody } from '../personas/vibe-lines';
import { maskName } from '../utils/mask';
import { conversationService } from './conversation.service';
import { safetyService } from './safety.service';

/** İstekteki dil, yoksa kayıtlı telefon/uygulama dili. */
export async function viewerLanguage(userId: string, acceptLanguage?: string | null) {
  const header = acceptLanguage?.split(',')[0]?.split('-')[0]?.trim().toLowerCase();
  if (header && (ENUMS.languages as readonly string[]).includes(header)) return header;
  const device = await prisma.deviceToken.findFirst({
    where: { userId },
    orderBy: { updatedAt: 'desc' },
    select: { locale: true },
  });
  if (device && (ENUMS.languages as readonly string[]).includes(device.locale)) return device.locale;
  return 'en';
}

/** Anonim vibe'da yazarın kimliği hiçbir alanda dönmez. */
function serializeVibe(v: Vibe & { author: User }, viewerId: string, likedByMe: boolean, locale: string) {
  const name = v.author.displayName ?? v.author.username;
  const body = v.author.isPersona ? personaVibeBody(v.body, locale, v.id, v.author.username) : v.body;
  return {
    id: v.id,
    body,
    anonymous: v.anonymous,
    author: v.anonymous
      ? {
          id: null,
          username: null,
          displayName: maskName(name),
          avatarUrl: v.author.avatarBlurUrl,
          avatarBlurred: true,
          isAi: false,
        }
      : {
          id: v.author.id,
          username: v.author.username,
          displayName: name,
          avatarUrl: v.author.avatarUrl,
          avatarBlurred: false,
          isAi: false,
        },
    likeCount: v.likeCount,
    likedByMe,
    isMine: v.authorId === viewerId,
    createdAt: v.createdAt,
    expiresAt: v.expiresAt,
  };
}

async function loadActive(vibeId: string) {
  const v = await prisma.vibe.findUnique({ where: { id: vibeId }, include: { author: true } });
  if (!v || v.deletedAt || v.expiresAt < new Date() || v.author.status !== 'ACTIVE') {
    throw AppError.notFound('VIBE_NOT_FOUND');
  }
  return v;
}

/** Son 24 saatin vibe'ları (engellenenler hariç), en yeni önce. */
async function feed(viewerId: string, q: { cursor?: string; search?: string; limit: number; locale: string }) {
  const blocked = await safetyService.blockedIdsFor(viewerId);
  const where: Prisma.VibeWhereInput = {
    deletedAt: null,
    expiresAt: { gt: new Date() },
    author: { status: 'ACTIVE' },
    ...(blocked.size ? { authorId: { notIn: [...blocked] } } : {}),
    ...(q.search ? { body: { contains: q.search } } : {}),
  };
  const rows = await prisma.vibe.findMany({
    where,
    include: { author: true },
    orderBy: [{ createdAt: 'desc' }, { id: 'desc' }],
    take: q.limit + 1,
    ...(q.cursor ? { cursor: { id: q.cursor }, skip: 1 } : {}),
  });
  const page = rows.slice(0, q.limit);
  const liked = new Set(
    (
      await prisma.vibeLike.findMany({
        where: { userId: viewerId, vibeId: { in: page.map((v) => v.id) } },
        select: { vibeId: true },
      })
    ).map((l) => l.vibeId),
  );
  return {
    items: page.map((v) => serializeVibe(v, viewerId, liked.has(v.id), q.locale)),
    nextCursor: rows.length > q.limit ? page[page.length - 1]!.id : null,
  };
}

async function create(viewerId: string, input: { body: string; anonymous: boolean }, locale: string) {
  const since = new Date(Date.now() - VIBE.ttlHours * 60 * 60 * 1000);
  const recent = await prisma.vibe.count({ where: { authorId: viewerId, createdAt: { gte: since } } });
  if (recent >= VIBE.dailyLimit) throw AppError.forbidden('VIBE_DAILY_LIMIT');

  const v = await prisma.vibe.create({
    data: {
      authorId: viewerId,
      body: input.body,
      anonymous: input.anonymous,
      expiresAt: new Date(Date.now() + VIBE.ttlHours * 60 * 60 * 1000),
    },
    include: { author: true },
  });
  return serializeVibe(v, viewerId, false, locale);
}

async function remove(viewerId: string, vibeId: string) {
  const res = await prisma.vibe.updateMany({
    where: { id: vibeId, authorId: viewerId, deletedAt: null },
    data: { deletedAt: new Date() },
  });
  if (res.count === 0) throw AppError.notFound('VIBE_NOT_FOUND');
}

async function setLiked(viewerId: string, vibeId: string, liked: boolean, locale: string) {
  await loadActive(vibeId);
  // Beğeni ve sayaç aynı işlemde: çift dokunuşta sayaç kaymaz.
  await prisma.$transaction(async (tx) => {
    if (liked) {
      try {
        await tx.vibeLike.create({ data: { vibeId, userId: viewerId } });
      } catch (err) {
        if (err instanceof Prisma.PrismaClientKnownRequestError && err.code === 'P2002') return;
        throw err;
      }
      await tx.vibe.update({ where: { id: vibeId }, data: { likeCount: { increment: 1 } } });
    } else {
      const res = await tx.vibeLike.deleteMany({ where: { vibeId, userId: viewerId } });
      if (res.count) await tx.vibe.updateMany({ where: { id: vibeId, likeCount: { gt: 0 } }, data: { likeCount: { decrement: 1 } } });
    }
  });
  const v = await prisma.vibe.findUniqueOrThrow({ where: { id: vibeId }, include: { author: true } });
  return serializeVibe(v, viewerId, liked, locale);
}

/**
 * Vibe'a cevap: yazarla anonim sohbet açılır (vibe metni alıntı olarak) ve cevap ilk mesaj
 * olarak gider. Yazar onaylayana kadar mesaj isteği olarak bekler.
 */
async function reply(viewerId: string, vibeId: string, input: { body: string; clientMsgId: string }, locale: string) {
  const v = await loadActive(vibeId);
  if (v.authorId === viewerId) throw AppError.badRequest('CANNOT_REPLY_OWN_VIBE');
  const quote = (v.author.isPersona ? personaVibeBody(v.body, locale, v.id, v.author.username) : v.body).slice(0, 160);
  const conversation = await conversationService.createAnonymous(viewerId, v.authorId, quote);
  await conversationService.send(viewerId, conversation.id, {
    clientMsgId: input.clientMsgId,
    type: 'TEXT',
    body: input.body,
  });
  return conversationService.get(viewerId, conversation.id);
}

async function report(viewerId: string, vibeId: string, input: { reason: ReportReason; details?: string }) {
  const v = await loadActive(vibeId);
  if (v.authorId === viewerId) throw AppError.badRequest('CANNOT_REPORT_SELF');
  await safetyService.report({
    reporterId: viewerId,
    targetUserId: v.authorId,
    context: 'VIBE',
    contentId: v.id,
    reason: input.reason,
    details: [`"${v.body}"`, input.details].filter(Boolean).join('\n').slice(0, 1000),
  });
}

export const vibeService = { feed, create, remove, setLiked, reply, report };
