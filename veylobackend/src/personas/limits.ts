import { env } from '../config/env';

/**
 * Günlük sayaçlar (bellekte; sunucu tek instance çalışır). Gün değişince sıfırlanır.
 * Amaç maliyet tavanı: sınır dolunca karakterler o gün susar.
 */
let day = today();
let globalCalls = 0;
const userReplies = new Map<string, number>();

function today() {
  return new Date().toISOString().slice(0, 10);
}

function roll() {
  const d = today();
  if (d !== day) {
    day = d;
    globalCalls = 0;
    userReplies.clear();
  }
}

export const personaLimits = {
  /** Bir OpenAI çağrısı yapılabilir mi (sayaç artar). */
  takeCall(): boolean {
    roll();
    if (globalCalls >= env.PERSONA_GLOBAL_DAILY_CALLS) return false;
    globalCalls++;
    return true;
  },
  /** Bu kullanıcıya bugün bir AI cevabı daha verilebilir mi (sayaç artar). */
  takeUserReply(userId: string): boolean {
    roll();
    const n = userReplies.get(userId) ?? 0;
    if (n >= env.PERSONA_USER_DAILY_REPLIES) return false;
    userReplies.set(userId, n + 1);
    return true;
  },
  stats() {
    roll();
    return { day, globalCalls, users: userReplies.size };
  },
};
