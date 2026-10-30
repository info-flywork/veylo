import { randomUUID } from 'node:crypto';
import { BOOST_OPTIONS, CHECKIN_REWARDS, TOKEN_PRODUCTS, type BoostOption } from '../config/constants';
import { env } from '../config/env';
import { AppError } from '../errors/AppError';
import { logger } from '../lib/logger';
import { prisma } from '../lib/prisma';
import { emitToUser } from '../realtime/emitter';
import { tokenService } from './token.service';

const DAY_MS = 24 * 60 * 60 * 1000;

/** Takvim günü (UTC). Aynı gün ikinci kez toplanamaz; bir gün atlanırsa seri sıfırlanır. */
const dayIndex = (d: Date) => Math.floor(d.getTime() / DAY_MS);

function checkinState(user: { checkinDay: number; lastCheckinAt: Date | null }, now = new Date()) {
  const last = user.lastCheckinAt ? dayIndex(user.lastCheckinAt) : null;
  const today = dayIndex(now);
  const collectedToday = last === today;
  // Dün toplandıysa seri devam eder; daha eskiyse 1. güne döner. 7'den sonra baştan.
  const continues = last !== null && (last === today || last === today - 1);
  const streak = continues ? user.checkinDay : 0;
  const nextDay = collectedToday ? streak : (streak % CHECKIN_REWARDS.length) + 1;
  return {
    /** Ekranda vurgulanan gün (bugün toplanacak ya da toplanmış olan). */
    day: nextDay,
    collectedToday,
    canCollect: !collectedToday,
    reward: CHECKIN_REWARDS[nextDay - 1]!,
    rewards: CHECKIN_REWARDS,
  };
}

function boostState(user: { boostedUntil: Date | null; boostLevel: number }, now = new Date()) {
  const active = Boolean(user.boostedUntil && user.boostedUntil > now);
  return { active, until: active ? user.boostedUntil : null, visibility: active ? user.boostLevel : 0 };
}

/** Boost ekranı: bakiye, günlük ödül durumu, aktif boost ve seçenekler. */
async function status(userId: string) {
  const user = await prisma.user.findUniqueOrThrow({ where: { id: userId } });
  return {
    balance: user.tokenBalance,
    checkin: checkinState(user),
    boost: boostState(user),
    options: Object.entries(BOOST_OPTIONS).map(([id, o]) => ({ id, ...o })),
    products: Object.entries(TOKEN_PRODUCTS).map(([id, tokens]) => ({ id, tokens })),
    testPurchases: env.STORE_TEST_PURCHASES,
  };
}

/** Günün ödülünü toplar. */
async function checkin(userId: string) {
  const now = new Date();
  const result = await prisma.$transaction(async (tx) => {
    const user = await tx.user.findUniqueOrThrow({ where: { id: userId } });
    const state = checkinState(user, now);
    if (!state.canCollect) throw AppError.conflict('ALREADY_CHECKED_IN');
    await tx.user.update({ where: { id: userId }, data: { checkinDay: state.day, lastCheckinAt: now } });
    const { balance } = await tokenService.credit(tx, userId, state.reward, 'DAILY_CHECKIN', `${userId}:${dayIndex(now)}`, {
      day: state.day,
    });
    return { balance, day: state.day, reward: state.reward };
  });
  emitToUser(userId, 'tokens:updated', { balance: result.balance, delta: result.reward, reason: 'DAILY_CHECKIN' });
  return status(userId).then((s) => ({ ...s, collected: result }));
}

/** Profil Boost'u. Aktif bir boost varsa süre uzar, görünürlük yüksek olanda kalır. */
async function boost(userId: string, option: BoostOption) {
  const o = BOOST_OPTIONS[option];
  const now = new Date();
  const balance = await prisma.$transaction(async (tx) => {
    const user = await tx.user.findUniqueOrThrow({ where: { id: userId } });
    const base = user.boostedUntil && user.boostedUntil > now ? user.boostedUntil : now;
    const until = new Date(base.getTime() + o.minutes * 60 * 1000);
    const { balance } = await tokenService.spend(tx, userId, o.cost, 'PROFILE_BOOST', randomUUID(), {
      option,
      minutes: o.minutes,
      visibility: o.visibility,
    });
    const level = user.boostedUntil && user.boostedUntil > now ? Math.max(user.boostLevel, o.visibility) : o.visibility;
    await tx.user.update({ where: { id: userId }, data: { boostedUntil: until, boostLevel: level } });
    return balance;
  });
  emitToUser(userId, 'tokens:updated', { balance, delta: -o.cost, reason: 'PROFILE_BOOST' });
  return status(userId);
}

/**
 * RevenueCat bağlanana kadar: paket "satın alınmış" sayılır ve token yüklenir.
 * Sadece STORE_TEST_PURCHASES=true iken çalışır; gerçek ödeme gelince kapatılmalı.
 */
async function testPurchase(userId: string, productId: string) {
  if (!env.STORE_TEST_PURCHASES) throw AppError.forbidden('TEST_PURCHASES_DISABLED');
  const tokens = TOKEN_PRODUCTS[productId];
  if (!tokens) throw AppError.badRequest('UNKNOWN_PRODUCT');
  const { balance } = await prisma.$transaction((tx) =>
    tokenService.credit(tx, userId, tokens, 'PURCHASE', `test:${randomUUID()}`, { productId, test: true }),
  );
  logger.warn({ userId, productId }, 'Test satın alma: ödeme alınmadan token yüklendi');
  emitToUser(userId, 'tokens:updated', { balance, delta: tokens, reason: 'PURCHASE' });
  return { balance, tokens };
}

export const boostService = { status, checkin, boost, testPurchase };
