import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/models/profile/profile_user.dart';
import 'package:veylo/screens/chat/widgets/chat_note_card.dart';
import 'package:veylo/screens/profile/report_user_sheet.dart';

enum ProfileConfirmAction { block, restrict }

/// Block @user onay sheet’i.
Future<void> showBlockUserSheet(
  BuildContext context, {
  required ProfileUser user,
}) {
  return showProfileConfirmSheet(
    context,
    user: user,
    action: ProfileConfirmAction.block,
  );
}

/// Restrict @user onay sheet’i — Block ile aynı kabuk, farklı metin.
Future<void> showRestrictUserSheet(
  BuildContext context, {
  required ProfileUser user,
}) {
  return showProfileConfirmSheet(
    context,
    user: user,
    action: ProfileConfirmAction.restrict,
  );
}

Future<void> showProfileConfirmSheet(
  BuildContext context, {
  required ProfileUser user,
  required ProfileConfirmAction action,
}) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => BlockUserSheet(
      user: user,
      parentContext: context,
      action: action,
    ),
  );
}

class BlockUserSheet extends StatelessWidget {
  const BlockUserSheet({
    super.key,
    required this.user,
    required this.parentContext,
    this.action = ProfileConfirmAction.block,
  });

  final ProfileUser user;
  final BuildContext parentContext;
  final ProfileConfirmAction action;

  static const _avatarSize = 102.0;
  static const _btnColor = Color(0xFF1A1714);

  String get _handle {
    final u = user.username ?? user.displayName;
    return u.startsWith('@') ? u : '@$u';
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).profile;
    final bottom = MediaQuery.viewPaddingOf(context).bottom;
    final isRestrict = action == ProfileConfirmAction.restrict;
    final title = isRestrict
        ? t.restrictTitle(username: _handle)
        : t.blockTitle(username: _handle);
    final body = isRestrict ? t.restrictBody : t.blockBody;
    final primary = isRestrict ? t.restrict : t.block;
    final secondary = isRestrict ? t.restrictAndReport : t.blockAndReport;

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          Container(
            margin: const EdgeInsets.only(top: _avatarSize / 2),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 66, 16, 20 + bottom),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText(
                    title,
                    style: AppTextStyles.shareProfileTitle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  AppText(
                    body,
                    style: AppTextStyles.shareProfileSubtitle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Material(
                      color: _btnColor,
                      borderRadius: BorderRadius.circular(999),
                      child: InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        borderRadius: BorderRadius.circular(999),
                        child: Center(
                          child: AppText(
                            primary,
                            style: const TextStyle(
                              fontFamily: AppFonts.poppins,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              height: 20 / 16,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (parentContext.mounted) {
                          showReportUserSheet(parentContext, user: user);
                        }
                      });
                    },
                    child: AppText(
                      secondary,
                      style: const TextStyle(
                        fontFamily: AppFonts.poppins,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        height: 20 / 16,
                        color: AppColors.textPrimary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              width: _avatarSize,
              height: _avatarSize,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFE8622A),
                    Color(0xFFF2A05A),
                    Color(0xFFDA87FD),
                  ],
                ),
              ),
              padding: const EdgeInsets.all(3),
              child: ClipOval(
                child: ColoredBox(
                  color: AppColors.white,
                  child: ChatAvatarImage(
                    url: user.avatarUrl,
                    size: _avatarSize - 6,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
