import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';

const _kAppShareLink = 'veylo.app';

/// Settings — Uygulamayı Paylaş bottom sheet (profil share ile aynı kabuk).
Future<void> showShareAppSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => const ShareAppSheet(),
  );
}

class ShareAppSheet extends StatelessWidget {
  const ShareAppSheet({super.key});

  static const _iconSize = 100.0;
  static const _iconBg = Color(0xFFF8FCFF);

  Future<void> _copy(BuildContext context) async {
    await Clipboard.setData(
      const ClipboardData(text: 'https://$_kAppShareLink'),
    );
    await HapticFeedback.lightImpact();
    if (!context.mounted) return;
    final msg = Translations.of(context).profile.shareLinkCopied;
    final messenger = ScaffoldMessenger.maybeOf(context);
    messenger?.clearSnackBars();
    messenger?.showSnackBar(
      SnackBar(
        content: Text(msg),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).profile;
    final bottom = MediaQuery.viewPaddingOf(context).bottom;

    const iconOverlap = _iconSize / 2;
    const titleAfterIcon = 2.0;

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          Container(
            margin: const EdgeInsets.only(top: iconOverlap),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                16,
                iconOverlap + titleAfterIcon,
                16,
                20 + bottom,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText(
                    t.shareAppTitle,
                    style: AppTextStyles.shareProfileTitle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: AppText(
                      t.shareAppSubtitle,
                      style: AppTextStyles.shareProfileSubtitle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AppText(
                      t.shareAppLabel,
                      style: AppTextStyles.shareProfileLabel,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Material(
                    color: const Color(0x0D998FED),
                    borderRadius: BorderRadius.circular(10),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => _copy(context),
                              behavior: HitTestBehavior.opaque,
                              child: AppText(
                                _kAppShareLink,
                                style: AppTextStyles.shareProfileLink,
                                maxLines: 1,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          IconButton(
                            onPressed: () => _copy(context),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(
                              minWidth: 40,
                              minHeight: 40,
                            ),
                            icon: const Icon(
                              Icons.copy_rounded,
                              size: 22,
                              color: Color(0xFF7E8896),
                            ),
                            tooltip: t.shareLinkCopied,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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
                AppAssets.iconEpChain,
                fit: BoxFit.contain,
              ),
            ),
          ),
          // Sheet sağ üst köşe
          Positioned(
            top: iconOverlap + 12,
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
    );
  }
}
