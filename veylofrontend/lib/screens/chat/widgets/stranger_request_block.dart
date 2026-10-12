import 'package:flutter/material.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/screens/chat/widgets/chat_note_card.dart';

/// Takip edilmeyen gönderenden gelen mesaj + Approve / Block / Reject.
class StrangerRequestBlock extends StatelessWidget {
  const StrangerRequestBlock({
    super.key,
    required this.text,
    required this.avatarUrl,
    required this.approveLabel,
    required this.blockLabel,
    required this.rejectLabel,
    required this.showActions,
    required this.onApprove,
    required this.onBlock,
    required this.onReject,
  });

  final String text;
  final String avatarUrl;
  final String approveLabel;
  final String blockLabel;
  final String rejectLabel;
  final bool showActions;
  final VoidCallback onApprove;
  final VoidCallback onBlock;
  final VoidCallback onReject;

  static const _bubble = Color(0x1A998FED);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipOval(
              child: avatarUrl.startsWith('http')
                  ? ChatAvatarImage(url: avatarUrl, size: 36)
                  : Image.asset(
                      avatarUrl,
                      width: 36,
                      height: 36,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => ColoredBox(
                        color: AppColors.sheetMuted,
                        child: Image.asset(
                          AppAssets.strangerAvatar,
                          width: 36,
                          height: 36,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: _bubble,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                ),
                child: AppText(
                  text,
                  style: const TextStyle(
                    fontFamily: AppFonts.poppins,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    height: 20 / 16,
                    letterSpacing: 16 * -0.02,
                    color: AppColors.textOnLight,
                  ),
                ),
              ),
            ),
          ],
        ),
        if (showActions) ...[
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _StrangerActionButton(
                  label: approveLabel,
                  foreground: AppColors.strangerApprove,
                  onTap: onApprove,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _StrangerActionButton(
                  label: blockLabel,
                  foreground: AppColors.strangerBlock,
                  onTap: onBlock,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _StrangerActionButton(
                  label: rejectLabel,
                  foreground: AppColors.strangerReject,
                  onTap: onReject,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class _StrangerActionButton extends StatelessWidget {
  const _StrangerActionButton({
    required this.label,
    required this.foreground,
    required this.onTap,
  });

  final String label;
  final Color foreground;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: foreground.withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          height: 44,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: AppText(
                  label,
                  style: TextStyle(
                    fontFamily: AppFonts.poppins,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    height: 24 / 16,
                    letterSpacing: 16 * -0.02,
                    color: foreground,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
