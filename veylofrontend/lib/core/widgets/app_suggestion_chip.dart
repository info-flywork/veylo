import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';

class AppSuggestionChip extends StatelessWidget {
  const AppSuggestionChip({
    super.key,
    required this.label,
    required this.onTap,
  });

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: AppSizes.suggestionChipHeight,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.suggestionChipFill,
          borderRadius: BorderRadius.circular(AppBorders.radiusPill),
        ),
        child: AppText(label, style: AppTextStyles.suggestionChip),
      ),
    );
  }
}
