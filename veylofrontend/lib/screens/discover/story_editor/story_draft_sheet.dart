import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';

Future<bool?> showStoryDraftSheet(BuildContext context) {
  return showModalBottomSheet<bool>(
    context: context,
    backgroundColor: const Color(0xFF1C1C1E),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => const StoryDraftSheet(),
  );
}

/// Figma: “Taslak olarak kaydedilsin mi?”
class StoryDraftSheet extends StatelessWidget {
  const StoryDraftSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).discover.story;
    final bottom = MediaQuery.paddingOf(context).bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 10, 16, 20 + bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          const SizedBox(height: 24),
          AppText(
            t.draftPrompt,
            style: const TextStyle(
              fontFamily: AppFonts.poppins,
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: AppColors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: Material(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(999),
              child: InkWell(
                onTap: () => Navigator.of(context).pop(true),
                borderRadius: BorderRadius.circular(999),
                child: Center(
                  child: Text(
                    t.saveToDraft,
                    style: const TextStyle(
                      fontFamily: AppFonts.poppins,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: AppColors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              t.moveToTrash,
              style: const TextStyle(
                fontFamily: AppFonts.poppins,
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Color(0xFFFF3B30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
