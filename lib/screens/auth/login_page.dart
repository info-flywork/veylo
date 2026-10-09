import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:veylo/core/errors/error_messages.dart';
import 'package:veylo/core/navigation/session_navigation.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_back_button.dart';
import 'package:veylo/core/widgets/app_gradient_text.dart';
import 'package:veylo/core/widgets/app_legal_footer.dart';
import 'package:veylo/core/widgets/app_or_divider.dart';
import 'package:veylo/core/widgets/app_primary_button.dart';
import 'package:veylo/core/widgets/app_social_button.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/core/widgets/app_text_field.dart';
import 'package:veylo/data/remote/session_store.dart';
import 'package:veylo/i18n/strings.g.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailOrUsernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _busy = false;

  @override
  void dispose() {
    _emailOrUsernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn(Future<SessionStatus> Function() method) async {
    if (_busy) return;
    FocusScope.of(context).unfocus();
    setState(() => _busy = true);
    try {
      final status = await method();
      if (!mounted) return;
      await goForSession(context, status);
    } on SignInCancelled {
      // Kullanıcı vazgeçti: sessizce bekle.
    } catch (e) {
      if (mounted) showErrorSnackBar(context, e);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _logInWithPassword() {
    final identifier = _emailOrUsernameController.text.trim();
    final password = _passwordController.text;
    if (identifier.isEmpty || password.isEmpty) return;
    _signIn(
      () => SessionStore.instance.signInWithPassword(identifier, password),
    );
  }

  Future<void> _forgotPassword() async {
    final identifier = _emailOrUsernameController.text.trim();
    final t = Translations.of(context);
    if (!identifier.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(t.errors.enterEmailForReset),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    try {
      await SessionStore.instance.sendPasswordReset(identifier);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(t.auth.passwordResetSent),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      if (mounted) showErrorSnackBar(context, e);
    }
  }

  /// Sadece debug: başlığa uzun basınca Firebase'siz test girişi.
  Future<void> _devSignIn() async {
    final controller = TextEditingController(text: 'tester1');
    final name = await showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Dev login'),
        content: TextField(controller: controller, autofocus: true),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.of(dialogContext).pop(controller.text.trim()),
            child: const Text('OK'),
          ),
        ],
      ),
    );
    controller.dispose();
    if (name == null || name.isEmpty) return;
    await _signIn(() => SessionStore.instance.signInAsDev(name));
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final session = SessionStore.instance;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenHorizontal,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppBackButton(),
                    const SizedBox(height: AppSpacing.md),
                    GestureDetector(
                      onLongPress: kDebugMode ? _devSignIn : null,
                      child: AppText(
                        t.auth.welcomeBackTitle,
                        style: AppTextStyles.authTitle,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    AppText(
                      t.auth.welcomeBackSubtitle,
                      style: AppTextStyles.authSubtitle,
                    ),
                    const SizedBox(height: 15),
                    AppTextField(
                      label: t.auth.emailOrUsername,
                      hint: t.auth.emailOrUsernameHint,
                      controller: _emailOrUsernameController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      autofillHints: const [
                        AutofillHints.username,
                        AutofillHints.email,
                      ],
                    ),
                    const SizedBox(height: AppSpacing.fieldGap),
                    AppTextField(
                      label: t.auth.password,
                      hint: t.auth.passwordEnterHint,
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      onToggleObscure: () {
                        setState(() => _obscurePassword = !_obscurePassword);
                      },
                      textInputAction: TextInputAction.done,
                      autofillHints: const [AutofillHints.password],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: _busy ? null : _forgotPassword,
                        child: AppGradientText(t.auth.forgotPassword),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sectionGap),
                    AppPrimaryButton(
                      label: _busy ? t.common.loading : t.auth.logIn,
                      onPressed: _busy ? null : _logInWithPassword,
                    ),
                    const SizedBox(height: 40),
                    AppOrDivider(label: t.common.or),
                    const SizedBox(height: 40),
                    // Android'de Apple ile giriş gösterilmiyor.
                    if (Platform.isIOS) ...[
                      AppSocialButton(
                        provider: AppSocialProvider.apple,
                        label: t.auth.continueWithApple,
                        onPressed: _busy
                            ? null
                            : () => _signIn(session.signInWithApple),
                      ),
                      const SizedBox(height: AppSpacing.buttonGap),
                    ],
                    AppSocialButton(
                      provider: AppSocialProvider.google,
                      label: t.auth.continueWithGoogle,
                      onPressed: _busy
                          ? null
                          : () => _signIn(session.signInWithGoogle),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.screenHorizontal,
                0,
                AppSpacing.screenHorizontal,
                AppSpacing.lg,
              ),
              child: AppLegalFooter(),
            ),
          ],
        ),
      ),
    );
  }
}
