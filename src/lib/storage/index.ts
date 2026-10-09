import path from 'node:path';
import { env } from '../../config/env';
import { BunnyStorage } from './bunny.storage';
import { LocalStorage } from './local.storage';
import type { StorageDriver } from './storage.types';

export const LOCAL_UPLOAD_DIR = path.resolve('uploads');

export const storage: StorageDriver = env.BUNNY_STORAGE_ZONE
  ? new BunnyStorage({
      zone: env.BUNNY_STORAGE_ZONE,
      password: env.BUNNY_STORAGE_PASSWORD!,
      region: env.BUNNY_STORAGE_REGION || undefined,
      cdnUrl: env.BUNNY_CDN_URL!,
    })
  : new LocalStorage(LOCAL_UPLOAD_DIR, env.publicBaseUrl);

export type { StorageDriver };
