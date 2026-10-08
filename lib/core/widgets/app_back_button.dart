import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';

/// Sol üst geri ikonu — 24×24 SVG.
class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed ?? () => Navigator.of(context).maybePop(),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 44,
        height: 44,
        child: Align(
          alignment: Alignment.centerLeft,
          child: SvgPicture.asset(
            AppAssets.backButton,
            width: AppSizes.backIcon,
            height: AppSizes.backIcon,
          ),
        ),
      ),
    );
  }
}
