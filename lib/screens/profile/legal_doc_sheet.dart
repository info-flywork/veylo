import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/i18n/strings.g.dart';

/// Hizmet şartları / gizlilik politikası bottom sheet.
Future<void> showLegalDocSheet(
  BuildContext context, {
  required String title,
  required String body,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => LegalDocSheet(title: title, body: body),
  );
}

Future<void> showTermsOfServiceSheet(BuildContext context) {
  final tr = LocaleSettings.currentLocale == AppLocale.tr;
  final title = tr
      ? 'Hizmet Şartları'
      : Translations.of(context).profile.termsOfService;
  return showLegalDocSheet(
    context,
    title: title,
    body: tr ? _termsTr : _termsEn,
  );
}

Future<void> showPrivacyPolicySheet(BuildContext context) {
  final tr = LocaleSettings.currentLocale == AppLocale.tr;
  final title = tr
      ? 'Gizlilik Politikası'
      : Translations.of(context).profile.privacyPolicy;
  return showLegalDocSheet(
    context,
    title: title,
    body: tr ? _privacyTr : _privacyEn,
  );
}

class LegalDocSheet extends StatelessWidget {
  const LegalDocSheet({
    super.key,
    required this.title,
    required this.body,
  });

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.viewPaddingOf(context).bottom;
    final maxHeight = MediaQuery.sizeOf(context).height * 0.92;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        constraints: BoxConstraints(maxHeight: maxHeight),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 10, 16, 10 + bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 46,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.sheetHandle,
                    borderRadius: BorderRadius.circular(9999),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontFamily: AppFonts.poppins,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  height: 1,
                  letterSpacing: 20 * -0.02,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 14),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.zero,
                  child: Text(
                    body,
                    style: const TextStyle(
                      fontFamily: AppFonts.poppins,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 22 / 14,
                      letterSpacing: 14 * -0.02,
                      color: Color(0xA6000000),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const _termsEn = '''
Last updated: March 16, 2026

Welcome to Veylo. By creating an account or using the app, you agree to these Terms of Service.

1. What Veylo is
Veylo is a social app where you can meet people, chat anonymously, build connection over time, and optionally move to voice or face-to-face calls when both sides agree.

2. Your account
You must provide accurate information and keep your login secure. You are responsible for activity under your account. You must be old enough to use Veylo under the laws of your country.

3. Respectful use
Do not harass, threaten, scam, impersonate others, share illegal content, or try to bypass safety features. We may remove content, limit features, or suspend accounts that break these rules.

4. Anonymous chat & profile reveal
Anonymous chats may hide your name and photo until connection milestones are reached. Full profile reveal requires mutual consent. Do not pressure others to reveal identity.

5. Purchases
Some features may be paid. Purchases are handled by Apple App Store or Google Play. Restore Purchases recovers eligible buys on the same store account. Refunds follow the store’s policy.

6. Content you share
You keep rights to your content, but grant Veylo a license to host and display it in the app as needed to operate the service. Do not post content you do not have rights to share.

7. Ending use
You can stop using Veylo anytime and request account deletion from Settings. We may also end or change the service with reasonable notice when required.

8. Contact
Questions about these terms: support@veylo.app
''';

const _termsTr = '''
Son güncelleme: 16 Mart 2026

Veylo’ya hoş geldin. Hesap oluşturarak veya uygulamayı kullanarak bu Hizmet Şartları’nı kabul etmiş olursun.

1. Veylo nedir?
Veylo; insanlarla tanışabileceğin, anonim sohbet edebileceğin, bağlantını zamanla güçlendirebileceğin ve karşılıklı onayla sesli veya yüz yüze aramaya geçebileceğin bir sosyal uygulamadır.

2. Hesabın
Doğru bilgi vermeli ve giriş bilgilerini güvende tutmalısın. Hesabındaki aktivitelerden sen sorumlusun. Yaşadığın ülkenin yasalarına göre Veylo’yu kullanabilecek yaşta olmalısın.

3. Saygılı kullanım
Taciz, tehdit, dolandırıcılık, kimliğe bürünme, yasa dışı içerik veya güvenlik özelliklerini atlatma girişimleri yasaktır. Kuralları ihlal eden içerik kaldırılabilir, özellikler kısıtlanabilir veya hesap askıya alınabilir.

4. Anonim sohbet ve profil açma
Anonim sohbetlerde isim ve fotoğraf, bağlantı eşiklerine kadar gizli kalabilir. Tam profil açılışı karşılıklı onay gerektirir. Kimliğini açması için kimseyi zorlama.

5. Satın alımlar
Bazı özellikler ücretli olabilir. Ödemeler App Store veya Google Play üzerinden yapılır. Restore Purchases, aynı mağaza hesabındaki uygun satın alımları geri yükler. İadeler mağaza politikasına tabidir.

6. Paylaştığın içerik
İçeriğinin hakları sende kalır; Veylo’ya hizmeti sunmak için gereken ölçüde barındırma ve gösterme lisansı verirsin. Hakkın olmayan içeriği paylaşma.

7. Kullanımı sonlandırma
İstediğin zaman Veylo’yu bırakabilir ve Ayarlar’dan hesap silme talebi oluşturabilirsin. Gerekirse hizmeti makul bildirimle değiştirebilir veya sonlandırabiliriz.

8. İletişim
Bu şartlarla ilgili soruların için: support@veylo.app
''';

const _privacyEn = '''
Last updated: March 16, 2026

This Privacy Policy explains how Veylo collects, uses, and protects your information.

1. Information we collect
• Account data: email, display name, profile photos, bio, preferences
• Usage data: chats, connection progress, call features you use, device/app basics
• Purchases: store receipt data needed to unlock and restore paid features

2. How we use it
We use your data to run Veylo, personalize matching and chat experiences, keep the community safe, process purchases, and improve the product. We do not sell your personal data.

3. Anonymous mode
In anonymous chats we limit what others see (for example masked name or blurred photo) until unlock rules and mutual consent allow more. Behind the scenes we still need account identifiers to operate the feature securely.

4. Sharing
We may share data with service providers that help us host, analyze, or process payments—only as needed. We may also disclose information if required by law or to protect users from harm.

5. Retention
We keep data while your account is active and as needed for legal, safety, and billing reasons. After a deletion request is completed, we remove or anonymize personal data except where retention is required.

6. Your choices
You can edit profile info, manage notifications, request account deletion, and contact us about your data. Store purchases are also managed through Apple or Google.

7. Security
We use reasonable technical and organizational measures to protect your information. No system is perfectly secure; please use a strong password and keep your device updated.

8. Contact
Privacy questions: privacy@veylo.app
''';

const _privacyTr = '''
Son güncelleme: 16 Mart 2026

Bu Gizlilik Politikası, Veylo’nun bilgilerini nasıl topladığını, kullandığını ve koruduğunu açıklar.

1. Topladığımız bilgiler
• Hesap verileri: e-posta, görünen ad, profil fotoğrafları, bio, tercihler
• Kullanım verileri: sohbetler, bağlantı ilerlemesi, kullandığın arama özellikleri, temel cihaz/uygulama bilgileri
• Satın alımlar: ücretli özellikleri açmak ve geri yüklemek için gerekli mağaza fiş bilgileri

2. Nasıl kullanırız?
Verilerini Veylo’yu işletmek, eşleşme ve sohbet deneyimini kişiselleştirmek, topluluğu güvende tutmak, satın alımları işlemek ve ürünü geliştirmek için kullanırız. Kişisel verilerini satmayız.

3. Anonim mod
Anonim sohbetlerde diğer kullanıcıların gördüğü bilgiler (ör. maskeli isim veya bulanık fotoğraf) kilit açma kuralları ve karşılıklı onayla sınırlıdır. Özelliğin güvenli çalışması için hesap tanımlayıcılarına yine ihtiyaç duyarız.

4. Paylaşım
Verileri yalnızca barındırma, analiz veya ödeme gibi hizmet sağlayıcılarla gerektiği ölçüde paylaşabiliriz. Yasal zorunluluk veya kullanıcıları zarardan koruma durumlarında da açıklama yapılabilir.

5. Saklama
Hesabın aktifken ve yasal, güvenlik ile faturalama gerekçeleriyle gerektiği süre veriyi saklarız. Silme talebi tamamlandıktan sonra, zorunlu saklama dışında kişisel veriler silinir veya anonimleştirilir.

6. Seçeneklerin
Profilini düzenleyebilir, bildirimleri yönetebilir, hesap silme talebi oluşturabilir ve verilerin hakkında bize yazabilirsin. Mağaza satın alımları Apple veya Google üzerinden de yönetilir.

7. Güvenlik
Bilgilerini korumak için makul teknik ve idari önlemler alırız. Hiçbir sistem tamamen risksiz değildir; güçlü parola kullan ve cihazını güncel tut.

8. İletişim
Gizlilik soruları: privacy@veylo.app
''';
