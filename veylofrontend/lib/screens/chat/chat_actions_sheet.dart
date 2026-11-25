import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/errors/error_messages.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/data/remote/chat_store.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/models/chat/chat_message.dart';
import 'package:veylo/models/chat/chat_thread.dart';
import 'package:veylo/models/profile/profile_user.dart';
import 'package:veylo/screens/chat/conversation_controller.dart';
import 'package:veylo/screens/chat/report_reason_sheet.dart';
import 'package:veylo/screens/profile/block_user_sheet.dart';

enum _ChatMenuAction { mute, block, delete }

/// Figma: Engelle / Sil kırmızısı.
const _kDanger = Color(0xFFD4537E);

/// Sohbet başlığındaki "daha fazla" butonu (Direct / Anonim başlıklarıyla aynı ölçü).
class ChatHeaderMoreButton extends StatelessWidget {
  const ChatHeaderMoreButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        height: 44,
        child: Center(
          child: SvgPicture.asset(
            AppAssets.iconSettings,
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(
              Color(0xFF5F5F5F),
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}

/// Başlıktaki menü: Sessize al / Engelle / Sohbeti sil.
Future<void> showChatActionsMenu(
  BuildContext context,
  ConversationController controller,
) async {
  final thread = controller.thread;
  if (thread.isLocalOnly) return;
  final action = await showModalBottomSheet<_ChatMenuAction>(
    context: context,
    backgroundColor: AppColors.white,
    isScrollControlled: true,
    // Safe area'yı kendimiz yönetiyoruz; çift boşluk olmasın.
    useSafeArea: false,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
    builder: (_) => _ChatActionsSheet(muted: thread.muted),
  );
  if (action == null || !context.mounted) return;

  final navigator = Navigator.of(context);
  switch (action) {
    case _ChatMenuAction.mute:
      try {
        await controller.setMuted(!thread.muted);
      } catch (e) {
        if (context.mounted) showErrorSnackBar(context, e);
      }
    case _ChatMenuAction.block:
      await showBlockUserSheet(
        context,
        user: _peerUser(thread),
        conversationId: thread.id,
        onDone: () => ChatStore.instance.remove(thread.id),
      );
    case _ChatMenuAction.delete:
      try {
        await controller.deleteChat();
        if (navigator.mounted) navigator.pop();
      } catch (e) {
        if (context.mounted) showErrorSnackBar(context, e);
      }
  }
}

Future<void> deleteChatMessage(
  BuildContext context,
  ConversationController controller,
  ChatMessage message,
) async {
  try {
    await controller.deleteMessage(message);
  } catch (e) {
    if (context.mounted) showErrorSnackBar(context, e);
  }
}

Future<void> reportChatMessage(
  BuildContext context,
  ConversationController controller,
  ChatMessage message,
) {
  return showReportReasonSheet(
    context,
    onSubmit: (reason) => controller.reportMessage(message, reason),
  );
}

ProfileUser _peerUser(ChatThread thread) => ProfileUser(
  id: thread.peerUserId ?? '',
  displayName: thread.isAnonymous
      ? (thread.maskedName ?? thread.title)
      : thread.title,
  username: thread.peerUsername,
  avatarUrl: thread.avatarUrl,
  bio: '',
  likeCount: 0,
  followCount: 0,
  followerCount: 0,
);

class _ChatActionsSheet extends StatelessWidget {
  const _ChatActionsSheet({required this.muted});

  final bool muted;

  @override
  Widget build(BuildContext context) {
    final tr = Translations.of(context);
    final bottom = MediaQuery.viewPaddingOf(context).bottom;
    void pick(_ChatMenuAction a) => Navigator.of(context).pop(a);

    return Padding(
      padding: EdgeInsets.fromLTRB(24, 20, 24, 8 + bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ActionItem(
            iconAsset: muted
                ? AppAssets.iconLucideVolume2
                : AppAssets.iconLucideVolumeX,
            label: muted ? tr.chats.unmute : tr.chats.mute,
            color: AppColors.black,
            onTap: () => pick(_ChatMenuAction.mute),
          ),
          _ActionItem(
            iconAsset: AppAssets.iconLucideBan,
            label: tr.profile.block,
            color: _kDanger,
            onTap: () => pick(_ChatMenuAction.block),
          ),
          _ActionItem(
            iconAsset: AppAssets.iconLucideTrash,
            label: tr.chats.deleteChat,
            color: _kDanger,
            onTap: () => pick(_ChatMenuAction.delete),
          ),
        ],
      ),
    );
  }
}

class _ActionItem extends StatelessWidget {
  const _ActionItem({
    required this.iconAsset,
    required this.label,
    required this.onTap,
    required this.color,
  });

  final String iconAsset;
  final String label;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconAsset,
              width: 22,
              height: 22,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
            const SizedBox(width: 10),
            AppText(
              label,
              style: TextStyle(
                fontFamily: AppFonts.poppins,
                fontWeight: FontWeight.w500,
                fontSize: 16,
                height: 20 / 16,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
