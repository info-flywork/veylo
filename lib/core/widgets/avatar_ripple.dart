import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';

/// Avatar etrafında genişleyip sönen radar dalgaları (Figma Vibes / Call).
///
/// [child] ortada kalır; halkalar [size] → [size] * [maxScale] aralığında
/// fade in/out ile tekrarlanır.
class AvatarRipple extends StatefulWidget {
  const AvatarRipple({
    super.key,
    required this.size,
    required this.child,
    this.ringCount = 4,
    this.maxScale = 3.0,
    this.duration = const Duration(milliseconds: 3200),
    this.phase = 0,
    this.color = const Color(0xFF7B2FFF),
    this.peakOpacity = 0.12,
  });

  final double size;
  final Widget child;
  final int ringCount;
  final double maxScale;
  final Duration duration;
  final double phase;
  final Color color;
  final double peakOpacity;

  @override
  State<AvatarRipple> createState() => _AvatarRippleState();
}

class _AvatarRippleState extends State<AvatarRipple>
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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final maxRing = widget.size * widget.maxScale;
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              for (var i = 0; i < widget.ringCount; i++)
                _RippleRing(
                  progress:
                      (_controller.value + widget.phase + i / widget.ringCount) %
                          1.0,
                  minSize: widget.size,
                  maxSize: maxRing,
                  color: widget.color,
                  peakOpacity: widget.peakOpacity,
                ),
              child!,
            ],
          );
        },
        child: widget.child,
      ),
    );
  }
}

class _RippleRing extends StatelessWidget {
  const _RippleRing({
    required this.progress,
    required this.minSize,
    required this.maxSize,
    required this.color,
    required this.peakOpacity,
  });

  final double progress;
  final double minSize;
  final double maxSize;
  final Color color;
  final double peakOpacity;

  @override
  Widget build(BuildContext context) {
    final d = minSize + (maxSize - minSize) * progress;
    // Figma: dolu lavanta daireler, kenarlık yok; genişlerken sönüyor.
    final fadeIn = (progress / 0.12).clamp(0.0, 1.0);
    final fadeOut = ((1.0 - progress) / 0.28).clamp(0.0, 1.0);
    final alpha = peakOpacity * fadeIn * fadeOut;

    return IgnorePointer(
      child: Container(
        width: d,
        height: d,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withValues(alpha: alpha),
        ),
      ),
    );
  }
}

/// Opsiyonel ince stroke’lu dalga (Preparing / soft map stili).
class AvatarRippleSoft extends StatelessWidget {
  const AvatarRippleSoft({
    super.key,
    required this.size,
    required this.child,
    this.phase = 0,
  });

  final double size;
  final Widget child;
  final double phase;

  @override
  Widget build(BuildContext context) {
    return AvatarRipple(
      size: size,
      phase: phase,
      ringCount: 3,
      maxScale: 2.4,
      duration: const Duration(milliseconds: 2400),
      color: AppColors.selectionBorder,
      peakOpacity: 0.14,
      child: child,
    );
  }
}
