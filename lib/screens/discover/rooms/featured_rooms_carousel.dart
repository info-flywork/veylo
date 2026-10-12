import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/data/remote/room_store.dart';
import 'package:veylo/models/room/live_room.dart';
import 'package:veylo/screens/chat/widgets/chat_note_card.dart';
import 'package:veylo/screens/discover/rooms/room_list_item.dart';

/// Üstteki renkli Live room kartları (yatay carousel, ortadaki büyür).
/// En kalabalık 3 canlı oda; hiç oda yoksa gizlenir.
class FeaturedRoomsCarousel extends StatefulWidget {
  const FeaturedRoomsCarousel({super.key});

  static const colors = <Color>[
    Color(0xFFCDD7F2),
    Color(0xFFE2F2CD),
    Color(0xFFECCDF2),
  ];

  @override
  State<FeaturedRoomsCarousel> createState() => _FeaturedRoomsCarouselState();
}

class _FeaturedRoomsCarouselState extends State<FeaturedRoomsCarousel> {
  late final PageController _controller;
  final _store = RoomStore.instance;
  double _page = 1;

  @override
  void initState() {
    super.initState();
    _store.addListener(_onStore);
    _controller = PageController(viewportFraction: 0.86, initialPage: 1);
    _controller.addListener(() {
      final p = _controller.page;
      if (p != null && mounted) setState(() => _page = p);
    });
  }

  @override
  void dispose() {
    _store.removeListener(_onStore);
    _controller.dispose();
    super.dispose();
  }

  void _onStore() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final rooms = _store.rooms.take(3).toList();
    if (rooms.isEmpty) return const SizedBox.shrink();
    return SizedBox(
      height: 215,
      child: PageView.builder(
        controller: _controller,
        itemCount: rooms.length,
        itemBuilder: (context, index) {
          final distance = (_page - index).abs().clamp(0.0, 1.0);
          final scale = 1.0 - (distance * 0.08);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: Transform.scale(
              scale: scale,
              alignment: Alignment.center,
              child: _FeaturedRoomCard(
                room: rooms[index],
                color: FeaturedRoomsCarousel
                    .colors[index % FeaturedRoomsCarousel.colors.length],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _FeaturedRoomCard extends StatelessWidget {
  const _FeaturedRoomCard({required this.room, required this.color});

  final LiveRoomSummary room;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).discover;
    final item = RoomListItem.fromRoom(room);
    final avatars = item.avatars;
    final more = (room.participantCount - avatars.length).clamp(0, 1 << 30);

    return Container(
      width: 344,
      height: 175,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      room.title,
                      style: AppTextStyles.roomCardTitle,
                      maxLines: 1,
                    ),
                    const SizedBox(height: 4),
                    AppText(
                      t.hostedBy(name: room.host.displayName),
                      style: AppTextStyles.roomCardSubtitle,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                height: 28,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(9999),
                ),
                alignment: Alignment.center,
                child: AppText(t.live, style: AppTextStyles.roomLiveBadge),
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    SizedBox(
                      width: 34.0 + (avatars.length - 1) * 22.0,
                      height: 34,
                      child: Stack(
                        children: [
                          for (var i = 0; i < avatars.length; i++)
                            Positioned(
                              left: i * 22.0,
                              child: Container(
                                width: 34,
                                height: 34,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: color,
                                    width: 2,
                                  ),
                                ),
                                child: ClipOval(
                                  child: ChatAvatarImage(
                                    url: avatars[i],
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (more > 0)
                    Flexible(
                      child: AppText(
                        t.moreCount(count: more.toString()),
                        style: AppTextStyles.roomMoreCount,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => openLiveRoom(context, item),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  height: 40,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  alignment: Alignment.center,
                  child: AppText(t.join, style: AppTextStyles.roomJoin),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
