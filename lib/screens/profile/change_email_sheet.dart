import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_edit_sheet.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/screens/profile/change_password_sheet.dart';

/// Email — Figma bottom sheet (single field + Save).
Future<String?> showChangeEmailSheet(
  BuildContext context, {
  String initialEmail = '',
}) {
  return showAppEditSheet<String>(
    context: context,
    builder: (_) => _ChangeEmailSheet(initialEmail: initialEmail),
  );
}

class _ChangeEmailSheet extends StatefulWidget {
  const _ChangeEmailSheet({required this.initialEmail});

  final String initialEmail;

  @override
  State<_ChangeEmailSheet> createState() => _ChangeEmailSheetState();
}

class _ChangeEmailSheetState extends State<_ChangeEmailSheet> {
  TextEditingController? _controller;
  final FocusNode _focusNode = FocusNode();
  var _focused = false;

  TextEditingController get _textController {
    return _controller ??= TextEditingController(
      text: widget.initialEmail.trim().isEmpty
          ? 'alex1234567@gmail.com'
          : widget.initialEmail.trim(),
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
      title: t.email,
      saveLabel: t.save,
      onSave: _save,
      child: AccountEditInput(
        controller: _textController,
        focusNode: _focusNode,
        style: _focused
            ? AppTextStyles.editSheetInput
            : AppTextStyles.editSheetInputHint,
        autofocus: false,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.done,
        onSubmitted: (_) => _save(),
      ),
    );
  }
}
