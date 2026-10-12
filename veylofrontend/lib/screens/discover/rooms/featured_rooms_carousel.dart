import 'package:flutter/material.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/screens/discover/rooms/room_token_sheet.dart';

class FeaturedRoom {
  const FeaturedRoom({
    required this.title,
    required this.subtitle,
    required this.color,
    required this.avatars,
    required this.moreCount,
  });

  final String title;
  final String subtitle;
  final Color color;
  final List<String> avatars;
  final int moreCount;
}

/// Üstteki 3 renkli Live room kartı (yatay carousel, ortadaki büyür).
class FeaturedRoomsCarousel extends StatefulWidget {
  const FeaturedRoomsCarousel({
    super.key,
    this.rooms = FeaturedRoomsCarousel.defaultRooms,
  });

  static const defaultRooms = <FeaturedRoom>[
    FeaturedRoom(
      title: 'Morning Vibes',
      subtitle: 'Early birds, coffee chats, sunrise talks',
      color: Color(0xFFCDD7F2),
      avatars: [
        AppAssets.fakePerson01,
        AppAssets.fakePerson02,
        AppAssets.fakePerson03,
        AppAssets.fakePerson04,
        AppAssets.fakePerson05,
      ],
      moreCount: 8,
    ),
    FeaturedRoom(
      title: 'Nighttime Chats',
      subtitle: 'Night shift workers, insomniacs, night owls',
      color: Color(0xFFE2F2CD),
      avatars: [
        AppAssets.fakePerson06,
        AppAssets.fakePerson07,
        AppAssets.fakePerson08,
        AppAssets.fakePerson03,
        AppAssets.fakePerson01,
      ],
      moreCount: 12,
    ),
    FeaturedRoom(
      title: 'Night Owls',
      subtitle: 'Night night deep talks and soft music',
      color: Color(0xFFECCDF2),
      avatars: [
        AppAssets.fakePerson02,
        AppAssets.fakePerson05,
        AppAssets.fakePerson04,
        AppAssets.fakePerson08,
        AppAssets.fakePerson07,
      ],
      moreCount: 5,
    ),
  ];

  final List<FeaturedRoom> rooms;

  @override
  State<FeaturedRoomsCarousel> createState() => _FeaturedRoomsCarouselState();
}

class _FeaturedRoomsCarouselState extends State<FeaturedRoomsCarousel> {
  late final PageController _controller;
  double _page = 1;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 0.86, initialPage: 1);
    _controller.addListener(() {
      final p = _controller.page;
      if (p != null && mounted) setState(() => _page = p);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 215,
      child: PageView.builder(
        controller: _controller,
        itemCount: widget.rooms.length,
        itemBuilder: (context, index) {
          final distance = (_page - index).abs().clamp(0.0, 1.0);
          final scale = 1.0 - (distance * 0.08);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: Transform.scale(
              scale: scale,
              alignment: Alignment.center,
              child: _FeaturedRoomCard(room: widget.rooms[index]),
            ),
          );
        },
      ),
    );
  }
}

class _FeaturedRoomCard extends StatelessWidget {
  const _FeaturedRoomCard({required this.room});

  final FeaturedRoom room;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).discover;

    return Container(
      width: 344,
      height: 175,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: room.color,
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
                      room.subtitle,
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
                      width: 34.0 + (room.avatars.length - 1) * 22.0,
                      height: 34,
                      child: Stack(
                        children: [
                          for (var i = 0; i < room.avatars.length; i++)
                            Positioned(
                              left: i * 22.0,
                              child: Container(
                                width: 34,
                                height: 34,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: room.color,
                                    width: 2,
                                  ),
                                ),
                                child: ClipOval(
                                  child: Image.asset(
                                    room.avatars[i],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: AppText(
                        t.moreCount(count: room.moreCount.toString()),
                        style: AppTextStyles.roomMoreCount,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => showRoomTokenSheet(context, roomTitle: room.title),
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
