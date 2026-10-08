import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/screens/onboarding/onboarding_flow_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  static const _duration = Duration(milliseconds: 1800);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Platform channel; ignore in widget tests / unsupported hosts.
      try {
        FlutterNativeSplash.remove();
      } catch (_) {}
    });
    Future<void>.delayed(_duration, _goOnboarding);
  }

  void _goOnboarding() {
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder<void>(
        pageBuilder: (_, _, _) => const OnboardingFlowPage(),
        transitionsBuilder: (_, animation, _, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            AppAssets.splashFirstPage,
            fit: BoxFit.cover,
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  AppAssets.veyloFirstSplashIcon,
                  width: AppSizes.splashIcon,
                  height: AppSizes.splashIcon,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: AppSpacing.splashBrandGap),
                SizedBox(
                  width: AppSizes.splashBrandWidth,
                  height: AppSizes.splashBrandHeight,
                  child: AppText(
                    t.app.name,
                    style: AppTextStyles.splashBrand,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
