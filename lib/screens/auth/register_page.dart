import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_back_button.dart';
import 'package:veylo/core/widgets/app_legal_footer.dart';
import 'package:veylo/core/widgets/app_primary_button.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/core/widgets/app_text_field.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/screens/create_profile/create_profile_username_page.dart';

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

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _goCreateProfile() {
    Navigator.of(context).push(
      PageRouteBuilder<void>(
        pageBuilder: (_, _, _) => const CreateProfileUsernamePage(),
        transitionsBuilder: (_, animation, _, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 350),
      ),
    );
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
                      autofillHints: const [AutofillHints.newPassword],
                    ),
                    const SizedBox(height: AppSpacing.sectionGap),
                    AppPrimaryButton(
                      label: t.auth.signUp,
                      onPressed: _goCreateProfile,
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
