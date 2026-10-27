/**
 * Geliştirme: tek cihazla arama/oda denemek için karşı taraf olan bir test kullanıcısı.
 * AUTH_DEV_BYPASS=true iken çalışır. Kullanıcı `erin_c0ffee` (cleanup-dev-users --smoke siler).
 *   npx tsx scripts/dev-call-peer.ts            → aramada sıraya girer, süre dolunca "devam" der, görüntülüyü kabul eder
 *   npx tsx scripts/dev-call-peer.ts --video    → ayrıca kimlikler açılınca görüntülü ister (20 token test kullanıcısından)
 *   npx tsx scripts/dev-call-peer.ts --room     → ilk canlı odaya girer (yoksa 50 token ile açar) ve bir mesaj yazar
 */
import 'dotenv/config';
import { io, type Socket } from 'socket.io-client';

const BASE = process.env.SMOKE_BASE ?? `http://localhost:${process.env.PORT ?? 4000}`;
const API = `${BASE}/api/v1`;
const TOKEN = 'dev:erin_c0ffee';

async function call(method: string, path: string, body?: unknown) {
  const res = await fetch(`${API}${path}`, {
    method,
    headers: { authorization: `Bearer ${TOKEN}`, 'content-type': 'application/json' },
    body: body ? JSON.stringify(body) : undefined,
  });
  const text = await res.text();
  return { status: res.status, data: text ? JSON.parse(text) : null };
}

function ack(s: Socket, event: string, payload: unknown) {
  return new Promise<any>((resolve, reject) =>
    s.emit(event, payload, (r: any) => (r?.ok ? resolve(r.data) : reject(new Error(JSON.stringify(r?.error))))),
  );
}

async function main() {
  await call('POST', '/auth/session');
  const me = await call('GET', '/users/me');
  if (!me.data.onboardingCompleted) {
    await call('POST', '/users/me/onboarding', {
      fullName: 'Erin Test',
      username: 'erin_c0ffee',
      gender: 'MALE',
      interests: ['music', 'movies', 'coffee', 'travel', 'tech'],
      chatGoal: 'quickMatch',
    });
  }

  const s = io(BASE, { auth: { token: TOKEN }, transports: ['websocket'] });
  await new Promise<void>((resolve, reject) => {
    s.on('connect', () => resolve());
    s.on('connect_error', reject);
  });
  s.onAny((event, data) => console.log('←', event, JSON.stringify(data)));

  if (process.argv.includes('--room')) {
    const rooms = await call('GET', '/rooms');
    const room = rooms.data.items[0] ?? (await call('POST', '/rooms', { title: 'Gece Sohbeti' })).data;
    if (!room?.id) throw new Error('Oda açılamadı');
    await ack(s, 'room:join', { roomId: room.id });
    await ack(s, 'room:message', { roomId: room.id, body: 'Selam, test kullanıcısı burada 👋' });
    await ack(s, 'room:mic', { roomId: room.id, on: true });
    console.log(`Odaya girildi: ${room.title}. Çıkmak için Ctrl+C.`);
    return;
  }

  s.on('call:times_up', ({ callId }) => setTimeout(() => void ack(s, 'call:keep', { callId }), 1000));
  if (process.argv.includes('--video')) {
    s.on('call:revealed', ({ callId }) =>
      setTimeout(() => ack(s, 'call:video_request', { callId }).catch((e) => console.error(e.message)), 3000),
    );
  }
  s.on('call:video_requested', ({ callId }) => void ack(s, 'call:video_respond', { callId, accept: true }));
  s.on('call:ended', () => {
    s.close();
    process.exit(0);
  });
  console.log('Sıra:', await ack(s, 'call:queue', { target: 'any' }));
}

main().catch((e) => {
  console.error(e);
  process.exit(1);
});
