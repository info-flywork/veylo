import { RtcRole, RtcTokenBuilder } from 'agora-token';
import { env } from '../config/env';

/** Agora RTC kanalına katılmak için istemciye verilen bilgiler. */
export interface RtcCredentials {
  appId: string;
  channel: string;
  uid: number;
  token: string;
  expiresAt: number;
}

export const agoraEnabled = () => Boolean(env.AGORA_APP_ID && env.AGORA_APP_CERTIFICATE);

/**
 * Kullanıcının kanaldaki sayısal kimliği (Agora uid). Kullanıcı id'sinden türetilir; istemciye
 * uid → katılımcı eşlemesi sunucudan gelir, böylece anonim kişinin gerçek id'si sızmaz.
 */
export function agoraUid(userId: string): number {
  let h = 0x811c9dc5;
  for (let i = 0; i < userId.length; i++) {
    h ^= userId.charCodeAt(i);
    h = Math.imul(h, 0x01000193);
  }
  return (h >>> 1) || 1;
}

/** Kısa ömürlü RTC token'ı (varsayılan 2 saat). Agora ayarlı değilse null. */
export function rtcCredentials(channel: string, userId: string, ttlSec = 2 * 60 * 60): RtcCredentials | null {
  if (!agoraEnabled()) return null;
  const uid = agoraUid(userId);
  const token = RtcTokenBuilder.buildTokenWithUid(
    env.AGORA_APP_ID!,
    env.AGORA_APP_CERTIFICATE!,
    channel,
    uid,
    RtcRole.PUBLISHER,
    ttlSec,
    ttlSec,
  );
  return { appId: env.AGORA_APP_ID!, channel, uid, token, expiresAt: Date.now() + ttlSec * 1000 };
}
