import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/core/widgets/profile_tappable_avatar.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/screens/discover/rooms/group_info_page.dart';
import 'package:veylo/screens/profile/profile_navigation.dart';

class _GroupMessage {
  const _GroupMessage({
    required this.name,
    required this.body,
    required this.avatar,
    this.isMine = false,
  });

  final String name;
  final String body;
  final String avatar;
  final bool isMine;
}

/// Grup kartına tıklanınca açılan sohbet ekranı (Nighttime Chats).
class GroupChatPage extends StatelessWidget {
  const GroupChatPage({
    super.key,
    required this.title,
    required this.memberCount,
    this.avatars = const [
      AppAssets.fakePerson02,
      AppAssets.fakePerson01,
      AppAssets.fakePerson05,
    ],
  });

  final String title;
  final int memberCount;
  final List<String> avatars;

  static Future<void> open(
    BuildContext context, {
    required String title,
    required int memberCount,
    List<String>? avatars,
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => GroupChatPage(
          title: title,
          memberCount: memberCount,
          avatars: avatars ??
              const [
                AppAssets.fakePerson02,
                AppAssets.fakePerson01,
                AppAssets.fakePerson05,
              ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).discover.groupChat;
    final live = Translations.of(context).discover.liveRoom;
    final top = MediaQuery.paddingOf(context).top;
    final bottom = MediaQuery.paddingOf(context).bottom;

    final messages = [
      _GroupMessage(
        name: 'Victoria',
        body: t.sampleVictoria,
        avatar: AppAssets.fakePerson05,
      ),
      _GroupMessage(
        name: 'Sona',
        body: t.sampleSona,
        avatar: AppAssets.fakePerson03,
      ),
      _GroupMessage(
        name: '',
        body: t.sampleOwn,
        avatar: AppAssets.fakePerson01,
        isMine: true,
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ColoredBox(
            color: AppColors.white,
            child: Padding(
              padding: EdgeInsets.fromLTRB(8, top + 4, 16, 10),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 18,
                      color: AppColors.black,
                    ),
                  ),
                  _HeaderAvatars(avatars: avatars),
                  const SizedBox(width: 8),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => GroupInfoPage.open(
                        context,
                        title: title,
                        memberCount: memberCount,
                      ),
                      behavior: HitTestBehavior.opaque,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            title,
                            style: AppTextStyles.groupChatTitle,
                            maxLines: 1,
                          ),
                          const SizedBox(height: 2),
                          AppText(
                            t.usersCount(count: memberCount.toString()),
                            style: AppTextStyles.groupChatUsers,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 1,
            color: AppColors.black.withValues(alpha: 0.10),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
              itemCount: messages.length,
              separatorBuilder: (_, _) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                return _GroupChatBubble(message: messages[index]);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              16,
              8,
              16,
              bottom > 0 ? bottom : 8,
            ),
            child: _GroupMessageInput(hint: live.messageHint),
          ),
        ],
      ),
    );
  }
}

class _HeaderAvatars extends StatelessWidget {
  const _HeaderAvatars({required this.avatars});

  final List<String> avatars;

  @override
  Widget build(BuildContext context) {
    final shown = avatars.take(3).toList();
    const size = 28.0;
    const overlap = 16.0;
    final width = size + (shown.length - 1) * overlap;

    return SizedBox(
      width: width,
      height: size,
      child: Stack(
        children: [
          for (var i = 0; i < shown.length; i++)
            Positioned(
              left: i * overlap,
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.white, width: 1.5),
                ),
                child: ProfileTappableAvatar(
                  avatarUrl: shown[i],
                  size: size,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _GroupChatBubble extends StatelessWidget {
  const _GroupChatBubble({required this.message});

  final _GroupMessage message;

  static const _incomingBg = Color(0x1A998FED); // #998FED @ 10%

  @override
  Widget build(BuildContext context) {
    if (message.isMine) {
      return Align(
        alignment: Alignment.centerRight,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.sizeOf(context).width * 0.75,
          ),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: AppColors.selectionBorder,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(4),
              ),
            ),
            child: AppText(
              message.body,
              style: AppTextStyles.groupChatOwnBody,
            ),
          ),
        ),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileTappableAvatar(
          avatarUrl: message.avatar,
          size: 44,
          displayName: message.name,
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => openUserProfile(
                  context,
                  displayName: message.name,
                  avatarUrl: message.avatar,
                ),
                child: AppText(
                  message.name,
                  style: AppTextStyles.groupChatSender,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: _incomingBg,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                ),
                child: AppText(
                  message.body,
                  style: AppTextStyles.groupChatBody,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _GroupMessageInput extends StatelessWidget {
  const _GroupMessageInput({required this.hint});

  final String hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.fromLTRB(6, 6, 10, 6),
      decoration: BoxDecoration(
        color: AppColors.sheetMuted,
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.selectionBorder,
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              AppAssets.cameraIcon,
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                AppColors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              style: AppTextStyles.liveRoomMessageHint,
              cursorColor: AppColors.selectionBorder,
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: hint,
                hintStyle: AppTextStyles.liveRoomMessageHint,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          const SizedBox(width: 6),
          SvgPicture.asset(
            AppAssets.iconSticker,
            width: 28,
            height: 28,
          ),
          const SizedBox(width: 8),
          SvgPicture.asset(
            AppAssets.imageIcon,
            width: 28,
            height: 28,
          ),
          const SizedBox(width: 8),
          SvgPicture.asset(
            AppAssets.iconMicrophone,
            width: 28,
            height: 28,
          ),
        ],
      ),
    );
  }
}
