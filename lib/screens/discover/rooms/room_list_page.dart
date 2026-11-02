import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/data/remote/group_store.dart';
import 'package:veylo/data/remote/room_store.dart';
import 'package:veylo/screens/discover/rooms/room_list_item.dart';

/// See All — Groups veya Rooms tam listesi (store'ları dinler, aşağı çekince yenilenir).
class RoomListPage extends StatefulWidget {
  const RoomListPage({
    super.key,
    required this.title,
    this.isGroup = false,
  });

  final String title;
  final bool isGroup;

  static Future<void> open(
    BuildContext context, {
    required String title,
    bool isGroup = false,
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => RoomListPage(title: title, isGroup: isGroup),
      ),
    );
  }

  @override
  State<RoomListPage> createState() => _RoomListPageState();
}

class _RoomListPageState extends State<RoomListPage> {
  final _groups = GroupStore.instance;
  final _rooms = RoomStore.instance;

  @override
  void initState() {
    super.initState();
    _groups.addListener(_onStore);
    _rooms.addListener(_onStore);
  }

  @override
  void dispose() {
    _groups.removeListener(_onStore);
    _rooms.removeListener(_onStore);
    super.dispose();
  }

  void _onStore() {
    if (mounted) setState(() {});
  }

  Future<void> _refresh() =>
      widget.isGroup ? _groups.refresh() : _rooms.refresh();

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.paddingOf(context).top;
    final isGroup = widget.isGroup;
    final items = isGroup
        ? [for (final g in _groups.groups) RoomListItem.fromGroup(g)]
        : [for (final r in _rooms.rooms) RoomListItem.fromRoom(r)];

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: top + 8),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 16, 0),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 20,
                    color: AppColors.black,
                  ),
                ),
                Expanded(
                  child: AppText(
                    widget.title,
                    style: AppTextStyles.roomsSectionTitle,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refresh,
              color: AppColors.brandPurple,
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 110),
                itemCount: items.length,
                separatorBuilder: (_, _) => const SizedBox(height: 12),
                itemBuilder: (context, index) => RoomListCard(
                  item: items[index],
                  isGroup: isGroup,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
