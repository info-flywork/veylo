import 'package:flutter/material.dart';
import 'package:veylo/screens/discover/rooms/featured_rooms_carousel.dart';
import 'package:veylo/screens/discover/rooms/rooms_catalog.dart';

/// Rooms sekmesi — featured carousel + All Groups / All Rooms.
class RoomsTab extends StatelessWidget {
  const RoomsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FeaturedRoomsCarousel(),
        RoomsCatalog(),
      ],
    );
  }
}
