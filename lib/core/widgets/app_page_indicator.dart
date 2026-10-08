import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';

class AppPageIndicator extends StatelessWidget {
  const AppPageIndicator({
    super.key,
    required this.count,
    required this.index,
  });

  final int count;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final active = i == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: EdgeInsets.only(right: i == count - 1 ? 0 : AppSpacing.sm),
          width: active ? 30 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: active
                ? AppColors.pageIndicatorActive
                : AppColors.pageIndicatorInactive,
            borderRadius: BorderRadius.circular(AppBorders.radiusPill),
          ),
        );
      }),
    );
  }
}
