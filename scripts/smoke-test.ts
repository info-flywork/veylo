/**
 * Uçtan uca duman testi. Sunucu AUTH_DEV_BYPASS=true ile çalışırken:
 *   npx tsx scripts/smoke-test.ts
 * Her çalıştırmada yeni rastgele kullanıcılar oluşturur.
 */
import { randomUUID } from 'node:crypto';
import sharp from 'sharp';
import { io, type Socket } from 'socket.io-client';
import 'dotenv/config';

const BASE = process.env.SMOKE_BASE ?? 'http://localhost:4000';
const API = `${BASE}/api/v1`;
const run = randomUUID().slice(0, 6);
let passed = 0;

function check(cond: unknown, label: string) {
  if (!cond) throw new Error(`✗ ${label}`);
  passed++;
  console.log(`✓ ${label}`);
}

async function call(token: string, method: string, path: string, body?: unknown) {
  const res = await fetch(`${API}${path}`, {
    method,
    headers: { authorization: `Bearer ${token}`, 'content-type': 'application/json' },
    body: body ? JSON.stringify(body) : undefined,
  });
  const text = await res.text();
  return { status: res.status, data: text ? JSON.parse(text) : null };
}

async function newUser(name: string) {
  const token = `dev:${name}_${run}`;
  const s = await call(token, 'POST', '/auth/session');
  check(s.status === 201 && s.data.user.tokenBalance === 100, `${name}: hesap oluştu, 100 hoş geldin token'ı`);
  const o = await call(token, 'POST', '/users/me/onboarding', {
    fullName: `${name} Test`,
    username: `${name}_${run}`,
    gender: 'FEMALE',
    interests: ['music', 'movies', 'coffee', 'travel', 'tech'],
    chatGoal: 'quickMatch',
  });
  check(o.status === 200 && o.data.onboardingCompleted, `${name}: profil oluşturma tamam`);

  const av = await upload(token, 'PUT', '/media/avatar', await photoWithGps(), 'photo.jpg');
  check(av.status === 200 && av.data.avatarUrl?.endsWith('.webp'), `${name}: profil fotoğrafı yüklendi (webp)`);
  return { token, id: o.data.id as string, username: o.data.username as string, avatarUrl: av.data.avatarUrl as string };
}

/** İçinde GPS EXIF'i olan 1600x1200 JPEG (sunucu bunu silmeli). */
async function photoWithGps() {
  return sharp({ create: { width: 1600, height: 1200, channels: 3, background: '#7b5cff' } })
    .withExif({ IFD3: { GPSLatitudeRef: 'N', GPSLatitude: '41/1 0/1 0/1', GPSLongitudeRef: 'E', GPSLongitude: '29/1 0/1 0/1' } })
    .jpeg()
    .toBuffer();
}

async function upload(token: string, method: string, path: string, data: Buffer, filename: string) {
  const form = new FormData();
  form.append('file', new Blob([new Uint8Array(data)]), filename);
  const res = await fetch(`${API}${path}`, { method, headers: { authorization: `Bearer ${token}` }, body: form });
  const text = await res.text();
  return { status: res.status, data: text ? JSON.parse(text) : null };
}

function connect(token: string): Promise<Socket> {
  return new Promise((resolve, reject) => {
    const s = io(BASE, { auth: { token }, transports: ['websocket'] });
    s.on('connect', () => resolve(s));
    s.on('connect_error', reject);
  });
}

function once<T = any>(s: Socket, event: string, ms = 3000): Promise<T> {
  return new Promise((resolve, reject) => {
    const t = setTimeout(() => reject(new Error(`timeout: ${event}`)), ms);
    s.once(event, (d: T) => {
      clearTimeout(t);
      resolve(d);
    });
  });
}

const emit = (s: Socket, event: string, payload: unknown) =>
  s.emitWithAck(event, payload) as Promise<{ ok: boolean; data?: any; error?: any }>;

async function main() {
  // ── Kullanıcılar
  const alice = await newUser('alice');
  const bob = await newUser('bob');

  // ── Medya
  const stored = Buffer.from(await (await fetch(alice.avatarUrl)).arrayBuffer());
  const storedMeta = await sharp(stored).metadata();
  check(storedMeta.format === 'webp' && Math.max(storedMeta.width!, storedMeta.height!) === 1080, 'fotoğraf 1080px webp olarak kaydedildi');
  check(!storedMeta.exif, 'GPS/EXIF bilgisi silindi');
  const notImage = await upload(alice.token, 'PUT', '/media/avatar', Buffer.from('<?php echo 1; ?>'.repeat(10)), 'x.jpg');
  check(notImage.status === 415, 'görsel olmayan dosya reddedildi (uzantısı .jpg olsa bile)');

  const avail = await call(alice.token, 'GET', `/users/username-available?username=${bob.username}`);
  check(avail.data.available === false && avail.data.suggestions.length > 0, 'alınmış kullanıcı adı için öneri geliyor');

  // ── Mesaj isteği (bob alice'i takip etmiyor → PENDING)
  const dm = await call(alice.token, 'POST', '/conversations/direct', { userId: bob.id });
  check(dm.status === 201 && dm.data.status === 'PENDING', 'takip etmeyen kişiye sohbet = mesaj isteği');
  const convId = dm.data.id;

  const first = await call(alice.token, 'POST', `/conversations/${convId}/messages`, {
    clientMsgId: randomUUID(), body: 'Selam!',
  });
  check(first.status === 201 && first.data.seq === 1, 'ilk mesaj gönderildi (seq=1)');
  const second = await call(alice.token, 'POST', `/conversations/${convId}/messages`, {
    clientMsgId: randomUUID(), body: 'Orada mısın?',
  });
  check(second.data?.error?.code === 'REQUEST_PENDING_LIMIT', 'onaysız istekte ikinci mesaj engellendi');

  const reqs = await call(bob.token, 'GET', '/conversations?box=requests');
  check(reqs.data.items.some((c: any) => c.id === convId && c.isRequest), 'bob isteği "requests" kutusunda görüyor');
  const bobReply = await call(bob.token, 'POST', `/conversations/${convId}/messages`, {
    clientMsgId: randomUUID(), body: 'x',
  });
  check(bobReply.data?.error?.code === 'REQUEST_NOT_ACCEPTED', 'onaylamadan cevap yazılamıyor');
  const ap = await call(bob.token, 'POST', `/conversations/${convId}/approve`);
  check(ap.data.status === 'ACCEPTED', 'bob isteği onayladı');

  // ── Socket: gerçek zamanlı mesaj, ack, tekrar gönderim
  const sa = await connect(alice.token);
  const sb = await connect(bob.token);
  check(sa.connected && sb.connected, 'iki taraf da socket ile bağlandı');

  const clientMsgId = randomUUID();
  const incoming = once(sa, 'message:new');
  const ack = await emit(sb, 'message:send', { conversationId: convId, clientMsgId, body: 'Merhaba alice 👋' });
  check(ack.ok && ack.data.seq === 2, 'socket ile gönderim ack döndü (seq=2)');
  const got = await incoming;
  check(got.message.body === 'Merhaba alice 👋' && !got.message.isMine, 'alice mesajı anında aldı (emoji dahil)');

  const dupAck = await emit(sb, 'message:send', { conversationId: convId, clientMsgId, body: 'Merhaba alice 👋' });
  check(dupAck.ok && dupAck.data.id === ack.data.id, 'aynı clientMsgId tekrar gelince ikinci mesaj yazılmadı');

  const sync = await emit(sa, 'conversation:sync', { conversationId: convId, afterSeq: 0 });
  check(sync.ok && sync.data.items.length === 2, 'sync ile kaçırılan mesajlar alındı');

  // ── Sohbette görsel: önce yükle, sonra mediaId ile gönder
  const img = await upload(bob.token, 'POST', '/media/chat?kind=image', await photoWithGps(), 'chat.jpg');
  check(img.status === 201 && img.data.mediaId, 'sohbet görseli yüklendi');
  const imgMsg = await emit(sb, 'message:send', { conversationId: convId, clientMsgId: randomUUID(), type: 'IMAGE', mediaId: img.data.mediaId });
  check(imgMsg.ok && imgMsg.data.mediaUrl === img.data.url, 'görselli mesaj gönderildi');
  const stolen = await emit(sa, 'message:send', { conversationId: convId, clientMsgId: randomUUID(), type: 'IMAGE', mediaId: img.data.mediaId });
  check(!stolen.ok && stolen.error.code === 'INVALID_MEDIA', 'başkasının yüklediği dosya kullanılamıyor');
  const voiceAsImage = await upload(bob.token, 'POST', '/media/chat?kind=voice', await photoWithGps(), 'v.m4a');
  check(voiceAsImage.status === 415, 'ses yerine görsel gönderilince reddedildi');

  const readEvt = once(sb, 'conversation:read');
  await emit(sa, 'message:read', { conversationId: convId, seq: 3 });
  check((await readEvt).seq === 3, 'okundu bilgisi karşı tarafa gitti');

  // ── Anonim sohbet: kimlik gizli
  const anon = await call(bob.token, 'POST', '/conversations/anonymous', {
    userId: alice.id, contextQuote: 'Can’t sleep, anyone up?',
  });
  check(anon.data.peer.id === null && anon.data.peer.avatarUrl === null, 'anonim sohbette karşı tarafın id/foto gizli');
  const anonId = anon.data.id;
  await call(bob.token, 'POST', `/conversations/${anonId}/messages`, { clientMsgId: randomUUID(), body: 'hey' });
  await call(alice.token, 'POST', `/conversations/${anonId}/approve`);

  // Karşılıklı konuşarak bağlantıyı %100'e çıkar
  for (let i = 0; i < 30; i++) {
    const who = i % 2 === 0 ? alice : bob;
    await call(who.token, 'POST', `/conversations/${anonId}/messages`, { clientMsgId: randomUUID(), body: `m${i}` });
  }
  const msgs = await call(alice.token, 'GET', `/conversations/${anonId}/messages`);
  check(msgs.data.items.filter((m: any) => !m.isMine).every((m: any) => m.senderId === null), 'anonim mesajlarda gönderen id gizli');

  const anonView = await call(alice.token, 'GET', `/conversations/${anonId}`);
  check(anonView.data.connection.progress === 100, 'bağlantı %100 oldu');
  const preview = anonView.data.peer.avatarUrl as string;
  check(preview?.includes('/previews/') && preview !== bob.avatarUrl, '%70 sonrası sadece bulanık önizleme görünüyor');
  const previewMeta = await sharp(Buffer.from(await (await fetch(preview)).arrayBuffer())).metadata();
  check(previewMeta.width === 96, 'önizleme 96px (orijinal fotoğraf değil)');
  check(/^B\*+$/.test(anonView.data.peer.displayName), `isim maskeli: ${anonView.data.peer.displayName}`);

  const r1 = await call(alice.token, 'POST', `/conversations/${anonId}/reveal`);
  check(!r1.data.connection.revealed && r1.data.connection.myConsent, 'tek taraf onayı: henüz açılmadı');
  const r2 = await call(bob.token, 'POST', `/conversations/${anonId}/reveal`);
  check(r2.data.connection.revealed && r2.data.peer.id === alice.id, 'iki taraf onaylayınca profiller açıldı');

  // ── Token: çerçeve satın alma
  const buy = await call(alice.token, 'POST', '/store/borders/sapphire/purchase');
  check(buy.data.balance === 30 && buy.data.charged === 70, 'sapphire (70) alındı, bakiye 30');
  const buy2 = await call(alice.token, 'POST', '/store/borders/crimson/purchase');
  check(buy2.status === 402 && buy2.data.error.code === 'INSUFFICIENT_TOKENS', 'yetersiz bakiyede 402 dönüyor');
  const notOwned = await call(alice.token, 'PATCH', '/users/me', { borderId: 'phoenix' });
  check(notOwned.data.error?.code === 'BORDER_NOT_OWNED', 'sahip olunmayan çerçeve takılamıyor');

  // ── RevenueCat webhook (aynı olay iki kez → bir kez yazılır)
  const tokensEvt = once(sa, 'tokens:updated');
  const event = {
    event: {
      id: randomUUID(), type: 'NON_RENEWING_PURCHASE', app_user_id: alice.id,
      product_id: 'veylo.tokens.400', transaction_id: `tx_${run}`, environment: 'SANDBOX',
    },
  };
  for (let i = 0; i < 2; i++) {
    await fetch(`${API}/webhooks/revenuecat`, {
      method: 'POST',
      headers: { authorization: `Bearer ${process.env.REVENUECAT_WEBHOOK_AUTH}`, 'content-type': 'application/json' },
      body: JSON.stringify(event),
    });
  }
  check((await tokensEvt).balance === 430, 'satın alma anında socket ile bildirildi');
  const bal = await call(alice.token, 'GET', '/tokens/balance');
  check(bal.data.balance === 430, 'webhook iki kez geldi ama 400 token bir kez eklendi');

  // ── Vibes
  const carol = await newUser('carol');
  const vibe = await call(bob.token, 'POST', '/vibes', { body: 'gece 3 kulübü 🌙', anonymous: true });
  check(vibe.status === 201 && vibe.data.isMine, 'bob anonim vibe paylaştı');
  const feed = await call(carol.token, 'GET', '/vibes');
  const seen = feed.data.items.find((v: any) => v.id === vibe.data.id);
  check(seen && seen.author.id === null && /^B\*+$/.test(seen.author.displayName), 'anonim vibe akışta maskeli, yazar id gizli');
  await call(carol.token, 'POST', `/vibes/${vibe.data.id}/like`);
  const liked = await call(carol.token, 'POST', `/vibes/${vibe.data.id}/like`);
  check(liked.data.likeCount === 1 && liked.data.likedByMe, 'iki kez beğenince sayaç 1 arttı');
  const unliked = await call(carol.token, 'DELETE', `/vibes/${vibe.data.id}/like`);
  check(unliked.data.likeCount === 0 && !unliked.data.likedByMe, 'beğeni geri alındı');
  const own = await call(bob.token, 'POST', `/vibes/${vibe.data.id}/reply`, { body: 'x', clientMsgId: randomUUID() });
  check(own.data.error?.code === 'CANNOT_REPLY_OWN_VIBE', 'kendi vibe’ına cevap verilemiyor');
  const vr = await call(carol.token, 'POST', `/vibes/${vibe.data.id}/reply`, { body: 'Ben de uyuyamıyorum', clientMsgId: randomUUID() });
  check(vr.status === 201 && vr.data.type === 'ANONYMOUS' && vr.data.status === 'PENDING', 'vibe cevabı anonim mesaj isteği açtı');
  check(vr.data.contextQuote === 'gece 3 kulübü 🌙', 'sohbette vibe metni alıntı olarak duruyor');
  const bobReqs = await call(bob.token, 'GET', '/conversations?box=requests');
  check(bobReqs.data.items.some((c: any) => c.id === vr.data.id), 'bob vibe cevabını istekler kutusunda görüyor');
  await call(bob.token, 'DELETE', `/vibes/${vibe.data.id}`);
  const feed2 = await call(carol.token, 'GET', '/vibes');
  check(!feed2.data.items.some((v: any) => v.id === vibe.data.id), 'silinen vibe akıştan kalktı');

  // ── Gruplar
  const g = await call(alice.token, 'POST', '/groups', { title: `Gece Kuşları ${run}`, anonymous: true });
  check(g.status === 201 && g.data.type === 'GROUP' && g.data.group.myRole === 'OWNER', 'alice anonim olarak grup kurdu (sahip)');
  const gid = g.data.id;
  const list = await call(carol.token, 'GET', `/groups?q=${run}`);
  check(list.data.items.some((x: any) => x.id === gid && !x.isMember), 'carol grubu keşfette görüyor');
  const joined = await call(carol.token, 'POST', `/groups/${gid}/join`, { anonymous: false });
  check(joined.data.memberCount === 2, 'carol açık gruba katıldı');
  await call(carol.token, 'POST', `/conversations/${gid}/messages`, { clientMsgId: randomUUID(), body: 'Selam grup!' });
  await call(alice.token, 'POST', `/conversations/${gid}/messages`, { clientMsgId: randomUUID(), body: 'Hoş geldin' });
  const carolView = await call(carol.token, 'GET', `/conversations/${gid}/messages`);
  const fromAlice = carolView.data.items.find((m: any) => !m.isMine);
  check(fromAlice.senderId === null && /^A\*+$/.test(fromAlice.sender.displayName), 'anonim üyenin mesajında ad maskeli, id gizli');
  const aliceView = await call(alice.token, 'GET', `/conversations/${gid}/messages`);
  check(aliceView.data.items.find((m: any) => !m.isMine).sender.id === carol.id, 'anonim olmayan üye kimliğiyle görünüyor');

  await call(alice.token, 'PATCH', `/groups/${gid}`, { isPrivate: true });
  const blockedJoin = await call(bob.token, 'POST', `/groups/${gid}/join`, {});
  check(blockedJoin.data.error?.code === 'GROUP_PRIVATE', 'gizli gruba direkt katılınamıyor');
  const req = await call(bob.token, 'POST', `/groups/${gid}/requests`, { message: 'Ben de geleyim mi?' });
  check(req.status === 201 && req.data.status === 'PENDING', 'bob katılma isteği gönderdi');
  const notAdmin = await call(carol.token, 'GET', `/groups/${gid}/requests`);
  check(notAdmin.data.error?.code === 'NOT_GROUP_ADMIN', 'yönetici olmayan istekleri göremiyor');
  const pending = await call(alice.token, 'GET', `/groups/${gid}/requests`);
  check(pending.data.items.length === 1 && pending.data.items[0].message === 'Ben de geleyim mi?', 'alice isteği görüyor');
  const decided = await call(alice.token, 'POST', `/groups/${gid}/requests/${pending.data.items[0].id}`, { approve: true });
  check(decided.data.items.length === 0, 'istek onaylandı');
  const ginfo = await call(alice.token, 'GET', `/groups/${gid}`);
  check(ginfo.data.memberCount === 3 && ginfo.data.members[0].isYou, 'bob gruba girdi, 3 üye');
  const carolMember = ginfo.data.members.find((m: any) => m.id === carol.id);
  const kickDenied = await call(carol.token, 'DELETE', `/groups/${gid}/members/${ginfo.data.members[0].memberId}`);
  check(kickDenied.data.error?.code === 'NOT_GROUP_ADMIN', 'üye kimseyi çıkaramıyor');
  const kicked = await call(alice.token, 'DELETE', `/groups/${gid}/members/${carolMember.memberId}`);
  check(kicked.data.memberCount === 2, 'yönetici carol’ı çıkardı');
  const carolGone = await call(carol.token, 'GET', `/conversations/${gid}`);
  check(carolGone.status === 404, 'çıkarılan üye grubu artık göremiyor');
  await call(alice.token, 'DELETE', `/groups/${gid}/members/me`);
  const bobInfo = await call(bob.token, 'GET', `/groups/${gid}`);
  check(bobInfo.data.myRole === 'OWNER', 'sahip ayrılınca kalan üye sahip oldu');
  await call(bob.token, 'DELETE', `/groups/${gid}/members/me`);
  check((await call(bob.token, 'GET', `/groups/${gid}`)).status === 404, 'son üye ayrılınca grup silindi');

  // ── Takip ve notlar
  const fol = await call(carol.token, 'POST', `/users/${alice.id}/follow`);
  check(fol.status === 204, 'carol alice’i takip etti');
  const aliceProf = await call(carol.token, 'GET', `/users/${alice.id}`);
  check(aliceProf.data.iFollow === true && aliceProf.data.stats.followerCount >= 1, 'profilde takip durumu ve sayı güncel');
  const aliceFollowers = await call(alice.token, 'GET', `/users/${alice.id}/followers?limit=50`);
  check(aliceFollowers.data.items.some((u: any) => u.id === carol.id), 'alice takipçilerinde carol’ı görüyor');
  await call(alice.token, 'DELETE', `/users/me/followers/${carol.id}`);
  const afterRemove = await call(carol.token, 'GET', `/users/${alice.id}`);
  check(afterRemove.data.iFollow === false, 'alice carol’ı takipçilerinden çıkardı');
  await call(carol.token, 'POST', `/users/${alice.id}/follow`);
  const note = await call(alice.token, 'PUT', '/notes/me', { text: 'Can’t sleep 🌙' });
  check(note.status === 200 && note.data.text === 'Can’t sleep 🌙', 'alice not paylaştı');
  const carolNotes = await call(carol.token, 'GET', '/notes');
  check(carolNotes.data.items.some((n: any) => n.user.id === alice.id), 'takip eden carol alice’in notunu görüyor');
  const tooLong = await call(alice.token, 'PUT', '/notes/me', { text: 'x'.repeat(61) });
  check(tooLong.status === 400, '60 karakterden uzun not reddedildi');
  await call(alice.token, 'DELETE', '/notes/me');
  check((await call(alice.token, 'GET', '/notes')).data.mine === null, 'not silindi');

  // ── Gönderiler (Discover)
  const pimg = await upload(alice.token, 'POST', '/media/post', await photoWithGps(), 'post.jpg');
  check(pimg.status === 201 && pimg.data.mediaId && pimg.data.thumbId, 'gönderi görseli yüklendi (tam boy + önizleme)');
  const post = await call(alice.token, 'POST', '/posts', {
    mediaId: pimg.data.mediaId, thumbId: pimg.data.thumbId, caption: `Merhaba ${run}`,
    music: { title: 'Song', artist: 'Artist', clipStartSec: 10, clipEndSec: 40 },
  });
  check(post.status === 201 && post.data.status === 'PUBLISHED', 'gönderi paylaşıldı');
  const stolenPost = await call(carol.token, 'POST', '/posts', { mediaId: pimg.data.mediaId, thumbId: pimg.data.thumbId });
  check(stolenPost.data.error?.code === 'INVALID_MEDIA', 'başkasının görseliyle gönderi oluşturulamıyor');
  const pf = await call(carol.token, 'GET', `/posts/feed?q=${run}`);
  check(pf.data.items.some((x: any) => x.id === post.data.id), 'gönderi akışta (arama ile) görünüyor');
  await call(carol.token, 'POST', `/posts/${post.data.id}/like`);
  const liked2 = await call(carol.token, 'POST', `/posts/${post.data.id}/like`);
  check(liked2.data.likeCount === 1 && liked2.data.likedByMe, 'iki kez beğeni = 1');
  const sv = await call(carol.token, 'POST', `/posts/${post.data.id}/save`);
  check(sv.data.savedByMe, 'gönderi kaydedildi');
  const savedList = await call(carol.token, 'GET', '/posts/saved');
  check(savedList.data.items.some((x: any) => x.id === post.data.id), 'kaydedilenlerde görünüyor');
  await call(carol.token, 'POST', `/posts/${post.data.id}/view`);
  await call(carol.token, 'POST', `/posts/${post.data.id}/view`);
  const cm = await call(carol.token, 'POST', `/posts/${post.data.id}/comments`, { body: 'Çok güzel 🔥' });
  check(cm.status === 201, 'yorum yapıldı');
  const st = await call(alice.token, 'GET', `/posts/${post.data.id}/stats`);
  check(st.data.viewCount === 1 && st.data.likeCount === 1 && st.data.commentCount === 1, 'istatistik: 1 görüntülenme, 1 beğeni, 1 yorum');
  const stOther = await call(carol.token, 'GET', `/posts/${post.data.id}/stats`);
  check(stOther.status === 404, 'başkası istatistikleri göremiyor');
  const prof2 = await call(carol.token, 'GET', `/users/${alice.id}`);
  check(prof2.data.stats.likeCount === 1, 'profildeki Like sayısı gönderi beğenilerinden');
  const balBefore = (await call(alice.token, 'GET', '/users/me')).data.tokenBalance;
  const boosted = await call(alice.token, 'POST', `/posts/${post.data.id}/boost`);
  check(boosted.data.balance === balBefore - 100 && boosted.data.boostedUntil, 'boost: 100 token düştü');
  const pf2 = await call(carol.token, 'GET', '/posts/feed');
  check(pf2.data.items[0]?.id === post.data.id && pf2.data.items[0].boosted, 'boost edilen gönderi akışta en üstte');
  await call(alice.token, 'DELETE', `/posts/comments/${cm.data.id}`);
  const afterDel = await call(alice.token, 'GET', `/posts/${post.data.id}`);
  check(afterDel.data.commentCount === 0, 'gönderi sahibi yorumu sildi');
  const draft = await call(alice.token, 'POST', '/posts', { mediaId: pimg.data.mediaId, thumbId: pimg.data.thumbId, draft: true });
  check((await call(carol.token, 'GET', `/posts/${draft.data.id}`)).status === 404, 'taslak başkasına görünmüyor');
  const pub = await call(alice.token, 'PATCH', `/posts/${draft.data.id}`, { publish: true });
  check(pub.data.status === 'PUBLISHED', 'taslak yayınlandı');
  await call(alice.token, 'DELETE', `/posts/${draft.data.id}`);
  const mine2 = await call(carol.token, 'GET', `/posts/user/${alice.id}`);
  check(mine2.data.items.length === 1, 'silinen gönderi profilde görünmüyor');

  // ── AI Match
  const ms = await call(carol.token, 'POST', '/match/search', { mood: 'bored', intent: 'friends' });
  check(ms.status === 200 && Array.isArray(ms.data.items), 'AI Match sonuç döndü');
  check(ms.data.items.every((x: any) => x.userId !== carol.id && x.vibePercent >= 60 && x.vibePercent <= 98), 'kendisi yok, vibe %60-98');

  // ── Engelleme
  await call(alice.token, 'POST', `/conversations/${anonId}/block`);
  const afterBlock = await emit(sb, 'message:send', { conversationId: convId, clientMsgId: randomUUID(), body: 'hey?' });
  check(!afterBlock.ok && afterBlock.error.code === 'BLOCKED', 'engellenen kişi mesaj gönderemiyor');
  const prof = await call(bob.token, 'GET', `/users/${alice.id}`);
  check(prof.status === 404, 'engellenen kişi profili göremiyor');
  const blocks = await call(alice.token, 'GET', '/safety/blocks');
  check(blocks.data.items[0].anonymous === false, 'açılmış sohbetten engelleme listede kimlikle görünüyor');

  sa.close();
  sb.close();
  console.log(`\nHepsi geçti: ${passed} kontrol ✅`);
}

main().catch((err) => {
  console.error(err.message ?? err);
  process.exit(1);
});
