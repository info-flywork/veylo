import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_primary_button.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/screens/profile/faq_help_sheet.dart';

/// Uygulama içi Destek & İletişim / uygunsuz içerik bildirim formu.
Future<void> showReportIssueSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => const ReportIssueSheet(),
  );
}

class ReportIssueSheet extends StatefulWidget {
  const ReportIssueSheet({super.key});

  @override
  State<ReportIssueSheet> createState() => _ReportIssueSheetState();
}

class _ReportIssueSheetState extends State<ReportIssueSheet> {
  final _controller = TextEditingController();
  bool _sending = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final text = _controller.text.trim();
    if (text.isEmpty || _sending) return;
    setState(() => _sending = true);
    final messenger = ScaffoldMessenger.of(context);
    final sent = Translations.of(context).profile.reportIssueSent;
    final uri = Uri(
      scheme: 'mailto',
      path: kSupportEmail,
      queryParameters: {
        'subject': 'Veylo — Support / Report an Issue',
        'body': text,
      },
    );
    try {
      await launchUrl(uri);
    } catch (_) {
      if (mounted) await openSupportMail(context);
    }
    if (!mounted) return;
    Navigator.of(context).pop();
    messenger.showSnackBar(
      SnackBar(content: Text(sent), behavior: SnackBarBehavior.floating),
    );
    if (mounted) setState(() => _sending = false);
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).profile;
    final bottom = MediaQuery.viewInsetsOf(context).bottom +
        MediaQuery.viewPaddingOf(context).bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 10, 16, 16 + bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFD9D9D9),
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
          const SizedBox(height: 16),
          AppText(
            t.reportIssueTitle,
            style: const TextStyle(
              fontFamily: AppFonts.poppins,
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          AppText(
            t.reportIssueSubtitle,
            style: const TextStyle(
              fontFamily: AppFonts.poppins,
              fontWeight: FontWeight.w400,
              fontSize: 13,
              height: 1.35,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _controller,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: t.reportIssueHint,
              filled: true,
              fillColor: AppColors.inputFill,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppBorders.inputRadius),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 12),
          AppPrimaryButton(
            label: _sending
                ? Translations.of(context).common.loading
                : t.reportIssueSend,
            onPressed: _sending ? null : _submit,
          ),
          TextButton(
            onPressed: () => openSupportMail(context),
            child: Text(kSupportEmail),
          ),
        ],
      ),
    );
  }
}
