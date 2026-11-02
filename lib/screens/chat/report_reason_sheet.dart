import 'package:flutter/material.dart';
import 'package:veylo/core/errors/error_messages.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';

/// Mesaj / vibe şikayeti: sebep seçilince [onSubmit] çağrılır (sunucu sebep kodu).
/// Görünüm profildeki şikayet sheet'iyle aynı kabuk.
Future<void> showReportReasonSheet(
  BuildContext context, {
  required Future<void> Function(String reason) onSubmit,
}) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: AppColors.white,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => _ReportReasonSheet(onSubmit: onSubmit),
  );
}

class _ReportReasonSheet extends StatefulWidget {
  const _ReportReasonSheet({required this.onSubmit});

  final Future<void> Function(String reason) onSubmit;

  @override
  State<_ReportReasonSheet> createState() => _ReportReasonSheetState();
}

class _ReportReasonSheetState extends State<_ReportReasonSheet> {
  static const _btnColor = Color(0xFF1A1714);

  String? _sending;

  Future<void> _send(String reason) async {
    if (_sending != null) return;
    setState(() => _sending = reason);
    final messenger = ScaffoldMessenger.of(context);
    final sent = Translations.of(context).profile.reportSent;
    try {
      await widget.onSubmit(reason);
      if (!mounted) return;
      Navigator.of(context).pop();
      messenger.showSnackBar(
        SnackBar(content: Text(sent), behavior: SnackBarBehavior.floating),
      );
    } catch (e) {
      if (mounted) showErrorSnackBar(context, e);
    } finally {
      if (mounted) setState(() => _sending = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tr = Translations.of(context);
    final t = tr.chats;
    final bottom = MediaQuery.viewPaddingOf(context).bottom;
    final reasons = [
      ('HARASSMENT', t.reasonHarassment),
      ('HATE_SPEECH', t.reasonHateSpeech),
      ('NUDITY', t.reasonNudity),
      ('SPAM', t.reasonSpam),
      ('SCAM', t.reasonScam),
      ('VIOLENCE', t.reasonViolence),
      ('OTHER', t.reasonOther),
    ];

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 10, 16, 16 + bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFFD9D9D9),
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          const SizedBox(height: 16),
          AppText(
            tr.profile.reportTitle,
            style: const TextStyle(
              fontFamily: AppFonts.poppins,
              fontWeight: FontWeight.w600,
              fontSize: 18,
              height: 1,
              letterSpacing: 18 * -0.02,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          AppText(
            t.reportReasonSubtitle,
            style: const TextStyle(
              fontFamily: AppFonts.poppins,
              fontWeight: FontWeight.w400,
              fontSize: 14,
              height: 18 / 14,
              letterSpacing: 14 * -0.02,
              color: Color(0xA61A1714),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          for (var i = 0; i < reasons.length; i++) ...[
            if (i > 0)
              const Divider(height: 1, thickness: 1, color: Color(0xFFE8E8E8)),
            InkWell(
              onTap: _sending == null ? () => _send(reasons[i].$1) : null,
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: Row(
                  children: [
                    Expanded(
                      child: AppText(
                        reasons[i].$2,
                        style: const TextStyle(
                          fontFamily: AppFonts.poppins,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          height: 20 / 16,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    if (_sending == reasons[i].$1)
                      const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.selectionBorder,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: Material(
              color: _btnColor,
              borderRadius: BorderRadius.circular(999),
              child: InkWell(
                onTap: () => Navigator.of(context).pop(),
                borderRadius: BorderRadius.circular(999),
                child: Center(
                  child: AppText(
                    tr.profile.reportCancel,
                    style: const TextStyle(
                      fontFamily: AppFonts.poppins,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      height: 20 / 16,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
