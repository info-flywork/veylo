import type { User } from '@prisma/client';
import { prisma } from '../lib/prisma';
import { presence } from '../realtime/presence.store';
import { safetyService } from './safety.service';

export const MOODS = ['sad', 'meltie', 'bored', 'crying', 'smile'] as const;
export const INTENTS = ['friends', 'venting', 'flirty', 'fun', 'cultures', 'language'] as const;

/** AI Match "aradığım" seçimi ile kullanıcıların sohbet hedefi (onboarding) arasındaki uyum. */
const INTENT_GOALS: Record<(typeof INTENTS)[number], string[]> = {
  friends: ['meetSomeoneNew', 'quickMatch'],
  venting: ['lateNight', 'moodMatch'],
  flirty: ['flirtyChat'],
  fun: ['quickMatch', 'lateNight'],
  cultures: ['meetSomeoneNew'],
  language: ['meetSomeoneNew'],
};

const RESULT_COUNT = 5;
const POOL = 200;

const interestsOf = (u: Pick<User, 'interests'>) => (Array.isArray(u.interests) ? (u.interests as string[]) : []);

/**
 * Akıllı eşleşme: ortak ilgi alanları, sohbet hedefi uyumu ve şu an çevrimiçi olmak puanlanır.
 * Sadece gerçek kullanıcılar (AI karakterler eşleşmeye girmez).
 */
async function search(viewerId: string, input: { mood: (typeof MOODS)[number]; intent: (typeof INTENTS)[number] }) {
  const me = await prisma.user.findUniqueOrThrow({ where: { id: viewerId } });
  const blocked = await safetyService.blockedIdsFor(viewerId);
  const recent = new Date(Date.now() - 14 * 24 * 60 * 60 * 1000);

  const pool = await prisma.user.findMany({
    where: {
      id: { notIn: [viewerId, ...blocked] },
      status: 'ACTIVE',
      onboardingCompleted: true,
      isPersona: false,
      OR: [{ lastSeenAt: { gte: recent } }, { lastSeenAt: null, createdAt: { gte: recent } }],
    },
    orderBy: { lastSeenAt: 'desc' },
    take: POOL,
  });

  const mine = new Set(interestsOf(me));
  const goals = new Set(INTENT_GOALS[input.intent]);
  const scored = pool.map((u) => {
    const theirs = interestsOf(u);
    const common = theirs.filter((i) => mine.has(i));
    const union = new Set([...mine, ...theirs]).size || 1;
    const online = presence.isOnline(u.id);
    const score =
      (common.length / union) * 55 + (u.chatGoal && goals.has(u.chatGoal) ? 20 : 0) + (online ? 15 : 0) + (u.avatarUrl ? 5 : 0) + Math.random() * 5;
    return { u, common, online, score };
  });
  scored.sort((a, b) => b.score - a.score);

  return {
    items: scored.slice(0, RESULT_COUNT).map(({ u, common, online, score }) => ({
      userId: u.id,
      username: u.username,
      displayName: u.displayName ?? u.username,
      avatarUrl: u.avatarUrl,
      bio: u.bio,
      commonInterests: common,
      isOnline: online,
      // Kartta "%XX Vibe match": 60-98 arası.
      vibePercent: Math.round(60 + Math.min(1, score / 100) * 38),
    })),
  };
}

/** AI Match ekranındaki canlı sayı. */
function stats() {
  return { onlineCount: presence.onlineCount };
}

export const matchService = { search, stats };
