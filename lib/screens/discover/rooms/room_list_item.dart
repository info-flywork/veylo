import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/errors/error_messages.dart';
import 'package:veylo/data/remote/chat_repository.dart';
import 'package:veylo/data/remote/chat_store.dart';
import 'package:veylo/data/remote/group_repository.dart';
import 'package:veylo/data/remote/group_store.dart';
import 'package:veylo/models/group/group_models.dart';
import 'package:veylo/screens/chat/widgets/chat_note_card.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/screens/discover/rooms/group_chat_page.dart';
import 'package:veylo/screens/discover/rooms/private_room_request_sheet.dart';
import 'package:veylo/screens/discover/rooms/room_token_sheet.dart';

class RoomListItem {
  const RoomListItem({
    required this.title,
    required this.count,
    required this.isPrivate,
    required this.avatars,
    this.isRequested = false,
    this.id,
    this.memberCount,
    this.isMember = false,
  });

  /// Backend grubu (`GET /groups`): açık grupta [count] aktif üye sayısıdır.
  factory RoomListItem.fromGroup(GroupSummary g) => RoomListItem(
    id: g.id,
    title: g.title,
    count: g.isPrivate ? g.memberCount : g.activeCount,
    memberCount: g.memberCount,
    isPrivate: g.isPrivate,
    isRequested: g.requested,
    isMember: g.isMember,
    // Fotoğrafı olmayan üyeler varsayılan avatarla (kart boş kalmasın).
    avatars: [
      ...g.avatars,
      for (var i = g.avatars.length; i < g.memberCount.clamp(0, 5); i++)
        AppAssets.strangerAvatar,
    ],
  );

  final String title;
  final int count;
  final bool isPrivate;
  final bool isRequested;
  final List<String> avatars;

  /// Gerçek grupta id (demo kartlarda null).
  final String? id;
  final int? memberCount;
  final bool isMember;
}

/// Dummy All Rooms listesi.
const defaultRooms = <RoomListItem>[
  RoomListItem(
    title: 'World Chat',
    count: 120,
    isPrivate: false,
    avatars: [
      AppAssets.fakePerson08,
      AppAssets.fakePerson07,
      AppAssets.fakePerson05,
      AppAssets.fakePerson01,
      AppAssets.fakePerson03,
    ],
  ),
  RoomListItem(
    title: 'The World of Gaming',
    count: 218,
    isPrivate: false,
    avatars: [
      AppAssets.fakePerson04,
      AppAssets.fakePerson06,
      AppAssets.fakePerson02,
      AppAssets.fakePerson08,
      AppAssets.fakePerson05,
    ],
  ),
  RoomListItem(
    title: 'Heart-to-Heart',
    count: 46,
    isPrivate: false,
    avatars: [
      AppAssets.fakePerson07,
      AppAssets.fakePerson01,
      AppAssets.fakePerson03,
      AppAssets.fakePerson05,
      AppAssets.fakePerson02,
    ],
  ),
];

class RoomListCard extends StatelessWidget {
  const RoomListCard({super.key, required this.item, this.isGroup = false});

  final RoomListItem item;
  final bool isGroup;

  static const _privateBg = Color(0xFF111111);
  static const _publicBg = Color(0x1A998FED);

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).discover;
    final locked = item.isPrivate;

    return GestureDetector(
      onTap: () {
        if (item.isRequested) return;
        if (isGroup && item.id != null) {
          _openGroup(context, item);
          return;
        }
        if (isGroup) {
          if (locked) {
            showPrivateRoomRequestSheet(
              context,
              roomTitle: item.title,
              memberCount: item.count,
              isGroup: true,
            );
          } else {
            GroupChatPage.open(
              context,
              title: item.title,
              memberCount: item.count,
              avatars: item.avatars,
            );
          }
          return;
        }
        if (locked) {
          showPrivateRoomRequestSheet(
            context,
            roomTitle: item.title,
            memberCount: item.count,
          );
        } else {
          showRoomTokenSheet(context, roomTitle: item.title);
        }
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: locked ? _privateBg : _publicBg,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            _AvatarBubbles(avatars: item.avatars, blurred: locked),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    item.title,
                    style: AppTextStyles.allRoomTitle.copyWith(
                      color: locked ? AppColors.white : AppColors.black,
                    ),
                    maxLines: 1,
                  ),
                  const SizedBox(height: 4),
                  if (locked)
                    Row(
                      children: [
                        Container(
                          height: 20,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(
                              color: AppColors.white,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.lock_rounded,
                                size: 10,
                                color: AppColors.white,
                              ),
                              const SizedBox(width: 4),
                              AppText(
                                t.private,
                                style: AppTextStyles.allRoomPrivateBadge,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: AppText(
                            t.membersCount(count: item.count.toString()),
                            style: AppTextStyles.allRoomSubtitle.copyWith(
                              color: const Color(0xA6FFFFFF),
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ],
                    )
                  else
                    AppText(
                      t.activeCount(count: item.count.toString()),
                      style: AppTextStyles.allRoomSubtitle,
                      maxLines: 1,
                    ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              height: 32,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              decoration: BoxDecoration(
                color: locked ? _privateBg : const Color(0xFF111111),
                borderRadius: BorderRadius.circular(9999),
                border: locked
                    ? Border.all(color: AppColors.white, width: 1)
                    : null,
              ),
              alignment: Alignment.center,
              child: AppText(
                locked ? (item.isRequested ? t.requested : t.request) : t.join,
                style: AppTextStyles.allRoomAction.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Gerçek grup: üyeysem sohbet, açıksa katıl + sohbet, gizliyse katılma isteği.
Future<void> _openGroup(BuildContext context, RoomListItem item) async {
  final id = item.id!;
  if (item.isPrivate && !item.isMember) {
    await showPrivateRoomRequestSheet(
      context,
      roomTitle: item.title,
      memberCount: item.memberCount ?? item.count,
      isGroup: true,
      groupId: id,
    );
    return;
  }
  try {
    final thread = item.isMember
        ? await ChatRepository.instance.get(id)
        : await GroupRepository.instance.join(id);
    GroupStore.instance.markJoined(id);
    ChatStore.instance.replace(thread);
    if (context.mounted) await GroupChatPage.openThread(context, thread);
    // Dönüşte üye sayısı / ayrılma güncel görünsün.
    GroupStore.instance.refresh();
  } catch (e) {
    if (context.mounted) showErrorSnackBar(context, e);
  }
}

class RoomListColumn extends StatelessWidget {
  const RoomListColumn({super.key, required this.items, this.isGroup = false});

  final List<RoomListItem> items;
  final bool isGroup;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < items.length; i++) ...[
          if (i > 0) const SizedBox(height: 12),
          RoomListCard(item: items[i], isGroup: isGroup),
        ],
      ],
    );
  }
}

class _AvatarBubbles extends StatelessWidget {
  const _AvatarBubbles({required this.avatars, required this.blurred});

  final List<String> avatars;
  final bool blurred;

  static const _layout = <(double left, double top, double size)>[
    (0, 14, 42),
    (28, 0, 32),
    (30, 34, 28),
    (52, 12, 30),
    (56, 42, 22),
  ];

  @override
  Widget build(BuildContext context) {
    final count = avatars.length.clamp(0, _layout.length);
    return SizedBox(
      width: 78,
      height: 69,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          for (var i = 0; i < count; i++)
            Positioned(
              left: _layout[i].$1,
              top: _layout[i].$2,
              child: _Bubble(
                asset: avatars[i],
                size: _layout[i].$3,
                blurred: blurred,
              ),
            ),
        ],
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({
    required this.asset,
    required this.size,
    required this.blurred,
  });

  final String asset;
  final double size;
  final bool blurred;

  @override
  Widget build(BuildContext context) {
    Widget photo = ChatAvatarImage(url: asset, size: size);

    if (blurred) {
      photo = ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: photo,
      );
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: blurred ? const Color(0xFF111111) : AppColors.white,
          width: 1.5,
        ),
      ),
      child: ClipOval(child: photo),
    );
  }
}
