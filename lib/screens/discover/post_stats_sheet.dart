import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';

/// Paylaşım sonrası İstatistik bottom sheet (Figma).
Future<void> showPostStatsSheet(
  BuildContext context, {
  required String imagePath,
}) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) => _PostStatsSheet(imagePath: imagePath),
  );
}

class _PostStatsSheet extends StatelessWidget {
  const _PostStatsSheet({required this.imagePath});

  final String imagePath;

  static const _avatarSize = 100.0;

  static const _subtitleStyle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w400,
    fontSize: 20,
    height: 24 / 20,
    letterSpacing: 20 * -0.02,
    color: Color(0xA61A1714),
  );

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).discover.stats;
    final bottom = MediaQuery.paddingOf(context).bottom;

    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: const EdgeInsets.only(top: _avatarSize / 2),
          width: double.infinity,
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              16,
              _avatarSize / 2 + 16,
              16,
              16 + bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText(
                  t.title,
                  style: AppTextStyles.filtersTitle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 324),
                  child: Text(
                    t.subtitle,
                    style: _subtitleStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                _StatRow(
                  label: t.viewers,
                  value: '1.8k',
                  icon: SvgPicture.asset(
                    AppAssets.iconStatsEye,
                    width: 24,
                    height: 24,
                  ),
                ),
                const SizedBox(height: 10),
                _StatRow(
                  label: t.comments,
                  value: '140',
                  icon: Image.asset(
                    AppAssets.iconAiCommentary,
                    width: 24,
                    height: 24,
                  ),
                ),
                const SizedBox(height: 10),
                _StatRow(
                  label: t.likes,
                  value: '550',
                  icon: SvgPicture.asset(
                    AppAssets.iconStatsLike,
                    width: 24,
                    height: 24,
                  ),
                ),
                const SizedBox(height: 24),
                _BoostButton(
                  label: t.boostCta,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: _avatarSize / 2 + 8,
          right: 16,
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            behavior: HitTestBehavior.opaque,
            child: SvgPicture.asset(
              AppAssets.iconClose,
              width: 32,
              height: 32,
            ),
          ),
        ),
        Positioned(
          top: 0,
          child: Container(
            width: _avatarSize,
            height: _avatarSize,
            decoration: BoxDecoration(
              color: const Color(0xFFF6F6FB),
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.white, width: 3),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: 0.08),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipOval(
              child: Image.file(
                File(imagePath),
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Image.asset(
                  AppAssets.fakePerson01,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _StatRow extends StatelessWidget {
  const _StatRow({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.inputFill,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontFamily: AppFonts.poppins,
                fontWeight: FontWeight.w500,
                fontSize: 16,
                height: 1,
                letterSpacing: 16 * -0.02,
                color: AppColors.black,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontFamily: AppFonts.poppins,
              fontWeight: FontWeight.w600,
              fontSize: 16,
              height: 1,
              letterSpacing: 16 * -0.02,
              color: AppColors.linkGradientStart,
            ),
          ),
          const SizedBox(width: 4),
          icon,
        ],
      ),
    );
  }
}

class _BoostButton extends StatelessWidget {
  const _BoostButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppSizes.primaryButtonHeight,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppBorders.buttonOuterRadius),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.brandPurpleSoft,
              AppColors.brandPurpleDeep,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onPressed,
              borderRadius: BorderRadius.circular(AppBorders.buttonRadius),
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppBorders.buttonRadius),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.brandPurple,
                      AppColors.brandPurpleLight,
                    ],
                  ),
                  border: Border.all(
                    width: AppBorders.buttonBorderWidth,
                    color: AppColors.white.withValues(alpha: 0.33),
                  ),
                ),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.buttonPrimary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Image.asset(
                        AppAssets.iconTokens,
                        width: 22,
                        height: 22,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
