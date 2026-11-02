import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';

/// Profil seçici sheet sonucu. `value == null` → kullanıcı değeri temizledi
/// ("Not set"); sheet kapatıldıysa sonuç hiç gelmez (null).
class PickedValue<T> {
  const PickedValue(this.value);

  final T? value;
}

/// Seçici sheet'lerin altında "Seçimi temizle" — değer "Not set"e döner.
class PickerClearAction extends StatelessWidget {
  const PickerClearAction({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: AppText(
          Translations.of(context).profile.clearSelection,
          style: const TextStyle(
            fontFamily: AppFonts.poppins,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            height: 20 / 16,
            letterSpacing: -0.32,
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
