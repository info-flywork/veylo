import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_primary_button.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';

/// Profil bağlantısını kopyalar ya da telefonun paylaşım sayfasından birine yollar.
Future<void> showShareProfileSheet(
  BuildContext context, {
  required String username,
  String? displayName,
}) {
  final handle = username.startsWith('@') ? username.substring(1) : username;
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => ShareProfileSheet(
      profileLink: 'veylo.app/$handle',
      displayName: (displayName ?? handle).trim(),
    ),
  );
}

class ShareProfileSheet extends StatelessWidget {
  const ShareProfileSheet({
    super.key,
    required this.profileLink,
    required this.displayName,
  });

  final String profileLink;
  final String displayName;

  static const _iconSize = 100.0;
  static const _iconBg = Color(0xFFF8FCFF);

  Future<void> _copy(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: _url));
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

  String get _url =>
      profileLink.startsWith('http') ? profileLink : 'https://$profileLink';

  Future<void> _send(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    final origin = box == null
        ? null
        : box.localToGlobal(Offset.zero) & box.size;
    final text = Translations.of(context).profile.shareMessage(
      name: displayName,
      url: _url,
    );
    final result = await SharePlus.instance.share(
      ShareParams(text: text, sharePositionOrigin: origin),
    );
    if (result.status == ShareResultStatus.success && context.mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).profile;
    final bottom = MediaQuery.viewPaddingOf(context).bottom;

    // İkon yarı dışarıda; alt kenar → "Share with Friends" arası 2px.
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
                    t.shareTitle,
                    style: AppTextStyles.shareProfileTitle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: _ShareSubtitleTwoLines(text: t.shareSubtitle),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AppText(
                      t.shareProfileLabel,
                      style: AppTextStyles.shareProfileLabel,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Figma: 44h, padding 10, radius 10, #998FED @ 5%.
                  Material(
                    color: const Color(0x0D998FED),
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      height: 44,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => _copy(context),
                                behavior: HitTestBehavior.opaque,
                                child: AppText(
                                  profileLink,
                                  style: AppTextStyles.shareProfileLink,
                                  maxLines: 1,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () => _copy(context),
                              behavior: HitTestBehavior.opaque,
                              child: Tooltip(
                                message: t.shareLinkCopied,
                                child: SvgPicture.asset(
                                  AppAssets.iconCopy,
                                  width: 24,
                                  height: 24,
                                  colorFilter: const ColorFilter.mode(
                                    AppColors.black,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  AppPrimaryButton(
                    label: t.shareSend,
                    onPressed: () => _send(context),
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

/// `\n` sonrası 2. satır; 1. satır (…connect) soft-wrap ile bölünmesin.
class _ShareSubtitleTwoLines extends StatelessWidget {
  const _ShareSubtitleTwoLines({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final parts = text.split('\n');
    final line1 = parts.isNotEmpty ? parts[0] : text;
    final line2 = parts.length > 1 ? parts.sublist(1).join(' ') : '';

    return Column(
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            line1,
            maxLines: 1,
            softWrap: false,
            textAlign: TextAlign.center,
            style: AppTextStyles.shareProfileSubtitle,
          ),
        ),
        if (line2.isNotEmpty)
          Text(
            line2,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: AppTextStyles.shareProfileSubtitle,
          ),
      ],
    );
  }
}
