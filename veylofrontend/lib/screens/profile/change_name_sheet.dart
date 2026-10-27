import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_edit_sheet.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/screens/profile/change_password_sheet.dart';

/// Change Name — text input içeriği ile [AppEditSheet].
Future<String?> showChangeNameSheet(
  BuildContext context, {
  required String initialName,
}) {
  return showAppEditSheet<String>(
    context: context,
    builder: (_) => _ChangeNameSheet(initialName: initialName),
  );
}

class _ChangeNameSheet extends StatefulWidget {
  const _ChangeNameSheet({required this.initialName});

  final String initialName;

  @override
  State<_ChangeNameSheet> createState() => _ChangeNameSheetState();
}

class _ChangeNameSheetState extends State<_ChangeNameSheet> {
  TextEditingController? _controller;
  final FocusNode _focusNode = FocusNode();
  var _focused = false;

  TextEditingController get _textController {
    return _controller ??= TextEditingController(
      text: widget.initialName.trim(),
    );
  }

  @override
  void initState() {
    super.initState();
    _textController;
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    final next = _focusNode.hasFocus;
    if (next == _focused || !mounted) return;
    setState(() => _focused = next);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _controller?.dispose();
    super.dispose();
  }

  void _save() {
    final value = _textController.text.trim();
    Navigator.of(context).pop(value.isEmpty ? null : value);
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).profile;

    return AppEditSheet(
      title: t.changeName,
      saveLabel: t.save,
      onSave: _save,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 11),
          AccountEditInput(
            controller: _textController,
            focusNode: _focusNode,
            style: _focused
                ? AppTextStyles.editSheetInput
                : AppTextStyles.editSheetInputHint,
            autofocus: false,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _save(),
          ),
          const SizedBox(height: 11),
        ],
      ),
    );
  }
}
