import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_back_button.dart';
import 'package:veylo/core/widgets/app_step_progress_bar.dart';
import 'package:veylo/core/widgets/app_text.dart';

/// Create Profile ortak iskelet: geri, başlıklar, progress, içerik, alt buton.
class CreateProfileShell extends StatelessWidget {
  const CreateProfileShell({
    super.key,
    required this.navTitle,
    required this.step,
    required this.stepLabel,
    required this.body,
    required this.footer,
    this.onBack,
  });

  final String navTitle;
  final int step;
  final String stepLabel;
  final Widget body;
  final Widget footer;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenHorizontal,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 48,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: AppBackButton(onPressed: onBack),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppText(
                              navTitle,
                              style: AppTextStyles.createProfileNav,
                            ),
                            AppText(
                              stepLabel,
                              style: AppTextStyles.createProfileStep,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AppStepProgressBar(step: step),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.screenHorizontal,
                  AppSpacing.xl,
                  AppSpacing.screenHorizontal,
                  AppSpacing.lg,
                ),
                child: body,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenHorizontal,
                0,
                AppSpacing.screenHorizontal,
                AppSpacing.lg,
              ),
              child: footer,
            ),
          ],
        ),
      ),
    );
  }
}
