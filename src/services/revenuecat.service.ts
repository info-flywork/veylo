import { TOKEN_PRODUCTS } from '../config/constants';
import { logger } from '../lib/logger';
import { prisma } from '../lib/prisma';
import { emitToUser } from '../realtime/emitter';
import { tokenService } from './token.service';

/** RevenueCat webhook gövdesinin kullandığımız kısmı. */
export interface RevenueCatEvent {
  id: string;
  type: string;
  app_user_id?: string;
  original_app_user_id?: string;
  aliases?: string[];
  product_id?: string;
  transaction_id?: string;
  environment?: 'SANDBOX' | 'PRODUCTION';
  store?: string;
  price?: number;
  currency?: string;
  cancel_reason?: string;
}

const UUID_RE = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;

/**
 * Uygulama girişten sonra Purchases.logIn(<bizim user id>) çağırmalı.
 * Anonim RevenueCat id'si ile gelirse alias'lar arasında bizim id aranır.
 */
async function resolveUserId(e: RevenueCatEvent): Promise<string | null> {
  const candidates = [e.app_user_id, e.original_app_user_id, ...(e.aliases ?? [])].filter(
    (id): id is string => Boolean(id && UUID_RE.test(id)),
  );
  if (candidates.length === 0) return null;
  const user = await prisma.user.findFirst({ where: { id: { in: candidates } }, select: { id: true } });
  return user?.id ?? null;
}

async function handleEvent(e: RevenueCatEvent): Promise<{ handled: boolean; note?: string }> {
  if (e.type === 'TEST') return { handled: true, note: 'test event' };

  const tokens = e.product_id ? TOKEN_PRODUCTS[e.product_id] : undefined;
  if (tokens === undefined) return { handled: false, note: `token ürünü değil: ${e.product_id}` };

  const userId = await resolveUserId(e);
  if (!userId) {
    logger.error({ eventId: e.id, appUserId: e.app_user_id }, 'RevenueCat: kullanıcı bulunamadı');
    return { handled: false, note: 'user not found' };
  }
  const refId = e.transaction_id ?? e.id;
  const meta = { eventId: e.id, productId: e.product_id, store: e.store, env: e.environment, price: e.price, currency: e.currency };

  if (e.type === 'NON_RENEWING_PURCHASE') {
    const { applied, balance } = await prisma.$transaction((tx) =>
      tokenService.credit(tx, userId, tokens, 'PURCHASE', refId, meta),
    );
    if (applied) emitToUser(userId, 'tokens:updated', { balance, delta: tokens, reason: 'PURCHASE' });
    return { handled: true };
  }

  // Mağaza iadesi: verilen token geri alınır (bakiye eksiye düşebilir).
  if (e.type === 'CANCELLATION' && e.cancel_reason === 'CUSTOMER_SUPPORT') {
    await prisma.$transaction((tx) => tokenService.forceDebit(tx, userId, tokens, 'REFUND', refId));
    const balance = await tokenService.getBalance(userId);
    emitToUser(userId, 'tokens:updated', { balance, delta: -tokens, reason: 'REFUND' });
    return { handled: true };
  }

  return { handled: false, note: `yok sayılan olay: ${e.type}` };
}

export const revenueCatService = { handleEvent };
