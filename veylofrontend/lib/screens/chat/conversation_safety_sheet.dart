import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/data/remote/chat_store.dart';
import 'package:veylo/data/remote/discover_store.dart';
import 'package:veylo/data/remote/safety_repository.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/models/profile/profile_user.dart';
import 'package:veylo/screens/chat/report_reason_sheet.dart';
import 'package:veylo/screens/profile/block_user_sheet.dart';

enum ConversationSafetyAction {
  reportUser,
  blockUser,
  reportMessage,
  reportRoom,
  reportGroup,
  leaveRoom,
  leaveGroup,
}

class _SafetyItem {
  const _SafetyItem({
    required this.action,
    required this.label,
    required this.icon,
    this.danger = false,
  });

  final ConversationSafetyAction action;
  final String label;
  final IconData icon;
  final bool danger;
}

/// Keşfet menüsüyle aynı kabukta sohbet / oda / grup güvenlik seçenekleri.
Future<ConversationSafetyAction?> showConversationSafetySheet(
  BuildContext context, {
  required List<ConversationSafetyAction> actions,
}) {
  return showModalBottomSheet<ConversationSafetyAction>(
    context: context,
    backgroundColor: AppColors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (ctx) {
      final t = Translations.of(ctx).chats;
      final items = <_SafetyItem>[
        for (final a in actions)
          switch (a) {
            ConversationSafetyAction.reportUser => _SafetyItem(
                action: a,
                label: t.reportUser,
                icon: Icons.flag_outlined,
                danger: true,
              ),
            ConversationSafetyAction.blockUser => _SafetyItem(
                action: a,
                label: t.blockUserFull,
                icon: Icons.block,
              ),
            ConversationSafetyAction.reportMessage => _SafetyItem(
                action: a,
                label: t.reportMessage,
                icon: Icons.flag_outlined,
                danger: true,
              ),
            ConversationSafetyAction.reportRoom => _SafetyItem(
                action: a,
                label: t.reportRoom,
                icon: Icons.flag_outlined,
                danger: true,
              ),
            ConversationSafetyAction.reportGroup => _SafetyItem(
                action: a,
                label: t.reportGroup,
                icon: Icons.flag_outlined,
                danger: true,
              ),
            ConversationSafetyAction.leaveRoom => _SafetyItem(
                action: a,
                label: t.leaveRoom,
                icon: Icons.logout_rounded,
              ),
            ConversationSafetyAction.leaveGroup => _SafetyItem(
                action: a,
                label: t.leaveGroup,
                icon: Icons.logout_rounded,
              ),
          },
      ];

      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              const SizedBox(height: 8),
              for (final item in items)
                ListTile(
                  leading: Icon(
                    item.icon,
                    color: item.danger
                        ? const Color(0xFFEC1C24)
                        : AppColors.textPrimary,
                  ),
                  title: AppText(
                    item.label,
                    style: TextStyle(
                      fontFamily: AppFonts.poppins,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: item.danger
                          ? const Color(0xFFEC1C24)
                          : AppColors.textPrimary,
                    ),
                  ),
                  onTap: () => Navigator.of(ctx).pop(item.action),
                ),
            ],
          ),
        ),
      );
    },
  );
}

ProfileUser safetyPeerUser({
  required String id,
  String? username,
  String? displayName,
  String? avatarUrl,
}) =>
    ProfileUser(
      id: id,
      username: username,
      displayName: displayName ?? username ?? '',
      avatarUrl: avatarUrl ?? '',
      bio: '',
      likeCount: 0,
      followCount: 0,
      followerCount: 0,
    );

/// Engelleme sonrası ortak temizlik: inbox + keşfet.
void applyInstantBlockSideEffects(String? userId) {
  if (userId == null || userId.isEmpty) return;
  ChatStore.instance.removeByPeer(userId);
  DiscoverStore.instance.removeByAuthor(userId);
}

Future<void> reportTargetUser(
  BuildContext context, {
  required String userId,
  String contextType = 'PROFILE',
  String? conversationId,
  String? contentId,
  String? details,
}) {
  return showReportReasonSheet(
    context,
    onSubmit: (reason) => SafetyRepository.instance.report(
      userId: userId,
      conversationId: conversationId,
      reason: reason,
      details: details,
      context: contextType,
      contentId: contentId,
    ),
  );
}

Future<void> blockTargetUser(
  BuildContext context, {
  required ProfileUser user,
  String? conversationId,
  VoidCallback? onDone,
  bool leaveScreen = false,
}) {
  return showBlockUserSheet(
    context,
    user: user,
    conversationId: conversationId,
    leaveProfile: leaveScreen,
    onDone: () {
      applyInstantBlockSideEffects(user.id);
      onDone?.call();
    },
  );
}
