import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_edit_sheet.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';

/// Change Password — Figma bottom sheet (Password + Confirm + Save).
Future<({String password, String confirm})?> showChangePasswordSheet(
  BuildContext context,
) {
  return showAppEditSheet<({String password, String confirm})>(
    context: context,
    builder: (_) => const _ChangePasswordSheet(),
  );
}

class _ChangePasswordSheet extends StatefulWidget {
  const _ChangePasswordSheet();

  @override
  State<_ChangePasswordSheet> createState() => _ChangePasswordSheetState();
}

class _ChangePasswordSheetState extends State<_ChangePasswordSheet> {
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  var _obscurePassword = true;
  var _obscureConfirm = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _save() {
    final password = _passwordController.text;
    final confirm = _confirmController.text;
    if (password.isEmpty || confirm.isEmpty) return;
    Navigator.of(context).pop((password: password, confirm: confirm));
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return AppEditSheet(
      title: t.profile.changePassword,
      saveLabel: t.profile.save,
      onSave: _save,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 8),
          _LabeledPasswordField(
            label: t.auth.password,
            controller: _passwordController,
            obscure: _obscurePassword,
            onToggleObscure: () =>
                setState(() => _obscurePassword = !_obscurePassword),
            hint: t.profile.passwordPlaceholder,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 24),
          _LabeledPasswordField(
            label: t.profile.confirmPassword,
            controller: _confirmController,
            obscure: _obscureConfirm,
            onToggleObscure: () =>
                setState(() => _obscureConfirm = !_obscureConfirm),
            hint: t.profile.passwordPlaceholder,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _save(),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _LabeledPasswordField extends StatelessWidget {
  const _LabeledPasswordField({
    required this.label,
    required this.controller,
    required this.obscure,
    required this.onToggleObscure,
    required this.hint,
    this.textInputAction,
    this.onSubmitted,
  });

  final String label;
  final TextEditingController controller;
  final bool obscure;
  final VoidCallback onToggleObscure;
  final String hint;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(label, style: AppTextStyles.editSheetFieldLabel),
        const SizedBox(height: 8),
        AccountEditInput(
          controller: controller,
          obscureText: obscure,
          hintText: hint,
          textInputAction: textInputAction,
          onSubmitted: onSubmitted,
          suffix: GestureDetector(
            onTap: onToggleObscure,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SvgPicture.asset(
                AppAssets.iconStatsEye,
                width: 24,
                height: 24,
                colorFilter: const ColorFilter.mode(
                  AppColors.black,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Figma edit input — 50h, radius 12, #83A0B4@10% fill + @20% border.
class AccountEditInput extends StatelessWidget {
  const AccountEditInput({
    super.key,
    required this.controller,
    this.focusNode,
    this.style,
    this.hintText,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.onSubmitted,
    this.suffix,
    this.autofocus = false,
  });

  final TextEditingController controller;
  final FocusNode? focusNode;
  final TextStyle? style;
  final String? hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;
  final Widget? suffix;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.editSheetInputFill,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.editSheetInputBorder),
      ),
      child: SizedBox(
        height: 50,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                autofocus: autofocus,
                obscureText: obscureText,
                obscuringCharacter: '*',
                keyboardType: keyboardType,
                textInputAction: textInputAction,
                onSubmitted: onSubmitted,
                style: style ?? AppTextStyles.editSheetInput,
                cursorColor: AppColors.selectionBorder,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: AppTextStyles.editSheetInputHint,
                  border: InputBorder.none,
                  isCollapsed: true,
                  contentPadding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                ),
              ),
            ),
            if (suffix != null)
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: suffix!,
              ),
          ],
        ),
      ),
    );
  }
}
