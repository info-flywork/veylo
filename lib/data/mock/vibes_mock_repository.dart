import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/models/vibes/vibe_post.dart';

/// Geçici mock — Figma Conversation Cards listesi + paylaşılan vibes.
class VibesMockRepository {
  const VibesMockRepository._();

  static final List<VibePost> _posts = [
    VibePost(
      id: 'vibe_1',
      name: 'Julia Ivanova',
      body: '“Eski sevgiliyi unutamamak”',
      likeCount: 126,
      dateLabel: '18 Feb 2026',
      avatarAsset: AppAssets.fakePerson01,
    ),
    VibePost(
      id: 'vibe_2',
      name: 'Julia Ivanova',
      body: '"sadece arkadaşız" diyip aslında öyle olmamak',
      likeCount: 95,
      dateLabel: '18 Feb 2026',
      avatarAsset: AppAssets.fakePerson05,
    ),
    VibePost(
      id: 'vibe_3',
      name: 'L***',
      body: "gece 3'te uyuyamayanlar kulübü",
      likeCount: 65,
      dateLabel: '18 Feb 2026',
      avatarAsset: AppAssets.fakePerson02,
      blurred: true,
    ),
    VibePost(
      id: 'vibe_4',
      name: 'L***',
      body: 'kafamda kurduğum senaryolar',
      likeCount: 37,
      dateLabel: '17 Feb 2026',
      avatarAsset: AppAssets.fakePerson04,
      blurred: true,
    ),
    VibePost(
      id: 'vibe_5',
      name: 'J*******',
      body: 'kafamda kurduğum senaryolar',
      likeCount: 16,
      dateLabel: '16 Feb 2026',
      avatarAsset: AppAssets.fakePerson06,
      blurred: true,
    ),
    VibePost(
      id: 'vibe_6',
      name: 'J*******',
      body: 'gece düşünceleri gündüz mantıksız gelir mi?',
      likeCount: 12,
      dateLabel: '16 Feb 2026',
      avatarAsset: AppAssets.fakePerson08,
      blurred: true,
    ),
  ];

  static List<VibePost> posts() => List<VibePost>.from(_posts);

  /// Paylaşılan vibe — listenin en üstüne ekler.
  static VibePost addShared({
    required String body,
    required bool anonymous,
    required String displayName,
    required String avatarAsset,
  }) {
    final trimmed = body.trim();
    final name = anonymous ? _maskName(displayName) : displayName.trim();
    final post = VibePost(
      id: 'vibe_${DateTime.now().millisecondsSinceEpoch}',
      name: name.isEmpty ? (anonymous ? 'A***' : 'You') : name,
      body: trimmed,
      likeCount: 0,
      dateLabel: _todayLabel(DateTime.now()),
      avatarAsset: avatarAsset,
      blurred: anonymous,
    );
    _posts.insert(0, post);
    return post;
  }

  static String _maskName(String name) {
    final t = name.trim();
    if (t.isEmpty) return 'A***';
    return '${t[0].toUpperCase()}***';
  }

  static String _todayLabel(DateTime d) {
    const months = <String>[
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${d.day} ${months[d.month - 1]} ${d.year}';
  }
}
