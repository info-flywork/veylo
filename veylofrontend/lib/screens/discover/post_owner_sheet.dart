import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_edit_sheet.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';

enum PostOwnerAction { boost, edit, editCaption, delete }

/// Kendi gönderim — Öne çıkar / Düzenle / Açıklamayı düzenle / Sil.
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
            Center(
              child: Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.progressTrack,
                  borderRadius: BorderRadius.circular(AppBorders.radiusPill),
                ),
              ),
            ),
            const SizedBox(height: 8),
            _ActionItem(
              label: tr.discover.post.boost,
              iconAsset: AppAssets.iconLucideRocket,
              color: AppColors.black,
              onTap: () => Navigator.of(context).pop(PostOwnerAction.boost),
            ),
            _ActionItem(
              label: tr.discover.post.edit,
              iconAsset: AppAssets.iconLucidePencil,
              color: AppColors.black,
              onTap: () => Navigator.of(context).pop(PostOwnerAction.edit),
            ),
            _ActionItem(
              label: tr.discover.post.editCaption,
              iconAsset: AppAssets.iconLucideText,
              color: AppColors.black,
              onTap: () =>
                  Navigator.of(context).pop(PostOwnerAction.editCaption),
            ),
            _ActionItem(
              label: tr.discover.post.delete,
              iconAsset: AppAssets.iconLucideTrash,
              color: AppColors.logout,
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
  late final _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _focus.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focus.dispose();
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
            focusNode: _focus,
            autofocus: true,
            minLines: 4,
            maxLines: 8,
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
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
              contentPadding: const EdgeInsets.fromLTRB(12, 14, 12, 14),
            ),
          ),
        ),
      ),
    );
  }
}

class _ActionItem extends StatelessWidget {
  const _ActionItem({
    required this.label,
    required this.iconAsset,
    required this.color,
    required this.onTap,
  });

  final String label;
  final String iconAsset;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconAsset,
              width: 22,
              height: 22,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
            const SizedBox(width: 12),
            AppText(
              label,
              style: TextStyle(
                fontFamily: AppFonts.poppins,
                fontWeight: FontWeight.w500,
                fontSize: 16,
                height: 20 / 16,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
