import type { NextFunction, Request, Response } from 'express';
import { AppError } from '../errors/AppError';
import { prisma } from '../lib/prisma';
import { authService } from '../services/auth.service';

function bearer(req: Request): string | undefined {
  const header = req.headers.authorization;
  return header?.startsWith('Bearer ') ? header.slice(7) : undefined;
}

/** Sadece Firebase token'ını doğrular (kullanıcı henüz veritabanında olmayabilir). */
export async function authenticate(req: Request, _res: Response, next: NextFunction) {
  req.identity = await authService.verifyToken(bearer(req));
  next();
}

/** Token + veritabanındaki aktif kullanıcı. */
export async function requireUser(req: Request, res: Response, next: NextFunction) {
  await authenticate(req, res, () => undefined);
  const user = await prisma.user.findUnique({ where: { firebaseUid: req.identity!.uid } });
  if (!user) throw AppError.unauthorized('USER_NOT_REGISTERED', 'Önce POST /auth/session çağrılmalı');
  req.user = await authService.ensureNotSuspended(user);
  next();
}

/** Profil oluşturma adımlarını bitirmiş kullanıcı (kullanıcı adı zorunlu). */
export async function requireOnboarded(req: Request, _res: Response, next: NextFunction) {
  if (!req.user?.onboardingCompleted) throw AppError.forbidden('ONBOARDING_REQUIRED');
  next();
}
