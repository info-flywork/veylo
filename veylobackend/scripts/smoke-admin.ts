/**
 * Yönetim paneli API'si + hesap silme duman testi. Sunucu AUTH_DEV_BYPASS=true ve ADMIN_API_KEY ile çalışırken:
 *   npx tsx scripts/smoke-admin.ts
 * Test kullanıcıları cleanup-dev-users --smoke ile silinir (silinmeyenler).
 */
import { randomUUID } from 'node:crypto';
import 'dotenv/config';
import { io } from 'socket.io-client';
import { processDueDeletions } from '../src/jobs/account-deletion.job';
import { prisma } from '../src/lib/prisma';

const BASE = process.env.SMOKE_BASE ?? 'http://localhost:4000';
const API = `${BASE}/api/v1`;
const ADMIN_KEY = process.env.ADMIN_API_KEY!;
const run = randomUUID().replace(/-/g, '').slice(0, 6);
let passed = 0;

function check(cond: unknown, label: string) {
  if (!cond) throw new Error(`✗ ${label}`);
  passed++;
  console.log(`✓ ${label}`);
}

async function call(token: string | null, method: string, path: string, body?: unknown, headers: Record<string, string> = {}) {
  const res = await fetch(`${API}${path}`, {
    method,
    headers: {
      ...(token ? { authorization: `Bearer ${token}` } : {}),
      'content-type': 'application/json',
      ...headers,
    },
    body: body ? JSON.stringify(body) : undefined,
  });
  const text = await res.text();
  return { status: res.status, data: text ? JSON.parse(text) : null };
}

const admin = (method: string, path: string, body?: unknown) =>
  call(null, method, `/admin${path}`, body, { 'x-admin-key': ADMIN_KEY, 'x-admin-actor': 'smoke-test' });

async function newUser(name: string) {
  const token = `dev:${name}_${run}`;
  await call(token, 'POST', '/auth/session');
  const o = await call(token, 'POST', '/users/me/onboarding', {
    fullName: `${name} Test`,
    username: `${name}_${run}`,
    gender: 'FEMALE',
    interests: ['music', 'movies', 'coffee', 'travel', 'tech'],
    chatGoal: 'quickMatch',
  });
  return { token, id: o.data.id as string };
}

function socketRejected(token: string) {
  return new Promise<string>((resolve) => {
    const s = io(BASE, { auth: { token }, transports: ['websocket'], reconnection: false });
    s.on('connect', () => {
      s.close();
      resolve('CONNECTED');
    });
    s.on('connect_error', (e: any) => resolve(e?.data?.code ?? e.message));
  });
}

async function main() {
  check(ADMIN_KEY, '.env içinde ADMIN_API_KEY var');
  const alice = await newUser('alice');
  const bob = await newUser('bob');
  const carol = await newUser('carol');

  // ── yetki ──
  check((await call(null, 'GET', '/admin/stats')).status === 401, 'anahtarsız /admin reddedilir');
  check(
    (await call(null, 'GET', '/admin/stats', undefined, { 'x-admin-key': 'yanlis' })).status === 401,
    'yanlış anahtar reddedilir',
  );
  const stats = await admin('GET', '/stats');
  check(stats.status === 200 && typeof stats.data.reports.open === 'number', 'özet istatistikler');

  // ── şikayet → içerik kaldır + askıya al ──
  const vibe = await call(bob.token, 'POST', '/vibes', { body: `kaba bir vibe ${run}`, anonymous: true });
  check(vibe.status === 201, 'bob vibe paylaştı');
  const rv = await call(alice.token, 'POST', `/vibes/${vibe.data.id}/report`, { reason: 'HARASSMENT' });
  check(rv.status < 300, 'alice vibe’ı şikayet etti');
  const rp = await call(alice.token, 'POST', '/safety/reports', { targetUserId: bob.id, reason: 'SPAM' });
  check(rp.status < 300, 'alice bob’un profilini şikayet etti');

  const list = await admin('GET', `/reports?targetUserId=${bob.id}`);
  const vibeReport = list.data.items.find((r: any) => r.context === 'VIBE');
  const profileReport = list.data.items.find((r: any) => r.context === 'PROFILE');
  check(vibeReport && profileReport, 'açık şikayetler listede');
  check(vibeReport.content?.body?.includes(run) && vibeReport.target.reportsReceived === 2, 'şikayette içerik ve kişinin şikayet sayısı');
  check(vibeReport.target.email === `bob_${run}@dev.local`, 'panel e-postayı görür');

  const reviewing = await admin('PATCH', `/reports/${vibeReport.id}`, { status: 'REVIEWING' });
  check(reviewing.data.status === 'REVIEWING', 'şikayet incelemeye alındı');

  const resolved = await admin('POST', `/reports/${vibeReport.id}/resolve`, {
    decision: 'ACTION',
    removeContent: true,
    suspendDays: 1,
    note: 'taciz',
  });
  check(resolved.status === 200 && resolved.data.status === 'ACTIONED', 'şikayet işlem yapılarak kapandı');
  check(resolved.data.resolution === 'CONTENT_REMOVED+SUSPENDED' && resolved.data.content.removed, 'içerik kaldırıldı, hesap askıda');
  check((await admin('POST', `/reports/${vibeReport.id}/resolve`, { decision: 'DISMISS' })).status === 409, 'kapanmış şikayet tekrar kapanmaz');

  const feed = await call(carol.token, 'GET', '/vibes');
  check(!JSON.stringify(feed.data).includes(run), 'kaldırılan vibe akışta yok');
  const me = await call(bob.token, 'GET', '/users/me');
  check(me.status === 403 && me.data.error.code === 'ACCOUNT_SUSPENDED', 'askıdaki bob API kullanamaz');
  check((await socketRejected(bob.token)) === 'ACCOUNT_SUSPENDED', 'askıdaki bob socket’e bağlanamaz');

  const dismissed = await admin('POST', `/reports/${profileReport.id}/resolve`, { decision: 'DISMISS' });
  check(dismissed.data.status === 'DISMISSED', 'diğer şikayet yoksayıldı');

  // ── askı süresi dolunca hesap açılır ──
  await prisma.user.update({ where: { id: bob.id }, data: { suspendedUntil: new Date(Date.now() - 1000) } });
  check((await call(bob.token, 'GET', '/users/me')).status === 200, 'askı süresi dolunca hesap kendiliğinden açıldı');

  // ── süresiz askı + kaldırma ──
  const perm = await admin('POST', `/users/${bob.id}/suspend`, { days: null, reason: 'test' });
  check(perm.data.status === 'SUSPENDED' && perm.data.suspendedUntil === null, 'süresiz askıya alındı');
  check((await call(bob.token, 'POST', '/auth/session')).status === 403, 'süresiz askıda giriş yapılamaz');
  const un = await admin('POST', `/users/${bob.id}/unsuspend`);
  check(un.data.status === 'ACTIVE' && (await call(bob.token, 'GET', '/users/me')).status === 200, 'askı kaldırıldı');

  const search = await admin('GET', `/users?q=bob_${run}`);
  check(search.data.items.length === 1, 'kullanıcı arama');
  const detail = await admin('GET', `/users/${bob.id}`);
  check(detail.data.counts.reportsReceived === 2 && detail.data.actions.length >= 4, 'kullanıcı detayı: şikayetler ve işlem geçmişi');

  // ── hesap silme: bekleme süresinde giriş = geri alma ──
  check((await call(bob.token, 'POST', '/users/me/deletion-request', { reason: 'test' })).status < 300, 'bob silme istedi');
  let bobRow = await prisma.user.findUnique({ where: { id: bob.id } });
  check(bobRow?.status === 'DELETION_REQUESTED', 'hesap silinme bekliyor');
  const pend = await admin('GET', '/deletion-requests');
  const req = pend.data.items.find((r: any) => r.userId === bob.id);
  check(req && new Date(req.purgeAt).getTime() > Date.now() + 29 * 24 * 3600 * 1000, 'kalıcı silme 30 gün sonraya planlandı');
  await call(bob.token, 'POST', '/auth/session');
  bobRow = await prisma.user.findUnique({ where: { id: bob.id } });
  const cancelled = await prisma.accountDeletionRequest.findUnique({ where: { id: req.id } });
  check(bobRow?.status === 'ACTIVE' && cancelled?.status === 'CANCELLED', 'tekrar giriş yapınca silme iptal edildi');

  // ── hemen silme (panelden): grup sahipliği devredilir ──
  const g = await call(bob.token, 'POST', '/groups', { title: `Silinecek grup ${run}` });
  check(g.status === 201, 'bob grup kurdu');
  check((await call(alice.token, 'POST', `/groups/${g.data.id}/join`, {})).status < 300, 'alice gruba katıldı');
  await call(bob.token, 'POST', '/users/me/deletion-request', {});
  const req2 = (await admin('GET', '/deletion-requests')).data.items.find((r: any) => r.userId === bob.id);
  const purged = await admin('POST', `/deletion-requests/${req2.id}/purge`, { note: 'kullanıcı e-postayla istedi' });
  check(purged.status === 200 && purged.data.purged, 'panelden hemen silindi');
  check(!(await prisma.user.findUnique({ where: { id: bob.id } })), 'bob veritabanında yok');
  const owner = await prisma.conversationMember.findFirst({ where: { conversationId: g.data.id, role: 'OWNER' } });
  check(owner?.userId === alice.id, 'grup sahipliği alice’e geçti');
  const log = await admin('GET', `/actions?targetUserId=${bob.id}`);
  check(log.data.items.some((a: any) => a.action === 'ACCOUNT_PURGED' && a.actor === 'smoke-test'), 'silme işlem kaydında');

  // ── zamanlanmış iş: süresi dolan istek ──
  await call(carol.token, 'POST', '/users/me/deletion-request', {});
  await prisma.accountDeletionRequest.updateMany({ where: { userId: carol.id }, data: { purgeAt: new Date(Date.now() - 1000) } });
  const job = await processDueDeletions();
  check(job.done >= 1 && !(await prisma.user.findUnique({ where: { id: carol.id } })), 'zamanlanmış iş süresi dolan hesabı sildi');

  console.log(`\nTamam: ${passed} kontrol geçti.`);
}

main()
  .catch((e) => {
    console.error(e);
    process.exitCode = 1;
  })
  .finally(() => prisma.$disconnect());
