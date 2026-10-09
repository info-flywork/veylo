import 'dotenv/config';
import { z } from 'zod';

const envSchema = z
  .object({
    NODE_ENV: z.enum(['development', 'test', 'production']).default('development'),
    PORT: z.coerce.number().int().positive().default(4000),
    CORS_ORIGINS: z.string().default(''),
    DATABASE_URL: z.string().min(1),
    FIREBASE_SERVICE_ACCOUNT_PATH: z.string().optional(),
    AUTH_DEV_BYPASS: z
      .string()
      .default('false')
      .transform((v) => v === 'true'),
    REVENUECAT_WEBHOOK_AUTH: z.string().min(1).default('change-me'),
    /** Firebase Web API anahtarı: kullanıcı adıyla girişte şifreyi doğrulamak için. */
    FIREBASE_WEB_API_KEY: z.string().optional(),
    /** Bu sunucunun dışarıdan erişilen adresi (yerel depolama URL'leri için). */
    PUBLIC_BASE_URL: z.string().optional(),
    BUNNY_STORAGE_ZONE: z.string().optional(),
    BUNNY_STORAGE_PASSWORD: z.string().optional(),
    /** Boş = Falkenstein (DE). Diğerleri: uk, ny, la, sg, se, br, jh, syd */
    BUNNY_STORAGE_REGION: z.string().optional(),
    BUNNY_CDN_URL: z.string().optional(),
  })
  .refine((e) => !e.BUNNY_STORAGE_ZONE || (e.BUNNY_STORAGE_PASSWORD && e.BUNNY_CDN_URL), {
    message: 'BUNNY_STORAGE_ZONE ayarlıysa BUNNY_STORAGE_PASSWORD ve BUNNY_CDN_URL de gerekli',
  })
  .refine((e) => !(e.NODE_ENV === 'production' && !e.BUNNY_STORAGE_ZONE), {
    message: 'production ortamında Bunny Storage ayarlanmalı',
  })
  .refine((e) => !(e.NODE_ENV === 'production' && e.AUTH_DEV_BYPASS), {
    message: 'AUTH_DEV_BYPASS production ortamında açık olamaz',
  })
  .refine((e) => !(e.NODE_ENV === 'production' && e.REVENUECAT_WEBHOOK_AUTH === 'change-me'), {
    message: 'REVENUECAT_WEBHOOK_AUTH production ortamında ayarlanmalı',
  });

const parsed = envSchema.safeParse(process.env);
if (!parsed.success) {
  console.error('Geçersiz ortam değişkenleri:', parsed.error.issues);
  process.exit(1);
}

export const env = {
  ...parsed.data,
  isProd: parsed.data.NODE_ENV === 'production',
  corsOrigins: parsed.data.CORS_ORIGINS.split(',').map((s) => s.trim()).filter(Boolean),
  publicBaseUrl: (parsed.data.PUBLIC_BASE_URL ?? `http://localhost:${parsed.data.PORT}`).replace(/\/$/, ''),
};
