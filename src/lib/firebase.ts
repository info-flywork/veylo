import fs from 'node:fs';
import path from 'node:path';
import { cert, initializeApp, type App } from 'firebase-admin/app';
import { getAuth } from 'firebase-admin/auth';
import { getMessaging } from 'firebase-admin/messaging';
import { env } from '../config/env';
import { logger } from './logger';

let app: App | null = null;

/** Servis hesabı yoksa null döner (geliştirmede AUTH_DEV_BYPASS ile çalışılabilir). */
export function getFirebaseApp(): App | null {
  if (app) return app;
  const file = env.FIREBASE_SERVICE_ACCOUNT_PATH;
  if (!file) return null;
  const full = path.resolve(file);
  if (!fs.existsSync(full)) {
    logger.warn({ file: full }, 'Firebase servis hesabı dosyası bulunamadı');
    return null;
  }
  app = initializeApp({ credential: cert(JSON.parse(fs.readFileSync(full, 'utf8'))) });
  return app;
}

export function firebaseAuth() {
  const a = getFirebaseApp();
  return a ? getAuth(a) : null;
}

export function firebaseMessaging() {
  const a = getFirebaseApp();
  return a ? getMessaging(a) : null;
}
