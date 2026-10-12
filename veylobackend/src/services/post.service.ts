import { Prisma, type Post, type ReportReason, type User } from '@prisma/client';
import { POST, TOKENS } from '../config/constants';
import { AppError } from '../errors/AppError';
import { prisma } from '../lib/prisma';
import { emitToUser } from '../realtime/emitter';
import { presence } from '../realtime/presence.store';
import { serializeUserSummary } from '../serializers/user.serializer';
import { mediaService } from './media.service';
import { notificationService } from './notification.service';
import { safetyService } from './safety.service';
import { tokenService } from './token.service';

type PostWithAuthor = Post & { author: User };

export interface MusicInput {
  title: string;
  artist?: string;
  coverUrl?: string;
  audioUrl?: string;
  clipStartSec?: number;
  clipEndSec?: number;
}

export interface FeedQuery {
  cursor?: string;
  q?: string;
  gender?: 'women' | 'men' | 'everyone';
  interests?: string[];
  onlineOnly?: boolean;
}

function serializePost(
  p: PostWithAuthor,
  viewerId: string,
  flags: { liked: boolean; saved: boolean; iFollowAuthor?: boolean },
) {
  const isMine = p.authorId === viewerId;
  return {
    id: p.id,
    status: p.status,
    mediaUrl: p.mediaUrl,
    thumbUrl: p.thumbUrl,
    width: p.width,
    height: p.height,
    caption: p.caption,
    music: p.music,
    likeCount: p.likeCount,
    commentCount: p.commentCount,
    // Görüntülenme sadece sahibine (istatistik ekranı).
    viewCount: isMine ? p.viewCount : null,
    likedByMe: flags.liked,
    savedByMe: flags.saved,
    isMine,
    boosted: Boolean(p.boostedUntil && p.boostedUntil > new Date()),
    boostedUntil: isMine ? p.boostedUntil : null,
    createdAt: p.createdAt,
    author: { ...serializeUserSummary(p.author), iFollow: flags.iFollowAuthor ?? null },
  };
}

/** Bir sayfa gönderiyi izleyenin beğeni/kaydetme durumuyla birlikte döndürür. */
async function withFlags(posts: PostWithAuthor[], viewerId: string) {
  const ids = posts.map((p) => p.id);
  const [likes, saves] = await Promise.all([
    prisma.postLike.findMany({ where: { userId: viewerId, postId: { in: ids } }, select: { postId: true } }),
    prisma.postSave.findMany({ where: { userId: viewerId, postId: { in: ids } }, select: { postId: true } }),
  ]);
  const liked = new Set(likes.map((l) => l.postId));
  const saved = new Set(saves.map((s) => s.postId));
  return posts.map((p) => serializePost(p, viewerId, { liked: liked.has(p.id), saved: saved.has(p.id) }));
}

/** Görünür (yayında, silinmemiş, aktif yazar) gönderi. */
async function loadVisible(postId: string, viewerId: string) {
  const p = await prisma.post.findUnique({ where: { id: postId }, include: { author: true } });
  const ownDraft = p?.status === 'DRAFT' && p.authorId === viewerId;
  if (!p || p.deletedAt || p.author.status !== 'ACTIVE' || (p.status !== 'PUBLISHED' && !ownDraft)) {
    throw AppError.notFound('POST_NOT_FOUND');
  }
  if (p.authorId !== viewerId && (await safetyService.isBlockedBetween(viewerId, p.authorId))) {
    throw AppError.notFound('POST_NOT_FOUND');
  }
  return p;
}

async function loadMine(postId: string, viewerId: string) {
  const p = await prisma.post.findUnique({ where: { id: postId }, include: { author: true } });
  if (!p || p.deletedAt || p.authorId !== viewerId) throw AppError.notFound('POST_NOT_FOUND');
  return p;
}

const GENDER = { women: 'FEMALE', men: 'MALE' } as const;

/**
 * Discover akışı: ilk sayfada öne çıkarılmış (boost) gönderiler üstte, sonra en yeniler.
 * İlgi alanı ve "şu an aktif" filtreleri sayfa içinde uygulanır.
 */
async function feed(viewerId: string, q: FeedQuery) {
  const blocked = await safetyService.blockedIdsFor(viewerId);
  const now = new Date();
  const authorWhere: Prisma.UserWhereInput = {
    status: 'ACTIVE',
    ...(q.gender && q.gender !== 'everyone' ? { gender: GENDER[q.gender] } : {}),
  };
  const search = q.q?.trim();
  const base: Prisma.PostWhereInput = {
    status: 'PUBLISHED',
    deletedAt: null,
    author: authorWhere,
    ...(blocked.size ? { authorId: { notIn: [...blocked] } } : {}),
    ...(search
      ? {
          OR: [
            { caption: { contains: search } },
            { author: { username: { contains: search } } },
            { author: { displayName: { contains: search } } },
          ],
        }
      : {}),
  };

  const boosted = q.cursor
    ? []
    : await prisma.post.findMany({
        where: { ...base, boostedUntil: { gt: now } },
        include: { author: true },
        orderBy: { boostedUntil: 'desc' },
        take: 10,
      });

  const take = POST.feedPageSize;
  const rows = await prisma.post.findMany({
    where: { ...base, id: { notIn: boosted.map((b) => b.id) } },
    include: { author: true },
    orderBy: [{ createdAt: 'desc' }, { id: 'desc' }],
    take: take + 1,
    ...(q.cursor ? { cursor: { id: q.cursor }, skip: 1 } : {}),
  });
  const page = rows.slice(0, take);

  const wanted = new Set(q.interests ?? []);
  const keep = (p: PostWithAuthor) => {
    if (q.onlineOnly && !presence.isOnline(p.authorId)) return false;
    if (wanted.size) {
      const mine = Array.isArray(p.author.interests) ? (p.author.interests as string[]) : [];
      if (!mine.some((i) => wanted.has(i))) return false;
    }
    return true;
  };

  return {
    items: await withFlags([...boosted, ...page].filter(keep), viewerId),
    nextCursor: rows.length > take ? page[page.length - 1]!.id : null,
  };
}

async function create(
  viewerId: string,
  input: { mediaId: string; thumbId: string; caption?: string; music?: MusicInput; draft: boolean },
) {
  const since = new Date(Date.now() - 24 * 60 * 60 * 1000);
  const recent = await prisma.post.count({ where: { authorId: viewerId, createdAt: { gte: since } } });
  if (recent >= POST.dailyLimit) throw AppError.forbidden('POST_DAILY_LIMIT');

  const { media, thumb } = await mediaService.resolveForPost(viewerId, input.mediaId, input.thumbId);
  const p = await prisma.post.create({
    data: {
      authorId: viewerId,
      status: input.draft ? 'DRAFT' : 'PUBLISHED',
      mediaUrl: media.url,
      thumbUrl: thumb.url,
      width: media.width,
      height: media.height,
      caption: input.caption || null,
      music: input.music ? (input.music as unknown as Prisma.InputJsonValue) : undefined,
    },
    include: { author: true },
  });
  return serializePost(p, viewerId, { liked: false, saved: false });
}

async function get(viewerId: string, postId: string) {
  const p = await loadVisible(postId, viewerId);
  const [liked, saved, follows] = await Promise.all([
    prisma.postLike.findUnique({ where: { postId_userId: { postId, userId: viewerId } } }),
    prisma.postSave.findUnique({ where: { postId_userId: { postId, userId: viewerId } } }),
    prisma.follow.findUnique({ where: { followerId_followingId: { followerId: viewerId, followingId: p.authorId } } }),
  ]);
  return serializePost(p, viewerId, { liked: Boolean(liked), saved: Boolean(saved), iFollowAuthor: Boolean(follows) });
}

/** Taslağı yayınla ve/veya açıklamayı değiştir. */
async function update(viewerId: string, postId: string, data: { caption?: string | null; publish?: boolean }) {
  await loadMine(postId, viewerId);
  await prisma.post.update({
    where: { id: postId },
    data: {
      ...(data.caption !== undefined ? { caption: data.caption || null } : {}),
      ...(data.publish ? { status: 'PUBLISHED', createdAt: new Date() } : {}),
    },
  });
  return get(viewerId, postId);
}

async function remove(viewerId: string, postId: string) {
  await loadMine(postId, viewerId);
  await prisma.post.update({ where: { id: postId }, data: { deletedAt: new Date() } });
}

async function setLiked(viewerId: string, postId: string, liked: boolean) {
  await loadVisible(postId, viewerId);
  await prisma.$transaction(async (tx) => {
    if (liked) {
      try {
        await tx.postLike.create({ data: { postId, userId: viewerId } });
      } catch (err) {
        if (err instanceof Prisma.PrismaClientKnownRequestError && err.code === 'P2002') return;
        throw err;
      }
      await tx.post.update({ where: { id: postId }, data: { likeCount: { increment: 1 } } });
    } else {
      const res = await tx.postLike.deleteMany({ where: { postId, userId: viewerId } });
      if (res.count) await tx.post.updateMany({ where: { id: postId, likeCount: { gt: 0 } }, data: { likeCount: { decrement: 1 } } });
    }
  });
  return get(viewerId, postId);
}

async function setSaved(viewerId: string, postId: string, saved: boolean) {
  await loadVisible(postId, viewerId);
  if (saved) {
    await prisma.postSave.createMany({ data: [{ postId, userId: viewerId }], skipDuplicates: true });
  } else {
    await prisma.postSave.deleteMany({ where: { postId, userId: viewerId } });
  }
  return get(viewerId, postId);
}

/** Gönderi açıldı: izleyen başına bir kez sayılır (sahibi sayılmaz). */
async function view(viewerId: string, postId: string) {
  const p = await loadVisible(postId, viewerId);
  if (p.authorId === viewerId) return;
  const { count } = await prisma.postView.createMany({ data: [{ postId, userId: viewerId }], skipDuplicates: true });
  if (count) await prisma.post.update({ where: { id: postId }, data: { viewCount: { increment: 1 } } });
}

async function stats(viewerId: string, postId: string) {
  const p = await loadMine(postId, viewerId);
  return {
    viewCount: p.viewCount,
    likeCount: p.likeCount,
    commentCount: p.commentCount,
    boostedUntil: p.boostedUntil,
  };
}

/** 100 token ile 24 saat akışta üstte. Süre zaten devam ediyorsa üstüne eklenir. */
async function boost(viewerId: string, postId: string) {
  const p = await loadMine(postId, viewerId);
  if (p.status !== 'PUBLISHED') throw AppError.badRequest('POST_NOT_PUBLISHED');
  const start = p.boostedUntil && p.boostedUntil > new Date() ? p.boostedUntil : new Date();
  const until = new Date(start.getTime() + POST.boostHours * 60 * 60 * 1000);

  const { balance } = await prisma.$transaction(async (tx) => {
    const spent = await tokenService.spend(tx, viewerId, TOKENS.postBoost1Day, 'POST_BOOST', `${postId}:${until.toISOString()}`, {
      postId,
    });
    await tx.post.update({ where: { id: postId }, data: { boostedUntil: until } });
    return spent;
  });
  emitToUser(viewerId, 'tokens:updated', { balance, delta: -TOKENS.postBoost1Day, reason: 'POST_BOOST' });
  return { boostedUntil: until, balance };
}

// ───────────────────────────── yorumlar ─────────────────────────────

async function comments(viewerId: string, postId: string, cursor?: string) {
  await loadVisible(postId, viewerId);
  const blocked = await safetyService.blockedIdsFor(viewerId);
  const rows = await prisma.comment.findMany({
    where: {
      postId,
      deletedAt: null,
      author: { status: 'ACTIVE' },
      ...(blocked.size ? { authorId: { notIn: [...blocked] } } : {}),
    },
    include: { author: true },
    orderBy: [{ createdAt: 'asc' }, { id: 'asc' }],
    take: 51,
    ...(cursor ? { cursor: { id: cursor }, skip: 1 } : {}),
  });
  const page = rows.slice(0, 50);
  return {
    items: page.map((c) => ({
      id: c.id,
      body: c.body,
      createdAt: c.createdAt,
      isMine: c.authorId === viewerId,
      author: serializeUserSummary(c.author),
    })),
    nextCursor: rows.length > 50 ? page[page.length - 1]!.id : null,
  };
}

async function addComment(viewerId: string, postId: string, body: string) {
  const p = await loadVisible(postId, viewerId);
  const [comment] = await prisma.$transaction([
    prisma.comment.create({ data: { postId, authorId: viewerId, body }, include: { author: true } }),
    prisma.post.update({ where: { id: postId }, data: { commentCount: { increment: 1 } } }),
  ]);
  if (p.authorId !== viewerId) {
    const name = comment.author.displayName ?? comment.author.username ?? 'Veylo';
    void notificationService.pushToUser(p.authorId, (t) => ({
      title: t.newCommentTitle,
      body: t.newCommentBody(name, body.slice(0, 80)),
      data: { type: 'comment', postId },
    }));
  }
  return {
    id: comment.id,
    body: comment.body,
    createdAt: comment.createdAt,
    isMine: true,
    author: serializeUserSummary(comment.author),
  };
}

/** Yorumu yazan ya da gönderinin sahibi silebilir. */
async function deleteComment(viewerId: string, commentId: string) {
  const c = await prisma.comment.findUnique({ where: { id: commentId }, include: { post: true } });
  if (!c || c.deletedAt || (c.authorId !== viewerId && c.post.authorId !== viewerId)) {
    throw AppError.notFound('COMMENT_NOT_FOUND');
  }
  await prisma.$transaction([
    prisma.comment.update({ where: { id: commentId }, data: { deletedAt: new Date() } }),
    prisma.post.updateMany({ where: { id: c.postId, commentCount: { gt: 0 } }, data: { commentCount: { decrement: 1 } } }),
  ]);
}

async function report(viewerId: string, postId: string, input: { reason: ReportReason; details?: string }) {
  const p = await loadVisible(postId, viewerId);
  if (p.authorId === viewerId) throw AppError.badRequest('CANNOT_REPORT_SELF');
  await safetyService.report({
    reporterId: viewerId,
    targetUserId: p.authorId,
    context: 'POST',
    reason: input.reason,
    details: [`post:${p.id}`, input.details].filter(Boolean).join('\n').slice(0, 1000),
  });
}

// ───────────────────────────── profil sekmeleri ─────────────────────────────

async function byUser(viewerId: string, userId: string, cursor?: string) {
  if (viewerId !== userId && (await safetyService.isBlockedBetween(viewerId, userId))) {
    throw AppError.notFound('USER_NOT_FOUND');
  }
  const rows = await prisma.post.findMany({
    where: { authorId: userId, status: 'PUBLISHED', deletedAt: null },
    include: { author: true },
    orderBy: [{ createdAt: 'desc' }, { id: 'desc' }],
    take: POST.feedPageSize + 1,
    ...(cursor ? { cursor: { id: cursor }, skip: 1 } : {}),
  });
  const page = rows.slice(0, POST.feedPageSize);
  return { items: await withFlags(page, viewerId), nextCursor: rows.length > POST.feedPageSize ? page.at(-1)!.id : null };
}

async function drafts(viewerId: string) {
  const rows = await prisma.post.findMany({
    where: { authorId: viewerId, status: 'DRAFT', deletedAt: null },
    include: { author: true },
    orderBy: { createdAt: 'desc' },
    take: 50,
  });
  return { items: await withFlags(rows, viewerId) };
}

/** Kaydedilenler: sadece kendim görürüm. */
async function saved(viewerId: string, cursor?: string) {
  const blocked = await safetyService.blockedIdsFor(viewerId);
  const rows = await prisma.postSave.findMany({
    where: {
      userId: viewerId,
      post: {
        status: 'PUBLISHED',
        deletedAt: null,
        author: { status: 'ACTIVE' },
        ...(blocked.size ? { authorId: { notIn: [...blocked] } } : {}),
      },
    },
    include: { post: { include: { author: true } } },
    orderBy: { createdAt: 'desc' },
    take: POST.feedPageSize + 1,
    ...(cursor ? { cursor: { postId_userId: { postId: cursor, userId: viewerId } }, skip: 1 } : {}),
  });
  const page = rows.slice(0, POST.feedPageSize);
  return {
    items: await withFlags(
      page.map((r) => r.post),
      viewerId,
    ),
    nextCursor: rows.length > POST.feedPageSize ? page.at(-1)!.postId : null,
  };
}

export const postService = {
  feed,
  create,
  get,
  update,
  remove,
  setLiked,
  setSaved,
  view,
  stats,
  boost,
  comments,
  addComment,
  deleteComment,
  report,
  byUser,
  drafts,
  saved,
};
