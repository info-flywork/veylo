import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/models/chat/chat_message.dart';
import 'package:veylo/screens/chat/chat_sticker.dart';

enum MessageMenuAction { reply, copy, edit, delete, report }

/// Uzun basınca: üstte emoji tepkileri, altta Yanıtla / Kopyala / Düzenle / Sil.
Future<void> showMessageContextMenu(
  BuildContext context, {
  required ChatMessage message,
  required ValueChanged<String> onReact,
  required ValueChanged<MessageMenuAction> onAction,
}) async {
  final t = Translations.of(context).chats;
  final copyable = message.type == 'TEXT' &&
      ChatSticker.assetOf(message.body) == null &&
      (message.body?.trim().isNotEmpty ?? false);
  final canEdit = message.canEdit;
  final canDelete = message.status != ChatMessageStatus.sending;
  final canReport = !message.isMine && message.id != null;

  await showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    barrierColor: AppColors.black.withValues(alpha: 0.35),
    builder: (ctx) {
      final bottom = MediaQuery.viewPaddingOf(ctx).bottom;
      return Padding(
        padding: EdgeInsets.fromLTRB(16, 0, 16, 12 + bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (message.id != null) ...[
              Material(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(28),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (final emoji in kChatReactionEmojis)
                        InkWell(
                          onTap: () {
                            Navigator.of(ctx).pop();
                            onReact(emoji);
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(emoji, style: const TextStyle(fontSize: 28)),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
            Material(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _MenuRow(
                    icon: Icons.reply_rounded,
                    label: t.messageReply,
                    onTap: () {
                      Navigator.of(ctx).pop();
                      onAction(MessageMenuAction.reply);
                    },
                  ),
                  if (copyable)
                    _MenuRow(
                      icon: Icons.content_copy_rounded,
                      label: t.messageCopy,
                      onTap: () {
                        Navigator.of(ctx).pop();
                        onAction(MessageMenuAction.copy);
                      },
                    ),
                  if (canEdit)
                    _MenuRow(
                      icon: Icons.edit_rounded,
                      label: t.messageEdit,
                      onTap: () {
                        Navigator.of(ctx).pop();
                        onAction(MessageMenuAction.edit);
                      },
                    ),
                  if (canReport)
                    _MenuRow(
                      icon: Icons.flag_rounded,
                      label: t.messageReport,
                      onTap: () {
                        Navigator.of(ctx).pop();
                        onAction(MessageMenuAction.report);
                      },
                    ),
                  if (canDelete)
                    _MenuRow(
                      icon: Icons.delete_outline_rounded,
                      label: t.messageDelete,
                      danger: true,
                      onTap: () {
                        Navigator.of(ctx).pop();
                        onAction(MessageMenuAction.delete);
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

class _MenuRow extends StatelessWidget {
  const _MenuRow({
    required this.icon,
    required this.label,
    required this.onTap,
    this.danger = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    final color = danger ? const Color(0xFFD4537E) : AppColors.textOnLight;
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 52,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Icon(icon, size: 22, color: color),
              const SizedBox(width: 14),
              Expanded(
                child: AppText(
                  label,
                  style: TextStyle(
                    fontFamily: AppFonts.poppins,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> copyChatMessageText(BuildContext context, ChatMessage message) async {
  await Clipboard.setData(ClipboardData(text: message.body ?? ''));
  if (!context.mounted) return;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(Translations.of(context).chats.messageCopied),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
