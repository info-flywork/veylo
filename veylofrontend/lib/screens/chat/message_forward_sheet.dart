import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/data/remote/chat_store.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/models/chat/chat_message.dart';
import 'package:veylo/models/chat/chat_thread.dart';
import 'package:veylo/screens/chat/conversation_controller.dart';
import 'package:veylo/screens/chat/widgets/chat_note_card.dart';

/// Mesajı başka bir sohbete ilet (WhatsApp tarzı).
Future<void> showMessageForwardSheet(
  BuildContext context, {
  required ConversationController controller,
  required ChatMessage message,
}) async {
  final currentId = controller.thread.id;
  final targets = ChatStore.instance.inbox
      .where((t) => t.id != currentId && !t.isLocalOnly)
      .toList();
  final t = Translations.of(context).chats;

  final picked = await showModalBottomSheet<ChatThread>(
    context: context,
    backgroundColor: AppColors.white,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (ctx) {
      final bottom = MediaQuery.viewPaddingOf(ctx).bottom;
      return SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 12, 16, 12 + bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 46,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.sheetHandle,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              AppText(
                t.forwardTitle,
                style: const TextStyle(
                  fontFamily: AppFonts.poppins,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 12),
              if (targets.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 28),
                  child: AppText(
                    t.forwardEmpty,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: AppFonts.poppins,
                      fontSize: 14,
                      color: AppColors.black.withValues(alpha: 0.5),
                    ),
                  ),
                )
              else
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.sizeOf(ctx).height * 0.5,
                  ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: targets.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 8),
                    itemBuilder: (_, i) {
                      final thread = targets[i];
                      final title = thread.isAnonymous
                          ? (thread.maskedName ?? thread.title)
                          : thread.title;
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: ChatAvatarImage(
                          url: thread.avatarUrl,
                          size: 44,
                        ),
                        title: AppText(
                          title,
                          maxLines: 1,
                          style: const TextStyle(
                            fontFamily: AppFonts.poppins,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        onTap: () => Navigator.of(ctx).pop(thread),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      );
    },
  );

  if (picked == null || !context.mounted) return;
  try {
    await controller.forwardTo(picked, message);
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(t.forwardSent),
        behavior: SnackBarBehavior.floating,
      ),
    );
  } catch (e) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$e'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
