import 'package:flutter/material.dart';
import 'package:veylo/core/errors/error_messages.dart';
import 'package:veylo/core/navigation/session_navigation.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/age_eula_checkbox.dart';
import 'package:veylo/core/widgets/app_back_button.dart';
import 'package:veylo/core/widgets/app_legal_footer.dart';
import 'package:veylo/core/widgets/app_primary_button.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/core/widgets/app_text_field.dart';
import 'package:veylo/data/local/eula_store.dart';
import 'package:veylo/data/remote/session_store.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/screens/profile/legal_doc_sheet.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _eulaAccepted = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _busy = false;

  /// Firebase'de hesap açar, backend kullanıcısını oluşturur (+100 token),
  /// sonra profil oluşturmaya geçer (kullanıcı adı orada hazır gelir).
  Future<void> _signUp() async {
    final t = Translations.of(context);
    if (!_eulaAccepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(t.auth.ageEulaRequired),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    final username = _usernameController.text
        .trim()
        .replaceFirst(RegExp(r'^@+'), '')
        .toLowerCase();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(t.errors.fillAllFields),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    FocusScope.of(context).unfocus();
    setState(() => _busy = true);
    try {
      await EulaStore.accept();
      final status = await SessionStore.instance.registerWithEmail(
        email,
        password,
      );
      if (!mounted) return;
      await goForSession(context, status, usernameHint: username);
    } catch (e) {
      if (mounted) showErrorSnackBar(context, e);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

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
                    AppText(
                      t.auth.createAccountTitle,
                      style: AppTextStyles.authTitle,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    AppText(
                      t.auth.createAccountSubtitle,
                      style: AppTextStyles.authSubtitle,
                    ),
                    const SizedBox(height: 15),
                    AppTextField(
                      label: t.auth.username,
                      hint: t.auth.usernameHint,
                      controller: _usernameController,
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.username],
                    ),
                    const SizedBox(height: AppSpacing.fieldGap),
                    AppTextField(
                      label: t.auth.email,
                      hint: t.auth.emailHint,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.email],
                    ),
                    const SizedBox(height: AppSpacing.fieldGap),
                    AppTextField(
                      label: t.auth.password,
                      hint: t.auth.passwordCreateHint,
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      onToggleObscure: () {
                        setState(() => _obscurePassword = !_obscurePassword);
                      },
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) {
                        if (!_busy) _signUp();
                      },
                      autofillHints: const [AutofillHints.newPassword],
                    ),
                    const SizedBox(height: AppSpacing.sectionGap),
                    AgeEulaCheckbox(
                      value: _eulaAccepted,
                      onChanged: (v) => setState(() => _eulaAccepted = v),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    AppPrimaryButton(
                      label: _busy ? t.common.loading : t.auth.signUp,
                      onPressed: _busy || !_eulaAccepted ? null : _signUp,
                    ),
                    const SizedBox(height: AppSpacing.xl),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenHorizontal,
                0,
                AppSpacing.screenHorizontal,
                AppSpacing.lg,
              ),
              child: AppLegalFooter(
                onTermsTap: () => showTermsOfServiceSheet(context),
                onPrivacyTap: () => showPrivacyPolicySheet(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
