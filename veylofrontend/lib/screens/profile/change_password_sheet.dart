import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/errors/error_messages.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_edit_sheet.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/data/remote/session_store.dart';
import 'package:veylo/i18n/strings.g.dart';

/// Change Password — Figma bottom sheet (Current + Password + Confirm + Save).
/// Şifreyi sheet içinde değiştirir; başarılıysa `true` ile kapanır.
Future<bool?> showChangePasswordSheet(BuildContext context) {
  return showAppEditSheet<bool>(
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
  final _currentController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  var _obscureCurrent = true;
  var _obscurePassword = true;
  var _obscureConfirm = true;
  var _busy = false;
  String? _error;

  @override
  void dispose() {
    _currentController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_busy) return;
    final t = Translations.of(context);
    final current = _currentController.text;
    final password = _passwordController.text;
    final confirm = _confirmController.text;
    if (current.isEmpty || password.isEmpty || confirm.isEmpty) {
      return setState(() => _error = t.errors.fillAllFields);
    }
    if (password != confirm) {
      return setState(() => _error = t.profile.passwordMismatch);
    }
    if (password.length < 6) {
      return setState(() => _error = t.errors.weakPassword);
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await SessionStore.instance.changePassword(
        currentPassword: current,
        newPassword: password,
      );
      if (mounted) Navigator.of(context).pop(true);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _busy = false;
        _error = _message(t, e);
      });
    }
  }

  /// Mevcut şifre yanlışsa giriş hatası yerine ekrana özel metin.
  String _message(Translations t, Object e) {
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'wrong-password':
        case 'invalid-credential':
        case 'invalid-login-credentials':
          return t.profile.currentPasswordWrong;
      }
    }
    return errorMessage(context, e);
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return AppEditSheet(
      title: t.profile.changePassword,
      saveLabel: _busy ? '...' : t.profile.save,
      onSave: _save,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 8),
          _LabeledPasswordField(
            label: t.profile.currentPassword,
            controller: _currentController,
            obscure: _obscureCurrent,
            onToggleObscure: () =>
                setState(() => _obscureCurrent = !_obscureCurrent),
            hint: t.profile.passwordPlaceholder,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 24),
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
          if (_error != null) ...[
            const SizedBox(height: 12),
            AppText(_error!, style: AppTextStyles.fieldError),
          ],
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
