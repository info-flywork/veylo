import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';

enum AppNavTab { discover, chat, call, vibes, profile }

/// Figma Navigation — 430×80, Call ortada (beyaz 98 disk + 82 purple).
class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    super.key,
    required this.current,
    required this.onChanged,
    this.profileAsset = AppAssets.radiusIcon,
  });

  final AppNavTab current;
  final ValueChanged<AppNavTab> onChanged;
  final String profileAsset;

  /// Figma Ellipse 2396 — Call arkasındaki beyaz disk.
  static const double callBgSize = 98;
  static const double callSize = 82;
  static const double callInnerSize = 76;
  static const double barHeight = 64;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).nav;
    final bottom = MediaQuery.paddingOf(context).bottom;
    // Call + beyaz disk üste taştığı için ekstra yükseklik
    final totalH = barHeight + (callBgSize / 2) + bottom;

    return SizedBox(
      height: totalH,
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          // Beyaz bar (alt kısım)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Material(
              color: AppColors.white,
              child: Container(
                height: barHeight + bottom,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  border: Border(
                    top: BorderSide(color: AppColors.navTopBorder, width: 1),
                  ),
                ),
                padding: EdgeInsets.only(bottom: bottom),
                child: Row(
                  children: [
                    Expanded(
                      child: _NavItem(
                        iconAsset: AppAssets.navDiscover,
                        label: t.discover,
                        selected: current == AppNavTab.discover,
                        onTap: () => onChanged(AppNavTab.discover),
                      ),
                    ),
                    Expanded(
                      child: _NavItem(
                        iconAsset: AppAssets.navChat,
                        label: t.chat,
                        selected: current == AppNavTab.chat,
                        onTap: () => onChanged(AppNavTab.chat),
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    Expanded(
                      child: _NavItem(
                        iconAsset: AppAssets.navVibes,
                        label: t.vibes,
                        selected: current == AppNavTab.vibes,
                        onTap: () => onChanged(AppNavTab.vibes),
                      ),
                    ),
                    Expanded(
                      child: _ProfileNavItem(
                        asset: profileAsset,
                        label: t.profile,
                        selected: current == AppNavTab.profile,
                        onTap: () => onChanged(AppNavTab.profile),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Call — ortada, barın üstüne taşar
          Positioned(
            bottom: bottom + 4,
            child: _CallNavItem(
              label: t.call,
              onTap: () => onChanged(AppNavTab.call),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.iconAsset,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String iconAsset;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color =
        selected ? AppColors.selectionBorder : AppColors.navInactive;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              iconAsset,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
            const SizedBox(height: 4),
            AppText(
              label,
              style: selected
                  ? AppTextStyles.navLabelActive
                  : AppTextStyles.navLabelIdle,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}

class _CallNavItem extends StatelessWidget {
  const _CallNavItem({
    required this.label,
    required this.onTap,
  });

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    // Figma: beyaz 98 disk + dış 82 (#976FEA→#5E35B4) + iç 76.
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: AppBottomNav.callBgSize,
        height: AppBottomNav.callBgSize,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.selectionBorder.withValues(alpha: 0.18),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Container(
          width: AppBottomNav.callSize,
          height: AppBottomNav.callSize,
          padding: const EdgeInsets.all(3),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.brandPurpleSoft,
                AppColors.brandPurpleDeep,
              ],
            ),
          ),
          child: Container(
            width: AppBottomNav.callInnerSize,
            height: AppBottomNav.callInnerSize,
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.brandPurple,
                  AppColors.brandPurpleLight,
                ],
              ),
              border: Border.all(
                width: 0.6,
                color: AppColors.white.withValues(alpha: 0.33),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppAssets.navPhone,
                  width: 24,
                  height: 24,
                ),
                const SizedBox(height: 6),
                AppText(label, style: AppTextStyles.navCallLabel),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileNavItem extends StatelessWidget {
  const _ProfileNavItem({
    required this.asset,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String asset;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.selectionBorder,
                  width: 2,
                ),
              ),
              child: ClipOval(
                child: Image.asset(asset, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 4),
            AppText(
              label,
              style: selected
                  ? AppTextStyles.navLabelActive
                  : AppTextStyles.navLabelIdle,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
