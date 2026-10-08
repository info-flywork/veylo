import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';

/// Figma OR divider — çizgi | metin | çizgi
class AppOrDivider extends StatelessWidget {
  const AppOrDivider({super.key, required this.label});

  final String label;

  static const _lineColor = Color(0x4D000000); // #000 @ 30%

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            height: 1,
            thickness: 1,
            color: _lineColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: AppText(label, style: AppTextStyles.orDivider),
        ),
        const Expanded(
          child: Divider(
            height: 1,
            thickness: 1,
            color: _lineColor,
          ),
        ),
      ],
    );
  }
}
