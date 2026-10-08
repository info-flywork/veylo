import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';

/// Discover / Chats vb. — aynı başlık satırı (sol başlık, sağ aksiyon).
class AppScreenTitle extends StatelessWidget {
  const AppScreenTitle({
    super.key,
    required this.title,
    this.trailing,
    this.onSearchTap,
    this.searchIconAsset = AppAssets.iconSearch,
  });

  final String title;
  final Widget? trailing;
  final VoidCallback? onSearchTap;
  final String searchIconAsset;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppText(title, style: AppTextStyles.discoverTitle),
        ),
        if (trailing != null)
          trailing!
        else if (onSearchTap != null)
          GestureDetector(
            onTap: onSearchTap,
            behavior: HitTestBehavior.opaque,
            child: SizedBox(
              width: 44,
              height: 44,
              child: Center(
                child: SvgPicture.asset(
                  searchIconAsset,
                  width: 24,
                  height: 24,
                  colorFilter: const ColorFilter.mode(
                    AppColors.textOnLight,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
