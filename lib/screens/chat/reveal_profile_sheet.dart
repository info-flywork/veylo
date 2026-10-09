import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_primary_button.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';

/// Anonim sohbet %100 — profil açma (reveal) bottom sheet.
/// "Reveal my profile" seçilirse `true` döner.
Future<bool?> showRevealProfileSheet(
  BuildContext context, {
  required String peerUsername,
}) {
  return showModalBottomSheet<bool>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => RevealProfileSheet(peerUsername: peerUsername),
  );
}

class RevealProfileSheet extends StatelessWidget {
  const RevealProfileSheet({super.key, required this.peerUsername});

  final String peerUsername;

  static const _iconSize = 100.0;
  static const _iconBg = Color(0xFFF6F6FB);

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).chats;
    final bottom = MediaQuery.viewPaddingOf(context).bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          Container(
            margin: const EdgeInsets.only(top: _iconSize / 2),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 50, 16, 10 + bottom),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppText(
                        t.revealTitle,
                        style: const TextStyle(
                          fontFamily: AppFonts.poppins,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          height: 1,
                          letterSpacing: 20 * -0.02,
                          color: AppColors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      AppText(
                        t.revealSubtitle,
                        style: const TextStyle(
                          fontFamily: AppFonts.poppins,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          height: 24 / 16,
                          letterSpacing: 16 * -0.02,
                          color: Color(0xA6000000),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      AppText(
                        t.revealWaiting(name: peerUsername),
                        style: const TextStyle(
                          fontFamily: AppFonts.poppins,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          height: 30 / 14,
                          letterSpacing: 14 * -0.02,
                          color: Color(0x73000000),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      AppPrimaryButton(
                        label: t.revealCta,
                        onPressed: () => Navigator.of(context).pop(true),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        behavior: HitTestBehavior.opaque,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: AppText(
                            t.revealNotYet,
                            style: const TextStyle(
                              fontFamily: AppFonts.poppins,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              height: 30 / 16,
                              letterSpacing: 16 * -0.02,
                              color: AppColors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    behavior: HitTestBehavior.opaque,
                    child: SizedBox(
                      width: 36,
                      height: 36,
                      child: Center(
                        child: SvgPicture.asset(
                          AppAssets.iconClose,
                          width: 28,
                          height: 28,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              width: _iconSize,
              height: _iconSize,
              decoration: const BoxDecoration(
                color: _iconBg,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(14),
              child: Image.asset(
                AppAssets.lockChat,
                fit: BoxFit.contain,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
