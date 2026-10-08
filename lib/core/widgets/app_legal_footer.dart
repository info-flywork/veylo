import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/i18n/strings.g.dart';

class AppLegalFooter extends StatefulWidget {
  const AppLegalFooter({
    super.key,
    this.onTermsTap,
    this.onPrivacyTap,
  });

  final VoidCallback? onTermsTap;
  final VoidCallback? onPrivacyTap;

  @override
  State<AppLegalFooter> createState() => _AppLegalFooterState();
}

class _AppLegalFooterState extends State<AppLegalFooter> {
  late final TapGestureRecognizer _termsRecognizer;
  late final TapGestureRecognizer _privacyRecognizer;

  @override
  void initState() {
    super.initState();
    _termsRecognizer = TapGestureRecognizer()..onTap = widget.onTermsTap;
    _privacyRecognizer = TapGestureRecognizer()..onTap = widget.onPrivacyTap;
  }

  @override
  void didUpdateWidget(covariant AppLegalFooter oldWidget) {
    super.didUpdateWidget(oldWidget);
    _termsRecognizer.onTap = widget.onTermsTap;
    _privacyRecognizer.onTap = widget.onPrivacyTap;
  }

  @override
  void dispose() {
    _termsRecognizer.dispose();
    _privacyRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Text.rich(
      TextSpan(
        style: AppTextStyles.legal,
        children: [
          TextSpan(text: t.auth.legalPrefix),
          TextSpan(
            text: t.auth.termsOfService,
            style: AppTextStyles.legalLink,
            recognizer: _termsRecognizer,
          ),
          TextSpan(text: t.auth.legalMiddle),
          TextSpan(
            text: t.auth.privacyPolicy,
            style: AppTextStyles.legalLink,
            recognizer: _privacyRecognizer,
          ),
          TextSpan(text: t.auth.legalSuffix),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
