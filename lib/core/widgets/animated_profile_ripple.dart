import 'package:flutter/material.dart';

/// Profil etrafında su damlası / radar dalgası animasyonu.
///
/// Figma referans (avatar 56): iç 110, dış 144, `#7B2FFF`.
/// Halkalar [child] arkasında büyür, opacity düşer, döngüsel devam eder.
class AnimatedProfileRipple extends StatefulWidget {
  const AnimatedProfileRipple({
    super.key,
    required this.avatarSize,
    required this.child,
    this.ringCount = 4,
    this.duration = const Duration(milliseconds: 3000),
    this.phase = 0,
    this.color = const Color(0xFF7B2FFF),
    this.peakOpacity = 0.18,
    this.intensity = 1.0,
    /// Figma dış halka / avatar: 144 / 56
    this.maxRingScale = 144 / 56,
  });

  final double avatarSize;
  final Widget child;
  final int ringCount;
  final Duration duration;

  /// 0–1 faz kayması (stagger için).
  final double phase;
  final Color color;

  /// Tepe opaklık (varsayılan %18 — biraz belirgin). [intensity] ile çarpılır.
  final double peakOpacity;

  /// 1.0 = belirgin (sol alt), &lt;1 = daha soft.
  final double intensity;

  final double maxRingScale;

  @override
  State<AnimatedProfileRipple> createState() => _AnimatedProfileRippleState();
}

class _AnimatedProfileRippleState extends State<AnimatedProfileRipple>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();
  }

  @override
  void didUpdateWidget(covariant AnimatedProfileRipple oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
      if (!_controller.isAnimating) _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final maxRing = widget.avatarSize * widget.maxRingScale;

    return SizedBox(
      width: widget.avatarSize,
      height: widget.avatarSize,
      child: OverflowBox(
        maxWidth: maxRing,
        maxHeight: maxRing,
        alignment: Alignment.center,
        child: SizedBox(
          width: maxRing,
          height: maxRing,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: _ProfileRipplePainter(
                  progress: _controller.value,
                  phase: widget.phase,
                  ringCount: widget.ringCount,
                  avatarSize: widget.avatarSize,
                  maxRing: maxRing,
                  color: widget.color,
                  peakOpacity: widget.peakOpacity * widget.intensity,
                ),
                child: Center(child: child),
              );
            },
            child: SizedBox(
              width: widget.avatarSize,
              height: widget.avatarSize,
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileRipplePainter extends CustomPainter {
  _ProfileRipplePainter({
    required this.progress,
    required this.phase,
    required this.ringCount,
    required this.avatarSize,
    required this.maxRing,
    required this.color,
    required this.peakOpacity,
  });

  final double progress;
  final double phase;
  final int ringCount;
  final double avatarSize;
  final double maxRing;
  final Color color;
  final double peakOpacity;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final minRadius = avatarSize / 2;
    final maxRadius = maxRing / 2;
    final paint = Paint()..style = PaintingStyle.fill;

    for (var i = 0; i < ringCount; i++) {
      // Staggered: dalgalar sırayla takip eder
      final raw = (progress + phase + i / ringCount) % 1.0;
      // Yumuşak genişleme — ani sıçrama yok
      final t = Curves.easeOut.transform(raw);

      final radius = minRadius + (maxRadius - minRadius) * t;

      // Kısa fade-in, sonra büyürken sönme → max’ta 0
      final fadeIn = Curves.easeOut.transform((raw / 0.12).clamp(0.0, 1.0));
      final fadeOut = 1.0 - Curves.easeIn.transform(t);
      final alpha = (peakOpacity * fadeIn * fadeOut).clamp(0.0, 1.0);
      if (alpha < 0.002) continue;

      paint.color = color.withValues(alpha: alpha);
      canvas.drawCircle(center, radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ProfileRipplePainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.phase != phase ||
        oldDelegate.ringCount != ringCount ||
        oldDelegate.avatarSize != avatarSize ||
        oldDelegate.maxRing != maxRing ||
        oldDelegate.color != color ||
        oldDelegate.peakOpacity != peakOpacity;
  }
}

/// Preparing / Finding stranger map preset — Figma 110 / 144 ölçeği.
class PreparingProfileRipple extends StatelessWidget {
  const PreparingProfileRipple({
    super.key,
    required this.avatarSize,
    required this.child,
    this.phase = 0,
    this.intensity = 1.0,
    this.ringCount = 4,
  });

  final double avatarSize;
  final Widget child;
  final double phase;
  final double intensity;
  final int ringCount;

  @override
  Widget build(BuildContext context) {
    return AnimatedProfileRipple(
      avatarSize: avatarSize,
      phase: phase,
      intensity: intensity,
      ringCount: ringCount,
      duration: Duration(milliseconds: intensity >= 0.9 ? 3000 : 3200),
      maxRingScale: 144 / 56,
      peakOpacity: 0.18,
      color: const Color(0xFF7B2FFF),
      child: child,
    );
  }
}
