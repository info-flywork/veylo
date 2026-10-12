import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/i18n/strings.g.dart';

/// `true` = kullanıcı çıkışı onayladı. Zovi logout_sheet karşılığı.
Future<bool> showLogoutSheet(BuildContext context) async {
  final result = await showModalBottomSheet<bool>(
    context: context,
    backgroundColor: AppColors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => const LogoutSheet(),
  );
  return result ?? false;
}

class LogoutSheet extends StatelessWidget {
  const LogoutSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.paddingOf(context).bottom;
    final tr = LocaleSettings.currentLocale == AppLocale.tr;

    final title = tr ? 'Çıkış yap' : 'Log out';
    final subtitle =
        tr ? 'Çıkış yapmak istediğinden emin misin?' : 'Are you sure you want to log out?';
    final cancel = tr ? 'İptal' : 'Cancel';
    final confirm = tr ? 'Çıkış yap' : 'Log out';

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
          _SheetButton(
            label: cancel,
            background: AppColors.black,
            onTap: () => Navigator.of(context).pop(false),
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

/// Dolgulu, tam genişlik, pill buton (zovi AppButton karşılığı).
class _SheetButton extends StatelessWidget {
  const _SheetButton({
    required this.label,
    required this.background,
    required this.onTap,
  });

  final String label;
  final Color background;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        height: 52,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(9999),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontFamily: AppFonts.poppins,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
