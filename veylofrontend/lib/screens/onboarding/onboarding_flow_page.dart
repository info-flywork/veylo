import 'dart:async';

import 'package:flutter/material.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/screens/auth/login_page.dart';
import 'package:veylo/screens/auth/register_page.dart';
import 'package:veylo/screens/onboarding/onboarding_slide.dart';
import 'package:veylo/screens/onboarding/onboarding_slide_view.dart';

class OnboardingFlowPage extends StatefulWidget {
  const OnboardingFlowPage({super.key});

  @override
  State<OnboardingFlowPage> createState() => _OnboardingFlowPageState();
}

class _OnboardingFlowPageState extends State<OnboardingFlowPage> {
  static const _autoAdvanceDelay = Duration(milliseconds: 1500);
  static const _pageAnimDuration = Duration(milliseconds: 350);
  static const _lastPageIndex = 2;

  final _controller = PageController();
  int _index = 0;
  Timer? _autoAdvanceTimer;
  bool _userPaused = false;
  bool _isAutoAnimating = false;

  List<OnboardingSlide> _slides(Translations t) => [
        OnboardingSlide(
          title: t.onboarding.page1Title,
          subtitle: t.onboarding.page1Subtitle,
          imageAsset: AppAssets.onboardingPage1,
        ),
        OnboardingSlide(
          title: t.onboarding.page2Title,
          subtitle: t.onboarding.page2Subtitle,
          imageAsset: AppAssets.onboardingPage2,
        ),
        OnboardingSlide(
          title: t.onboarding.page3Title,
          subtitle: t.onboarding.page3Subtitle,
          imageAsset: AppAssets.onboardingPage3,
          showCta: true,
        ),
      ];

  @override
  void initState() {
    super.initState();
    _scheduleAutoAdvance();
  }

  void _pauseAutoAdvance() {
    _autoAdvanceTimer?.cancel();
    _autoAdvanceTimer = null;
    if (_userPaused) return;
    _userPaused = true;
    // Otomatik animasyon ortasındaysa mevcut ekranda kal.
    if (_isAutoAnimating && _controller.hasClients) {
      _isAutoAnimating = false;
      _controller.jumpToPage(_index);
    }
  }

  void _scheduleAutoAdvance() {
    _autoAdvanceTimer?.cancel();
    if (_userPaused || _index >= _lastPageIndex) return;

    _autoAdvanceTimer = Timer(_autoAdvanceDelay, () async {
      if (!mounted || _userPaused || _index >= _lastPageIndex) return;
      _isAutoAnimating = true;
      await _controller.animateToPage(
        _index + 1,
        duration: _pageAnimDuration,
        curve: Curves.easeInOut,
      );
      _isAutoAnimating = false;
    });
  }

  void _onPageChanged(int i) {
    setState(() => _index = i);
    _scheduleAutoAdvance();
  }

  void _goLogin() {
    _pauseAutoAdvance();
    Navigator.of(context).push(
      PageRouteBuilder<void>(
        pageBuilder: (_, _, _) => const LoginPage(),
        transitionsBuilder: (_, animation, _, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 350),
      ),
    );
  }

  void _goRegister() {
    _pauseAutoAdvance();
    Navigator.of(context).push(
      PageRouteBuilder<void>(
        pageBuilder: (_, _, _) => const RegisterPage(),
        transitionsBuilder: (_, animation, _, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 350),
      ),
    );
  }

  @override
  void dispose() {
    _autoAdvanceTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final slides = _slides(t);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SafeArea(
            bottom: false,
            left: false,
            right: false,
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: _goLogin,
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.screenHorizontal,
                    AppSpacing.sm,
                    AppSpacing.screenHorizontal,
                    0,
                  ),
                  child: SizedBox(
                    height: 44,
                    child: Align(
                      // Yazı altta — Skip ↔ başlık görsel boşluğu 18px olsun
                      alignment: Alignment.bottomRight,
                      child: AppText(
                        t.onboarding.skip,
                        style: AppTextStyles.onboardingSkip,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Listener(
              onPointerDown: (_) => _pauseAutoAdvance(),
              child: PageView.builder(
                controller: _controller,
                itemCount: slides.length,
                onPageChanged: _onPageChanged,
                itemBuilder: (context, i) {
                  return OnboardingSlideView(
                    slide: slides[i],
                    pageIndex: _index,
                    pageCount: slides.length,
                    onGetStarted: _goRegister,
                    onLogin: _goLogin,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
