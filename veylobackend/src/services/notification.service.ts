import { notificationTexts, type NotificationTexts } from '../i18n/notifications';
import { firebaseMessaging } from '../lib/firebase';
import { logger } from '../lib/logger';
import { prisma } from '../lib/prisma';
import { presence } from '../realtime/presence.store';

interface PushPayload {
  title: string;
  body: string;
  data?: Record<string, string>;
  /** Aynı sohbetin bildirimleri iOS'ta gruplanır. */
  threadId?: string;
}

/** Bildirim metni cihazın diline göre üretilir. */
type PushBuilder = (t: NotificationTexts, locale: string) => PushPayload;

const INVALID_TOKEN_CODES = new Set([
  'messaging/registration-token-not-registered',
  'messaging/invalid-registration-token',
]);

/** Android'de uygulamanın oluşturduğu kanal (push_service.dart ile aynı). */
const ANDROID_CHANNEL_ID = 'messages';

/** Kullanıcı çevrimdışıysa tüm cihazlarına FCM bildirimi gönderir. Hata asla yukarı taşınmaz. */
async function pushToUser(userId: string, build: PushBuilder, opts: { evenIfOnline?: boolean } = {}) {
  try {
    if (!opts.evenIfOnline && presence.isOnline(userId)) return;
    const messaging = firebaseMessaging();
    if (!messaging) return;

    const devices = await prisma.deviceToken.findMany({
      where: { userId },
      select: { token: true, locale: true },
    });
    if (devices.length === 0) return;

    const byLocale = new Map<string, string[]>();
    for (const d of devices) byLocale.set(d.locale, [...(byLocale.get(d.locale) ?? []), d.token]);

    const dead: string[] = [];
    for (const [locale, tokens] of byLocale) {
      const payload = build(notificationTexts(locale), locale);
      const res = await messaging.sendEachForMulticast({
        tokens,
        notification: { title: payload.title, body: payload.body },
        data: payload.data,
        apns: { payload: { aps: { sound: 'default', threadId: payload.threadId } } },
        android: { priority: 'high', notification: { channelId: ANDROID_CHANNEL_ID, sound: 'default' } },
      });
      res.responses.forEach((r, i) => {
        if (!r.success && INVALID_TOKEN_CODES.has(r.error?.code ?? '')) dead.push(tokens[i]!);
      });
    }
    if (dead.length) await prisma.deviceToken.deleteMany({ where: { token: { in: dead } } });
  } catch (err) {
    logger.warn({ err, userId }, 'Push gönderilemedi');
  }
}

export const notificationService = { pushToUser };
