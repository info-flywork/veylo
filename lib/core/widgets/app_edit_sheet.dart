import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';

/// Figma edit bottom sheet modal — kabuk [AppEditSheet] ile kullanılır.
Future<T?> showAppEditSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool isDismissible = true,
}) {
  return showModalBottomSheet<T>(
    context: context,
    backgroundColor: AppColors.white,
    isScrollControlled: true,
    isDismissible: isDismissible,
    enableDrag: isDismissible,
    useSafeArea: false,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: builder,
  );
}

/// Handle + title + esnek [child] + Save — yükseklik içeriğe göre büyür.
class AppEditSheet extends StatelessWidget {
  const AppEditSheet({
    super.key,
    required this.title,
    required this.saveLabel,
    required this.onSave,
    required this.child,
    this.afterChildGap = 10,
  });

  final String title;
  final String saveLabel;
  final VoidCallback onSave;
  final Widget child;
  /// Child ile Save butonu arası boşluk.
  final double afterChildGap;

  static const _buttonHeight = 54.0;

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.viewPaddingOf(context).bottom;
    final keyboard = MediaQuery.viewInsetsOf(context).bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: keyboard),
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 10, 16, 10 + bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(child: _SheetHandle()),
            const SizedBox(height: 20),
            AppText(title, style: AppTextStyles.editSheetTitle),
            const SizedBox(height: 10),
            child,
            SizedBox(height: afterChildGap),
            SizedBox(
              width: double.infinity,
              height: _buttonHeight,
              child: Material(
                color: AppColors.editSheetButton,
                borderRadius: BorderRadius.circular(999),
                child: InkWell(
                  onTap: onSave,
                  borderRadius: BorderRadius.circular(999),
                  child: Center(
                    child: AppText(saveLabel, style: AppTextStyles.editSheetSave),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SheetHandle extends StatelessWidget {
  const _SheetHandle();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: AppColors.sheetHandle,
        borderRadius: BorderRadius.circular(999),
      ),
    );
  }
}
