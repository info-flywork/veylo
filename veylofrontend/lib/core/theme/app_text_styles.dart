import 'package:flutter/material.dart';
import 'package:veylo/core/theme/app_colors.dart';
import 'package:veylo/core/theme/app_fonts.dart';

/// Shared text styles — Figma tipografisi buradan kullanılır.
abstract final class AppTextStyles {
  static const TextStyle splashBrand = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 36,
    height: 40 / 36,
    letterSpacing: 36 * -0.02,
    color: AppColors.black,
  );

  /// Auth screen titles — "Create your account" / "Welcome back"
  static const TextStyle authTitle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w700,
    fontSize: 40,
    height: 48 / 40,
    letterSpacing: 40 * -0.02,
    color: AppColors.textPrimary,
  );

  /// Poppins Medium 16 / lh 20 / -2% — subtitle, labels
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 20 / 16,
    letterSpacing: 16 * -0.02,
    color: AppColors.textPrimary,
  );

  static const TextStyle authSubtitle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 20 / 16,
    letterSpacing: 16 * -0.02,
    color: AppColors.textSecondary,
  );

  static const TextStyle fieldLabel = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 20 / 16,
    letterSpacing: 16 * -0.02,
    color: AppColors.black,
  );

  static const TextStyle fieldInput = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 20 / 16,
    letterSpacing: 16 * -0.02,
    color: AppColors.textPrimary,
  );

  static const TextStyle fieldPlaceholder = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 20 / 16,
    letterSpacing: 16 * -0.02,
    color: AppColors.textPlaceholder,
  );

  static const TextStyle buttonPrimary = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 30 / 16,
    letterSpacing: 16 * -0.02,
    color: AppColors.white,
  );

  static const TextStyle buttonSocial = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 20 / 16,
    letterSpacing: 16 * -0.02,
    color: AppColors.textOnLight,
  );

  static const TextStyle buttonSocialOnDark = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 20 / 16,
    letterSpacing: 16 * -0.02,
    color: AppColors.white,
  );

  /// Forgot Password — Poppins Medium 16 / lh 20 / -2% (renk gradient)
  static const TextStyle link = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 20 / 16,
    letterSpacing: 16 * -0.02,
    color: AppColors.textLink,
  );

  /// Legal footer — Figma: SF Pro Regular 12 / lh 100% / tracking 0
  static const TextStyle legal = TextStyle(
    fontFamily: '.SF Pro Text',
    fontFamilyFallback: ['Roboto', 'sans-serif'],
    fontWeight: FontWeight.w400,
    fontSize: 12,
    height: 1,
    letterSpacing: 0,
    color: AppColors.textSecondary,
  );

  /// Legal links — Figma: SF Pro Medium (~510) 12 / lh 100% / underline
  static const TextStyle legalLink = TextStyle(
    fontFamily: '.SF Pro Text',
    fontFamilyFallback: ['Roboto', 'sans-serif'],
    fontWeight: FontWeight.w500,
    fontSize: 12,
    height: 1,
    letterSpacing: 0,
    color: AppColors.textSecondary,
    decoration: TextDecoration.underline,
    decorationColor: AppColors.textSecondary,
  );

  static const TextStyle orDivider = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 18 / 14,
    letterSpacing: 0,
    color: Color(0x80000000), // #000 @ 50%
  );

  /// Onboarding title — Poppins Bold 32 / lh 36 / -2% / #171414
  static const TextStyle onboardingTitle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w700,
    fontSize: 32,
    height: 36 / 32,
    letterSpacing: 32 * -0.02,
    color: AppColors.onboardingTitle,
  );

  /// Onboarding subtitle — Poppins Medium 18 / lh 24 / -2% / #171414 @ 45%
  static const TextStyle onboardingSubtitle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 18,
    height: 24 / 18,
    letterSpacing: 18 * -0.02,
    color: AppColors.onboardingSubtitle,
  );

  /// Skip — Poppins Medium 16 / lh 24 / -2% / #000
  static const TextStyle onboardingSkip = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 24 / 16,
    letterSpacing: 16 * -0.02,
    color: AppColors.black,
  );

  /// "Already have a Veylo account?" — Poppins SemiBold 16 / lh 20 / -2% / #636363
  static const TextStyle accountPrompt = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 20 / 16,
    letterSpacing: 16 * -0.02,
    color: AppColors.accountPrompt,
  );

  static const TextStyle accountPromptAction = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 20 / 16,
    letterSpacing: 16 * -0.02,
    color: AppColors.linkGradientStart,
  );

  /// Create Profile nav title — Poppins Medium 16 / lh 24 / #000 @ 65%
  static const TextStyle createProfileNav = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 24 / 16,
    letterSpacing: 16 * -0.02,
    color: AppColors.textSecondary,
  );

  /// "1/5 Username" — Poppins Bold 16 / lh 24
  static const TextStyle createProfileStep = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w700,
    fontSize: 16,
    height: 24 / 16,
    letterSpacing: 16 * -0.02,
    color: AppColors.textPrimary,
  );

  /// "Create your profile" — Poppins Bold 36 / lh 48 / #1A1714
  static const TextStyle createProfileTitle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w700,
    fontSize: 36,
    height: 48 / 36,
    letterSpacing: 36 * -0.02,
    color: AppColors.textOnLight,
  );

  /// Gender / Interests heading — Poppins Bold 40 / lh 48
  static const TextStyle createProfileHeading = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w700,
    fontSize: 40,
    height: 48 / 40,
    letterSpacing: 40 * -0.02,
    color: AppColors.textOnLight,
  );

  /// Preparing profiles title — Poppins Bold 28 / lh 32 / -2%
  static const TextStyle preparingTitle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w700,
    fontSize: 28,
    height: 32 / 28,
    letterSpacing: 28 * -0.02,
    color: AppColors.textPrimary,
  );

  /// Preparing profiles subtitle — Poppins Medium 16 / lh 100% / -2% / #000@65%
  static const TextStyle preparingSubtitle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 1,
    letterSpacing: 16 * -0.02,
    color: Color(0xA6000000),
  );

  /// Preparing profiles percent — Poppins Medium 14
  static const TextStyle preparingPercent = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 14 * -0.02,
    color: AppColors.textPrimary,
  );

  /// Discover page title — Poppins SemiBold 32 / lh 36 / -2% / #1A1714
  static const TextStyle discoverTitle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 32,
    height: 36 / 32,
    letterSpacing: 32 * -0.02,
    color: AppColors.textOnLight,
  );

  /// Profile eyebrow — Poppins SemiBold 16 / lh 20 / #7E8896
  static const TextStyle profileEyebrow = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 20 / 16,
    color: Color(0xFF7E8896),
  );

  /// Profile Settings title — Poppins SemiBold 32 / lh 32
  static const TextStyle profileTitle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 32,
    height: 1,
    color: AppColors.textPrimary,
  );

  /// Follow page title — Poppins SemiBold 32 / lh 36 / -2% / #1A1714
  static const TextStyle followPageTitle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 32,
    height: 36 / 32,
    letterSpacing: 32 * -0.02,
    color: AppColors.textOnLight,
  );

  /// Follow search placeholder — Poppins Regular 16 / lh 20 / -2% / #000@40%
  static const TextStyle followSearchHint = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 20 / 16,
    letterSpacing: 16 * -0.02,
    color: Color(0x66000000),
  );

  /// Follow search input — Poppins Regular 16 / lh 20 / -2%
  static const TextStyle followSearchInput = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 20 / 16,
    letterSpacing: 16 * -0.02,
    color: AppColors.textOnLight,
  );

  /// Follow tab inactive — Medium 16 / #1A1714@50%
  static const TextStyle followTabInactive = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 1,
    letterSpacing: 16 * -0.02,
    color: Color(0x801A1714),
  );

  /// Follow tab active — Medium 16 / #7B2FFF
  static const TextStyle followTabActive = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 1,
    letterSpacing: 16 * -0.02,
    color: Color(0xFF7B2FFF),
  );

  /// Follow list name — Poppins SemiBold 16 / #1A1714
  static const TextStyle followListName = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 20 / 16,
    letterSpacing: 16 * -0.02,
    color: AppColors.textOnLight,
  );

  /// Follow Unfollow CTA — Poppins Medium 16 / white
  static const TextStyle followUnfollow = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 1,
    color: AppColors.white,
  );

  /// Profile token count — Poppins SemiBold 14 / #7B2FFF
  static const TextStyle profileTokenCount = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 14,
    height: 36 / 14,
    color: Color(0xFF7B2FFF),
  );

  /// Profile name — Poppins SemiBold 20
  static const TextStyle profileName = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 20,
    height: 1,
    color: AppColors.textPrimary,
  );

  /// Profile @username — Poppins Medium 14 / #7E8896
  static const TextStyle profileUsername = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 18 / 14,
    color: Color(0xFF7E8896),
  );

  /// Profile stat label — Poppins Medium 14 / lh 18 / #000
  static const TextStyle profileStatLabel = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 18 / 14,
    color: AppColors.textPrimary,
  );

  /// Profile stat value — Poppins SemiBold 20 / lh 20 / #000
  static const TextStyle profileStatValue = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 20,
    height: 1,
    color: AppColors.textPrimary,
  );

  /// Profile bio — Poppins Medium 16 / lh 20 / #7E8896
  static const TextStyle profileBio = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 20 / 16,
    color: Color(0xFF7E8896),
  );

  /// Profile edit button — Poppins Medium 16 / white
  static const TextStyle profileEditButton = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 20 / 16,
    color: AppColors.white,
  );

  /// Profile promo title — Poppins SemiBold 20 / white / -1.5%
  static const TextStyle profilePromoTitle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 20,
    height: 1,
    letterSpacing: 20 * -0.015,
    color: AppColors.white,
  );

  /// Profile promo subtitle — Poppins Medium 14 / lh 18 / white@65%
  static const TextStyle profilePromoSubtitle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 18 / 14,
    letterSpacing: 14 * -0.015,
    color: Color(0xA6FFFFFF),
  );

  /// Profile Stand Out CTA — Poppins SemiBold 16 / lh 30 / -2%
  static const TextStyle profileStandOut = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 30 / 16,
    letterSpacing: 16 * -0.02,
    color: AppColors.white,
  );

  /// Profile content tab idle — Poppins Medium 16 / #1A1714@50%
  static const TextStyle profileTabIdle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 1,
    letterSpacing: 16 * -0.02,
    color: Color(0x801A1714),
  );

  /// Profile content tab active — Poppins Medium 16 / #7B2FFF
  static const TextStyle profileTabActive = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 1,
    letterSpacing: 16 * -0.02,
    color: Color(0xFF7B2FFF),
  );

  /// Edit Profile section label — Poppins SemiBold 20 / lh 32
  static const TextStyle editProfileSection = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 20,
    height: 32 / 20,
    color: AppColors.textPrimary,
  );

  /// Edit Profile Save — Poppins SemiBold 14 / white
  static const TextStyle editProfileSave = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 14,
    height: 18 / 14,
    color: AppColors.white,
  );

  /// Edit Profile Change Border label — Poppins Medium 12 / #7E8896
  static const TextStyle editProfileChangeBorder = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 12,
    height: 14 / 12,
    color: Color(0xFF7E8896),
  );

  /// Edit Profile interest body — Poppins Medium 16 / lh 20 / #7E8896
  static const TextStyle editProfileInterest = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 20 / 16,
    color: Color(0xFF7E8896),
  );

  /// Edit Profile field value — Poppins Medium 16 / lh 20 / #7E8896
  static const TextStyle editProfileField = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 20 / 16,
    color: Color(0xFF7E8896),
  );

  /// Edit Profile field trailing value — Poppins Medium 16 / lh 20 / #7E8896
  static const TextStyle editProfileFieldValue = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 20 / 16,
    color: Color(0xFF7E8896),
  );

  /// Profile border sheet title — Poppins SemiBold 20 / -2%
  static const TextStyle profileBorderTitle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 20,
    height: 1,
    letterSpacing: 20 * -0.02,
    color: AppColors.textPrimary,
  );

  /// Profile border subtitle — Poppins Medium 14 / lh 20 / -2% / #000@65%
  static const TextStyle profileBorderSubtitle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 14 * -0.02,
    color: Color(0xA6000000),
  );

  /// Profile border section — Poppins Medium 14 / lh 20 / -2%
  static const TextStyle profileBorderSection = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 14 * -0.02,
    color: AppColors.textPrimary,
  );

  /// Profile border card name — Poppins Medium 12 / lh 16 / -2%
  static const TextStyle profileBorderName = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 12,
    height: 16 / 12,
    letterSpacing: 12 * -0.02,
    color: AppColors.textPrimary,
  );

  /// Profile border card price — Poppins Medium 13 / lh 16 / -2% / #000@65%
  static const TextStyle profileBorderPrice = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 13,
    height: 16 / 13,
    letterSpacing: 13 * -0.02,
    color: Color(0xA6000000),
  );

  /// Share profile title — Poppins SemiBold 20
  static const TextStyle shareProfileTitle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 20,
    height: 30 / 20,
    color: AppColors.textPrimary,
  );

  /// Share profile subtitle — Poppins Regular 16 / lh 20 / -2% / #1A1714@65%
  static const TextStyle shareProfileSubtitle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 20 / 16,
    letterSpacing: 16 * -0.02,
    color: Color(0xA61A1714),
  );

  /// Share profile field label — Poppins SemiBold 14 / -2%
  static const TextStyle shareProfileLabel = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 14,
    height: 1,
    letterSpacing: 14 * -0.02,
    color: AppColors.textPrimary,
  );

  /// Share profile link — Poppins Medium 14 / -2%
  static const TextStyle shareProfileLink = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 1,
    letterSpacing: 14 * -0.02,
    color: AppColors.textPrimary,
  );

  /// Edit Profile counter — Figma Open Runde Medium 14 / lh 20 / #7E8896
  /// (projede Open Runde yok → Poppins Medium)
  static const TextStyle editProfileCounter = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 0,
    color: Color(0xFF7E8896),
  );

  /// Chats — Messages bölüm başlığı — Poppins Medium 24 / lh 28
  static const TextStyle chatsSectionTitle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 24,
    height: 28 / 24,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  /// Chats — Request link — Poppins Medium 14 / #1A1714@65%
  static const TextStyle chatsRequestLink = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 1,
    letterSpacing: 14 * -0.02,
    color: Color(0xA61A1714),
  );

  /// Request empty title — Poppins Medium 24 / lh 28 / -2% / #000
  static const TextStyle requestEmptyTitle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 24,
    height: 28 / 24,
    letterSpacing: 24 * -0.02,
    color: AppColors.black,
  );

  /// Request empty subtitle — Poppins Regular 16 / lh 20 / -2% / #1A1714@65%
  static const TextStyle requestEmptySubtitle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 20 / 16,
    letterSpacing: 16 * -0.02,
    color: AppColors.textSecondary,
  );

  /// Request nav title — Poppins SemiBold 16 / #000
  static const TextStyle requestNavTitle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 24 / 16,
    letterSpacing: 16 * -0.02,
    color: AppColors.black,
  );

  /// Chats note isim — Poppins Medium 16
  static const TextStyle chatsNoteName = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 16 / 16,
    color: AppColors.textPrimary,
  );

  /// Chats note durum — Poppins Medium 16 / bold görünüm için w600
  static const TextStyle chatsNoteStatus = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 16 / 16,
    color: AppColors.textPrimary,
  );

  /// Chats liste isim — Poppins SemiBold 16 / Deep Roast
  static const TextStyle chatsThreadName = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 16 / 16,
    letterSpacing: 16 * -0.02,
    color: AppColors.textOnLight,
  );

  /// Chats liste önizleme — Poppins Regular 16 / lh 20 / -2% / #1A1714 @ 65%
  static const TextStyle chatsThreadPreview = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 20 / 16,
    letterSpacing: 16 * -0.02,
    color: AppColors.textSecondary,
  );

  /// Chats liste saat — Poppins Regular 12 / #000@65%
  static const TextStyle chatsThreadTime = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    height: 16 / 12,
    color: Color(0xA6000000),
  );

  static const TextStyle discoverTabActive = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 20 / 16,
    letterSpacing: 16 * -0.02,
    color: AppColors.selectionBorder,
  );

  static const TextStyle discoverTabIdle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 20 / 16,
    letterSpacing: 16 * -0.02,
    color: AppColors.navInactive,
  );

  static const TextStyle discoverSearchHint = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 20 / 16,
    letterSpacing: 16 * -0.02,
    color: AppColors.searchPlaceholder,
  );

  /// Shared success message — Poppins Medium 14 / lh 20 / -2% / #000
  static const TextStyle sharedSuccessMessage = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 14 * -0.02,
    color: Color(0xFF000000),
  );

  /// Shared success "Öne Çıkar" — Poppins Medium 14 / lh 20 / -2% / #7B2FFF
  static const TextStyle sharedSuccessBoost = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 14 * -0.02,
    color: Color(0xFF7B2FFF),
  );

  /// Room card title — Poppins SemiBold 24 / lh 36 / -2%
  static const TextStyle roomCardTitle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 24,
    height: 36 / 24,
    letterSpacing: 24 * -0.02,
    color: AppColors.black,
  );

  /// Room card subtitle — Poppins Medium 16 / lh 20 / -2% / #000@65%
  static const TextStyle roomCardSubtitle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 20 / 16,
    letterSpacing: 16 * -0.02,
    color: Color(0xA6000000),
  );

  /// Live badge — Poppins SemiBold 14
  static const TextStyle roomLiveBadge = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 14 * -0.02,
    color: AppColors.black,
  );

  /// +12 more — Poppins SemiBold 14 / #000@65%
  static const TextStyle roomMoreCount = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 14 * -0.02,
    color: Color(0xA6000000),
  );

  /// Join button — Poppins SemiBold 16 / white
  static const TextStyle roomJoin = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 20 / 16,
    letterSpacing: 16 * -0.02,
    color: AppColors.white,
  );

  /// All Rooms / All Groups section — Poppins SemiBold 16 / lh 20 / -2%
  static const TextStyle roomsSectionTitle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 20 / 16,
    letterSpacing: 16 * -0.02,
    color: AppColors.black,
  );

  /// See All — Poppins SemiBold 16 / lh 20 / #7B2FFF
  static const TextStyle roomsSeeAll = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 20 / 16,
    letterSpacing: 16 * -0.02,
    color: AppColors.selectionBorder,
  );

  /// All Rooms list title — Poppins SemiBold 16 / lh 20 / -2%
  static const TextStyle allRoomTitle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 20 / 16,
    letterSpacing: 16 * -0.02,
    color: AppColors.black,
  );

  /// All Rooms list subtitle — Poppins Medium 14 / lh 18 / -2% / #000@65%
  static const TextStyle allRoomSubtitle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 18 / 14,
    letterSpacing: 14 * -0.02,
    color: Color(0xA6000000),
  );

  /// Private badge — Poppins Medium 11 / lh 14 / white
  static const TextStyle allRoomPrivateBadge = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 11,
    height: 14 / 11,
    letterSpacing: 11 * -0.02,
    color: AppColors.white,
  );

  /// Join / Request small button — Poppins SemiBold 14
  static const TextStyle allRoomAction = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 14 * -0.02,
    color: AppColors.white,
  );

  /// Private room sheet subtitle — Poppins Regular 16 / lh 24 / #1A1714@65%
  static const TextStyle privateRoomSubtitle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 24 / 16,
    letterSpacing: 16 * -0.02,
    color: Color(0xA61A1714),
  );

  /// Token row label — Poppins Medium 16
  static const TextStyle privateRoomRowLabel = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 1,
    letterSpacing: 16 * -0.02,
    color: AppColors.black,
  );

  /// Token amount — Poppins SemiBold 16 / #7B2FFF
  static const TextStyle privateRoomTokenAmount = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 1,
    letterSpacing: 16 * -0.02,
    color: AppColors.selectionBorder,
  );

  /// Cancel under primary — Poppins SemiBold 16 / #000@65%
  static const TextStyle privateRoomCancel = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 30 / 16,
    letterSpacing: 16 * -0.02,
    color: Color(0xA6000000),
  );

  /// Private request room info — Poppins Regular 20 / lh 24 / #1A1714@65%
  static const TextStyle privateRequestRoomInfo = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w400,
    fontSize: 20,
    height: 24 / 20,
    letterSpacing: 20 * -0.02,
    color: Color(0xA61A1714),
  );

  /// Optional message hint — Poppins Medium 16 / lh 20 / #000@30%
  static const TextStyle privateRequestInput = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 20 / 16,
    letterSpacing: 16 * -0.02,
    color: Color(0x4D000000),
  );

  /// Admin review footer — Poppins SemiBold 14 / lh 30 / #000@65%
  static const TextStyle privateRequestFooter = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 14,
    height: 30 / 14,
    letterSpacing: 14 * -0.02,
    color: Color(0xA6000000),
  );

  /// Room approved subtitle — Poppins Regular 16 / lh 24 / #1A1714@65%
  static const TextStyle roomApprovedSubtitle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 24 / 16,
    letterSpacing: 16 * -0.02,
    color: Color(0xA61A1714),
  );

  /// Create Room/Group subtitle — Poppins Regular 20 / lh 24 / #1A1714@65%
  static const TextStyle createSpaceSubtitle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w400,
    fontSize: 20,
    height: 24 / 20,
    letterSpacing: 20 * -0.02,
    color: Color(0xA61A1714),
  );

  /// Create option label — Poppins Medium 16
  static const TextStyle createSpaceOption = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 1,
    letterSpacing: 16 * -0.02,
    color: AppColors.black,
  );

  /// Live room title — Poppins SemiBold 16
  static const TextStyle liveRoomTitle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 1,
    letterSpacing: 16 * -0.02,
    color: AppColors.black,
  );

  /// Live room member name — Poppins SemiBold 16 / lh 20
  static const TextStyle liveRoomMemberName = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 20 / 16,
    letterSpacing: 16 * -0.02,
    color: AppColors.black,
  );

  /// Live room (Admin) suffix — Poppins SemiBold 16 / purple
  static const TextStyle liveRoomAdminSuffix = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 20 / 16,
    letterSpacing: 16 * -0.02,
    color: AppColors.selectionBorder,
  );

  /// Live room chat sender — Poppins Medium 14 / lh 20 / muted
  static const TextStyle liveRoomChatName = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 14 * -0.02,
    color: Color(0xA6000000),
  );

  /// Live room chat body — Poppins Medium 14 / lh 20
  static const TextStyle liveRoomChatBody = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 14 * -0.02,
    color: AppColors.black,
  );

  /// Live room quick reply — Poppins Medium 14 / purple
  static const TextStyle liveRoomQuickReply = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 18 / 14,
    letterSpacing: 14 * -0.02,
    color: AppColors.selectionBorder,
  );

  /// Live room message hint — Poppins Regular 16 / lh 18 / #1A1714
  static const TextStyle liveRoomMessageHint = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 18 / 16,
    letterSpacing: 16 * -0.02,
    color: AppColors.textOnLight,
  );

  /// Group chat title — Poppins Medium 16 / lh 24 / -2%
  static const TextStyle groupChatTitle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 24 / 16,
    letterSpacing: 16 * -0.02,
    color: AppColors.black,
  );

  /// Group chat users count — Poppins Medium 14 / lh 18 / -2% / #000@65%
  static const TextStyle groupChatUsers = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 18 / 14,
    letterSpacing: 14 * -0.02,
    color: Color(0xA6000000),
  );

  /// Group chat sender name — Poppins Medium 16 / #7B2FFF
  static const TextStyle groupChatSender = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 20 / 16,
    letterSpacing: 16 * -0.02,
    color: AppColors.selectionBorder,
  );

  /// Group chat incoming body — Poppins Medium 16
  static const TextStyle groupChatBody = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 20 / 16,
    letterSpacing: 16 * -0.02,
    color: AppColors.black,
  );

  /// Group chat own body — Poppins Medium 16 / white
  static const TextStyle groupChatOwnBody = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 20 / 16,
    letterSpacing: 16 * -0.02,
    color: AppColors.white,
  );

  /// Group info page title — Poppins SemiBold 24 / lh 32 / -2%
  static const TextStyle groupInfoTitle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 24,
    height: 32 / 24,
    letterSpacing: 24 * -0.02,
    color: AppColors.black,
  );

  /// Group info section label — Poppins Medium 14 / #1A1714@65%
  static const TextStyle groupInfoSection = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 1,
    letterSpacing: 14 * -0.02,
    color: Color(0xA61A1714),
  );

  /// Group info row label — Poppins Medium 16 / #1A1714
  static const TextStyle groupInfoRow = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 1,
    letterSpacing: 16 * -0.02,
    color: AppColors.textOnLight,
  );

  /// Group info add people — Poppins SemiBold 16
  static const TextStyle groupInfoAddPeople = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 1,
    letterSpacing: 16 * -0.02,
    color: AppColors.black,
  );

  /// Group info member name — Poppins SemiBold 16
  static const TextStyle groupInfoMemberName = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 1,
    letterSpacing: 16 * -0.02,
    color: AppColors.black,
  );

  /// Group info admin / muted — Poppins Medium 14 / #1A1714@65%
  static const TextStyle groupInfoMemberRole = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 1,
    letterSpacing: 14 * -0.02,
    color: Color(0xA61A1714),
  );

  /// Group info leave — Poppins Medium 16 / error
  static const TextStyle groupInfoLeave = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 1,
    letterSpacing: 16 * -0.02,
    color: AppColors.error,
  );

  /// AI Match feeling title — Poppins Medium 16
  static const TextStyle aiMatchFeelingTitle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 1,
    letterSpacing: 16 * -0.02,
    color: AppColors.black,
  );

  /// AI Match feeling subtitle — Poppins Regular 14 / #000@65%
  static const TextStyle aiMatchFeelingSubtitle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 1,
    letterSpacing: 14 * -0.02,
    color: Color(0xA6000000),
  );

  /// AI Match mood label — Poppins Medium 18
  static const TextStyle aiMatchMoodLabel = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 18,
    height: 1,
    letterSpacing: 18 * -0.02,
    color: AppColors.black,
  );

  /// AI Match looking title — Poppins Medium 16
  static const TextStyle aiMatchLookingTitle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 1,
    letterSpacing: 16 * -0.02,
    color: AppColors.black,
  );

  /// AI Match chip — Poppins Medium 14
  static const TextStyle aiMatchChip = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 1,
    letterSpacing: 14 * -0.02,
    color: AppColors.textOnLight,
  );

  /// AI Match chip selected — purple
  static const TextStyle aiMatchChipSelected = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 1,
    letterSpacing: 14 * -0.02,
    color: AppColors.selectionBorder,
  );

  /// AI Match stat value — Poppins SemiBold 18 / lh 22
  static const TextStyle aiMatchStatValue = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 18,
    height: 22 / 18,
    letterSpacing: 18 * -0.02,
    color: AppColors.black,
  );

  /// AI Match stat label — Poppins Medium 16 / lh 20 / #000@40%
  static const TextStyle aiMatchStatLabel = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 20 / 16,
    letterSpacing: 16 * -0.02,
    color: Color(0x66000000),
  );

  /// AI Match CTA — Poppins SemiBold 16 / white
  static const TextStyle aiMatchCta = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 30 / 16,
    letterSpacing: 16 * -0.02,
    color: AppColors.white,
  );

  /// Finding match step (done) — Poppins Medium 14
  static const TextStyle aiMatchFindingStepDone = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 1,
    color: AppColors.textPrimary,
  );

  /// Finding match step (active) — Poppins Medium 14 / muted
  static const TextStyle aiMatchFindingStepActive = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 1,
    color: Color(0x66000000),
  );

  /// Finding match step (pending) — Poppins Medium 14
  static const TextStyle aiMatchFindingStepPending = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 1,
    color: AppColors.textPrimary,
  );

  /// Finding match online footer — Poppins SemiBold 16 / lh 20 / #000@35%
  static const TextStyle aiMatchFindingOnline = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 20 / 16,
    letterSpacing: 0,
    color: Color(0x59000000),
  );

  /// Your Match title — Poppins SemiBold 32 / lh 32 / -2%
  static const TextStyle yourMatchTitle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 32,
    height: 1,
    letterSpacing: 32 * -0.02,
    color: AppColors.textPrimary,
  );

  /// Your Match subtitle — Poppins Medium 14 / lh 16 / #000@65%
  static const TextStyle yourMatchSubtitle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 16 / 14,
    letterSpacing: 0,
    color: Color(0xA6000000),
  );

  /// Vibe match pill — Poppins SemiBold 14 / lh 18 / #34C759
  static const TextStyle yourMatchVibe = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 14,
    height: 18 / 14,
    letterSpacing: 0,
    color: Color(0xFF34C759),
  );

  /// Match name — Poppins Bold 28 / white
  static const TextStyle yourMatchName = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w700,
    fontSize: 28,
    height: 1.1,
    letterSpacing: 28 * -0.02,
    color: AppColors.white,
  );

  /// Match bio — Poppins Regular 14 / white@90%
  static const TextStyle yourMatchBio = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 18 / 14,
    color: Color(0xE6FFFFFF),
  );

  static const TextStyle discoverCardUsername = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 12,
    height: 16 / 12,
    color: AppColors.white,
  );

  static const TextStyle navLabelActive = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 20 / 14,
    color: AppColors.selectionBorder,
  );

  static const TextStyle navLabelIdle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 20 / 14,
    color: AppColors.navInactive,
  );

  static const TextStyle navCallLabel = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 20 / 14,
    color: AppColors.white,
  );

  static const TextStyle optionTile = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 20 / 16,
    letterSpacing: 16 * -0.02,
    color: AppColors.textSecondary,
  );

  /// Seçili option — Poppins Bold 16 / lh 20 / -2% / #7B2FFF (border ile aynı)
  static const TextStyle optionTileSelected = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w700,
    fontSize: 16,
    height: 20 / 16,
    letterSpacing: 16 * -0.02,
    color: AppColors.selectionBorder,
  );

  /// Interest chip — Poppins Medium 16 / lh 20 / -2% / #000 @ 40%
  static const TextStyle interestChip = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 20 / 16,
    letterSpacing: 16 * -0.02,
    color: Color(0x66000000),
  );

  static const TextStyle interestChipSelected = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w700,
    fontSize: 16,
    height: 20 / 16,
    letterSpacing: 16 * -0.02,
    color: AppColors.selectionBorder,
  );

  static const TextStyle fieldError = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 18 / 14,
    letterSpacing: 14 * -0.02,
    color: AppColors.error,
  );

  static const TextStyle fieldSuccess = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 18 / 14,
    letterSpacing: 14 * -0.02,
    color: AppColors.success,
  );

  static const TextStyle suggestionHint = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 18 / 14,
    letterSpacing: 14 * -0.02,
    color: AppColors.textHintMuted,
  );

  /// Suggestion chip — Poppins Medium 14 / lh 18 / -2% / #1A1714 @ 65%
  static const TextStyle suggestionChip = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 18 / 14,
    letterSpacing: 14 * -0.02,
    color: AppColors.textSecondary,
  );

  /// "Choose a photo" link — Poppins SemiBold 16 / lh 20 / #7B2FFF
  static const TextStyle choosePhotoLink = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 20 / 16,
    letterSpacing: 16 * -0.02,
    color: AppColors.selectionBorder,
  );

  /// Bottom sheet title — Poppins Bold 20
  static const TextStyle bottomSheetTitle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w700,
    fontSize: 20,
    height: 1,
    letterSpacing: 20 * -0.02,
    color: AppColors.black,
  );

  /// Filters title — Poppins SemiBold 20 / lh 100% / -2%
  static const TextStyle filtersTitle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 20,
    height: 1,
    letterSpacing: 20 * -0.02,
    color: AppColors.black,
  );

  /// Filters section label — Poppins SemiBold 16
  static const TextStyle filtersSectionLabel = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 1,
    letterSpacing: 16 * -0.02,
    color: AppColors.black,
  );

  /// Filters value (18-35, 25 km) — Poppins SemiBold 16
  static const TextStyle filtersValue = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 1,
    letterSpacing: 16 * -0.02,
    color: AppColors.black,
  );

  /// Filters active-now subtitle — Poppins Medium 16 / #000@30%
  static const TextStyle filtersSubtitle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 1,
    letterSpacing: 16 * -0.02,
    color: AppColors.textHintMuted,
  );

  /// Show me chip — unselected
  static const TextStyle filtersChip = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 18 / 14,
    letterSpacing: 14 * -0.02,
    color: AppColors.textSecondary,
  );

  /// Show me chip — selected (#7B2FFF)
  static const TextStyle filtersChipSelected = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w700,
    fontSize: 16,
    height: 20 / 16,
    letterSpacing: 16 * -0.02,
    color: AppColors.selectionBorder,
  );

  /// Post detail username — Poppins SemiBold 16 / lh 20 / -2% / white
  static const TextStyle postUsername = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 20 / 16,
    letterSpacing: 16 * -0.02,
    color: AppColors.white,
  );

  /// Post follow button — Poppins Medium 14 / white
  static const TextStyle postFollow = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 18 / 14,
    letterSpacing: 14 * -0.02,
    color: AppColors.white,
  );

  /// Post caption — Poppins Medium 14 / white @ 85%
  static const TextStyle postCaption = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 1,
    letterSpacing: 14 * -0.02,
    color: Color(0xD9FFFFFF),
  );

  /// Add comment hint on post — Poppins Regular 14 / lh 20 / white
  static const TextStyle postCommentHint = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 14 * -0.02,
    color: AppColors.white,
  );

  /// Comments sheet title — Poppins SemiBold 16
  static const TextStyle commentsTitle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 1,
    letterSpacing: 16 * -0.02,
    color: AppColors.black,
  );

  /// Comment username — Poppins SemiBold 14 / lh 20 / -2%
  static const TextStyle commentUsername = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 14 * -0.02,
    color: Color(0xFF000001),
  );

  /// Comment time — Poppins Regular 12 / muted
  static const TextStyle commentTime = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    height: 16 / 12,
    color: AppColors.navInactive,
  );

  /// Comment body — Poppins SemiBold 14 / lh 20
  static const TextStyle commentBody = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 14 * -0.02,
    color: Color(0xFF000001),
  );

  /// Add comment hint — Poppins Medium 14 / #000@30%
  static const TextStyle commentInputHint = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 14 * -0.02,
    color: AppColors.textHintMuted,
  );

  /// Story mode idle — Poppins Medium 16 / white @ 45%
  static const TextStyle storyModeIdle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 1,
    letterSpacing: 16 * -0.02,
    color: Color(0x73FFFFFF),
  );

  /// Story mode active — Poppins Medium 16 / white
  static const TextStyle storyModeActive = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 1,
    letterSpacing: 16 * -0.02,
    color: AppColors.white,
  );

  /// Story share button — Poppins SemiBold 16 / white
  static const TextStyle storyShare = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 20 / 16,
    letterSpacing: 16 * -0.02,
    color: AppColors.white,
  );

  /// Vibes isim — Poppins SemiBold 16 / lh 16 / -2% / #1A1714
  static const TextStyle vibesName = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 16 / 16,
    letterSpacing: 16 * -0.02,
    color: AppColors.textOnLight,
  );

  /// Vibes alıntı — Poppins Medium 16 / lh 20 / -2% / #000 @ 65%
  static const TextStyle vibesQuote = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 20 / 16,
    letterSpacing: 16 * -0.02,
    color: Color(0xA6000000),
  );

  /// Vibes beğeni / mesaj / tarih — Poppins Medium 16 / lh 20 / -2% / #000 @ 45%
  static const TextStyle vibesMeta = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 20 / 16,
    letterSpacing: 16 * -0.02,
    color: Color(0x73000000),
  );

  /// Vibes tarih — Poppins Regular 12 / -2% / #000 @ 45%
  static const TextStyle vibesDate = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    height: 16 / 12,
    letterSpacing: 12 * -0.02,
    color: Color(0x73000000),
  );

  /// Vibes arama — Poppins Regular 16 / lh 20 / -2% / #000 @ 40%
  static const TextStyle vibesSearch = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 20 / 16,
    letterSpacing: 16 * -0.02,
    color: Color(0x66000000),
  );

  /// Bottom sheet row label — Poppins SemiBold 16 / lh 20 / #1A1714
  static const TextStyle bottomSheetOption = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 20 / 16,
    letterSpacing: 16 * -0.02,
    color: AppColors.textOnLight,
  );

  /// Edit sheet title — Poppins SemiBold 24 / -2%
  static const TextStyle editSheetTitle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 24,
    height: 1,
    letterSpacing: 24 * -0.02,
    color: AppColors.textPrimary,
  );

  /// Edit sheet field label — Poppins Medium 14 / -2% / #000
  static const TextStyle editSheetFieldLabel = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 1,
    letterSpacing: 14 * -0.02,
    color: AppColors.black,
  );

  /// Edit sheet Save — Poppins SemiBold 16 / -2% / white
  static const TextStyle editSheetSave = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 1,
    letterSpacing: 16 * -0.02,
    color: AppColors.white,
  );

  /// Edit sheet text input — Poppins Medium 16 / lh 20 / -2%
  static const TextStyle editSheetInput = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 20 / 16,
    letterSpacing: 16 * -0.02,
    color: AppColors.textPrimary,
  );

  /// Edit sheet input hint — Poppins Medium 16 / lh 20 / -2% / #000@30%
  static const TextStyle editSheetInputHint = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 20 / 16,
    letterSpacing: 16 * -0.02,
    color: AppColors.textHintMuted,
  );

  /// Edit sheet option selected — Poppins Medium 20
  static const TextStyle editSheetOptionSelected = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 20,
    height: 1,
    color: AppColors.textPrimary,
  );

  /// Edit sheet option idle — Poppins Medium 20 / #000@25%
  static const TextStyle editSheetOptionIdle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 20,
    height: 1,
    color: Color(0x40000000),
  );

  /// Call Stranger title — Poppins SemiBold 32 / lh 36 / -2%
  static const TextStyle callStrangerTitle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 32,
    height: 36 / 32,
    letterSpacing: 32 * -0.02,
    color: AppColors.textPrimary,
  );

  /// Call Stranger subtitle — Poppins Medium 20 / lh 24 / -2% / #000@65%
  static const TextStyle callStrangerSubtitle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 20,
    height: 24 / 20,
    letterSpacing: 20 * -0.02,
    color: Color(0xA6000000),
  );

  /// Call gender chip idle — Poppins Medium 16 / lh 20 / -2% / #000@40%
  static const TextStyle callGenderIdle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 20 / 16,
    letterSpacing: 16 * -0.02,
    color: Color(0x66000000),
  );

  /// Call gender chip selected — Poppins Medium 16 / lh 20 / -2% / #7B2FFF
  static const TextStyle callGenderSelected = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 20 / 16,
    letterSpacing: 16 * -0.02,
    color: AppColors.selectionBorder,
  );

  /// Call primary CTA — Poppins SemiBold 16 / white / -2%
  static const TextStyle callStrangerCta = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 1,
    letterSpacing: 16 * -0.02,
    color: AppColors.white,
  );

  /// Anonymous call badge — Poppins Bold 14 / lh 24 / -2% / #7B2FFF
  static const TextStyle callAnonymousBadge = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w700,
    fontSize: 14,
    height: 24 / 14,
    letterSpacing: 14 * -0.02,
    color: AppColors.selectionBorder,
  );

  /// Call stranger name — Poppins Medium 20 / lh 24 / -2% / #000@65%
  static const TextStyle callInCallName = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 20,
    height: 24 / 20,
    letterSpacing: 20 * -0.02,
    color: Color(0xA6000000),
  );

  /// Call timer — Poppins SemiBold 36 / lh 40 / -2%
  static const TextStyle callInCallTimer = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 36,
    height: 40 / 36,
    letterSpacing: 36 * -0.02,
    color: AppColors.textPrimary,
  );

  /// Time's up End Call — Poppins SemiBold 16 / lh 30 / -2% / #000@65%
  static const TextStyle callEndCall = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 30 / 16,
    letterSpacing: 16 * -0.02,
    color: Color(0xA6000000),
  );

  /// Waiting status — Poppins SemiBold 14 / lh 18 / -2% / #000@35%
  static const TextStyle callWaiting = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 14,
    height: 18 / 14,
    letterSpacing: 14 * -0.02,
    color: Color(0x59000000),
  );
}
