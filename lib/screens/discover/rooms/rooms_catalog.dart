import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/data/remote/group_store.dart';
import 'package:veylo/data/remote/room_store.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/screens/discover/rooms/room_list_item.dart';
import 'package:veylo/screens/discover/rooms/room_list_page.dart';

/// Rooms tab — All Groups + All Rooms bölümleri (See All ile iç sayfa).
/// Gruplar ve canlı odalar backend'den gelir.
class RoomsCatalog extends StatefulWidget {
  const RoomsCatalog({super.key, this.previewCount = 3});

  final int previewCount;

  @override
  State<RoomsCatalog> createState() => _RoomsCatalogState();
}

class _RoomsCatalogState extends State<RoomsCatalog> {
  final _store = GroupStore.instance;
  final _rooms = RoomStore.instance;

  @override
  void initState() {
    super.initState();
    _store.addListener(_onStore);
    _rooms.addListener(_onStore);
    _store.refresh();
    _rooms.refresh();
  }

  @override
  void dispose() {
    _store.removeListener(_onStore);
    _rooms.removeListener(_onStore);
    super.dispose();
  }

  void _onStore() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).discover;
    final groups = [for (final g in _store.groups) RoomListItem.fromGroup(g)];
    final rooms = [for (final r in _rooms.rooms) RoomListItem.fromRoom(r)];
    final previewCount = widget.previewCount;

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
        if (rooms.isNotEmpty) ...[
        const SizedBox(height: 8),
        _Section(
          title: t.allRooms,
          seeAllLabel: t.seeAll,
          items: rooms.take(previewCount).toList(),
          isGroup: false,
          onSeeAll: () =>
              RoomListPage.open(context, title: t.allRooms, items: rooms),
        ),
        ],
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
