import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/models/profile/follow_user.dart';

class FollowMockRepository {
  const FollowMockRepository._();

  static final _now = DateTime(2026, 10, 8);

  /// Takip ettiklerim — karışık reciprocal / one-way.
  static final following = <FollowUser>[
    FollowUser(
      id: 'f1',
      displayName: 'Julia Ivanova',
      avatarUrl: AppAssets.fakePerson01,
      badge: FollowBadge.goldenDiamond,
      iFollow: true,
      followsMe: false, // beni takip etmiyor
      followedAt: _now.subtract(const Duration(hours: 2)),
    ),
    FollowUser(
      id: 'f2',
      displayName: 'Sona Iglesias',
      avatarUrl: AppAssets.fakePerson02,
      badge: FollowBadge.goldenDiamond,
      iFollow: true,
      followsMe: true,
      followedAt: _now.subtract(const Duration(days: 1)),
    ),
    FollowUser(
      id: 'f3',
      displayName: 'Jessica Blues',
      avatarUrl: AppAssets.fakePerson05,
      badge: FollowBadge.crown,
      iFollow: true,
      followsMe: false, // beni takip etmiyor
      followedAt: _now.subtract(const Duration(hours: 5)),
    ),
    FollowUser(
      id: 'f4',
      displayName: 'Victoria',
      avatarUrl: AppAssets.fakePerson06,
      badge: FollowBadge.crown,
      iFollow: true,
      followsMe: true,
      followedAt: _now.subtract(const Duration(days: 4)),
    ),
    FollowUser(
      id: 'f5',
      displayName: 'Lyra Night',
      avatarUrl: AppAssets.fakePerson07,
      badge: FollowBadge.goldenDiamond,
      iFollow: true,
      followsMe: false,
      followedAt: _now.subtract(const Duration(minutes: 40)),
    ),
    FollowUser(
      id: 'f6',
      displayName: 'Clara Moss',
      avatarUrl: AppAssets.fakePerson04,
      badge: FollowBadge.crown,
      iFollow: true,
      followsMe: true,
      followedAt: _now.subtract(const Duration(days: 12)),
    ),
  ];

  /// Takipçilerim — karışık reciprocal / one-way.
  static final followers = <FollowUser>[
    FollowUser(
      id: 'r1',
      displayName: 'Maya Ross',
      avatarUrl: AppAssets.fakePerson08,
      badge: FollowBadge.goldenDiamond,
      followsMe: true,
      iFollow: false, // ben takip etmiyorum
      followedAt: _now.subtract(const Duration(hours: 3)),
    ),
    FollowUser(
      id: 'r2',
      displayName: 'Sona Iglesias',
      avatarUrl: AppAssets.fakePerson02,
      badge: FollowBadge.goldenDiamond,
      followsMe: true,
      iFollow: true,
      followedAt: _now.subtract(const Duration(days: 2)),
    ),
    FollowUser(
      id: 'r3',
      displayName: 'Ella Park',
      avatarUrl: AppAssets.fakePerson03,
      badge: FollowBadge.crown,
      followsMe: true,
      iFollow: false, // ben takip etmiyorum
      followedAt: _now.subtract(const Duration(hours: 8)),
    ),
    FollowUser(
      id: 'r4',
      displayName: 'Victoria',
      avatarUrl: AppAssets.fakePerson06,
      badge: FollowBadge.crown,
      followsMe: true,
      iFollow: true,
      followedAt: _now.subtract(const Duration(days: 6)),
    ),
    FollowUser(
      id: 'r5',
      displayName: 'Noah Blake',
      avatarUrl: AppAssets.fakePerson07,
      badge: FollowBadge.goldenDiamond,
      followsMe: true,
      iFollow: false,
      followedAt: _now.subtract(const Duration(minutes: 90)),
    ),
    FollowUser(
      id: 'r6',
      displayName: 'Sarah Kim',
      avatarUrl: AppAssets.fakePerson01,
      badge: FollowBadge.crown,
      followsMe: true,
      iFollow: true,
      followedAt: _now.subtract(const Duration(days: 20)),
    ),
  ];
}
