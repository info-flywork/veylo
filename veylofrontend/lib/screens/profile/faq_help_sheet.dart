import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/i18n/strings.g.dart';

const _kItemFill = Color(0x0D998FED); // #998FED @ 5%
const _kItemBorder = Color(0x3383A0B4); // #83A0B4 @ 20%

/// SSS / F.A.Q & Help bottom sheet.
Future<void> showFaqHelpSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const FaqHelpSheet(),
  );
}

class FaqHelpSheet extends StatefulWidget {
  const FaqHelpSheet({super.key});

  @override
  State<FaqHelpSheet> createState() => _FaqHelpSheetState();
}

class _FaqHelpSheetState extends State<FaqHelpSheet> {
  int? _expandedIndex = 0;

  List<({String q, String a})> _items(bool tr) {
    if (tr) {
      return const [
        (
          q: 'Bu uygulama nasıl çalışır?',
          a: 'Veylo’da anonim olarak yeni insanlarla tanışabilir, sohbet edebilir ve bağlantın güçlendikçe profilini adım adım açabilirsin. İstediğin zaman yazışma, sesli arama veya yüz yüze görüşmeye geçebilirsin.',
        ),
        (
          q: 'Anonim sohbet nedir?',
          a: 'Anonim sohbette kimliğin ve fotoğrafın gizli kalır. Bağlantı yüzdesi arttıkça isim baş harfi, bulanık fotoğraf gibi bilgiler açılır; %100’de karşılıklı onayla tam profil paylaşılır.',
        ),
        (
          q: 'Connection Progress ne işe yarar?',
          a: 'Sohbet ettikçe bağlantı yüzdeniz artar. Belirli eşiklerde isim baş harfi, bulanık fotoğraf ve tam profil gibi adımlar açılır. Detayları Connection pill’ine dokunarak görebilirsin.',
        ),
        (
          q: 'Profilimi nasıl açarım?',
          a: 'Bağlantı %100 olduğunda Reveal my profile ile talep gönderebilirsin. Karşı taraf da kabul ederse karşılıklı tam profiller görünür.',
        ),
        (
          q: '60 Second Stranger nedir?',
          a: 'Call sekmesinden kısa süreli rastgele bir eşleşme bulabilirsin. Süre bitince görüşmeyi uzatmayı seçebilir veya kapatabilirsin.',
        ),
        (
          q: 'Vibes nedir?',
          a: 'Vibes, yakındaki veya keşfedilebilir insanları harita / liste üzerinden görmeni sağlar. İlgilendiğin kişiye yaklaşıp sohbet başlatabilirsin.',
        ),
        (
          q: 'Profilimi nasıl düzenlerim?',
          a: 'Profil sekmesinden Edit Profile’a girerek adını, fotoğraflarını, hakkında bilgilerini ve ilgi alanlarını güncelleyebilirsin. Değişiklikler kaydettikten sonra görünür olur.',
        ),
        (
          q: 'Bildirimleri nasıl yönetirim?',
          a: 'Ayarlar’daki Notifications bölümünden mesaj, eşleşme ve diğer uyarıları açıp kapatabilirsin.',
        ),
        (
          q: 'Satın alımları nasıl geri yüklerim?',
          a: 'Ayarlar → Account Management → Restore Purchases’a dokun. Aynı mağaza hesabındaki uygun satın alımlar geri yüklenir.',
        ),
        (
          q: 'Tüm sohbetleri silebilir miyim?',
          a: 'Evet. Ayarlar → Delete Conversation ile onayladıktan sonra tüm konuşmaların silinir. Bu işlem geri alınamaz.',
        ),
        (
          q: 'Verilerim güvende mi?',
          a: 'Hesap bilgilerin ve mesajların korumalı sistemlerde saklanır. İstersen hesap yönetimi üzerinden hesabını ve verilerini silme talebi oluşturabilirsin.',
        ),
        (
          q: 'Bir kullanıcıyı nasıl engeller veya şikayet ederim?',
          a: 'Profil veya sohbet ekranındaki menüden engelle veya şikayet et seçeneklerini kullanabilirsin. Şikayetler ekibimiz tarafından incelenir.',
        ),
        (
          q: 'Uygulamayı nasıl paylaşırım?',
          a: 'Ayarlar’daki Share App ile bağlantıyı kopyalayıp arkadaşlarınla paylaşabilirsin.',
        ),
        (
          q: 'Hesabımı nasıl silebilirim?',
          a: 'Ayarlar → Account Management → Delete Account and Data yolunu izle. Sebep belirttikten sonra silme talebini onaylaman gerekir.',
        ),
      ];
    }
    return const [
      (
        q: 'How does this app work?',
        a: 'On Veylo you can meet new people anonymously, chat, and gradually reveal your profile as your connection grows. Switch to text, voice, or face-to-face whenever you both feel ready.',
      ),
      (
        q: 'What is anonymous chat?',
        a: 'In anonymous chat your identity and photo stay hidden. As connection rises you unlock details like a name initial and a blurred photo. At 100%, both sides must agree to reveal full profiles.',
      ),
      (
        q: 'What is Connection Progress?',
        a: 'As you chat, your connection percentage grows. At certain milestones you unlock a name initial, a blurred photo, and full profile. Tap the Connection pill to see details.',
      ),
      (
        q: 'How do I reveal my profile?',
        a: 'When connection reaches 100%, tap Reveal my profile. If the other person also accepts, both full profiles become visible.',
      ),
      (
        q: 'What is 60 Second Stranger?',
        a: 'From the Call tab you can get a short random match. When time is up you can keep talking or end the call.',
      ),
      (
        q: 'What are Vibes?',
        a: 'Vibes lets you discover people nearby or around you on a map/list view and start a chat with someone you’re interested in.',
      ),
      (
        q: 'How do I edit my profile?',
        a: 'Open the Profile tab and go to Edit Profile to update your name, photos, bio, and interests. Changes appear after you save.',
      ),
      (
        q: 'How do I manage notifications?',
        a: 'Open Notifications in Settings to turn message, match, and other alerts on or off.',
      ),
      (
        q: 'How do I restore purchases?',
        a: 'Go to Settings → Account Management → Restore Purchases. Eligible buys on the same store account will be restored.',
      ),
      (
        q: 'Can I delete all conversations?',
        a: 'Yes. Use Settings → Delete Conversation and confirm. All chats will be removed. This can’t be undone.',
      ),
      (
        q: 'Is my data secure?',
        a: 'Your account details and messages are stored on protected systems. You can also request account and data deletion from Account Management anytime.',
      ),
      (
        q: 'How do I block or report someone?',
        a: 'Use the menu on a profile or chat screen to block or report. Reports are reviewed by our team.',
      ),
      (
        q: 'How do I share the app?',
        a: 'Use Share App in Settings to copy the link and send it to friends.',
      ),
      (
        q: 'How do I delete my account?',
        a: 'Go to Settings → Account Management → Delete Account and Data. After sharing a reason, confirm to submit your deletion request.',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).profile;
    final tr = LocaleSettings.currentLocale == AppLocale.tr;
    final bottom = MediaQuery.viewPaddingOf(context).bottom;
    final items = _items(tr);
    final sheetHeight = MediaQuery.sizeOf(context).height * 0.90;

    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: sheetHeight,
        width: double.infinity,
        child: DecoratedBox(
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
                tr ? 'SSS ve Yardım' : t.faqHelp,
                style: const TextStyle(
                  fontFamily: AppFonts.poppins,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  height: 1,
                  letterSpacing: 20 * -0.02,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: items.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    final expanded = _expandedIndex == index;
                    return _FaqItem(
                      question: item.q,
                      answer: item.a,
                      expanded: expanded,
                      onTap: () {
                        setState(() {
                          _expandedIndex = expanded ? null : index;
                        });
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          ),
        ),
      ),
    );
  }
}

class _FaqItem extends StatelessWidget {
  const _FaqItem({
    required this.question,
    required this.answer,
    required this.expanded,
    required this.onTap,
  });

  final String question;
  final String answer;
  final bool expanded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: _kItemFill,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _kItemBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 30,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      question,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: AppFonts.poppins,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 20 / 16,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                  Icon(
                    expanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    size: 22,
                    color: AppColors.black,
                  ),
                ],
              ),
            ),
            if (expanded) ...[
              const SizedBox(height: 10),
              Text(
                answer,
                style: const TextStyle(
                  fontFamily: AppFonts.poppins,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 20 / 14,
                  color: Color(0xA6000000),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
