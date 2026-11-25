import 'package:flutter/material.dart';
import 'package:veylo/core/errors/error_messages.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/data/remote/api_client.dart';
import 'package:veylo/data/remote/chat_store.dart';
import 'package:veylo/data/remote/discover_store.dart';
import 'package:veylo/data/remote/post_repository.dart';
import 'package:veylo/data/remote/safety_repository.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/models/discover/post.dart';
import 'package:veylo/models/profile/profile_user.dart';
import 'package:veylo/screens/chat/report_reason_sheet.dart';
import 'package:veylo/screens/profile/block_user_sheet.dart';

enum PostSafetyAction { report, block }

/// Başkasının gönderisi: Şikayet Et / Kullanıcıyı Engelle.
Future<PostSafetyAction?> showPostSafetyActionsSheet(BuildContext context) {
  return showModalBottomSheet<PostSafetyAction>(
    context: context,
    backgroundColor: AppColors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (ctx) {
      final t = Translations.of(ctx).discover.post;
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
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.flag_outlined, color: Color(0xFFEC1C24)),
                title: AppText(
                  t.report,
                  style: const TextStyle(
                    fontFamily: AppFonts.poppins,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: AppColors.textPrimary,
                  ),
                ),
                onTap: () => Navigator.of(ctx).pop(PostSafetyAction.report),
              ),
              ListTile(
                leading: const Icon(Icons.block, color: AppColors.textPrimary),
                title: AppText(
                  t.block,
                  style: const TextStyle(
                    fontFamily: AppFonts.poppins,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: AppColors.textPrimary,
                  ),
                ),
                onTap: () => Navigator.of(ctx).pop(PostSafetyAction.block),
              ),
            ],
          ),
        ),
      );
    },
  );
}

/// Gönderi şikayet / engelle akışı; başarıda akıştan anında gizler.
Future<void> handlePostSafetyAction(
  BuildContext context,
  Post post, {
  PostSafetyAction? preset,
  VoidCallback? onRemoved,
}) async {
  final action = preset ?? await showPostSafetyActionsSheet(context);
  if (!context.mounted || action == null) return;
  final messenger = ScaffoldMessenger.of(context);
  final t = Translations.of(context).discover.post;

  switch (action) {
    case PostSafetyAction.report:
      await showReportReasonSheet(
        context,
        onSubmit: (reason) async {
          await PostRepository.instance.report(post.id, reason: reason);
          DiscoverStore.instance.remove(post.id);
          onRemoved?.call();
        },
      );
    case PostSafetyAction.block:
      final user = ProfileUser(
        id: post.authorId,
        username: post.authorUsername,
        displayName: post.authorName,
        avatarUrl: post.authorAvatarUrl ?? '',
        bio: '',
        likeCount: 0,
        followCount: 0,
        followerCount: 0,
      );
      await showBlockUserSheet(
        context,
        user: user,
        onDone: () {
          DiscoverStore.instance.removeByAuthor(post.authorId);
          onRemoved?.call();
          messenger.showSnackBar(
            SnackBar(content: Text(t.hiddenAfterBlock), behavior: SnackBarBehavior.floating),
          );
        },
      );
  }
}

/// Oda / sohbet üst barı için şikayet + engelle.
Future<void> handlePeerSafetyFromRoom(
  BuildContext context, {
  required String userId,
  String? username,
  String? displayName,
  String? avatarUrl,
}) async {
  final action = await showPostSafetyActionsSheet(context);
  if (!context.mounted || action == null) return;
  if (!SafetyRepository.isRealUser(userId)) {
    showErrorSnackBar(context, const ApiException(status: 404, code: 'PEER_UNAVAILABLE'));
    return;
  }
  final user = ProfileUser(
    id: userId,
    username: username,
    displayName: displayName ?? username ?? '',
    avatarUrl: avatarUrl ?? '',
    bio: '',
    likeCount: 0,
    followCount: 0,
    followerCount: 0,
  );
  switch (action) {
    case PostSafetyAction.report:
      await showReportReasonSheet(
        context,
        onSubmit: (reason) => SafetyRepository.instance.report(
          userId: userId,
          reason: reason,
        ),
      );
    case PostSafetyAction.block:
      await showBlockUserSheet(
        context,
        user: user,
        onDone: () {
          DiscoverStore.instance.removeByAuthor(userId);
          ChatStore.instance.removeByPeer(userId);
        },
      );
  }
}
