import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';

class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.leading,
  });

  final String label;
  final VoidCallback? onPressed;
  final Widget? leading;

  /// Figma pasif: aynı gradient/border yapısı, düşük opacity.
  static const double _disabledOpacity = 0.4;

  bool get _enabled => onPressed != null;

  @override
  Widget build(BuildContext context) {
    final button = SizedBox(
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
                      if (leading != null) ...[
                        leading!,
                        const SizedBox(width: 10),
                      ],
                      AppText(label, style: AppTextStyles.buttonPrimary),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    if (_enabled) return button;

    return IgnorePointer(
      child: Opacity(
        opacity: _disabledOpacity,
        child: button,
      ),
    );
  }
}
