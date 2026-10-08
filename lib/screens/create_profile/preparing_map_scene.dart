import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/animated_profile_ripple.dart';

/// Onboarding / Finding Match ortak harita + profil ripple sahnesi.
///
/// [float] null ise avatarlar sabit (Preparing Profiles).
/// Verilirse hafif süzülme (Finding Match).
class PreparingMapScene extends StatelessWidget {
  const PreparingMapScene({
    super.key,
    this.float,
    required this.avatarSize,
    required this.mapHeight,
  });

  final Animation<double>? float;
  final double avatarSize;
  final double mapHeight;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final h = constraints.maxHeight;
        final mapTop = (h - mapHeight) * 0.55;

        Widget scene(Offset Function(double phase, double amp) drift) {
          Widget place({
            required double left,
            required double top,
            required Widget child,
            required double phase,
            required double amp,
          }) {
            final d = drift(phase, amp);
            return Positioned(
              left: left + d.dx,
              top: top + d.dy,
              child: child,
            );
          }

          Widget avatar(String asset) => PreparingProfileAvatar(
                asset: asset,
                size: avatarSize,
              );

          return Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: 0,
                width: w,
                top: mapTop,
                height: mapHeight,
                child: Image.asset(
                  AppAssets.preparingWorld,
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.center,
                  filterQuality: FilterQuality.high,
                ),
              ),
              // Soft ripple
              place(
                left: w * 0.06,
                top: mapTop + mapHeight * 0.12,
                phase: 0.0,
                amp: 6,
                child: PreparingProfileRipple(
                  avatarSize: avatarSize,
                  phase: 0.1,
                  intensity: 0.55,
                  ringCount: 3,
                  child: avatar(AppAssets.preparingFirst),
                ),
              ),
              // Sol alt — Figma’daki belirgin mor dalgalar
              place(
                left: w * 0.20,
                top: mapTop + mapHeight * 0.46,
                phase: 0.22,
                amp: 10,
                child: PreparingProfileRipple(
                  avatarSize: avatarSize,
                  phase: 0,
                  intensity: 1.0,
                  ringCount: 4,
                  child: avatar(AppAssets.preparingSecond),
                ),
              ),
              place(
                left: w * 0.44,
                top: mapTop + mapHeight * 0.58,
                phase: 0.48,
                amp: 7,
                child: PreparingProfileRipple(
                  avatarSize: avatarSize,
                  phase: 0.35,
                  intensity: 0.5,
                  ringCount: 3,
                  child: avatar(AppAssets.preparingThird),
                ),
              ),
              place(
                left: w * 0.50,
                top: mapTop + mapHeight * 0.08,
                phase: 0.65,
                amp: 8,
                child: PreparingProfileRipple(
                  avatarSize: avatarSize,
                  phase: 0.55,
                  intensity: 0.5,
                  ringCount: 3,
                  child: avatar(AppAssets.preparingFour),
                ),
              ),
              // Sağ — orta yoğunluk
              place(
                left: w * 0.78,
                top: mapTop + mapHeight * 0.28,
                phase: 0.35,
                amp: 10,
                child: PreparingProfileRipple(
                  avatarSize: avatarSize,
                  phase: 0.45,
                  intensity: 0.75,
                  ringCount: 4,
                  child: avatar(AppAssets.preparingSix),
                ),
              ),
            ],
          );
        }

        final floatAnim = float;
        if (floatAnim == null) {
          return scene((_, __) => Offset.zero);
        }

        return AnimatedBuilder(
          animation: floatAnim,
          builder: (context, _) {
            return scene((phase, amp) {
              final t = (floatAnim.value + phase) % 1.0;
              final y = math.sin(t * math.pi * 2) * amp;
              final x = math.cos(t * math.pi * 2) * amp * 0.35;
              return Offset(x, y);
            });
          },
        );
      },
    );
  }
}

class PreparingProfileAvatar extends StatelessWidget {
  const PreparingProfileAvatar({
    super.key,
    required this.asset,
    required this.size,
  });

  final String asset;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: ClipOval(
            child: Image.asset(
              asset,
              fit: BoxFit.cover,
              width: size,
              height: size,
              filterQuality: FilterQuality.high,
              gaplessPlayback: true,
              errorBuilder: (_, error, _) {
                debugPrint('Preparing avatar failed: $asset → $error');
                return ColoredBox(
                  color: AppColors.inputFill,
                  child: Icon(
                    Icons.person,
                    size: size * 0.5,
                    color: AppColors.brandPurpleMuted,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
