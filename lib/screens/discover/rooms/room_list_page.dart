import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/screens/discover/rooms/room_list_item.dart';

/// See All — Groups veya Rooms tam listesi.
class RoomListPage extends StatelessWidget {
  const RoomListPage({
    super.key,
    required this.title,
    required this.items,
    this.isGroup = false,
  });

  final String title;
  final List<RoomListItem> items;
  final bool isGroup;

  static Future<void> open(
    BuildContext context, {
    required String title,
    required List<RoomListItem> items,
    bool isGroup = false,
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => RoomListPage(
          title: title,
          items: items,
          isGroup: isGroup,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.paddingOf(context).top;

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
                    title,
                    style: AppTextStyles.roomsSectionTitle,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 110),
              itemCount: items.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) => RoomListCard(
                item: items[index],
                isGroup: isGroup,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
