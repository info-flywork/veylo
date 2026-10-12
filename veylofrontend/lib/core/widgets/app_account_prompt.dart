import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';

/// "Already have a Veylo account? Log In" — ortak auth yönlendirme satırı.
class AppAccountPrompt extends StatefulWidget {
  const AppAccountPrompt({
    super.key,
    required this.prefix,
    required this.actionLabel,
    required this.onActionTap,
  });

  final String prefix;
  final String actionLabel;
  final VoidCallback onActionTap;

  @override
  State<AppAccountPrompt> createState() => _AppAccountPromptState();
}

class _AppAccountPromptState extends State<AppAccountPrompt> {
  late final TapGestureRecognizer _recognizer;

  @override
  void initState() {
    super.initState();
    _recognizer = TapGestureRecognizer()..onTap = widget.onActionTap;
  }

  @override
  void didUpdateWidget(covariant AppAccountPrompt oldWidget) {
    super.didUpdateWidget(oldWidget);
    _recognizer.onTap = widget.onActionTap;
  }

  @override
  void dispose() {
    _recognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: AppTextStyles.accountPrompt,
        children: [
          TextSpan(text: widget.prefix),
          TextSpan(
            text: widget.actionLabel,
            style: AppTextStyles.accountPromptAction,
            recognizer: _recognizer,
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
