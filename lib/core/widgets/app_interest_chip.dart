import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';

/// İlgi alanı chip’i — Figma: h 52, radius 10, padding 16, gap 4.
/// Seçili değil: #998FED@5%, bordersız, Medium 16.
/// Seçili: aynı ebat + #7B2FFF border + Bold 16 #7B2FFF metin.
class AppInterestChip extends StatelessWidget {
  const AppInterestChip({
    super.key,
    required this.iconAsset,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String iconAsset;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  static const double _iconSize = 20;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: 52,
        // Figma 16; Photography+Theatre+Fitness aynı satıra sığsın diye 12
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.inputFill,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected
                ? AppColors.selectionBorder
                : Colors.transparent,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Opacity(
              opacity: selected ? 1 : 0.72,
              child: Image.asset(
                iconAsset,
                width: _iconSize,
                height: _iconSize,
                fit: BoxFit.contain,
                filterQuality: FilterQuality.high,
                errorBuilder: (_, _, _) =>
                    const SizedBox(width: _iconSize, height: _iconSize),
              ),
            ),
            const SizedBox(width: 4),
            // Bold genişliğini rezerve et — seçince satır kırılımı değişmesin
            Stack(
              alignment: Alignment.centerLeft,
              children: [
                Opacity(
                  opacity: 0,
                  child: AppText(
                    label,
                    style: AppTextStyles.interestChipSelected,
                  ),
                ),
                AppText(
                  label,
                  style: selected
                      ? AppTextStyles.interestChipSelected
                      : AppTextStyles.interestChip,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
