import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';

enum AppSocialProvider { apple, google }

class AppSocialButton extends StatelessWidget {
  const AppSocialButton({
    super.key,
    required this.provider,
    required this.label,
    required this.onPressed,
  });

  final AppSocialProvider provider;
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final isApple = provider == AppSocialProvider.apple;

    return SizedBox(
      width: double.infinity,
      height: AppSizes.socialButtonHeight,
      child: Material(
        color: isApple ? AppColors.socialApple : AppColors.white,
        borderRadius: BorderRadius.circular(AppBorders.buttonOuterRadius),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(AppBorders.buttonOuterRadius),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppBorders.buttonOuterRadius),
              border: isApple
                  ? null
                  : Border.all(color: AppColors.socialGoogleBorder),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  isApple ? AppAssets.appleIcon : AppAssets.googleIcon,
                  width: isApple ? 20 : 22,
                  height: isApple ? 24 : 22,
                ),
                const SizedBox(width: AppSpacing.sm),
                AppText(
                  label,
                  style: isApple
                      ? AppTextStyles.buttonSocialOnDark
                      : AppTextStyles.buttonSocial,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
