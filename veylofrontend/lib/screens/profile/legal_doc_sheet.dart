import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/i18n/strings.g.dart';

/// Hizmet şartları / gizlilik politikası bottom sheet.
Future<void> showLegalDocSheet(
  BuildContext context, {
  required String title,
  required String body,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => LegalDocSheet(title: title, body: body),
  );
}

Future<void> showTermsOfServiceSheet(BuildContext context) {
  final t = Translations.of(context).legal;
  return showLegalDocSheet(context, title: t.termsTitle, body: t.termsBody);
}

Future<void> showPrivacyPolicySheet(BuildContext context) {
  final t = Translations.of(context).legal;
  return showLegalDocSheet(context, title: t.privacyTitle, body: t.privacyBody);
}

class LegalDocSheet extends StatelessWidget {
  const LegalDocSheet({
    super.key,
    required this.title,
    required this.body,
  });

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.viewPaddingOf(context).bottom;
    final maxHeight = MediaQuery.sizeOf(context).height * 0.92;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        constraints: BoxConstraints(maxHeight: maxHeight),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 10, 16, 10 + bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 46,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.sheetHandle,
                    borderRadius: BorderRadius.circular(9999),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontFamily: AppFonts.poppins,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  height: 1,
                  letterSpacing: 20 * -0.02,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 14),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.zero,
                  child: Text(
                    body,
                    style: const TextStyle(
                      fontFamily: AppFonts.poppins,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 22 / 14,
                      letterSpacing: 14 * -0.02,
                      color: Color(0xA6000000),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




