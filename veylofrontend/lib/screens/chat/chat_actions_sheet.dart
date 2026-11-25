import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/errors/error_messages.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/data/remote/chat_store.dart';
import 'package:veylo/data/remote/discover_store.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/models/chat/chat_message.dart';
import 'package:veylo/screens/chat/conversation_controller.dart';
import 'package:veylo/screens/chat/conversation_safety_sheet.dart';
import 'package:veylo/screens/chat/report_reason_sheet.dart';
import 'package:veylo/screens/profile/block_user_sheet.dart';

enum _ChatMenuAction { mute, report, block, delete }

/// Figma: Engelle / Sil kırmızısı.
const _kDanger = Color(0xFFD4537E);

/// Sohbet başlığındaki "daha fazla" butonu (üç nokta).
class ChatHeaderMoreButton extends StatelessWidget {
  const ChatHeaderMoreButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.opaque,
      child: const SizedBox(
        width: 44,
        height: 44,
        child: Icon(Icons.more_horiz, size: 24, color: Color(0xFF5F5F5F)),
      ),
    );
  }
}

/// Başlıktaki menü: Sessize al / Şikayet / Engelle / Sohbeti sil.
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
    case _ChatMenuAction.report:
      final peerId = thread.peerUserId;
      if (peerId == null) return;
      await reportTargetUser(
        context,
        userId: peerId,
        conversationId: thread.id,
        contextType: 'CHAT',
      );
    case _ChatMenuAction.block:
      await showBlockUserSheet(
        context,
        user: safetyPeerUser(
          id: thread.peerUserId ?? '',
          username: thread.peerUsername,
          displayName: thread.isAnonymous
              ? (thread.maskedName ?? thread.title)
              : thread.title,
          avatarUrl: thread.avatarUrl,
        ),
        conversationId: thread.id,
        // leaveProfile ile onDone.pop birlikte çift pop yapıp siyah ekrana düşüyordu.
        onDone: () {
          applyInstantBlockSideEffects(thread.peerUserId);
          ChatStore.instance.remove(thread.id);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (navigator.mounted) navigator.maybePop();
          });
        },
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
    onSubmit: (reason) async {
      await controller.reportMessage(message, reason);
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(Translations.of(context).profile.reportSent),
          behavior: SnackBarBehavior.floating,
        ),
      );
    },
  );
}

Future<void> blockChatMessageUser(
  BuildContext context,
  ConversationController controller,
  ChatMessage message, {
  bool closeScreen = true,
}) async {
  final thread = controller.thread;
  final userId = message.senderId ?? thread.peerUserId;
  if (userId == null || message.isMine) return;

  await showBlockUserSheet(
    context,
    user: safetyPeerUser(
      id: userId,
      displayName: message.senderName ?? thread.title,
      avatarUrl: message.senderAvatarUrl ?? thread.avatarUrl,
    ),
    conversationId: thread.isGroup ? null : thread.id,
    onDone: () {
      controller.hideMessagesFrom(userId);
      applyInstantBlockSideEffects(userId);
      DiscoverStore.instance.removeByAuthor(userId);
      if (!thread.isGroup) {
        ChatStore.instance.remove(thread.id);
        if (closeScreen) {
          final nav = Navigator.of(context);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (nav.mounted) nav.maybePop();
          });
        }
      }
    },
  );
}

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
            icon: Icons.flag_outlined,
            label: tr.chats.reportUser,
            color: _kDanger,
            onTap: () => pick(_ChatMenuAction.report),
          ),
          _ActionItem(
            iconAsset: AppAssets.iconLucideBan,
            label: tr.chats.blockUserFull,
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
    this.iconAsset,
    this.icon,
    required this.label,
    required this.onTap,
    required this.color,
  }) : assert(iconAsset != null || icon != null);

  final String? iconAsset;
  final IconData? icon;
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
            if (iconAsset != null)
              SvgPicture.asset(
                iconAsset!,
                width: 22,
                height: 22,
                colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
              )
            else
              Icon(icon, size: 22, color: color),
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
