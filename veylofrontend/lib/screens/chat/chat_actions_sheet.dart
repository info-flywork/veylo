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
import 'package:veylo/screens/profile/report_user_sheet.dart';

enum _ChatMenuAction { mute, report, block, delete }

/// Sohbet başlığındaki "daha fazla" butonu (Direct / Anonim başlıklarıyla aynı ölçü).
class ChatHeaderMoreButton extends StatelessWidget {
  const ChatHeaderMoreButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(minWidth: 32, minHeight: 44),
      icon: SvgPicture.asset(
        AppAssets.iconMoreOptions,
        width: 24,
        height: 24,
        colorFilter: const ColorFilter.mode(
          AppColors.textOnLight,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}

/// Başlıktaki menü: Sessize al / Şikayet et / Engelle / Sohbeti sil.
/// Silme sonrası sohbet ekranı kapanır.
Future<void> showChatActionsMenu(
  BuildContext context,
  ConversationController controller,
) async {
  final thread = controller.thread;
  if (thread.isLocalOnly) return;
  final action = await showModalBottomSheet<_ChatMenuAction>(
    context: context,
    backgroundColor: AppColors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
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
      await showReportUserSheet(
        context,
        user: _peerUser(thread),
        conversationId: thread.id,
      );
    case _ChatMenuAction.block:
      await showBlockUserSheet(
        context,
        user: _peerUser(thread),
        conversationId: thread.id,
        // Ekran açık kalır: "Engelle ve şikayet et" şikayet penceresini bu ekranda açar.
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

/// Mesaj balonundaki Sil: kendi mesajım herkesten, karşı tarafınki yalnızca benden.
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

/// Mesaj balonundaki Şikayet Et: sebep seçilir, mesaj id'siyle gönderilir.
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

/// Anonim sohbette kullanıcı id'si bilinmez; işlemler sohbet üzerinden yapılır.
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
      padding: EdgeInsets.fromLTRB(16, 12, 16, 8 + bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ActionItem(
            label: muted ? tr.chats.unmute : tr.chats.mute,
            color: AppColors.textPrimary,
            onTap: () => pick(_ChatMenuAction.mute),
          ),
          _ActionItem(
            label: tr.profile.report,
            onTap: () => pick(_ChatMenuAction.report),
          ),
          _ActionItem(
            label: tr.profile.block,
            onTap: () => pick(_ChatMenuAction.block),
          ),
          _ActionItem(
            label: tr.chats.deleteChat,
            onTap: () => pick(_ChatMenuAction.delete),
          ),
        ],
      ),
    );
  }
}

/// Profil menüsündeki satırla aynı görünüm.
class _ActionItem extends StatelessWidget {
  const _ActionItem({
    required this.label,
    required this.onTap,
    this.color = const Color(0xFFD4537E),
  });

  final String label;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: Center(
          child: AppText(
            label,
            style: TextStyle(
              fontFamily: AppFonts.poppins,
              fontWeight: FontWeight.w500,
              fontSize: 16,
              height: 20 / 16,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}
