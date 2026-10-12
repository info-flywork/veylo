import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/errors/error_messages.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_primary_button.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/data/remote/note_store.dart';
import 'package:veylo/i18n/strings.g.dart';

/// Kendi not kartına dokununca: not yaz / değiştir / sil (oda adı sheet'iyle aynı düzen).
Future<void> showNoteSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: AppColors.white,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => const _NoteSheet(),
  );
}

class _NoteSheet extends StatefulWidget {
  const _NoteSheet();

  @override
  State<_NoteSheet> createState() => _NoteSheetState();
}

class _NoteSheetState extends State<_NoteSheet> {
  final _store = NoteStore.instance;
  late final _controller = TextEditingController(text: _store.mine ?? '');
  bool _busy = false;

  static const _inputBg = Color(0x0D998FED);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _run(Future<void> Function() action) async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      await action();
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) {
        setState(() => _busy = false);
        showErrorSnackBar(context, e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).chats;
    final bottom = MediaQuery.paddingOf(context).bottom;
    final text = _controller.text.trim();

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 30,
        bottom: 10 + bottom + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              behavior: HitTestBehavior.opaque,
              child: SvgPicture.asset(
                AppAssets.iconClose,
                width: 32,
                height: 32,
              ),
            ),
          ),
          AppText(
            t.noteSheetTitle,
            style: AppTextStyles.filtersTitle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          AppText(
            t.noteSheetSubtitle,
            style: AppTextStyles.createSpaceSubtitle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Container(
            height: 54,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: _inputBg,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.centerLeft,
            child: TextField(
              controller: _controller,
              autofocus: true,
              maxLength: 60,
              onChanged: (_) => setState(() {}),
              style: AppTextStyles.createSpaceOption,
              cursorColor: AppColors.selectionBorder,
              decoration: InputDecoration(
                isDense: true,
                counterText: '',
                border: InputBorder.none,
                hintText: t.noteHint,
                hintStyle: AppTextStyles.privateRequestInput,
              ),
            ),
          ),
          const SizedBox(height: 20),
          AppPrimaryButton(
            label: t.noteShare,
            onPressed: text.isEmpty || _busy
                ? null
                : () => _run(() => _store.setMine(text)),
          ),
          if (_store.mine != null) ...[
            const SizedBox(height: 12),
            GestureDetector(
              onTap: _busy ? null : () => _run(_store.deleteMine),
              behavior: HitTestBehavior.opaque,
              child: SizedBox(
                width: double.infinity,
                height: 30,
                child: Center(
                  child: AppText(
                    t.noteDelete,
                    style: AppTextStyles.privateRoomCancel,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
