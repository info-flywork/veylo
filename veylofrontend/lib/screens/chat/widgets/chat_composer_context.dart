import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/models/chat/chat_message.dart';
import 'package:veylo/screens/chat/chat_sticker.dart';

/// Composer üstünde yanıt / düzenleme şeridi.
class ChatComposerContextBar extends StatelessWidget {
  const ChatComposerContextBar({
    super.key,
    this.reply,
    this.editing,
    required this.onClear,
  });

  final ChatMessage? reply;
  final ChatMessage? editing;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final target = editing ?? reply;
    if (target == null) return const SizedBox.shrink();
    final t = Translations.of(context).chats;
    final isEdit = editing != null;
    final preview = ChatSticker.assetOf(target.body) != null
        ? t.previewSticker
        : target.type == 'TEXT'
        ? (target.body ?? '')
        : target.displayText;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      padding: const EdgeInsets.fromLTRB(12, 8, 4, 8),
      decoration: BoxDecoration(
        color: AppColors.inputFill,
        borderRadius: BorderRadius.circular(12),
        border: const Border(
          left: BorderSide(color: AppColors.selectionBorder, width: 3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            isEdit ? Icons.edit_rounded : Icons.reply_rounded,
            size: 18,
            color: AppColors.selectionBorder,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  isEdit ? t.messageEditing : t.messageReplying,
                  style: const TextStyle(
                    fontFamily: AppFonts.poppins,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: AppColors.selectionBorder,
                  ),
                ),
                AppText(
                  preview,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: AppFonts.poppins,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    color: AppColors.textOnLight.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onClear,
            icon: const Icon(Icons.close_rounded, size: 20),
            color: AppColors.textOnLight.withValues(alpha: 0.55),
          ),
        ],
      ),
    );
  }
}
