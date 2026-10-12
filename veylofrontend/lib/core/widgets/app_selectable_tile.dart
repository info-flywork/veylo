import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';

/// Tam genişlik seçim satırı (gender / chat goal).
/// Bg: #998FED@5%. Seçili: #7B2FFF border + Bold #7B2FFF metin.
class AppSelectableTile extends StatelessWidget {
  const AppSelectableTile({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final style = selected
        ? AppTextStyles.optionTileSelected
        : AppTextStyles.optionTile;
    final lines = label.split('\n');
    final isMultiline = lines.length > 1;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: AppSizes.inputHeight),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: AppColors.inputFill, // #998FED @ 5%
          borderRadius: BorderRadius.circular(AppBorders.inputRadius),
          border: Border.all(
            color: selected
                ? AppColors.selectionBorder
                : Colors.transparent,
            width: 1,
          ),
        ),
        child: isMultiline
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 1. satır taşmasın diye scaleDown — 2. satır (asleep) kesilmesin
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      lines.first,
                      maxLines: 1,
                      softWrap: false,
                      style: style,
                    ),
                  ),
                  Text(
                    lines.sublist(1).join(' '),
                    maxLines: 1,
                    softWrap: false,
                    style: style,
                  ),
                ],
              )
            : AppText(
                label,
                style: style,
                maxLines: 2,
              ),
      ),
    );
  }
}
