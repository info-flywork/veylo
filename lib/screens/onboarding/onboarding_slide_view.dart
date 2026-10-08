import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_account_prompt.dart';
import 'package:veylo/core/widgets/app_page_indicator.dart';
import 'package:veylo/core/widgets/app_primary_button.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/screens/onboarding/onboarding_slide.dart';

/// Ortak onboarding splash layout.
class OnboardingSlideView extends StatelessWidget {
  const OnboardingSlideView({
    super.key,
    required this.slide,
    required this.pageIndex,
    required this.pageCount,
    this.onGetStarted,
    this.onLogin,
  });

  final OnboardingSlide slide;
  final int pageIndex;
  final int pageCount;
  final VoidCallback? onGetStarted;
  final VoidCallback? onLogin;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final screenWidth = MediaQuery.sizeOf(context).width;
    // Page 2: 3 satır subtitle — üst boşluğu biraz sıkıştırıp kafanın kesilmesini önle
    final isPage2 = pageIndex == 1;
    final isPage3 = pageIndex == 2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenHorizontal,
              ),
              child: Column(
                children: [
                  // Skip ↔ başlık: page3=10, page2=0, diğer=18
                  SizedBox(
                    height: isPage2 ? 0 : (isPage3 ? 10 : 18),
                  ),
                  AppText(
                    slide.title,
                    style: AppTextStyles.onboardingTitle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                ],
              ),
            ),
            // Page 1: tam 2 satır (conversations sonrası kırılım).
            // Page 2: 308 → "ready." 3. satır.
            // Page 3: 364 → 2 satır.
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenHorizontal,
              ),
              child: Center(
                child: pageIndex == 0
                    ? _OnboardingSubtitleTwoLines(text: slide.subtitle)
                    : ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: isPage2 ? 308 : 364,
                        ),
                        child: AppText(
                          slide.subtitle,
                          style: AppTextStyles.onboardingSubtitle,
                          textAlign: TextAlign.center,
                        ),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenHorizontal,
              ),
              child: Column(
                children: [
                  SizedBox(height: isPage2 ? AppSpacing.sm : AppSpacing.lg),
                  AppPageIndicator(count: pageCount, index: pageIndex),
                  SizedBox(height: isPage2 ? AppSpacing.xs : AppSpacing.md),
                ],
              ),
            ),
          ],
        ),
        Expanded(
          child: SizedBox(
            width: screenWidth,
            child: Image.asset(
              slide.imageAsset,
              fit: BoxFit.fitWidth,
              alignment: slide.showCta ? Alignment.topCenter : Alignment.bottomCenter,
              filterQuality: FilterQuality.high,
            ),
          ),
        ),
        if (slide.showCta)
          // Figma footer: 124h, padding 10, gap 10, top border #E2E2E2
          DecoratedBox(
            decoration: const BoxDecoration(
              color: AppColors.white,
              border: Border(
                top: BorderSide(color: Color(0xFFE2E2E2), width: 1),
              ),
            ),
            child: SafeArea(
              top: false,
              left: false,
              right: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppPrimaryButton(
                      label: t.onboarding.getStarted,
                      onPressed: onGetStarted,
                    ),
                    const SizedBox(height: 10),
                    AppAccountPrompt(
                      prefix: t.onboarding.alreadyHaveAccount,
                      actionLabel: t.onboarding.logInAction,
                      onActionTap: onLogin ?? () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// Page 1 subtitle — `\n` ile 2 satır; dar ekranda 1. satır FittedBox ile sığar.
class _OnboardingSubtitleTwoLines extends StatelessWidget {
  const _OnboardingSubtitleTwoLines({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final parts = text.split('\n');
    final line1 = parts.isNotEmpty ? parts[0] : text;
    final line2 = parts.length > 1 ? parts.sublist(1).join(' ') : '';

    return Column(
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            line1,
            maxLines: 1,
            softWrap: false,
            textAlign: TextAlign.center,
            style: AppTextStyles.onboardingSubtitle,
          ),
        ),
        if (line2.isNotEmpty)
          Text(
            line2,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: AppTextStyles.onboardingSubtitle,
          ),
      ],
    );
  }
}
