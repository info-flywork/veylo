import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';

/// Veylo'nun AI karakterlerinin adının yanında gösterilen küçük etiket.
class AiBadge extends StatelessWidget {
  const AiBadge({super.key, this.compact = false});

  /// Küçük satırlarda (liste, grup mesajı) biraz daha küçük.
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(start: 6),
      padding: EdgeInsets.symmetric(horizontal: compact ? 4 : 5, vertical: 1),
      decoration: BoxDecoration(
        color: AppColors.selectionBorder,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        'AI',
        style: TextStyle(
          fontFamily: AppFonts.poppins,
          fontWeight: FontWeight.w600,
          fontSize: compact ? 9 : 10,
          height: 1.4,
          color: AppColors.white,
        ),
      ),
    );
  }
}
