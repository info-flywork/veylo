import 'package:veylo/core/assets/app_assets.dart';

/// Profil çerçevesi kataloğu — id ↔ asset (local / backend ortak).
class ProfileBorder {
  const ProfileBorder({
    required this.id,
    required this.asset,
    required this.tokenCost,
  });

  final String id;
  final String asset;
  final int tokenCost;

  /// Figma sırası: Amethyst → Phoenix → Frost → Emerald → Rose → Starlit → …
  static const catalog = <ProfileBorder>[
    ProfileBorder(
      id: 'amethyst',
      asset: AppAssets.borderAmethystWings,
      tokenCost: 30,
    ),
    ProfileBorder(
      id: 'phoenix',
      asset: AppAssets.borderGoldenPhoenix,
      tokenCost: 50,
    ),
    ProfileBorder(
      id: 'frost',
      asset: AppAssets.borderFrostCrown,
      tokenCost: 30,
    ),
    ProfileBorder(
      id: 'emerald',
      asset: AppAssets.borderEmeraldWhisper,
      tokenCost: 40,
    ),
    ProfileBorder(
      id: 'rose',
      asset: AppAssets.borderRoseQuartz,
      tokenCost: 40,
    ),
    ProfileBorder(
      id: 'starlit',
      asset: AppAssets.borderStarlitComet,
      tokenCost: 50,
    ),
    ProfileBorder(
      id: 'crimson',
      asset: AppAssets.borderCrimsonRoyal,
      tokenCost: 60,
    ),
    ProfileBorder(
      id: 'sapphire',
      asset: AppAssets.borderSapphireHalo,
      tokenCost: 70,
    ),
  ];

  static ProfileBorder? byId(String? id) {
    if (id == null || id.isEmpty) return null;
    for (final item in catalog) {
      if (item.id == id) return item;
    }
    return null;
  }

  static String? assetFor(String? id) => byId(id)?.asset;
}
