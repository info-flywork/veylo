import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/models/profile/profile_user.dart';

/// Report kullanıcı sheet’i.
Future<void> showReportUserSheet(
  BuildContext context, {
  required ProfileUser user,
}) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: AppColors.white,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => ReportUserSheet(user: user),
  );
}

class ReportUserSheet extends StatefulWidget {
  const ReportUserSheet({super.key, required this.user});

  final ProfileUser user;

  @override
  State<ReportUserSheet> createState() => _ReportUserSheetState();
}

class _ReportUserSheetState extends State<ReportUserSheet> {
  final _controller = TextEditingController();

  static const _btnColor = Color(0xFF1A1714);
  static const _sendColor = Color(0xFFEC1C24);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).profile;
    final bottom = MediaQuery.viewPaddingOf(context).bottom;
    final keyboard = MediaQuery.viewInsetsOf(context).bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: keyboard),
      child: SafeArea(
        top: false,
        child: Padding(
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
                t.reportTitle,
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
                t.reportSubtitle,
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
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: AppText(
                  t.reportMessageLabel,
                  style: const TextStyle(
                    fontFamily: AppFonts.poppins,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    height: 1,
                    letterSpacing: 14 * -0.02,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _controller,
                maxLines: 4,
                style: const TextStyle(
                  fontFamily: AppFonts.poppins,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  height: 1.2,
                  color: AppColors.textPrimary,
                ),
                cursorColor: AppColors.selectionBorder,
                decoration: InputDecoration(
                  hintText: t.reportMessageHint,
                  hintStyle: const TextStyle(
                    fontFamily: AppFonts.poppins,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    height: 1,
                    letterSpacing: 14 * -0.02,
                    color: Color(0xA61A1714),
                  ),
                  filled: true,
                  fillColor: AppColors.white,
                  contentPadding: const EdgeInsets.all(12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0x3383A0B4)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0x3383A0B4)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: AppColors.selectionBorder,
                    ),
                  ),
                ),
              ),
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
                        t.reportCancel,
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
              const SizedBox(height: 14),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: AppText(
                  t.sendReport,
                  style: const TextStyle(
                    fontFamily: AppFonts.poppins,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    height: 20 / 16,
                    color: _sendColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
