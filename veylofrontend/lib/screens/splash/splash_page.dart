import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/errors/error_messages.dart';
import 'package:veylo/core/navigation/session_navigation.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/data/remote/api_client.dart';
import 'package:veylo/data/remote/session_store.dart';
import 'package:veylo/i18n/strings.g.dart';

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
    _route();
  }

  /// Açılış animasyonu süresince oturumu geri yükler, sonra doğru ekrana geçer.
  Future<void> _route() async {
    final results = await Future.wait<Object?>([
      Future<void>.delayed(_duration),
      SessionStore.instance.restore().then<Object?>(
        (s) => s,
        onError: (Object e) => e,
      ),
    ]);
    if (!mounted) return;
    final outcome = results[1];
    if (outcome is SessionStatus) {
      await goForSession(context, outcome);
      return;
    }
    // Firebase oturumu var ama backend'e ulaşılamadı: tekrar dene.
    await _showRetry(outcome ?? const ApiException(code: 'UNKNOWN'));
  }

  Future<void> _showRetry(Object error) async {
    final t = Translations.of(context);
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        content: Text(errorMessage(context, error)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(t.common.retry),
          ),
        ],
      ),
    );
    if (mounted) _route();
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
