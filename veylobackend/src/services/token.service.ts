import { Prisma, type LedgerReason } from '@prisma/client';
import { AppError } from '../errors/AppError';
import { prisma, type Tx } from '../lib/prisma';

/** refId verilmişse ve bu işlem daha önce yazıldıysa true. */
async function alreadyApplied(tx: Tx, reason: LedgerReason, refId?: string) {
  if (!refId) return false;
  const found = await tx.tokenLedger.findUnique({ where: { reason_refId: { reason, refId } } });
  return Boolean(found);
}

/**
 * Bakiyeye ekler. Aynı (reason, refId) ikinci kez gelirse hiçbir şey yapmaz.
 * Her zaman bir transaction içinden çağrılır.
 */
async function credit(
  tx: Tx,
  userId: string,
  amount: number,
  reason: LedgerReason,
  refId?: string,
  meta?: Prisma.InputJsonValue,
): Promise<{ applied: boolean; balance: number }> {
  if (await alreadyApplied(tx, reason, refId)) {
    const u = await tx.user.findUniqueOrThrow({ where: { id: userId }, select: { tokenBalance: true } });
    return { applied: false, balance: u.tokenBalance };
  }
  const user = await tx.user.update({
    where: { id: userId },
    data: { tokenBalance: { increment: amount } },
    select: { tokenBalance: true },
  });
  await tx.tokenLedger.create({
    data: { userId, delta: amount, balanceAfter: user.tokenBalance, reason, refId, meta },
  });
  return { applied: true, balance: user.tokenBalance };
}

/**
 * Bakiyeden düşer. Koşullu UPDATE sayesinde eşzamanlı iki harcama bakiyeyi eksiye düşüremez.
 * Yetersizse 402 INSUFFICIENT_TOKENS fırlatır.
 */
async function spend(
  tx: Tx,
  userId: string,
  amount: number,
  reason: LedgerReason,
  refId?: string,
  meta?: Prisma.InputJsonValue,
): Promise<{ applied: boolean; balance: number }> {
  if (amount <= 0) throw new Error('spend amount must be positive');
  if (await alreadyApplied(tx, reason, refId)) {
    const u = await tx.user.findUniqueOrThrow({ where: { id: userId }, select: { tokenBalance: true } });
    return { applied: false, balance: u.tokenBalance };
  }
  const result = await tx.user.updateMany({
    where: { id: userId, tokenBalance: { gte: amount } },
    data: { tokenBalance: { decrement: amount } },
  });
  const user = await tx.user.findUniqueOrThrow({ where: { id: userId }, select: { tokenBalance: true } });
  if (result.count === 0) throw AppError.insufficientTokens(amount, user.tokenBalance);

  await tx.tokenLedger.create({
    data: { userId, delta: -amount, balanceAfter: user.tokenBalance, reason, refId, meta },
  });
  return { applied: true, balance: user.tokenBalance };
}

/** İade gibi durumlarda bakiyenin eksiye düşmesine izin veren düşüm. */
async function forceDebit(tx: Tx, userId: string, amount: number, reason: LedgerReason, refId?: string) {
  if (await alreadyApplied(tx, reason, refId)) return;
  const user = await tx.user.update({
    where: { id: userId },
    data: { tokenBalance: { decrement: amount } },
    select: { tokenBalance: true },
  });
  await tx.tokenLedger.create({
    data: { userId, delta: -amount, balanceAfter: user.tokenBalance, reason, refId },
  });
}

async function getBalance(userId: string) {
  const u = await prisma.user.findUniqueOrThrow({ where: { id: userId }, select: { tokenBalance: true } });
  return u.tokenBalance;
}

async function history(userId: string, cursor?: string, limit = 30) {
  const rows = await prisma.tokenLedger.findMany({
    where: { userId },
    orderBy: [{ createdAt: 'desc' }, { id: 'desc' }],
    take: limit + 1,
    ...(cursor ? { cursor: { id: cursor }, skip: 1 } : {}),
    select: { id: true, delta: true, balanceAfter: true, reason: true, createdAt: true },
  });
  const hasMore = rows.length > limit;
  const items = hasMore ? rows.slice(0, limit) : rows;
  return { items, nextCursor: hasMore ? items[items.length - 1]!.id : null };
}

export const tokenService = { credit, spend, forceDebit, getBalance, history };
