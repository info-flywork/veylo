import type { Note, User } from '@prisma/client';
import { NOTE } from '../config/constants';
import { prisma } from '../lib/prisma';
import { serializeUserSummary } from '../serializers/user.serializer';
import { safetyService } from './safety.service';

const LIMIT = 30;

function serializeNote(n: Note & { user: User }) {
  return { text: n.text, expiresAt: n.expiresAt, updatedAt: n.updatedAt, user: serializeUserSummary(n.user) };
}

/**
 * Sohbetler ekranındaki notlar: kendi notum + takip ettiklerim, birebir sohbet ettiklerim
 * (anonim olmayan, kabul edilmiş) ve AI karakterler.
 */
async function list(viewerId: string) {
  const now = new Date();
  const [mine, follows, chats, blocked] = await Promise.all([
    prisma.note.findFirst({ where: { userId: viewerId, expiresAt: { gt: now } }, include: { user: true } }),
    prisma.follow.findMany({ where: { followerId: viewerId }, select: { followingId: true } }),
    prisma.conversationMember.findMany({
      where: {
        userId: { not: viewerId },
        conversation: {
          type: { in: ['DIRECT', 'ANONYMOUS'] },
          status: 'ACCEPTED',
          members: { some: { userId: viewerId } },
          OR: [{ type: 'DIRECT' }, { revealedAt: { not: null } }],
        },
      },
      select: { userId: true },
    }),
    safetyService.blockedIdsFor(viewerId),
  ]);
  const known = new Set([...follows.map((f) => f.followingId), ...chats.map((c) => c.userId)]);
  known.delete(viewerId);

  const rows = await prisma.note.findMany({
    where: {
      expiresAt: { gt: now },
      user: { status: 'ACTIVE' },
      OR: [{ userId: { in: [...known] } }, { user: { isPersona: true } }],
      ...(blocked.size ? { userId: { notIn: [...blocked] } } : {}),
    },
    include: { user: true },
    orderBy: { updatedAt: 'desc' },
    take: LIMIT,
  });
  // Tanıdıklarımın notları AI karakterlerinkinden önce.
  rows.sort((a, b) => Number(b.user.isPersona === false) - Number(a.user.isPersona === false));

  return { mine: mine ? serializeNote(mine) : null, items: rows.map(serializeNote) };
}

async function setMine(viewerId: string, text: string) {
  const expiresAt = new Date(Date.now() + NOTE.ttlHours * 60 * 60 * 1000);
  const note = await prisma.note.upsert({
    where: { userId: viewerId },
    create: { userId: viewerId, text, expiresAt },
    update: { text, expiresAt },
    include: { user: true },
  });
  return serializeNote(note);
}

async function deleteMine(viewerId: string) {
  await prisma.note.deleteMany({ where: { userId: viewerId } });
}

export const noteService = { list, setMine, deleteMine };
