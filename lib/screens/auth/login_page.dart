import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_back_button.dart';
import 'package:veylo/core/widgets/app_gradient_text.dart';
import 'package:veylo/core/widgets/app_legal_footer.dart';
import 'package:veylo/core/widgets/app_or_divider.dart';
import 'package:veylo/core/widgets/app_primary_button.dart';
import 'package:veylo/core/widgets/app_social_button.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/core/widgets/app_text_field.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/screens/main/main_shell.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailOrUsernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailOrUsernameController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                    AppText(t.auth.welcomeBackTitle, style: AppTextStyles.authTitle),
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
                        onTap: () {},
                        child: AppGradientText(t.auth.forgotPassword),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sectionGap),
                    AppPrimaryButton(
                      label: t.auth.logIn,
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute<void>(
                            builder: (_) => const MainShell(),
                          ),
                          (_) => false,
                        );
                      },
                    ),
                    const SizedBox(height: 40),
                    AppOrDivider(label: t.common.or),
                    const SizedBox(height: 40),
                    AppSocialButton(
                      provider: AppSocialProvider.apple,
                      label: t.auth.continueWithApple,
                      onPressed: () {},
                    ),
                    const SizedBox(height: AppSpacing.buttonGap),
                    AppSocialButton(
                      provider: AppSocialProvider.google,
                      label: t.auth.continueWithGoogle,
                      onPressed: () {},
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
