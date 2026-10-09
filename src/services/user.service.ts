import type { Prisma, User } from '@prisma/client';
import { BORDER_CATALOG, RESERVED_USERNAMES } from '../config/constants';
import { AppError } from '../errors/AppError';
import { prisma } from '../lib/prisma';
import { serializeMe, serializePublicProfile, serializeUserSummary } from '../serializers/user.serializer';
import { safetyService } from './safety.service';

async function followCounts(userId: string) {
  const [followerCount, followingCount] = await Promise.all([
    prisma.follow.count({ where: { followingId: userId } }),
    prisma.follow.count({ where: { followerId: userId } }),
  ]);
  return { followerCount, followingCount };
}

async function getMe(user: User) {
  return serializeMe(user, await followCounts(user.id));
}

async function isUsernameTaken(username: string, exceptUserId?: string) {
  if (RESERVED_USERNAMES.has(username)) return true;
  const found = await prisma.user.findUnique({ where: { username }, select: { id: true } });
  return Boolean(found && found.id !== exceptUserId);
}

/** Flutter'daki öneri mantığının sunucu karşılığı: base1, base12, ... içinden boş olanlar. */
async function usernameAvailability(username: string) {
  if (!(await isUsernameTaken(username))) return { available: true, suggestions: [] as string[] };

  const base = username.slice(0, 26);
  const candidates = [
    `${base}1`,
    `${base}12`,
    `${base}_${new Date().getFullYear() % 100}`,
    `${base}.${Math.floor(100 + Math.random() * 900)}`,
    `${base}${Math.floor(1000 + Math.random() * 9000)}`,
  ];
  const taken = await prisma.user.findMany({
    where: { username: { in: candidates } },
    select: { username: true },
  });
  const takenSet = new Set(taken.map((t) => t.username));
  const suggestions = candidates.filter((c) => !takenSet.has(c) && !RESERVED_USERNAMES.has(c)).slice(0, 3);
  return { available: false, suggestions };
}

async function completeOnboarding(
  user: User,
  input: {
    fullName: string;
    username: string;
    gender: User['gender'];
    interests: string[];
    chatGoal: string;
  },
) {
  if (await isUsernameTaken(input.username, user.id)) throw AppError.conflict('USERNAME_TAKEN');
  const updated = await prisma.user.update({
    where: { id: user.id },
    data: {
      fullName: input.fullName,
      username: input.username,
      displayName: user.displayName ?? input.username,
      gender: input.gender,
      interests: input.interests,
      chatGoal: input.chatGoal,
      onboardingCompleted: true,
    },
  });
  return getMe(updated);
}

async function updateProfile(user: User, input: Record<string, unknown>) {
  const data = { ...input } as Prisma.UserUpdateInput & { username?: string; borderId?: string | null };

  if (data.username && (await isUsernameTaken(data.username, user.id))) {
    throw AppError.conflict('USERNAME_TAKEN');
  }
  if (data.borderId) {
    if (!(data.borderId in BORDER_CATALOG)) throw AppError.badRequest('UNKNOWN_BORDER');
    const owned = await prisma.ownedItem.findUnique({
      where: { userId_itemType_itemId: { userId: user.id, itemType: 'BORDER', itemId: data.borderId } },
    });
    if (!owned) throw AppError.forbidden('BORDER_NOT_OWNED');
  }

  const updated = await prisma.user.update({ where: { id: user.id }, data });
  return getMe(updated);
}

async function getPublicProfile(viewerId: string, targetId: string) {
  if (viewerId === targetId) throw AppError.badRequest('USE_ME_ENDPOINT');
  const target = await prisma.user.findUnique({ where: { id: targetId } });
  // Engellenmiş kullanıcıya profil "yok" gibi görünür.
  if (!target || target.status !== 'ACTIVE' || (await safetyService.isBlockedBetween(viewerId, targetId))) {
    throw AppError.notFound('USER_NOT_FOUND');
  }
  const [counts, iFollow, followsMe] = await Promise.all([
    followCounts(targetId),
    prisma.follow.findUnique({ where: { followerId_followingId: { followerId: viewerId, followingId: targetId } } }),
    prisma.follow.findUnique({ where: { followerId_followingId: { followerId: targetId, followingId: viewerId } } }),
  ]);
  return serializePublicProfile(target, { ...counts, iFollow: Boolean(iFollow), followsMe: Boolean(followsMe) });
}

async function follow(viewerId: string, targetId: string) {
  if (viewerId === targetId) throw AppError.badRequest('CANNOT_FOLLOW_SELF');
  const target = await prisma.user.findUnique({ where: { id: targetId }, select: { status: true } });
  if (!target || target.status !== 'ACTIVE' || (await safetyService.isBlockedBetween(viewerId, targetId))) {
    throw AppError.notFound('USER_NOT_FOUND');
  }
  await prisma.follow.upsert({
    where: { followerId_followingId: { followerId: viewerId, followingId: targetId } },
    create: { followerId: viewerId, followingId: targetId },
    update: {},
  });
}

async function unfollow(viewerId: string, targetId: string) {
  await prisma.follow.deleteMany({ where: { followerId: viewerId, followingId: targetId } });
}

/** kind=followers → userId'yi takip edenler; kind=following → userId'nin takip ettikleri. */
async function listFollows(
  viewerId: string,
  userId: string,
  kind: 'followers' | 'following',
  cursor: string | undefined,
  limit: number,
) {
  if (viewerId !== userId && (await safetyService.isBlockedBetween(viewerId, userId))) {
    throw AppError.notFound('USER_NOT_FOUND');
  }
  const where = kind === 'followers' ? { followingId: userId } : { followerId: userId };
  const rows = await prisma.follow.findMany({
    where,
    orderBy: { createdAt: 'desc' },
    take: limit + 1,
    ...(cursor ? { skip: 1, cursor: decodeFollowCursor(cursor) } : {}),
    include: { follower: true, following: true },
  });
  const hasMore = rows.length > limit;
  const page = hasMore ? rows.slice(0, limit) : rows;
  const hidden = await safetyService.blockedIdsFor(viewerId);

  // Listedeki kişilerle viewer arasındaki takip ilişkileri (rozetler ve "beni takip etmiyor" sıralaması için).
  const people = page.map((r) => (kind === 'followers' ? r.follower : r.following));
  const ids = people.map((p) => p.id);
  const [iFollowRows, followsMeRows] = await Promise.all([
    prisma.follow.findMany({ where: { followerId: viewerId, followingId: { in: ids } }, select: { followingId: true } }),
    prisma.follow.findMany({ where: { followingId: viewerId, followerId: { in: ids } }, select: { followerId: true } }),
  ]);
  const iFollow = new Set(iFollowRows.map((r) => r.followingId));
  const followsMe = new Set(followsMeRows.map((r) => r.followerId));

  const items = page
    .map((r, i) => ({ row: r, person: people[i]! }))
    .filter(({ person }) => !hidden.has(person.id) && person.status === 'ACTIVE')
    .map(({ row, person }) => ({
      ...serializeUserSummary(person),
      followedAt: row.createdAt,
      iFollow: iFollow.has(person.id),
      followsMe: followsMe.has(person.id),
    }));

  const last = page[page.length - 1];
  return { items, nextCursor: hasMore && last ? encodeFollowCursor(last.followerId, last.followingId) : null };
}

function encodeFollowCursor(followerId: string, followingId: string) {
  return Buffer.from(`${followerId}|${followingId}`).toString('base64url');
}

function decodeFollowCursor(cursor: string) {
  const [followerId, followingId] = Buffer.from(cursor, 'base64url').toString().split('|');
  if (!followerId || !followingId) throw AppError.badRequest('INVALID_CURSOR');
  return { followerId_followingId: { followerId, followingId } };
}

async function registerDevice(userId: string, token: string, platform: string, locale = 'en') {
  await prisma.deviceToken.upsert({
    where: { token },
    create: { userId, token, platform, locale },
    update: { userId, platform, locale },
  });
}

async function removeDevice(userId: string, token: string) {
  await prisma.deviceToken.deleteMany({ where: { userId, token } });
}

/** Apple kuralı: silme uygulama içinden başlatılabilmeli. Talep kaydedilir, hesap hemen gizlenir. */
async function requestDeletion(user: User, reason?: string) {
  await prisma.$transaction([
    prisma.accountDeletionRequest.create({ data: { userId: user.id, reason } }),
    prisma.user.update({ where: { id: user.id }, data: { status: 'DELETION_REQUESTED' } }),
    prisma.deviceToken.deleteMany({ where: { userId: user.id } }),
  ]);
}

export const userService = {
  getMe,
  usernameAvailability,
  completeOnboarding,
  updateProfile,
  getPublicProfile,
  follow,
  unfollow,
  listFollows,
  registerDevice,
  removeDevice,
  requestDeletion,
};
