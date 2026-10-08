import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';

/// Figma link metni — linear gradient fill (#7B2FFF → #998FED).
class AppGradientText extends StatelessWidget {
  const AppGradientText(
    this.data, {
    super.key,
    this.style = AppTextStyles.link,
  });

  final String data;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) {
        return const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            AppColors.linkGradientStart,
            AppColors.linkGradientEnd,
          ],
        ).createShader(bounds);
      },
      child: Text(data, style: style),
    );
  }
}
