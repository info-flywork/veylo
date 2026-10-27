import { createHash, timingSafeEqual } from 'node:crypto';
import type { NextFunction, Request, Response } from 'express';
import { env } from '../config/env';
import { AppError } from '../errors/AppError';

const digest = (v: string) => createHash('sha256').update(v).digest();

/**
 * Yönetim paneli: `x-admin-key: <ADMIN_API_KEY>`. Anahtar ayarlı değilse uçlar hiç yokmuş gibi davranır.
 * `x-admin-actor` (ör. "ayse@veylo.app") işlem kaydına yazılır.
 */
export function requireAdmin(req: Request, _res: Response, next: NextFunction) {
  const key = env.ADMIN_API_KEY;
  if (!key) throw AppError.notFound('ROUTE_NOT_FOUND');
  const given = req.header('x-admin-key') ?? '';
  if (!timingSafeEqual(digest(given), digest(key))) throw AppError.unauthorized('INVALID_ADMIN_KEY');
  req.adminActor = (req.header('x-admin-actor') ?? 'admin').trim().slice(0, 100) || 'admin';
  next();
}
