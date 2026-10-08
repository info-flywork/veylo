import 'package:flutter/material.dart';
import 'package:veylo/screens/chat/widgets/chat_note_card.dart';

/// Avatar + opsiyonel dekoratif çerçeve.
///
/// [size] çerçevesiz gri halkalı avatar çapı (Edit 90 / Profile 88).
/// Çerçeve seçiliyken Figma sheet oranları (86→132 / 70) ölçeklenir.
class ProfileFramedAvatar extends StatelessWidget {
  const ProfileFramedAvatar({
    super.key,
    required this.avatarUrl,
    required this.size,
    this.borderAsset,
    this.fit = BoxFit.cover,
    this.showGrayRingWhenBare = true,
  });

  final String avatarUrl;
  final double size;
  final String? borderAsset;
  final BoxFit fit;
  final bool showGrayRingWhenBare;

  /// Sheet preview: bare 86 → frame 132, framed avatar 70.
  static const _refBare = 86.0;
  static const _refFrame = 132.0;
  static const _refFramedAvatar = 70.0;

  @override
  Widget build(BuildContext context) {
    final framed = borderAsset != null;
    if (!framed) {
      return SizedBox(
        width: size,
        height: size,
        child: Container(
          decoration: const BoxDecoration(shape: BoxShape.circle),
          foregroundDecoration: showGrayRingWhenBare
              ? const BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.fromBorderSide(
                    BorderSide(color: Color(0xFF848484), width: 4),
                  ),
                )
              : null,
          child: ClipOval(
            child: ChatAvatarImage(
              url: avatarUrl,
              size: size,
              fit: fit,
            ),
          ),
        ),
      );
    }

    final scale = size / _refBare;
    final frameSize = _refFrame * scale;
    final avatarSize = _refFramedAvatar * scale;

    return SizedBox(
      width: size,
      height: size,
      child: OverflowBox(
        maxWidth: frameSize,
        maxHeight: frameSize,
        alignment: Alignment.center,
        child: SizedBox(
          width: frameSize,
          height: frameSize,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Transform.translate(
                offset: const Offset(0, 2),
                child: ClipOval(
                  child: ChatAvatarImage(
                    url: avatarUrl,
                    size: avatarSize,
                    fit: fit,
                  ),
                ),
              ),
              Image.asset(
                borderAsset!,
                width: frameSize,
                height: frameSize,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
