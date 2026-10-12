import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';

/// Tüm sohbetleri silme onay sheet'i.
Future<bool> showDeleteConversationSheet(BuildContext context) async {
  final result = await showModalBottomSheet<bool>(
    context: context,
    backgroundColor: AppColors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => const DeleteConversationSheet(),
  );
  return result ?? false;
}

class DeleteConversationSheet extends StatelessWidget {
  const DeleteConversationSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.paddingOf(context).bottom;

    // Figma kopyası (EN).
    const title = 'Are you sure want to delete all conversation';
    const subtitle = 'If you confirm, all messages will be deleted';
    const delete = 'Delete';

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 10, 16, 10 + bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 46,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.sheetHandle,
              borderRadius: BorderRadius.circular(9999),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: AppFonts.poppins,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              height: 28 / 20,
              letterSpacing: 20 * -0.02,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: AppFonts.poppins,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              height: 20 / 16,
              letterSpacing: 16 * -0.02,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(true),
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: double.infinity,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.editSheetButton,
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Text(
                delete,
                style: const TextStyle(
                  fontFamily: AppFonts.poppins,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  height: 20 / 16,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
