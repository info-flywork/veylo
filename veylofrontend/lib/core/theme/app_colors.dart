import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);

  /// Brand / primary purple
  static const Color brandPurple = Color(0xFF7D37FD);
  static const Color brandPurpleLight = Color(0xFF9073F2);
  static const Color brandPurpleDeep = Color(0xFF5E35B4);
  static const Color brandPurpleSoft = Color(0xFF976FEA);
  static const Color brandPurpleMuted = Color(0xFF998FED);

  /// Figma text-secondary: #1A1714 @ 65%
  static const Color textPrimary = Color(0xFF000000);
  static const Color textSecondary = Color(0xA61A1714);
  static const Color textOnLight = Color(0xFF1A1714);
  static const Color onboardingTitle = Color(0xFF171414);
  /// #171414 @ 45%
  static const Color onboardingSubtitle = Color(0x73171414);
  /// "Already have a Veylo account?" — Figma #636363
  static const Color accountPrompt = Color(0xFF636363);
  static const Color textPlaceholder = Color(0xFF989898);
  static const Color textLink = Color(0xFF7D37FD);
  static const Color linkGradientStart = Color(0xFF7B2FFF);
  static const Color linkGradientEnd = Color(0xFF998FED);

  static const Color pageIndicatorActive = Color(0xFF7B2FFF);
  static const Color pageIndicatorInactive = Color(0xFFD9D9D9);

  /// Input fill: #998FED @ 5%
  static const Color inputFill = Color(0x0D998FED);

  static const Color borderLight = Color(0xFFE5E5E5);
  static const Color socialApple = Color(0xFF000000);
  static const Color socialGoogleBorder = Color(0xFFDDDDDD);

  /// Validation
  static const Color error = Color(0xFFC2000C);
  static const Color success = Color(0xFF43A047);

  /// Stranger message actions — Figma
  /// Approve #43A047, Block #F8C523, Reject #C23041 (@10% fill)
  static const Color strangerApprove = Color(0xFF43A047);
  static const Color strangerBlock = Color(0xFFF8C523);
  static const Color strangerReject = Color(0xFFC23041);

  /// Settings Log Out — #EB3A68
  static const Color logout = Color(0xFFEB3A68);

  /// Settings toggle active — #33C658
  static const Color toggleActive = Color(0xFF33C658);

  /// Progress track: #000 @ 8%
  static const Color progressTrack = Color(0x14000000);

  /// Disabled primary button fill
  static const Color buttonDisabled = Color(0xFFD4C9F5);

  /// Suggestion chip fill: #998FED @ 10%
  static const Color suggestionChipFill = Color(0x1A998FED);

  /// "Might want to try..." — #000 @ 30%
  static const Color textHintMuted = Color(0x4D000000);

  /// Selection border — #7B2FFF
  static const Color selectionBorder = Color(0xFF7B2FFF);
  static const Color selectionBorderIdle = Color(0xFFE8E8E8);

  /// Shared success banner — #F8C523 @ 10% on white (= #FEF9E8)
  static const Color sharedSuccessStrip = Color(0xFFFEF9E8);

  /// Bottom sheet option muted fill — #F4F4F9
  static const Color sheetMuted = Color(0xFFF4F4F9);

  /// Edit sheet input fill — #83A0B4 @ 10%
  static const Color editSheetInputFill = Color(0x1A83A0B4);

  /// Edit sheet input border — #83A0B4 @ 20%
  static const Color editSheetInputBorder = Color(0x3383A0B4);

  /// Edit sheet primary action — #1A1714
  static const Color editSheetButton = Color(0xFF1A1714);

  /// Drag handle — #D9D9D9
  static const Color sheetHandle = Color(0xFFD9D9D9);

  /// Nav inactive / search placeholder
  static const Color navInactive = Color(0xFF7E8896);
  static const Color searchPlaceholder = Color(0xFFB9B9C6);
  static const Color navTopBorder = Color(0x267E8896); // #7E8896 @ 15%

  /// Filters section divider — #000 @ 15%
  static const Color filterDivider = Color(0x26000000);

  /// Slider inactive track
  static const Color sliderTrackIdle = Color(0xFFE8E8E8);
}
