import crypto from 'node:crypto';
import type { Request, Response } from 'express';
import { env } from '../config/env';
import { AppError } from '../errors/AppError';
import { logger } from '../lib/logger';
import { revenueCatService, type RevenueCatEvent } from '../services/revenuecat.service';

function safeEqual(a: string, b: string) {
  const ab = Buffer.from(a);
  const bb = Buffer.from(b);
  return ab.length === bb.length && crypto.timingSafeEqual(ab, bb);
}

/** POST /webhooks/revenuecat */
export async function revenueCat(req: Request, res: Response) {
  const auth = req.headers.authorization ?? '';
  const provided = auth.startsWith('Bearer ') ? auth.slice(7) : auth;
  if (!safeEqual(provided, env.REVENUECAT_WEBHOOK_AUTH)) throw AppError.unauthorized('INVALID_WEBHOOK_AUTH');

  const event = req.body?.event as RevenueCatEvent | undefined;
  if (!event?.id || !event.type) throw AppError.badRequest('INVALID_EVENT');

  const result = await revenueCatService.handleEvent(event);
  logger.info({ eventId: event.id, type: event.type, ...result }, 'RevenueCat webhook');
  // 200 dönmezsek RevenueCat tekrar dener; işlenmeyen olaylar da loglanıp 200 alır.
  res.json({ ok: true });
}
