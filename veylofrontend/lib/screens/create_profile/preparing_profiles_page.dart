import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_primary_button.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/screens/create_profile/preparing_map_scene.dart';
import 'package:veylo/screens/main/main_shell.dart';

/// Figma: bar 357×6, row 398×40, content 398, avatar 56.
const _kProgressBarWidth = 357.0;
const _kProgressBarHeight = 6.0;
const _kProgressRowHeight = 40.0;
const _kContentWidth = 398.0;
const _kAvatarSize = 56.0;

/// Create Profile sonrası — eşleşme hazırlama ekranı.
class PreparingProfilesPage extends StatefulWidget {
  const PreparingProfilesPage({super.key});

  @override
  State<PreparingProfilesPage> createState() => _PreparingProfilesPageState();
}

class _PreparingProfilesPageState extends State<PreparingProfilesPage>
    with TickerProviderStateMixin {
  static const _prepareDuration = Duration(milliseconds: 4200);

  late final AnimationController _progressController;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: _prepareDuration,
    )..forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    for (final path in [
      AppAssets.preparingWorld,
      AppAssets.preparingFirst,
      AppAssets.preparingSecond,
      AppAssets.preparingThird,
      AppAssets.preparingFour,
      AppAssets.preparingSix,
    ]) {
      precacheImage(AssetImage(path), context);
    }
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  void _goHome() {
    Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder<void>(
        pageBuilder: (_, _, _) => const MainShell(),
        transitionsBuilder: (_, animation, _, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 350),
      ),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).createProfile;
    final media = MediaQuery.of(context);
    final screenW = media.size.width;
    final bottomInset = media.padding.bottom;
    // SafeArea L/R yok — harita full-bleed. İçerik 398.
    final hPad = math.max(16.0, (screenW - _kContentWidth) / 2);
    final mapH = screenW * 267 / 512;
    final sceneH = mapH + 36;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: screenW,
                    height: sceneH,
                    child: PreparingMapScene(
                      avatarSize: _kAvatarSize,
                      mapHeight: mapH,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: hPad),
                    child: Column(
                      children: [
                        const SizedBox(height: 28),
                        Column(
                          children: [
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: AppText(
                                t.preparingTitleLine1,
                                style: AppTextStyles.preparingTitle,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                              ),
                            ),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: AppText(
                                t.preparingTitleLine2,
                                style: AppTextStyles.preparingTitle,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                              ),
                            ),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: AppText(
                                t.preparingTitleLine3,
                                style: AppTextStyles.preparingTitle,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Column(
                          children: [
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: AppText(
                                t.preparingSubtitleLine1,
                                style: AppTextStyles.preparingSubtitle,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                              ),
                            ),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: AppText(
                                t.preparingSubtitleLine2,
                                style: AppTextStyles.preparingSubtitle,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 28),
                        AnimatedBuilder(
                          animation: _progressController,
                          builder: (context, _) {
                            final value = Curves.easeInOut.transform(
                              _progressController.value,
                            );
                            final percent =
                                (value * 100).round().clamp(0, 100);
                            return _PreparingProgressRow(
                              progress: value,
                              label: t.preparingPercent(percent: percent),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(hPad, 0, hPad, 16 + bottomInset),
            child: AnimatedBuilder(
              animation: _progressController,
              builder: (context, _) {
                final ready = _progressController.isCompleted;
                return AppPrimaryButton(
                  label: t.getStarted,
                  onPressed: ready ? _goHome : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _PreparingProgressRow extends StatelessWidget {
  const _PreparingProgressRow({
    required this.progress,
    required this.label,
  });

  final double progress;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _kProgressRowHeight,
      width: double.infinity,
      child: LayoutBuilder(
        builder: (context, constraints) {
          const percentSlot = 41.0;
          final maxBar = math.max(0.0, constraints.maxWidth - percentSlot);
          final barW = math.min(_kProgressBarWidth, maxBar);

          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: barW,
                height: _kProgressBarHeight,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      const ColoredBox(color: AppColors.progressTrack),
                      FractionallySizedBox(
                        widthFactor: progress.clamp(0.0, 1.0),
                        alignment: Alignment.centerLeft,
                        child: const DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.linkGradientStart,
                                AppColors.linkGradientEnd,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: AppText(
                    label,
                    style: AppTextStyles.preparingPercent,
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
