import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/theme/theme.dart';

/// Sola kaydırınca açılan kare aksiyon butonları (sohbet listesi ve mesaj balonları).
const kChatSwipeActionSize = 44.0;
const kChatSwipeActionGap = 10.0;
const kChatSwipeActionsPadding = 12.0;

/// Satır içeriği ile ilk buton arasındaki boşluk (rozet/saat butona yapışmasın).
const kChatSwipeActionsLeadingGap = 12.0;

const kChatSwipePinBg = Color(0xFF7C6CD6);
const kChatSwipeBlockBg = Color(0xFF6B6480);
const kChatSwipeDeleteBg = Color(0xFFD4537E);

/// [count] buton + aradaki boşluklar + sağ padding + içerikle arası.
double chatSwipeRevealWidth(int count) => count <= 0
    ? 0
    : (kChatSwipeActionSize * count) +
          (kChatSwipeActionGap * (count - 1)) +
          kChatSwipeActionsPadding +
          kChatSwipeActionsLeadingGap;

class ChatSwipeActionButton extends StatelessWidget {
  const ChatSwipeActionButton({
    super.key,
    required this.color,
    required this.onTap,
    this.iconAsset,
    this.icon,
    this.crossedOut = false,
  }) : assert(iconAsset != null || icon != null);

  final Color color;
  final String? iconAsset;
  final IconData? icon;
  final VoidCallback onTap;

  /// Aktif durumu geri alan aksiyon (ör. sabitlemeyi kaldır): ikonun üstünde çapraz çizgi.
  final bool crossedOut;

  @override
  Widget build(BuildContext context) {
    Widget glyph = iconAsset != null
        ? SvgPicture.asset(
            iconAsset!,
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(
              AppColors.white,
              BlendMode.srcIn,
            ),
          )
        : Icon(icon, size: 22, color: AppColors.white);
    if (crossedOut) {
      glyph = SizedBox(
        width: 24,
        height: 24,
        child: CustomPaint(
          foregroundPainter: _SlashPainter(background: color),
          child: Center(child: glyph),
        ),
      );
    }
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          width: kChatSwipeActionSize,
          height: kChatSwipeActionSize,
          child: Center(child: glyph),
        ),
      ),
    );
  }
}

class _SlashPainter extends CustomPainter {
  const _SlashPainter({required this.background});

  final Color background;

  @override
  void paint(Canvas canvas, Size size) {
    final from = Offset(size.width * 0.12, size.height * 0.12);
    final to = Offset(size.width * 0.88, size.height * 0.88);
    // Önce zemin renginde kalın çizgi: ikonla çizgi birbirine karışmasın.
    canvas.drawLine(
      from,
      to,
      Paint()
        ..color = background
        ..strokeWidth = 4.5
        ..strokeCap = StrokeCap.round,
    );
    canvas.drawLine(
      from,
      to,
      Paint()
        ..color = AppColors.white
        ..strokeWidth = 2
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant _SlashPainter oldDelegate) =>
      oldDelegate.background != background;
}
