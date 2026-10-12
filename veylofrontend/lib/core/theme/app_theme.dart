import 'package:flutter/material.dart';
import 'package:veylo/core/theme/app_colors.dart';
import 'package:veylo/core/theme/app_fonts.dart';
import 'package:veylo/core/theme/app_text_styles.dart';

abstract final class AppTheme {
  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      fontFamily: AppFonts.poppins,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.brandPurple,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: AppColors.white,
      textTheme: const TextTheme(
        headlineLarge: AppTextStyles.authTitle,
        headlineMedium: AppTextStyles.splashBrand,
        bodyMedium: AppTextStyles.bodyMedium,
      ),
    );
  }
}
