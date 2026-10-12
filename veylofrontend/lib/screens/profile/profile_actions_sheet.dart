import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/models/profile/profile_user.dart';
import 'package:veylo/screens/profile/block_user_sheet.dart';
import 'package:veylo/screens/profile/report_user_sheet.dart';

/// Başka profil — Restrict / Block / Report menüsü.
Future<void> showProfileActionsSheet(
  BuildContext context, {
  required ProfileUser user,
}) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: AppColors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => _ProfileActionsSheet(
      user: user,
      parentContext: context,
    ),
  );
}

class _ProfileActionsSheet extends StatelessWidget {
  const _ProfileActionsSheet({
    required this.user,
    required this.parentContext,
  });

  final ProfileUser user;
  final BuildContext parentContext;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).profile;
    final bottom = MediaQuery.viewPaddingOf(context).bottom;

    // SafeArea yok — bottom inset bir kez; Report altında fazla boşluk oluşmasın.
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 12, 16, 8 + bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
            _ActionItem(
              label: t.restrict,
              onTap: () {
                Navigator.of(context).pop();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (parentContext.mounted) {
                    showRestrictUserSheet(parentContext, user: user);
                  }
                });
              },
            ),
          _ActionItem(
            label: t.block,
            onTap: () {
              Navigator.of(context).pop();
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (parentContext.mounted) {
                  showBlockUserSheet(parentContext, user: user);
                }
              });
            },
          ),
          _ActionItem(
            label: t.report,
            onTap: () {
              Navigator.of(context).pop();
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (parentContext.mounted) {
                  showReportUserSheet(parentContext, user: user);
                }
              });
            },
          ),
        ],
      ),
    );
  }
}

class _ActionItem extends StatelessWidget {
  const _ActionItem({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: Center(
          child: AppText(
            label,
            style: const TextStyle(
              fontFamily: AppFonts.poppins,
              fontWeight: FontWeight.w500,
              fontSize: 16,
              height: 20 / 16,
              color: Color(0xFFD4537E),
            ),
          ),
        ),
      ),
    );
  }
}
