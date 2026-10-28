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
    /** Agora (sesli/görüntülü arama ve canlı odalar). Boşsa aramalar ses/görüntü olmadan çalışmaz. */
    AGORA_APP_ID: z.string().optional(),
    AGORA_APP_CERTIFICATE: z.string().optional(),
    /** Sadece test: anonim arama süresi (sn). Production'da her zaman 60. */
    CALL_ANON_SECONDS: z.coerce.number().int().min(1).max(60).optional(),
    /**
     * true iken bakiye yetmese de oda, arama ve diğer ücretli işlemler geçer.
     * Mağazaya çıkmadan önce false yap.
     */
    SKIP_TOKEN_SPEND: z
      .string()
      .default('true')
      .transform((v) => v === 'true'),
    /** AI karakterler (persona). Boşsa karakterler cevap vermez, vibe paylaşmaz. */
    OPENAI_API_KEY: z.string().optional(),
    OPENAI_MODEL: z.string().default('gpt-4o-mini'),
    /** Test için değiştirilebilir (ör. yerel sahte sunucu). */
    OPENAI_BASE_URL: z.string().default('https://api.openai.com/v1'),
    /** Yönetim paneli API anahtarı (x-admin-key). Boşsa /admin kapalıdır. */
    ADMIN_API_KEY: z.string().min(32).optional().or(z.literal('').transform(() => undefined)),
    /** Silme isteğinden kalıcı silmeye kadar geçen gün (bu sürede giriş yapan hesabını geri alır). */
    ACCOUNT_DELETION_GRACE_DAYS: z.coerce.number().int().min(0).default(30),
    /** Bir kullanıcının AI karakterlerden günde alabileceği en fazla cevap. */
    PERSONA_USER_DAILY_REPLIES: z.coerce.number().int().positive().default(60),
    /** Tüm sistemde günlük en fazla OpenAI çağrısı (maliyet tavanı). */
    PERSONA_GLOBAL_DAILY_CALLS: z.coerce.number().int().positive().default(3000),
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
