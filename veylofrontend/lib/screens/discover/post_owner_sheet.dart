import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_edit_sheet.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';

enum PostOwnerAction { edit, editCaption, delete }

/// Kendi gönderim — Düzenle / Sil menüsü (profil işlem menüsüyle aynı yapı).
Future<PostOwnerAction?> showPostOwnerActionsSheet(BuildContext context) {
  return showModalBottomSheet<PostOwnerAction>(
    context: context,
    backgroundColor: AppColors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      final tr = Translations.of(context);
      final bottom = MediaQuery.viewPaddingOf(context).bottom;
      return Padding(
        padding: EdgeInsets.fromLTRB(16, 12, 16, 8 + bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _ActionItem(
              label: tr.discover.post.edit,
              onTap: () => Navigator.of(context).pop(PostOwnerAction.edit),
            ),
            _ActionItem(
              label: tr.discover.post.editCaption,
              onTap: () =>
                  Navigator.of(context).pop(PostOwnerAction.editCaption),
            ),
            _ActionItem(
              label: tr.discover.post.delete,
              onTap: () => Navigator.of(context).pop(PostOwnerAction.delete),
            ),
          ],
        ),
      );
    },
  );
}

/// Açıklamayı düzenle; boş bırakılırsa açıklama kaldırılır. Vazgeçilirse null.
Future<String?> showEditCaptionSheet(
  BuildContext context, {
  required String initial,
}) {
  return showAppEditSheet<String>(
    context: context,
    builder: (_) => _EditCaptionSheet(initial: initial),
  );
}

class _EditCaptionSheet extends StatefulWidget {
  const _EditCaptionSheet({required this.initial});

  final String initial;

  @override
  State<_EditCaptionSheet> createState() => _EditCaptionSheetState();
}

class _EditCaptionSheetState extends State<_EditCaptionSheet> {
  late final _controller = TextEditingController(text: widget.initial.trim());

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tr = Translations.of(context);
    return AppEditSheet(
      title: tr.discover.post.editCaption,
      saveLabel: tr.profile.save,
      onSave: () => Navigator.of(context).pop(_controller.text.trim()),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 11),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.editSheetInputFill,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.editSheetInputBorder),
          ),
          child: TextField(
            controller: _controller,
            autofocus: true,
            minLines: 1,
            maxLines: 5,
            // Sunucu sınırı (POST.captionMaxLength).
            maxLength: 500,
            style: AppTextStyles.editSheetInput,
            cursorColor: AppColors.selectionBorder,
            decoration: InputDecoration(
              hintText: tr.discover.post.captionHint,
              hintStyle: AppTextStyles.editSheetInputHint,
              border: InputBorder.none,
              isCollapsed: true,
              counterText: '',
              contentPadding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
            ),
          ),
        ),
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
