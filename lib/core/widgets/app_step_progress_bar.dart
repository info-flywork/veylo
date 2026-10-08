import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';

/// Create Profile adım çubuğu — [step] 1-based, [total] toplam adım.
class AppStepProgressBar extends StatelessWidget {
  const AppStepProgressBar({
    super.key,
    required this.step,
    this.total = 5,
  });

  final int step;
  final int total;

  @override
  Widget build(BuildContext context) {
    final progress = (step.clamp(1, total)) / total;

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppBorders.radiusPill),
      child: SizedBox(
        height: AppSizes.progressBarHeight,
        width: double.infinity,
        child: Stack(
          children: [
            const ColoredBox(
              color: AppColors.progressTrack,
              child: SizedBox.expand(),
            ),
            FractionallySizedBox(
              widthFactor: progress,
              child: const ColoredBox(
                color: AppColors.brandPurpleMuted,
                child: SizedBox.expand(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
