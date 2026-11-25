import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:veylo/core/theme/app_colors.dart';
import 'package:veylo/core/theme/app_fonts.dart';
import 'package:veylo/core/theme/app_text_styles.dart';

abstract final class AppTheme {
  /// Açık arka plan: saat / şarj / wifi koyu görünsün.
  static const SystemUiOverlayStyle lightStatusBar = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
  );

  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      fontFamily: AppFonts.poppins,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.brandPurple,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: AppColors.white,
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: lightStatusBar,
      ),
      textTheme: const TextTheme(
        headlineLarge: AppTextStyles.authTitle,
        headlineMedium: AppTextStyles.splashBrand,
        bodyMedium: AppTextStyles.bodyMedium,
      ),
    );
  }
}
