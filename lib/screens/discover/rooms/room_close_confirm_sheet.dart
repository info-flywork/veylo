import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/i18n/strings.g.dart';

/// Odayı kapat / odadan ayrıl onayı. `true` = onaylandı.
Future<bool> showRoomCloseConfirmSheet(
  BuildContext context, {
  required bool isHost,
}) async {
  final t = Translations.of(context).discover.liveRoom;
  final result = await showModalBottomSheet<bool>(
    context: context,
    backgroundColor: AppColors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => _RoomCloseConfirmSheet(
      title: isHost ? t.closeConfirmTitle : t.leaveConfirmTitle,
      subtitle: isHost ? t.closeConfirmSubtitle : t.leaveConfirmSubtitle,
      cancel: t.cancel,
      confirm: isHost ? t.closeConfirm : t.leaveConfirm,
    ),
  );
  return result ?? false;
}

class _RoomCloseConfirmSheet extends StatelessWidget {
  const _RoomCloseConfirmSheet({
    required this.title,
    required this.subtitle,
    required this.cancel,
    required this.confirm,
  });

  final String title;
  final String subtitle;
  final String cancel;
  final String confirm;

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.paddingOf(context).bottom;
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 10, 16, 10 + bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          Container(
            width: 46,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.sheetHandle,
              borderRadius: BorderRadius.circular(9999),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: AppFonts.poppins,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              height: 1,
              letterSpacing: -0.4,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: AppFonts.poppins,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              height: 20 / 16,
              letterSpacing: -0.32,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 22),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: double.infinity,
              height: 52,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                cancel,
                style: const TextStyle(
                  fontFamily: AppFonts.poppins,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(true),
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Text(
                confirm,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: AppFonts.poppins,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  height: 20 / 16,
                  letterSpacing: -0.32,
                  color: AppColors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
