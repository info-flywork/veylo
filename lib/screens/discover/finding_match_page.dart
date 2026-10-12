import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/core/errors/error_messages.dart';
import 'package:veylo/data/remote/match_repository.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/screens/create_profile/preparing_map_scene.dart';
import 'package:veylo/screens/discover/your_match_page.dart';

/// Figma: content 398, avatar 56, progress 6, checklist gap 10.
const _kContentWidth = 398.0;
const _kAvatarSize = 56.0;
const _kProgressBarHeight = 6.0;

enum _StepStatus { pending, active, done }

/// AI Match — Finding your match animasyon ekranı.
class FindingMatchPage extends StatefulWidget {
  const FindingMatchPage({
    super.key,
    this.mood = 'bored',
    this.intent = 'cultures',
    this.onlineCount,
  });

  final String mood;
  final String intent;
  final int? onlineCount;

  @override
  State<FindingMatchPage> createState() => _FindingMatchPageState();
}

class _FindingMatchPageState extends State<FindingMatchPage>
    with TickerProviderStateMixin {
  static const _matchDuration = Duration(milliseconds: 4800);

  late final AnimationController _progressController;
  late final AnimationController _floatController;
  late final AnimationController _spinController;
  bool _navigated = false;

  /// Animasyonla aynı anda başlayan gerçek arama.
  late final Future<List<MatchCandidate>> _search = MatchRepository.instance
      .search(mood: widget.mood, intent: widget.intent);

  @override
  void initState() {
    super.initState();
    _progressController =
        AnimationController(vsync: this, duration: _matchDuration)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _goToYourMatch();
            }
          });

    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
    )..repeat();

    _spinController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();

    _progressController.forward();
    // Hata animasyon bitince gösterilir; burada yakalanmazsa uyarı düşer.
    _search.catchError((Object _) => const <MatchCandidate>[]);
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
      AppAssets.fakePerson03,
    ]) {
      precacheImage(AssetImage(path), context);
    }
  }

  @override
  void dispose() {
    _progressController.dispose();
    _floatController.dispose();
    _spinController.dispose();
    super.dispose();
  }

  Future<void> _goToYourMatch() async {
    if (!mounted || _navigated) return;
    _navigated = true;
    final List<MatchCandidate> matches;
    try {
      matches = await _search;
    } catch (e) {
      if (!mounted) return;
      showErrorSnackBar(context, e);
      Navigator.of(context).pop();
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      Navigator.of(context, rootNavigator: true).pushReplacement(
        PageRouteBuilder<void>(
          pageBuilder: (_, _, _) => YourMatchPage(matches: matches),
          transitionsBuilder: (_, animation, _, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 350),
        ),
      );
    });
  }

  _StepStatus _statusFor(int index, double progress) {
    // 4 adım; her biri ~%25
    final doneThrough = (progress * 4).floor().clamp(0, 4);
    if (index < doneThrough) return _StepStatus.done;
    if (index == doneThrough && progress < 1.0) return _StepStatus.active;
    if (progress >= 1.0) return _StepStatus.done;
    return _StepStatus.pending;
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).discover.aiMatch;
    final media = MediaQuery.of(context);
    final screenW = media.size.width;
    final bottomInset = media.padding.bottom;
    final hPad = math.max(16.0, (screenW - _kContentWidth) / 2);
    final mapH = screenW * 267 / 512;
    final sceneH = mapH + 36;

    final steps = [
      t.findingStepMood,
      t.findingStepInterests,
      t.findingStepCompatibility,
      t.findingStepContent,
    ];

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
                      float: _floatController,
                      avatarSize: _kAvatarSize,
                      mapHeight: mapH,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: hPad),
                    child: Column(
                      children: [
                        const SizedBox(height: 28),
                        AppText(
                          t.findingTitle,
                          style: AppTextStyles.preparingTitle,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        AppText(
                          t.findingSubtitle,
                          style: AppTextStyles.preparingSubtitle,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        AnimatedBuilder(
                          animation: _progressController,
                          builder: (context, _) {
                            final value = Curves.easeInOut.transform(
                              _progressController.value,
                            );
                            return _FindingProgressBar(progress: value);
                          },
                        ),
                        const SizedBox(height: 20),
                        AnimatedBuilder(
                          animation: Listenable.merge([
                            _progressController,
                            _spinController,
                          ]),
                          builder: (context, _) {
                            final value = Curves.easeInOut.transform(
                              _progressController.value,
                            );
                            return Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  for (var i = 0; i < steps.length; i++) ...[
                                    if (i > 0) const SizedBox(height: 10),
                                    Center(
                                      child: _FindingStepRow(
                                        label: steps[i],
                                        status: _statusFor(i, value),
                                        spin: _spinController,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
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
            padding: EdgeInsets.fromLTRB(hPad, 0, hPad, 24 + bottomInset),
            child: AppText(
              t.findingOnline(count: '${widget.onlineCount ?? '–'}'),
              style: AppTextStyles.aiMatchFindingOnline,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class _FindingProgressBar extends StatelessWidget {
  const _FindingProgressBar({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
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
    );
  }
}

class _FindingStepRow extends StatelessWidget {
  const _FindingStepRow({
    required this.label,
    required this.status,
    required this.spin,
  });

  final String label;
  final _StepStatus status;
  final Animation<double> spin;

  @override
  Widget build(BuildContext context) {
    final isDone = status == _StepStatus.done;
    final isActive = status == _StepStatus.active;
    final isPending = status == _StepStatus.pending;

    final textStyle = isDone
        ? AppTextStyles.aiMatchFindingStepDone
        : isActive
        ? AppTextStyles.aiMatchFindingStepActive
        : AppTextStyles.aiMatchFindingStepPending;

    return Opacity(
      opacity: isPending ? 0.35 : 1,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isDone || isActive) ...[
            SizedBox(
              width: 24,
              height: 24,
              child: isDone
                  ? const _CheckIcon()
                  : RotationTransition(
                      turns: spin,
                      child: const _SpinnerIcon(),
                    ),
            ),
            const SizedBox(width: 10),
          ],
          AppText(label, style: textStyle, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class _CheckIcon extends StatelessWidget {
  const _CheckIcon();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.textPrimary,
      ),
      child: const Center(
        child: Icon(Icons.check, size: 14, color: AppColors.white),
      ),
    );
  }
}

class _SpinnerIcon extends StatelessWidget {
  const _SpinnerIcon();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(24, 24),
      painter: _SpinnerPainter(
        color: AppColors.textPrimary.withValues(alpha: 0.28),
      ),
    );
  }
}

class _SpinnerPainter extends CustomPainter {
  _SpinnerPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final rect = Offset.zero & size;
    canvas.drawArc(rect.deflate(2), -math.pi / 2, math.pi * 1.4, false, paint);
  }

  @override
  bool shouldRepaint(covariant _SpinnerPainter oldDelegate) =>
      oldDelegate.color != color;
}
