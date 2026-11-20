"""Veylo yasal metinleri (TR + EN). Uygulamanın ve veylobackend'in gerçekte
işlediği verilere göre yazılmıştır: e-posta / Google / Apple ile hesap; profil
(fotoğraf, bio, tercihler); anonim sohbet ve bağlantı ilerlemesi; mesajlar ve
medya (Bunny CDN); sesli / görüntülü arama (Agora); push (FCM); uygulama içi
satın alma (RevenueCat / mağazalar); engelleme, şikâyet ve hesap silme."""

EMAIL = '<a href="mailto:support@fly-work.com">support@fly-work.com</a>'

# ───────────────────────────── GİZLİLİK ─────────────────────────────

PRIVACY_TR = f"""
<div class="note"><strong>Veylo</strong>, insanlarla tanışabileceğin, anonim sohbet edebileceğin, bağlantını
zamanla güçlendirebileceğin ve karşılıklı onayla sesli veya görüntülü aramaya geçebileceğin bir sosyal
uygulamadır. Verilerini <strong>satmayız</strong>. Bu politika hangi verileri neden işlediğimizi ve haklarını
açıklar (6698 sayılı KVKK ve AB Genel Veri Koruma Tüzüğü – GDPR).</div>

<h2>1. Veri sorumlusu</h2>
<p>Veylo uygulaması ("Uygulama") Fly Work tarafından geliştirilir ve işletilir. Kişisel verilerinle ilgili tüm
talepler için: {EMAIL}</p>

<h2>2. Topladığımız veriler</h2>
<h3>2.1 Hesap ve kimlik doğrulama</h3>
<ul>
<li>E-posta ve şifre ile kayıt, veya Google / Apple ile giriş (Firebase Authentication).</li>
<li>Kimlik doğrulama sağlayıcısından gelen kullanıcı kimliği (Firebase UID) ve isteğe bağlı e-posta.</li>
<li>Doğrulama amaçlı ad-soyad (herkese açık profilde gösterilmez).</li>
</ul>
<h3>2.2 Profil</h3>
<ul>
<li>Kullanıcı adı, görünen ad, bio, cinsiyet, ilgi alanları, sohbet / ilişki hedefleri, boy, diller, burç,
eğitim, evcil hayvan, alkol / sigara tercihleri.</li>
<li>Profil fotoğrafları ve (anonim sohbet için) sunucuda bulanıklaştırılmış küçük sürüm.</li>
<li>İsteğe bağlı sesli tanıtım kaydı.</li>
<li>Profil görünürlüğü, kenarlık / kozmetik öğeler ve profil öne çıkarma (boost) durumu.</li>
</ul>
<h3>2.3 Sosyal etkileşim</h3>
<ul>
<li>Sohbetler (doğrudan, anonim, grup): metin, görsel ve sesli mesajlar; tepkiler; bağlantı / yakınlık
ilerlemesi ve profil açma onayı.</li>
<li>Takip ilişkileri, durum notları, Vibes (24 saatlik kısa paylaşımlar), gönderiler ve yorumlar.</li>
<li>Engelleme / kısıtlama ve şikâyet kayıtları (neden, bağlam, içerik kimliği).</li>
</ul>
<h3>2.4 Arama ve gerçek zamanlı iletişim</h3>
<ul>
<li>Sesli veya görüntülü arama oturum meta verileri (kimler, süre, tür). Canlı ses / görüntü Agora üzerinden
aktarılır; arama içeriğini kalıcı olarak saklamayız.</li>
<li>Rastgele eşleşme ve oda özellikleri için gerekli oturum bilgileri.</li>
</ul>
<h3>2.5 Satın alma ve jeton</h3>
<ul>
<li>Uygulama içi jeton bakiyesi ve hareket kayıtları (bonus, satın alma, harcama, iade).</li>
<li>Satın alımları doğrulamak için mağaza / RevenueCat fiş verileri. Kart numaranı biz tutmayız; ödemeyi
Apple App Store veya Google Play işler.</li>
</ul>
<h3>2.6 Cihaz ve teknik veriler</h3>
<ul>
<li>Push bildirim jetonu, platform (iOS / Android) ve bildirim dili tercihi.</li>
<li>Uygulama sürümü, dil tercihi; güvenlik ve kötüye kullanımı önleme amaçlı sunucu istek kayıtları
(IP adresi dahil).</li>
<li>Son görülme zamanı (çevrimiçi durumu).</li>
</ul>
<p>Sağlık verisi veya tarama geçmişi <strong>toplamayız</strong>. Konum yalnızca cihazda, sen açıkça izin
verdiğinde ve ilgili özelliğin çalışması için kullanılır; kalıcı konum geçmişi oluşturmayız.</p>

<h2>3. Verileri neden ve hangi hukuki sebeple işliyoruz</h2>
<div class="table"><table>
<tr><th>Amaç</th><th>Hukuki sebep</th></tr>
<tr><td>Hesap oluşturma, giriş, profil ve sohbet hizmetini sunmak</td><td>Sözleşmenin kurulması ve ifası</td></tr>
<tr><td>Anonim sohbet, bağlantı ilerlemesi ve karşılıklı profil açma</td><td>Sözleşmenin ifası</td></tr>
<tr><td>Sesli / görüntülü arama ve eşleşme özelliklerini çalıştırmak</td><td>Sözleşmenin ifası</td></tr>
<tr><td>Jeton bakiyesi, satın alma doğrulama ve ücretli özellikler</td><td>Sözleşmenin ifası</td></tr>
<tr><td>Push bildirimleri (mesaj, eşleşme vb.)</td><td>Sözleşmenin ifası / meşru menfaat</td></tr>
<tr><td>Güvenlik, dolandırıcılık, taciz ve çocuk güvenliği; engelleme / şikâyet</td><td>Meşru menfaat / kanuni yükümlülük</td></tr>
<tr><td>Hesap silme taleplerini işlemek</td><td>Sözleşmenin ifası / kanuni yükümlülük</td></tr>
<tr><td>Yasal yükümlülükler (ör. ticari kayıtlar)</td><td>Kanuni yükümlülük</td></tr>
</table></div>
<p>Verilerini reklam ağlarına satmayız ve uygulamalar arası takip için kullanmayız.</p>

<h2>4. Verilerin aktarıldığı taraflar</h2>
<p>Verilerini <strong>satmayız</strong>. Yalnızca hizmeti sunmak için gereken asgari veriyi, bizim adımıza
çalışan sağlayıcılarla paylaşırız:</p>
<div class="table"><table>
<tr><th>Hizmet sağlayıcı</th><th>Veri</th><th>Konum</th></tr>
<tr><td>Barındırma (API, veritabanı)</td><td>Hesap, profil, sohbet ve işlem kayıtları</td><td>Avrupa Birliği / hizmet bölgesi</td></tr>
<tr><td>Firebase (Google) – Auth &amp; FCM</td><td>Kimlik doğrulama, push jetonları</td><td>Global</td></tr>
<tr><td>Bunny Storage / CDN</td><td>Profil, sohbet ve gönderi medyası</td><td>Global CDN</td></tr>
<tr><td>Agora</td><td>Canlı ses / görüntü oturumu (geçici aktarım)</td><td>Global</td></tr>
<tr><td>RevenueCat + Apple / Google</td><td>Satın alma doğrulama ve abonelik / ürün durumu</td><td>Global</td></tr>
</table></div>
<p>Ayrıca yasal zorunluluk, yetkili makam talebi veya kullanıcıları zarardan korumak için veri
açıklayabiliriz. Diğer kullanıcılara, senin paylaştığın profil ve sohbet içeriği görünür (anonim
modda sınırlı).</p>

<h2>5. Yurt dışına aktarım</h2>
<p>Firebase, CDN, Agora ve mağaza hizmetleri Türkiye ve Avrupa Ekonomik Alanı dışında bulunabilir. Bu
aktarımları KVKK ve GDPR'ın öngördüğü güvencelerle (standart sözleşme hükümleri ve ilgili bildirimler)
yaparız.</p>

<h2>6. Saklama süreleri</h2>
<div class="table"><table>
<tr><th>Veri</th><th>Süre</th></tr>
<tr><td>Hesap ve profil</td><td>Hesap aktifken; silme talebi tamamlanınca silinir / anonimleştirilir</td></tr>
<tr><td>Sohbetler ve medya</td><td>Hesap veya ilgili içerik silinene kadar (grup / yasal saklama istisnaları hariç)</td></tr>
<tr><td>Vibes / durum notları</td><td>Yayın süresi bitince (ör. 24 saat) veya silindiğinde</td></tr>
<tr><td>Arama meta verileri</td><td>Hizmet ve güvenlik için makul süre; canlı medya kalıcı saklanmaz</td></tr>
<tr><td>Jeton hareketleri / satın alma kayıtları</td><td>Hesap aktifken ve yasal saklama zorunluluğu süresince</td></tr>
<tr><td>Şikâyet ve güvenlik kayıtları</td><td>İnceleme ve yasal yükümlülük için gerekli süre</td></tr>
<tr><td>Hesap silme talebi</td><td>Talep sonrası bekleme süresi dolunca kalıcı silme; süre içinde giriş yapılırsa iptal edilebilir</td></tr>
<tr><td>Sunucu istek kayıtları</td><td>Kısa süre (ör. 30 gün)</td></tr>
</table></div>

<h2>7. Hakların</h2>
<p>KVKK m.11 ve GDPR kapsamında; verilerinin işlenip işlenmediğini öğrenme, bilgi ve kopya talep etme,
düzeltme, silme, işlemeyi kısıtlama ve itiraz etme ve verilerin taşınması hakların vardır.</p>
<ul>
<li><strong>Verilerini / hesabını silme:</strong> Uygulama içi <em>Hesap Yönetimi → Hesabı ve Verileri Sil</em>
veya {EMAIL} (konu: "Veylo veri silme"). Talebin işlendikten ve bekleme süresi dolduktan sonra kişisel
verilerin silinir veya anonimleştirilir; yasal saklama zorunluluğu olan kayıtlar hariç.</li>
<li><strong>Diğer talepler</strong> (bilgi, kopya, itiraz): {EMAIL}. En geç 30 gün içinde yanıtlarız.</li>
<li>Kişisel Verileri Koruma Kurulu'na veya bulunduğun ülkedeki veri koruma otoritesine şikâyette bulunma
hakkın saklıdır.</li>
</ul>

<h2>8. Çocuklar</h2>
<p>Veylo 17 yaşından küçük kullanıcılara yönelik değildir. 17 yaşından küçük çocuklardan bilerek hesap
açtırmayız veya kişisel veri toplamayız. Yaş ihlali tespit edersek hesabı kapatır ve ilgili verileri
sileriz. Ayrıca <a href="../csae/">Çocuk Güvenliği Standartları (CSAE)</a> sayfamıza bak.</p>

<h2>9. Güvenlik</h2>
<p>Veriler aktarım sırasında TLS ile şifrelenir; sunucu erişimi yetkiyle sınırlıdır; hesap silme, engelleme
ve şikâyet araçları sunulur. Hiçbir sistem yüzde yüz güvenli olmasa da makul teknik ve idari önlemleri
alırız. Güçlü bir parola kullan ve cihazını güncel tut.</p>

<h2>10. Değişiklikler</h2>
<p>Bu politikayı güncelleyebiliriz. Önemli değişikliklerde uygulama içinde bilgilendiririz. Güncel sürüm
her zaman bu sayfadadır.</p>

<h2>11. İletişim</h2>
<p>Sorular ve talepler için: {EMAIL}</p>
"""

PRIVACY_EN = f"""
<div class="note"><strong>Veylo</strong> is a social app where you can meet people, chat anonymously, build
connection over time, and optionally move to voice or video calls when both sides agree. We
<strong>do not sell</strong> your data. This policy explains what we process, why, and your rights
(Turkish Personal Data Protection Law No. 6698 – KVKK and the EU GDPR).</div>

<h2>1. Data controller</h2>
<p>The Veylo app (the "App") is developed and operated by Fly Work. For any request regarding your
personal data: {EMAIL}</p>

<h2>2. Data we collect</h2>
<h3>2.1 Account and authentication</h3>
<ul>
<li>Sign-up with email and password, or Google / Apple sign-in (Firebase Authentication).</li>
<li>Authentication user ID (Firebase UID) and optional email from the provider.</li>
<li>Full name for verification (not shown on the public profile).</li>
</ul>
<h3>2.2 Profile</h3>
<ul>
<li>Username, display name, bio, gender, interests, chat / relationship goals, height, languages,
zodiac, education, pets, drinking / smoking preferences.</li>
<li>Profile photos and a server-blurred small version used in anonymous chat.</li>
<li>Optional voice intro recording.</li>
<li>Profile visibility, cosmetic borders / items and profile boost status.</li>
</ul>
<h3>2.3 Social interaction</h3>
<ul>
<li>Conversations (direct, anonymous, group): text, image and voice messages; reactions; connection /
intimacy progress and profile-reveal consent.</li>
<li>Follows, status notes, Vibes (short posts that expire after about 24 hours), feed posts and comments.</li>
<li>Block / restrict and report records (reason, context, content id).</li>
</ul>
<h3>2.4 Calls and realtime</h3>
<ul>
<li>Voice or video call session metadata (who, duration, type). Live audio / video is carried by Agora;
we do not permanently store call media.</li>
<li>Session data needed for random match and room features.</li>
</ul>
<h3>2.5 Purchases and tokens</h3>
<ul>
<li>In-app token balance and ledger entries (bonus, purchase, spend, refund).</li>
<li>Store / RevenueCat receipt data to unlock and restore purchases. We do not store your card number;
payments are processed by the Apple App Store or Google Play.</li>
</ul>
<h3>2.6 Device and technical data</h3>
<ul>
<li>Push notification token, platform (iOS / Android) and notification language.</li>
<li>App version, language preference; server request logs (including IP) for security and abuse prevention.</li>
<li>Last-seen time (online status).</li>
</ul>
<p>We <strong>do not collect</strong> health data or browsing history. Location is used on-device only when
you grant permission and only as needed for the relevant feature; we do not build a permanent location
history.</p>

<h2>3. Why we process data and on what legal basis</h2>
<div class="table"><table>
<tr><th>Purpose</th><th>Legal basis</th></tr>
<tr><td>Creating accounts, sign-in, profiles and chat</td><td>Performance of a contract</td></tr>
<tr><td>Anonymous chat, connection progress and mutual profile reveal</td><td>Performance of a contract</td></tr>
<tr><td>Running voice / video calls and matching</td><td>Performance of a contract</td></tr>
<tr><td>Token balance, purchase verification and paid features</td><td>Performance of a contract</td></tr>
<tr><td>Push notifications (messages, matches, etc.)</td><td>Performance of a contract / legitimate interest</td></tr>
<tr><td>Safety, fraud, harassment and child safety; blocks / reports</td><td>Legitimate interest / legal obligation</td></tr>
<tr><td>Processing account deletion requests</td><td>Performance of a contract / legal obligation</td></tr>
<tr><td>Legal obligations (e.g. commercial records)</td><td>Legal obligation</td></tr>
</table></div>
<p>We do not sell your data to ad networks or use it for cross-app tracking.</p>

<h2>4. Who we share data with</h2>
<p>We <strong>do not sell</strong> your data. We share only the minimum needed with providers acting on our
behalf:</p>
<div class="table"><table>
<tr><th>Provider</th><th>Data</th><th>Location</th></tr>
<tr><td>Hosting (API, database)</td><td>Account, profile, chat and transaction records</td><td>European Union / service region</td></tr>
<tr><td>Firebase (Google) – Auth &amp; FCM</td><td>Authentication, push tokens</td><td>Global</td></tr>
<tr><td>Bunny Storage / CDN</td><td>Profile, chat and post media</td><td>Global CDN</td></tr>
<tr><td>Agora</td><td>Live audio / video session (transient)</td><td>Global</td></tr>
<tr><td>RevenueCat + Apple / Google</td><td>Purchase verification and product / subscription status</td><td>Global</td></tr>
</table></div>
<p>We may also disclose data where required by law, by a competent authority, or to protect users from
harm. Other users see the profile and chat content you choose to share (limited in anonymous mode).</p>

<h2>5. International transfers</h2>
<p>Firebase, the CDN, Agora and store services may be located outside Türkiye and the European Economic
Area. We carry out these transfers with the safeguards required by KVKK and GDPR (standard contractual
clauses and related notifications).</p>

<h2>6. Retention</h2>
<div class="table"><table>
<tr><th>Data</th><th>Period</th></tr>
<tr><td>Account and profile</td><td>While the account is active; deleted / anonymised after deletion completes</td></tr>
<tr><td>Chats and media</td><td>Until the account or content is deleted (subject to group / legal retention)</td></tr>
<tr><td>Vibes / status notes</td><td>Until expiry (e.g. 24 hours) or deletion</td></tr>
<tr><td>Call metadata</td><td>Reasonable period for service and safety; live media is not stored permanently</td></tr>
<tr><td>Token ledger / purchase records</td><td>While the account is active and as required by law</td></tr>
<tr><td>Reports and safety records</td><td>As needed for review and legal obligations</td></tr>
<tr><td>Account deletion request</td><td>Permanent purge after the waiting period; signing in again may cancel it</td></tr>
<tr><td>Server request logs</td><td>Short period (e.g. 30 days)</td></tr>
</table></div>

<h2>7. Your rights</h2>
<p>Under KVKK Art. 11 and the GDPR you have the right to know whether your data is processed, to request
information and a copy, to rectification, erasure, restriction and objection, and to data portability.</p>
<ul>
<li><strong>Deleting your data / account:</strong> in-app <em>Account Management → Delete Account and Data</em>
or {EMAIL} (subject: "Veylo data deletion"). After processing and the waiting period, personal data is
deleted or anonymised except where retention is legally required.</li>
<li><strong>Other requests</strong> (information, copy, objection): {EMAIL}. We respond within 30 days.</li>
<li>You may also lodge a complaint with the Turkish Personal Data Protection Authority or the authority in
your country.</li>
</ul>

<h2>8. Children</h2>
<p>Veylo is not directed at users under 17. We do not knowingly allow accounts or collect personal data
from children under 17. If we learn of an underage account, we close it and delete related data. See also
our <a href="../csae/">Child Safety Standards (CSAE)</a>.</p>

<h2>9. Security</h2>
<p>Data is encrypted in transit with TLS; server access is restricted; account deletion, blocking and
reporting tools are provided. No system is 100% secure, but we take reasonable technical and
organisational measures. Use a strong password and keep your device updated.</p>

<h2>10. Changes</h2>
<p>We may update this policy. We will inform you in the App about significant changes. The current version
is always on this page.</p>

<h2>11. Contact</h2>
<p>For questions and requests: {EMAIL}</p>
"""

# ───────────────────────────── KOŞULLAR ─────────────────────────────

TERMS_TR = f"""
<div class="note"><strong>Kısaca:</strong> Veylo bir sosyal uygulamadır. Hesap oluşturarak veya uygulamayı
kullanarak bu koşulları ve <a href="../privacy-policy/">Gizlilik Politikası</a>'nı kabul edersin. 17 yaşından
küçükler kullanamaz. Taciz, dolandırıcılık, yasa dışı içerik ve çocuk istismarı yasaktır.</div>

<h2>1. Kabul</h2>
<p>Veylo uygulamasını ("Uygulama") indirerek, hesap oluşturarak veya kullanarak bu Kullanım Koşulları'nı
kabul etmiş olursun. Kabul etmiyorsan Uygulamayı kullanma. Uygulama Fly Work ("biz") tarafından sunulur.</p>

<h2>2. Hizmet</h2>
<p>Veylo; tanışma, anonim ve açık sohbet, bağlantı / yakınlık ilerlemesi, Vibes ve gönderiler, gruplar,
rastgele eşleşme, sesli / görüntülü arama ve isteğe bağlı ücretli özellikler sunar. Özellikleri, jeton
fiyatlarını ve kuralları zaman içinde değiştirebilir, ekleyebilir veya kaldırabiliriz.</p>

<h2>3. Hesap ve yaş</h2>
<ul>
<li>Doğru bilgi vermeli ve giriş bilgilerini güvende tutmalısın. Hesabındaki aktivitelerden sen
sorumlusun.</li>
<li>Veylo'yu kullanmak için en az <strong>17 yaşında</strong> olmalı ve bulunduğun ülkenin yasalarına göre
bu tür bir hizmeti kullanabilecek yaşta olmalısın.</li>
<li>Tek bir gerçek kişi hesabı açabilirsin; başkasının kimliğine bürünmek yasaktır.</li>
</ul>

<h2>4. Anonim sohbet ve profil açma</h2>
<ul>
<li>Anonim sohbetlerde isim ve fotoğraf, bağlantı eşiklerine kadar gizli / maskeli kalabilir.</li>
<li>Tam profil açılışı karşılıklı onay gerektirir. Kimliğini açması için kimseyi zorlama.</li>
<li>Anonimliği güvenlik özelliklerini atlatmak veya zarar vermek için kullanma.</li>
</ul>

<h2>5. Kabul edilebilir kullanım</h2>
<p>Şunları yapmamayı kabul edersin:</p>
<ul>
<li>Taciz, tehdit, nefret söylemi, şiddet, dolandırıcılık, spam veya kimliğe bürünme.</li>
<li>Yasa dışı, müstehcen (izin verilmeyen), çocuk cinsel istismarı materyali veya zararlı içerik paylaşmak.</li>
<li>Başkalarının rızası olmadan özel içeriklerini yaymak.</li>
<li>Tersine mühendislik, otomasyon / bot, aşırı yük veya güvenlik önlemlerini atlatma.</li>
<li>Jeton veya ücretli özellikleri hileyle elde etmek.</li>
</ul>
<p>İhlalde içerik kaldırılabilir, özellikler kısıtlanabilir veya hesap askıya alınabilir / kapatılabilir.
Şikâyet ve engelleme araçlarını kullan; acil tehlikede yerel acil hattını ara.</p>

<h2>6. İçeriğin</h2>
<ul>
<li>Paylaştığın içeriğin haklarına sen sahipsin; hizmeti işletmek için bize barındırma ve gösterme lisansı
verirsin.</li>
<li>Paylaşmaya hakkın olmayan içeriği yükleme.</li>
<li>Kurallara aykırı içeriği kaldırma ve şikâyetleri inceleme hakkımız saklıdır.</li>
</ul>

<h2>7. Jetonlar ve satın alımlar</h2>
<ul>
<li>Bazı özellikler (ör. görüntülü arama, oda oluşturma, boost, kenarlık) jeton veya mağaza ürünü
gerektirebilir.</li>
<li>Jetonlar Uygulama içinde kullanman için verilen <strong>sınırlı, devredilemez ve geri alınabilir bir
lisanstır</strong>; gerçek para değeri yoktur, nakde çevrilemez ve başka hesaba aktarılamaz.</li>
<li>Ödemeler Apple App Store veya Google Play üzerinden alınır; iade ve faturalama mağaza kurallarına
tabidir. "Satın alımları geri yükle" aynı mağaza hesabındaki uygun satın alımları geri getirir.</li>
</ul>

<h2>8. Fikri mülkiyet</h2>
<p>Uygulama, marka, tasarım, yazılım ve ilgili içerikler bize veya lisans verenlerimize aittir. Sana
Uygulamayı kişisel ve ticari olmayan amaçla kullanman için sınırlı, devredilemez bir hak veriyoruz.</p>

<h2>9. Üçüncü taraf hizmetleri</h2>
<p>Apple, Google, Firebase, Agora, CDN ve ödeme / abonelik doğrulama hizmetlerinin kullanımı, o
hizmetlerin kendi koşullarına da tabidir.</p>

<h2>10. Sorumluluğun sınırlandırılması</h2>
<p>Uygulama "olduğu gibi" sunulur. Diğer kullanıcıların davranışlarını garanti etmeyiz. Yürürlükteki
hukukun izin verdiği ölçüde; dolaylı zararlardan sorumlu değiliz. Kast veya ağır ihmal ile tüketici
olarak sahip olduğun yasal haklar saklıdır.</p>

<h2>11. Fesih</h2>
<p>Uygulamayı istediğin zaman bırakabilir ve Hesap Yönetimi'nden silme talebi oluşturabilirsin. Bu
koşulları ihlal edersen hesabını askıya alabilir veya kapatabiliriz. Kalan jetonlar silme sonrası geri
getirilemez.</p>

<h2>12. Uygulanacak hukuk</h2>
<p>Bu koşullar Türkiye Cumhuriyeti hukukuna tabidir. Tüketici olarak ikamet ettiğin ülkenin emredici
hükümlerinden doğan hakların saklıdır.</p>

<h2>13. Değişiklikler</h2>
<p>Bu koşulları güncelleyebiliriz. Önemli değişikliklerde Uygulama içinde bilgilendiririz.</p>

<h2>14. İletişim</h2>
<p>{EMAIL}</p>
"""

TERMS_EN = f"""
<div class="note"><strong>In short:</strong> Veylo is a social app. By creating an account or using the App
you accept these terms and our <a href="../privacy-policy/">Privacy Policy</a>. Users under 17 are not
allowed. Harassment, scams, illegal content and child exploitation are prohibited.</div>

<h2>1. Acceptance</h2>
<p>By downloading, creating an account or using the Veylo app (the "App") you accept these Terms of Use.
If you do not agree, do not use the App. The App is provided by Fly Work ("we").</p>

<h2>2. The service</h2>
<p>Veylo offers meeting people, anonymous and open chat, connection progress, Vibes and posts, groups,
random matching, voice / video calls and optional paid features. We may change, add or remove features,
token prices and rules over time.</p>

<h2>3. Account and age</h2>
<ul>
<li>You must provide accurate information and keep your login secure. You are responsible for activity
under your account.</li>
<li>You must be at least <strong>17 years old</strong> and old enough under the laws of your country to use
a service like Veylo.</li>
<li>One account per real person; impersonation is prohibited.</li>
</ul>

<h2>4. Anonymous chat and profile reveal</h2>
<ul>
<li>In anonymous chats, name and photo may stay hidden / masked until connection milestones.</li>
<li>Full profile reveal requires mutual consent. Do not pressure others to reveal identity.</li>
<li>Do not use anonymity to bypass safety features or to harm others.</li>
</ul>

<h2>5. Acceptable use</h2>
<p>You agree not to:</p>
<ul>
<li>Harass, threaten, use hate speech, promote violence, scam, spam or impersonate others.</li>
<li>Share illegal, prohibited sexual, child sexual abuse material or other harmful content.</li>
<li>Distribute others' private content without consent.</li>
<li>Reverse engineer, automate / bot, overload or circumvent security measures.</li>
<li>Obtain tokens or paid features through cheating.</li>
</ul>
<p>We may remove content, limit features or suspend / close accounts for violations. Use in-app report
and block tools; if someone is in immediate danger, call your local emergency number.</p>

<h2>6. Your content</h2>
<ul>
<li>You keep rights to content you share; you grant us a licence to host and display it as needed to
operate the service.</li>
<li>Do not upload content you do not have rights to share.</li>
<li>We may remove content that breaks the rules and review reports.</li>
</ul>

<h2>7. Tokens and purchases</h2>
<ul>
<li>Some features (e.g. video calls, creating rooms, boosts, borders) may require tokens or store
products.</li>
<li>Tokens are a <strong>limited, non-transferable, revocable licence</strong> for use in the App; they have
no real-world monetary value, cannot be cashed out and cannot be transferred.</li>
<li>Payments are processed by the Apple App Store or Google Play; refunds and billing follow store rules.
"Restore purchases" recovers eligible buys on the same store account.</li>
</ul>

<h2>8. Intellectual property</h2>
<p>The App, brand, design, software and related materials belong to us or our licensors. We grant you a
limited, non-transferable right to use the App for personal, non-commercial purposes.</p>

<h2>9. Third-party services</h2>
<p>Use of Apple, Google, Firebase, Agora, the CDN and payment / subscription verification services is also
subject to their own terms.</p>

<h2>10. Limitation of liability</h2>
<p>The App is provided "as is". We do not guarantee other users' behaviour. To the extent permitted by law,
we are not liable for indirect damages. Liability for intent or gross negligence and your statutory
consumer rights remain unaffected.</p>

<h2>11. Termination</h2>
<p>You may stop using the App anytime and submit a deletion request from Account Management. If you
violate these terms, we may suspend or close your account. Remaining tokens cannot be restored after
deletion.</p>

<h2>12. Governing law</h2>
<p>These terms are governed by the laws of the Republic of Türkiye. Mandatory consumer protection rights of
your country of residence remain unaffected.</p>

<h2>13. Changes</h2>
<p>We may update these terms. We will inform you in the App about significant changes.</p>

<h2>14. Contact</h2>
<p>{EMAIL}</p>
"""

# ───────────────────────────── ÇEREZLER ─────────────────────────────

COOKIES_TR = f"""
<div class="note">Kısaca: Veylo yasal web sayfaları <strong>çerez veya yerel depolama kullanmaz</strong>.
Mobil uygulama, çalışması için gereken oturum ve tercihleri cihazında saklar; reklam / takip çerezi
kullanmaz.</div>

<h2>1. Çerez nedir?</h2>
<p>Çerezler, web sitelerinin tarayıcına kaydettiği küçük dosyalardır. Mobil uygulamalar tarayıcı çerezi
yerine cihazdaki benzer depolama alanlarını (güvenli anahtar deposu, uygulama tercihleri) kullanır. Bu
politika her ikisini de kapsar.</p>

<h2>2. Uygulamanın cihazında sakladığı bilgiler</h2>
<p>Bunlar hizmet için <strong>gerekli</strong> niteliktedir; reklam veya uygulamalar arası takip amacıyla
kullanılmaz:</p>
<div class="table"><table>
<tr><th>Bilgi</th><th>Amaç</th><th>Nerede</th></tr>
<tr><td>Oturum / kimlik doğrulama jetonları</td><td>Girişinin sürmesi</td><td>Cihaz güvenli deposu / Firebase SDK</td></tr>
<tr><td>Dil ve bildirim tercihleri</td><td>Ayarlarını hatırlamak</td><td>Uygulama tercihleri</td></tr>
<tr><td>Önbelleğe alınan görseller</td><td>Performans</td><td>Uygulama önbelleği</td></tr>
<tr><td>Push bildirim jetonu</td><td>Mesaj ve uyarı göndermek</td><td>Cihaz + sunucu</td></tr>
</table></div>
<p>Uygulamayı kaldırdığında cihazındaki uygulama verileri silinir (platform kurallarına bağlı olarak bazı
güvenli depo öğeleri kalabilir).</p>

<h2>3. Üçüncü taraf bileşenler</h2>
<ul>
<li><strong>Firebase Auth / FCM:</strong> giriş ve push.</li>
<li><strong>Bunny CDN:</strong> medya barındırma.</li>
<li><strong>Agora:</strong> canlı arama aktarımı.</li>
<li><strong>RevenueCat / mağazalar:</strong> satın alma doğrulama.</li>
</ul>
<p>Bu sağlayıcıların kendi gizlilik politikaları da geçerlidir. Uygulamada üçüncü taraf reklam SDK'sı
<strong>yoktur</strong>.</p>

<h2>4. Bu web sayfaları</h2>
<p>Veylo yasal sayfaları çerez, yerel depolama veya analitik araç kullanmaz. Dil seçimi yalnızca sayfa
adresi (<code>?lang=</code>) üzerinden yapılır.</p>

<h2>5. Tercihlerini yönetme</h2>
<ul>
<li>Bildirimleri uygulama ayarlarından kapatabilirsin.</li>
<li>Hesabını ve verilerini Hesap Yönetimi'nden silebilirsin.</li>
<li>Ayrıntılar: <a href="../privacy-policy/">Gizlilik Politikası</a>.</li>
</ul>

<h2>6. İletişim</h2>
<p>{EMAIL}</p>
"""

COOKIES_EN = f"""
<div class="note">In short: Veylo legal web pages <strong>do not use cookies or local storage</strong>. The
mobile app stores on your device only what it needs for sessions and preferences; it does not use
advertising / tracking cookies.</div>

<h2>1. What are cookies?</h2>
<p>Cookies are small files websites store in your browser. Mobile apps use similar on-device storage
(secure key storage, app preferences) instead of browser cookies. This policy covers both.</p>

<h2>2. Information the App stores on your device</h2>
<p>This is <strong>necessary</strong> for the service and is not used for advertising or cross-app
tracking:</p>
<div class="table"><table>
<tr><th>Information</th><th>Purpose</th><th>Where</th></tr>
<tr><td>Session / auth tokens</td><td>Keeping you signed in</td><td>Device secure storage / Firebase SDK</td></tr>
<tr><td>Language and notification preferences</td><td>Remembering settings</td><td>App preferences</td></tr>
<tr><td>Cached images</td><td>Performance</td><td>App cache</td></tr>
<tr><td>Push notification token</td><td>Delivering messages and alerts</td><td>Device + server</td></tr>
</table></div>
<p>Uninstalling the App removes app data from your device (some secure-storage items may remain depending
on platform rules).</p>

<h2>3. Third-party components</h2>
<ul>
<li><strong>Firebase Auth / FCM:</strong> sign-in and push.</li>
<li><strong>Bunny CDN:</strong> media hosting.</li>
<li><strong>Agora:</strong> live call transport.</li>
<li><strong>RevenueCat / stores:</strong> purchase verification.</li>
</ul>
<p>Those providers' own privacy policies also apply. There is <strong>no</strong> third-party advertising
SDK in the App.</p>

<h2>4. These web pages</h2>
<p>The Veylo legal pages do not use cookies, local storage or analytics. Language is selected only via the
page address (<code>?lang=</code>).</p>

<h2>5. Managing your preferences</h2>
<ul>
<li>You can turn off notifications in app settings.</li>
<li>You can delete your account and data from Account Management.</li>
<li>Details: <a href="../privacy-policy/">Privacy Policy</a>.</li>
</ul>

<h2>6. Contact</h2>
<p>{EMAIL}</p>
"""

# ───────────────────────────── CSAE ─────────────────────────────

CSAE_TR = f"""
<div class="note">Veylo, <strong>çocukların cinsel istismarı ve sömürüsüne (CSAE)</strong> ve çocuk cinsel
istismarı materyaline (CSAM) karşı <strong>sıfır tolerans</strong> politikası uygular.</div>

<h2>1. Kapsam</h2>
<p>Bu standartlar Veylo uygulaması ve ilgili tüm hizmetler için geçerlidir. Veylo kullanıcılar arası
mesajlaşma, profil, medya, arama ve herkese açık / yarı herkese açık paylaşımlar (Vibes, gönderiler)
içeren bir sosyal uygulamadır. Bu nedenle çocuk güvenliği önlemleri kritik önemdedir.</p>

<h2>2. Yasaklanan içerik ve davranışlar</h2>
<ul>
<li>Çocukların cinsel istismarını gösteren, teşvik eden veya cinselleştiren her türlü görsel, metin,
ses veya diğer içerik (CSAM).</li>
<li>Çocuklarla cinsel amaçlı iletişim, kandırma veya istismar girişimi (grooming).</li>
<li>Çocukların cinsel sömürüsünü, insan ticaretini veya bunlara aracılığı içeren her türlü faaliyet.</li>
<li>17 yaşından küçüklerin hesap oluşturması veya hizmeti kullanması.</li>
</ul>

<h2>3. Önleme</h2>
<ul>
<li>Minimum yaş kuralı (17+) kullanım koşullarında belirtilir.</li>
<li>Kullanıcılar engelleme, kısıtlama ve şikâyet araçlarını kullanabilir; şikâyet nedenleri arasında
"reşit olmayan" seçeneği vardır.</li>
<li>Kurallara aykırı hesaplar askıya alınabilir veya kapatılabilir; ilgili içerik kaldırılabilir.</li>
<li>Anonim sohbet, güvenlik kurallarını atlatmak için kullanılamaz.</li>
</ul>

<h2>4. Bildirim</h2>
<p>Uygulamada çocuk güvenliğini tehdit eden içerik veya davranış görürsen hemen bildir:</p>
<ul>
<li><strong>Uygulama içi:</strong> profil / sohbet menüsünden Şikâyet et</li>
<li><strong>E-posta:</strong> {EMAIL} (konu: "Çocuk güvenliği")</li>
</ul>
<p>Bir çocuk acil tehlikedeyse önce <strong>112</strong>'yi (veya bulunduğun ülkedeki acil durum hattını)
ara.</p>

<h2>5. Müdahale</h2>
<ul>
<li>Bildirimler öncelikli incelenir.</li>
<li>CSAM tespit edildiğinde yürürlükteki yasalar uyarınca yetkili makamlara bildirilir; soruşturmalarda
iş birliği yapılır.</li>
<li>İlgili hesaplar kapatılır ve içerik kaldırılır.</li>
</ul>

<h2>6. Yasalara uyum</h2>
<p>Veylo, çocuk güvenliğine ilişkin yürürlükteki yasalara ve Google Play ile App Store politikalarına
uyar.</p>

<h2>7. Çocuk güvenliği irtibat kişisi</h2>
<p>Çocuk güvenliği uygulamalarımız ve bu standartlar hakkında: {EMAIL}</p>
"""

CSAE_EN = f"""
<div class="note">Veylo has a <strong>zero-tolerance</strong> policy against <strong>child sexual abuse and
exploitation (CSAE)</strong> and child sexual abuse material (CSAM).</div>

<h2>1. Scope</h2>
<p>These standards apply to the Veylo app and all related services. Veylo is a social app with messaging,
profiles, media, calls and public / semi-public sharing (Vibes, posts). Child safety measures are
therefore critical.</p>

<h2>2. Prohibited content and behaviour</h2>
<ul>
<li>Any imagery, text, audio or other content depicting, promoting or sexualising the sexual abuse of
children (CSAM).</li>
<li>Any attempt to contact, deceive or exploit children for sexual purposes (grooming).</li>
<li>Any activity involving or facilitating the sexual exploitation or trafficking of children.</li>
<li>Accounts or use by anyone under 17.</li>
</ul>

<h2>3. Prevention</h2>
<ul>
<li>A minimum age rule (17+) is stated in the terms of use.</li>
<li>Users can block, restrict and report; report reasons include underage.</li>
<li>Accounts that break the rules may be suspended or closed; related content may be removed.</li>
<li>Anonymous chat must not be used to bypass safety rules.</li>
</ul>

<h2>4. Reporting</h2>
<p>If you see content or behaviour that threatens child safety, report it immediately:</p>
<ul>
<li><strong>In-app:</strong> Report from the profile / chat menu</li>
<li><strong>Email:</strong> {EMAIL} (subject: "Child safety")</li>
</ul>
<p>If a child is in immediate danger, first call your local emergency number (<strong>112</strong> in
Türkiye and the EU).</p>

<h2>5. Response</h2>
<ul>
<li>Reports are reviewed with priority.</li>
<li>Where CSAM is identified, it is reported to competent authorities as required by law, and we cooperate
in investigations.</li>
<li>Related accounts are closed and content is removed.</li>
</ul>

<h2>6. Legal compliance</h2>
<p>Veylo complies with applicable child safety laws and with Google Play and App Store policies.</p>

<h2>7. Child safety point of contact</h2>
<p>For questions about our child safety practices and these standards: {EMAIL}</p>
"""

# ───────────────────────────── HAKKINDA ─────────────────────────────

ABOUT_TR = f"""
<div class="note"><strong>Veylo</strong>, insanlarla tanışabileceğin, anonim sohbet edebileceğin ve
bağlantını zamanla güçlendirebileceğin bir sosyal uygulamadır. Bir Fly Work ürünüdür.</div>

<h2>1. Ne yapabilirsin?</h2>
<ul>
<li>Profil oluştur; ilgi alanlarını ve hedeflerini paylaş.</li>
<li>Anonim sohbetle tanış; bağlantı ilerledikçe karşılıklı onayla profilini aç.</li>
<li>Vibes, gönderiler ve gruplarla toplulukta yer al.</li>
<li>Karşılıklı onayla sesli veya görüntülü aramaya geç.</li>
<li>Güvenliğin için engelle, kısıtla veya şikâyet et.</li>
</ul>

<h2>2. Güvenlik</h2>
<p>17 yaş sınırı vardır. Çocuk güvenliği politikamız için
<a href="../csae/?lang=tr">CSAE sayfası</a>na bak. Gizlilik ayrıntıları:
<a href="../privacy-policy/?lang=tr">Gizlilik Politikası</a>.</p>

<h2>3. Satın alımlar</h2>
<p>Bazı özellikler jeton veya mağaza ürünü gerektirebilir. Ödemeler App Store / Google Play üzerinden
alınır. Ayrıntılar: <a href="../terms/?lang=tr">Kullanım Koşulları</a>.</p>

<h2>4. Destek</h2>
<ul>
<li>E-posta: {EMAIL}</li>
<li>Web: <a href="https://fly-work.com">fly-work.com</a> ·
<a href="https://fly-work.com/contact-us/">İletişim formu</a></li>
<li>Uygulama: <em>Ayarlar → Hesap Yönetimi / SSS</em></li>
</ul>
"""

ABOUT_EN = f"""
<div class="note"><strong>Veylo</strong> is a social app where you can meet people, chat anonymously and
build connection over time. A Fly Work product.</div>

<h2>1. What you can do</h2>
<ul>
<li>Create a profile; share interests and goals.</li>
<li>Meet through anonymous chat; reveal profiles with mutual consent as connection grows.</li>
<li>Join the community with Vibes, posts and groups.</li>
<li>Move to voice or video calls when both sides agree.</li>
<li>Block, restrict or report to stay safe.</li>
</ul>

<h2>2. Safety</h2>
<p>There is a 17+ age rule. See our <a href="../csae/?lang=en">CSAE page</a> for child safety. Privacy
details: <a href="../privacy-policy/?lang=en">Privacy Policy</a>.</p>

<h2>3. Purchases</h2>
<p>Some features may require tokens or store products. Payments go through the App Store / Google Play.
Details: <a href="../terms/?lang=en">Terms of Use</a>.</p>

<h2>4. Support</h2>
<ul>
<li>Email: {EMAIL}</li>
<li>Web: <a href="https://fly-work.com">fly-work.com</a> ·
<a href="https://fly-work.com/contact-us/">Contact form</a></li>
<li>In-app: <em>Settings → Account Management / FAQ</em></li>
</ul>
"""

PAGES = {
    "about": {
        "title": {"tr": "Veylo Hakkında", "en": "About Veylo"},
        "desc": "About Veylo — social app by Fly Work / Veylo hakkında",
        "body": {"tr": ABOUT_TR, "en": ABOUT_EN},
    },
    "privacy-policy": {
        "title": {"tr": "Veylo – Gizlilik Politikası", "en": "Veylo – Privacy Policy"},
        "desc": "Veylo privacy policy / gizlilik politikası",
        "body": {"tr": PRIVACY_TR, "en": PRIVACY_EN},
    },
    "terms": {
        "title": {"tr": "Veylo – Kullanım Koşulları", "en": "Veylo – Terms of Use"},
        "desc": "Veylo terms of use / kullanım koşulları",
        "body": {"tr": TERMS_TR, "en": TERMS_EN},
    },
    "cookies": {
        "title": {"tr": "Veylo – Çerez Politikası", "en": "Veylo – Cookie Policy"},
        "desc": "Veylo cookie policy / çerez politikası",
        "body": {"tr": COOKIES_TR, "en": COOKIES_EN},
    },
    "csae": {
        "title": {
            "tr": "Veylo – Çocuk Güvenliği Standartları (CSAE)",
            "en": "Veylo – Child Safety Standards (CSAE)",
        },
        "desc": "Veylo child safety standards against CSAE / çocuk güvenliği standartları",
        "body": {"tr": CSAE_TR, "en": CSAE_EN},
    },
}
