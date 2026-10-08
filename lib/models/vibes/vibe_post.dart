/// Vibes akışındaki tek kart.
class VibePost {
  const VibePost({
    required this.id,
    required this.name,
    required this.body,
    required this.likeCount,
    required this.dateLabel,
    required this.avatarAsset,
    this.blurred = false,
  });

  final String id;
  final String name;
  final String body;
  final int likeCount;
  final String dateLabel;
  final String avatarAsset;
  final bool blurred;
}
