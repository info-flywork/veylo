import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/screens/discover/rooms/room_list_item.dart';
import 'package:veylo/screens/discover/rooms/room_list_page.dart';

/// Rooms tab — All Groups + All Rooms bölümleri (See All ile iç sayfa).
class RoomsCatalog extends StatelessWidget {
  const RoomsCatalog({
    super.key,
    this.groups = defaultGroups,
    this.rooms = defaultRooms,
    this.previewCount = 3,
  });

  final List<RoomListItem> groups;
  final List<RoomListItem> rooms;
  final int previewCount;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).discover;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Section(
          title: t.allGroups,
          seeAllLabel: t.seeAll,
          items: groups.take(previewCount).toList(),
          isGroup: true,
          onSeeAll: () => RoomListPage.open(
            context,
            title: t.allGroups,
            items: groups,
            isGroup: true,
          ),
        ),
        const SizedBox(height: 8),
        _Section(
          title: t.allRooms,
          seeAllLabel: t.seeAll,
          items: rooms.take(previewCount).toList(),
          isGroup: false,
          onSeeAll: () => RoomListPage.open(
            context,
            title: t.allRooms,
            items: rooms,
          ),
        ),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({
    required this.title,
    required this.seeAllLabel,
    required this.items,
    required this.onSeeAll,
    this.isGroup = false,
  });

  final String title;
  final String seeAllLabel;
  final List<RoomListItem> items;
  final VoidCallback onSeeAll;
  final bool isGroup;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: Row(
            children: [
              Expanded(
                child: AppText(title, style: AppTextStyles.roomsSectionTitle),
              ),
              GestureDetector(
                onTap: onSeeAll,
                behavior: HitTestBehavior.opaque,
                child: AppText(seeAllLabel, style: AppTextStyles.roomsSeeAll),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: RoomListColumn(items: items, isGroup: isGroup),
        ),
      ],
    );
  }
}
