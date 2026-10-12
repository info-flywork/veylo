import type { User } from '@prisma/client';
import { env } from '../config/env';
import { TOKENS } from '../config/constants';
import { AppError } from '../errors/AppError';
import { firebaseAuth } from '../lib/firebase';
import { prisma } from '../lib/prisma';
import type { FirebaseIdentity } from '../types/express';
import { tokenService } from './token.service';

const PROVIDERS: Record<string, FirebaseIdentity['provider']> = {
  'google.com': 'GOOGLE',
  'apple.com': 'APPLE',
  password: 'PASSWORD',
  // Kullanıcı adıyla girişte backend'in ürettiği custom token (bkz. loginWithUsername).
  custom: 'PASSWORD',
};

/** HTTP ve Socket.IO'nun ortak kullandığı Firebase ID token doğrulaması. */
async function verifyToken(rawToken: string | undefined): Promise<FirebaseIdentity> {
  if (!rawToken) throw AppError.unauthorized('MISSING_TOKEN');

  if (env.AUTH_DEV_BYPASS && rawToken.startsWith('dev:')) {
    const uid = rawToken.slice(4);
    if (!uid) throw AppError.unauthorized('INVALID_TOKEN');
    return { uid: `dev_${uid}`, email: `${uid}@dev.local`, provider: 'DEV' };
  }

  const auth = firebaseAuth();
  if (!auth) throw AppError.unauthorized('AUTH_NOT_CONFIGURED');

  try {
    const decoded = await auth.verifyIdToken(rawToken, true);
    const provider = PROVIDERS[decoded.firebase.sign_in_provider];
    if (!provider) throw AppError.unauthorized('UNSUPPORTED_PROVIDER');
    return { uid: decoded.uid, email: decoded.email, provider };
  } catch (err) {
    if (err instanceof AppError) throw err;
    throw AppError.unauthorized('INVALID_TOKEN');
  }
}

/** Kullanıcı yoksa oluşturur ve hoş geldin token'ını verir. */
async function upsertSession(identity: FirebaseIdentity): Promise<{ user: User; isNew: boolean }> {
  const existing = await prisma.user.findUnique({ where: { firebaseUid: identity.uid } });
  if (existing) {
    const user = await prisma.user.update({
      where: { id: existing.id },
      data: { lastSeenAt: new Date(), email: identity.email ?? existing.email },
    });
    return { user, isNew: false };
  }

  const user = await prisma.$transaction(async (tx) => {
    const created = await tx.user.create({
      data: { firebaseUid: identity.uid, authProvider: identity.provider, email: identity.email },
    });
    await tokenService.credit(tx, created.id, TOKENS.welcomeBonus, 'WELCOME_BONUS', `welcome:${created.id}`);
    return tx.user.findUniqueOrThrow({ where: { id: created.id } });
  });
  return { user, isNew: true };
}

/**
 * Kullanıcı adı + şifre ile giriş. E-posta istemciye hiç gönderilmez:
 * şifre Firebase'de doğrulanır, sonra uygulamaya custom token döner.
 * Kullanıcı yok / şifre yanlış ayrımı yapılmaz (kullanıcı adı taraması engellenir).
 */
async function loginWithUsername(username: string, password: string): Promise<string> {
  const auth = firebaseAuth();
  if (!auth || !env.FIREBASE_WEB_API_KEY) throw AppError.unauthorized('AUTH_NOT_CONFIGURED');

  const user = await prisma.user.findUnique({
    where: { username },
    select: { firebaseUid: true, email: true, authProvider: true, status: true },
  });
  if (!user?.email || user.authProvider !== 'PASSWORD') throw AppError.unauthorized('INVALID_CREDENTIALS');
  if (user.status === 'SUSPENDED') throw AppError.forbidden('ACCOUNT_SUSPENDED');

  const res = await fetch(
    `https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=${env.FIREBASE_WEB_API_KEY}`,
    {
      method: 'POST',
      headers: { 'content-type': 'application/json' },
      body: JSON.stringify({ email: user.email, password, returnSecureToken: false }),
      signal: AbortSignal.timeout(10_000),
    },
  );
  const body = (await res.json().catch(() => ({}))) as { localId?: string; error?: { message?: string } };
  if (!res.ok) {
    if (body.error?.message?.startsWith('TOO_MANY_ATTEMPTS')) throw new AppError(429, 'TOO_MANY_ATTEMPTS');
    throw AppError.unauthorized('INVALID_CREDENTIALS');
  }
  if (body.localId !== user.firebaseUid) throw AppError.unauthorized('INVALID_CREDENTIALS');

  return auth.createCustomToken(user.firebaseUid);
}

export const authService = { verifyToken, upsertSession, loginWithUsername };
