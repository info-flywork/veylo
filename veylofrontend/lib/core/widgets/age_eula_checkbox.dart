import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/screens/profile/legal_doc_sheet.dart';

/// Kayıt / sosyal giriş için zorunlu 18+ ve EULA onayı.
class AgeEulaCheckbox extends StatelessWidget {
  const AgeEulaCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).auth;
    return InkWell(
      onTap: () => onChanged(!value),
      borderRadius: BorderRadius.circular(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
              value: value,
              onChanged: (v) => onChanged(v ?? false),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
              activeColor: AppColors.selectionBorder,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text.rich(
              TextSpan(
                style: const TextStyle(
                  fontFamily: AppFonts.poppins,
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  height: 1.35,
                  color: AppColors.textSecondary,
                ),
                children: [
                  TextSpan(text: t.ageEulaBeforeLink),
                  TextSpan(
                    text: t.termsOfService,
                    style: const TextStyle(
                      color: AppColors.selectionBorder,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => showTermsOfServiceSheet(context),
                  ),
                  TextSpan(text: t.ageEulaAfterLink),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
