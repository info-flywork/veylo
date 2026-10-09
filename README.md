# Veylo Backend

Node.js (TypeScript) + Express 5 + Socket.IO + Prisma (MySQL / MariaDB).
Firebase sadece giriş (Google / Apple) ve push bildirimi (FCM) için kullanılır.

## Klasör yapısı

```
prisma/schema.prisma      Veritabanı şeması (tek doğru kaynak)
src/
  server.ts               HTTP + Socket.IO sunucusunu başlatır
  app.ts                  Express ayarları (helmet, cors, rate limit, route'lar)
  config/                 env.ts (ortam değişkenleri), constants.ts (fiyatlar, kurallar)
  routes/                 URL → middleware → controller eşlemesi
  controllers/            HTTP isteğini alır, servisi çağırır, cevabı döner
  services/               İş mantığı (veritabanı, kurallar, token)
  validators/             zod şemaları (gelen veri doğrulama)
  serializers/            Veritabanı kaydı → API cevabı (anonimlik burada uygulanır)
  middlewares/            auth, validate, error
  realtime/               Socket.IO, çevrimiçi listesi (bellekte), olay işleyicileri
  lib/                    prisma, firebase, logger
scripts/smoke-test.ts     Uçtan uca test
```

## Yerelde çalıştırma

```bash
npm install
cp .env.example .env          # DATABASE_URL'i düzenle
npx prisma migrate dev        # tabloları oluşturur
npm run dev                   # http://localhost:4000/api/v1
npx tsx scripts/smoke-test.ts # (başka terminalde) uçtan uca test
```

Firebase kurulmadan önce `AUTH_DEV_BYPASS=true` ile `Authorization: Bearer dev:alice` gibi sahte
kullanıcılarla test edilebilir. Production'da bu ayar açıksa sunucu başlamaz.

## Sunucuya kurulum (pm2 + Nginx)

1. **Veritabanı (Güzel.net / phpMyAdmin)**
   - Veritabanını oluştur, sonra SQL sekmesinde:
     `ALTER DATABASE <db_adı> CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;`
   - cPanel > Remote MySQL'e Node sunucusunun IP'sini ekle.
   - Tabloları elle kurmak istersen: phpMyAdmin > İçe aktar > `database/veylo_schema.sql`.
     Sonra sunucuda her migration'ı "uygulandı" olarak işaretle, yoksa `migrate deploy` tabloları tekrar kurmaya çalışır:
     `npx prisma migrate resolve --applied 20261008111106_init` (ve `20261008113110_media`).
     Bu dosya şemadan üretilir: `npx prisma migrate diff --from-empty --to-schema-datamodel prisma/schema.prisma --script > database/veylo_schema.sql`
2. **Sunucuda**
   ```bash
   npm ci
   npm run build
   npx prisma migrate deploy      # sadece hazır migration'ları uygular, shadow DB gerekmez
   pm2 start ecosystem.config.js --env production
   pm2 save
   ```
   Güncelleme: `git pull && npm ci && npm run build && npx prisma migrate deploy && pm2 restart veylo-api`
3. **Nginx** (WebSocket için `Upgrade` başlıkları şart):
   ```nginx
   location / {
       proxy_pass http://127.0.0.1:4000;
       proxy_http_version 1.1;
       proxy_set_header Upgrade $http_upgrade;
       proxy_set_header Connection "upgrade";
       proxy_set_header Host $host;
       proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
       proxy_set_header X-Forwarded-Proto $scheme;
       proxy_read_timeout 120s;
   }
   ```

**pm2'de `instances: 1` kalmalı** (çevrimiçi listesi bellekte).

**Node sunucusu veritabanıyla aynı veri merkezinde olmalı.** Her sorgu ağ üzerinden gidip geldiği için
uzak bir veritabanında (ör. İstanbul → Fransa ~65 ms) bir mesaj gönderimi ~1 sn sürer; aynı veri
merkezinde birkaç ms'dir.

Test girişiyle (`dev:`) oluşan kullanıcıları ve Bunny dosyalarını temizlemek için:
`npx tsx scripts/cleanup-dev-users.ts --yes`

## Medya (Bunny Storage + CDN)

Bunny Storage imzalı yükleme URL'si desteklemediği ve AccessKey tüm depolamaya yetki verdiği için
dosyalar **uygulama → Node → Bunny** yolunu izler. Node'da:

- Tür, uzantıya değil dosyanın içeriğine bakılarak doğrulanır (görsel: sharp, ses: ilk byte'lar).
- Görseller döndürülür, **GPS dahil tüm EXIF silinir**, küçültülür (profil 1080px, sohbet 1600px), WebP'ye çevrilir.
- Profil fotoğrafı için ayrıca 96px, ağır bulanık bir önizleme üretilir. Bu önizleme anonim sohbette
  %70'te gösterilir. Yolu rastgeledir, orijinal fotoğrafa ulaşmak mümkün değildir.
- Yollarda kullanıcı id'si geçmez: `avatars/2026/10/<uuid>.webp`.
- Fotoğraf değişince veya silinince eski dosyalar Bunny'den de silinir.
- Mesajlarda URL değil `mediaId` gönderilir; sunucu dosyanın gönderene ait olduğunu kontrol eder.

**Bunny kurulumu:**
1. Storage > Add Storage Zone (ör. `veylo-media`, ana bölge Falkenstein).
2. Zone'a bir Pull Zone bağla (ör. `veylo.b-cdn.net`; istersen `cdn.veylo.app` gibi özel alan adı).
3. `.env`: `BUNNY_STORAGE_ZONE`, `BUNNY_STORAGE_PASSWORD` (FTP & API Access > Password),
   `BUNNY_STORAGE_REGION` (Falkenstein ise boş), `BUNNY_CDN_URL`.

Bunny ayarlı değilse (sadece geliştirmede) dosyalar `./uploads` klasörüne yazılır ve
`/uploads/...` altından servis edilir. Production'da Bunny ayarlı değilse sunucu başlamaz.

## Giriş akışı

1. Uygulama Firebase ile Google/Apple girişi yapar, `idToken` alır.
2. `POST /api/v1/auth/session` (Bearer idToken) → kullanıcı yoksa oluşturulur, +100 token.
3. `onboardingCompleted=false` ise profil oluşturma adımları → `POST /api/v1/users/me/onboarding`.
4. Socket bağlantısı: `io(URL, { auth: { token: idToken } })`.
5. RevenueCat: girişten sonra `Purchases.logIn(user.id)` (bizim `id`, Firebase uid değil).

Hata cevapları her zaman `{ "error": { "code": "...", "message": "..." } }` şeklindedir.
`402 INSUFFICIENT_TOKENS` gelirse uygulama token mağazasını açmalı.

## REST API (`/api/v1`)

| Metot | Yol | Açıklama |
|---|---|---|
| GET | `/health` | Sağlık kontrolü |
| POST | `/auth/session` | Giriş / kayıt |
| GET / PATCH | `/users/me` | Profilim / profil düzenleme |
| POST | `/users/me/onboarding` | Profil oluşturma (ad, kullanıcı adı, cinsiyet, ilgi alanları, hedef) |
| GET | `/users/username-available?username=` | Müsaitlik + öneriler |
| POST / DELETE | `/users/me/devices` | FCM token kaydet / sil |
| POST | `/users/me/deletion-request` | Hesap silme talebi |
| GET | `/users/:id` | Başkasının profili |
| POST / DELETE | `/users/:id/follow` | Takip et / bırak |
| GET | `/users/:id/followers`, `/users/:id/following` | Listeler (cursor) |
| GET | `/conversations?box=inbox\|requests` | Sohbetler / mesaj istekleri |
| DELETE | `/conversations` | Tüm sohbetleri benim için sil |
| POST | `/conversations/direct` | `{userId}` birebir sohbet (takip etmiyorsa istek olur) |
| POST | `/conversations/anonymous` | `{userId, contextQuote?}` anonim sohbet |
| GET / DELETE | `/conversations/:id` | Detay / benim için sil |
| PATCH | `/conversations/:id/settings` | `{pinned?, muted?}` |
| GET | `/conversations/:id/messages?beforeSeq=&afterSeq=&limit=` | Mesajlar |
| POST | `/conversations/:id/messages` | `{clientMsgId, type, body?, mediaUrl?}` |
| POST | `/conversations/:id/read` | `{seq}` okundu |
| POST | `/conversations/:id/approve`, `/reject` | Mesaj isteği |
| POST | `/conversations/:id/reveal` | Profil açma onayı (%100'de) |
| POST | `/conversations/:id/block`, `/report` | Sohbetten engelle / raporla |
| GET / POST | `/safety/blocks` | Engellenenler / `{userId, type: BLOCK\|RESTRICT}` |
| DELETE | `/safety/blocks/:userId` | Engeli kaldır |
| POST | `/safety/reports` | `{targetUserId, context, reason, details?, alsoBlock?}` |
| PUT / DELETE | `/media/avatar` | Profil fotoğrafı (multipart `file`; onboarding sırasında da çalışır) |
| PUT / DELETE | `/media/voice-intro` | Profil ses kaydı (m4a/aac/mp3/ogg/wav, en fazla 5 MB) |
| POST | `/media/chat?kind=image\|voice` | Sohbet medyası yükle → `{mediaId, url}` |
| GET | `/tokens/balance`, `/tokens/history`, `/tokens/products` | Token |
| GET | `/store/borders` | Çerçeve kataloğu + sahiplik |
| POST | `/store/borders/:borderId/purchase` | Token ile çerçeve al |
| POST | `/webhooks/revenuecat` | RevenueCat (Authorization: REVENUECAT_WEBHOOK_AUTH) |

## Socket.IO olayları

İstemci → sunucu (hepsi ack ile `{ok, data}` veya `{ok:false, error}` döner):

| Olay | Veri |
|---|---|
| `message:send` | `{conversationId, clientMsgId, type?, body?, mediaUrl?}` |
| `message:read` | `{conversationId, seq}` |
| `conversation:sync` | `{conversationId, afterSeq}` (yeniden bağlanınca) |
| `typing` | `{conversationId}` |

Sunucu → istemci:

| Olay | Veri |
|---|---|
| `message:new` | `{message, conversation}` |
| `conversation:updated` | sohbet (onay, reddetme, bağlantı yüzdesi, açılma) |
| `conversation:read` | `{conversationId, seq}` karşı taraf okudu |
| `typing` | `{conversationId}` |
| `presence:update` | `{conversationId, isOnline}` |
| `tokens:updated` | `{balance, delta, reason}` |

**Mesaj güvenilirliği:** her mesaja istemci bir `clientMsgId` (UUID) verir. Ack gelmezse aynı id ile
tekrar gönderilir; sunucu ikinci kez yazmaz. Bağlantı kopup gelince her açık sohbet için
`conversation:sync { afterSeq: <elimdeki son seq> }` çağrılır.

**Anonimlik:** anonim sohbet açılana kadar karşı tarafın `id`, kullanıcı adı ve fotoğrafı hiçbir cevapta
dönmez; mesajlarda `senderId` null'dır; çevrimiçi bilgisi sohbet id'si ile gelir.

## Sıradaki adımlar

- Aramalar: 60 sn yabancı eşleştirme kuyruğu, Agora token, karşılıklı "devam", video (token ile)
- Odalar: sahne/koltuk, el kaldırma, katılma istekleri
- Sohbet medyası için Bunny Token Authentication (süreli imzalı URL) ve kullanılmayan yüklemeleri temizleme işi
- Vibes, keşfet, hikayeler; admin paneli (raporlar, silme talepleri)
