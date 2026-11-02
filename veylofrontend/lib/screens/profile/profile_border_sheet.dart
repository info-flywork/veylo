import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/errors/error_messages.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_primary_button.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/data/remote/session_store.dart';
import 'package:veylo/data/remote/user_repository.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/models/profile/profile_border.dart';
import 'package:veylo/screens/profile/widgets/profile_framed_avatar.dart';

/// Figma Profile Border — çerçeve seç / satın al bottom sheet.
///
/// Sunucudaki fiyat / sahiplik ile çalışır: sahip olunan çerçeve takılır, olmayan
/// token ile alınır, "None" çerçeveyi kaldırır. Onaylanınca id döner ('' = yok).
Future<String?> showProfileBorderSheet(
  BuildContext context, {
  String? avatarUrl,
  String? initialBorderId,
}) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => ProfileBorderSheet(
      avatarUrl: avatarUrl ?? SessionStore.instance.me?.avatarUrl ?? '',
      initialBorderId: initialBorderId ?? SessionStore.instance.me?.borderId,
    ),
  );
}

class ProfileBorderSheet extends StatefulWidget {
  const ProfileBorderSheet({
    super.key,
    required this.avatarUrl,
    this.initialBorderId,
  });

  final String avatarUrl;
  final String? initialBorderId;

  @override
  State<ProfileBorderSheet> createState() => _ProfileBorderSheetState();
}

/// "None" kartının seçim id'si (çerçeveyi kaldır).
const _kNoBorder = '';

class _ProfileBorderSheetState extends State<ProfileBorderSheet> {
  late String? _selectedId;

  /// Sunucu kataloğu: id → (fiyat, sahip mi). Yüklenene kadar yerel fiyatlar.
  Map<String, ({int price, bool owned})> _server = const {};

  @override
  void initState() {
    super.initState();
    _selectedId = widget.initialBorderId ?? _kNoBorder;
    _loadBorders();
  }

  Future<void> _loadBorders() async {
    try {
      final items = await UserRepository.instance.borders();
      if (!mounted) return;
      setState(() {
        _server = {
          for (final b in items) b.id: (price: b.price, owned: b.owned),
        };
      });
    } catch (e) {
      if (mounted) showErrorSnackBar(context, e);
    }
  }

  String? get _currentId => SessionStore.instance.me?.borderId;

  bool _owned(String id) => _server[id]?.owned ?? false;

  int _price(ProfileBorder item) => _server[item.id]?.price ?? item.tokenCost;

  String _nameFor(String id) {
    final t = Translations.of(context).profile;
    return switch (id) {
      'amethyst' => t.borderAmethystWings,
      'phoenix' => t.borderGoldenPhoenix,
      'frost' => t.borderFrostCrown,
      'emerald' => t.borderEmeraldWhisper,
      'rose' => t.borderRoseQuartz,
      'starlit' => t.borderStarlitComet,
      'crimson' => t.borderCrimsonRoyal,
      'sapphire' => t.borderSapphireHalo,
      _ => id,
    };
  }

  bool _buying = false;

  /// None → kaldırır; sahip olunan → takar; değilse token ile satın alıp takar.
  Future<void> _confirm() async {
    final id = _selectedId;
    if (id == null || _buying || id == (_currentId ?? _kNoBorder)) return;
    setState(() => _buying = true);
    try {
      final repo = UserRepository.instance;
      if (id == _kNoBorder) {
        await repo.updateProfile({'borderId': null});
      } else if (_owned(id)) {
        await repo.updateProfile({'borderId': id});
      } else {
        await repo.purchaseBorder(id);
      }
      if (!mounted) return;
      Navigator.of(context).pop(id);
    } catch (e) {
      if (mounted) showErrorSnackBar(context, e);
    } finally {
      if (mounted) setState(() => _buying = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).profile;
    final bottom = MediaQuery.viewPaddingOf(context).bottom;
    final selected = ProfileBorder.byId(_selectedId);
    final selectedId = _selectedId;
    final isCurrent = selectedId == (_currentId ?? _kNoBorder);
    final cta = selectedId == _kNoBorder
        ? t.borderRemoveCta
        : (selectedId != null && _owned(selectedId)
              ? t.borderEquipCta
              : t.borderBuyCta);

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, bottom + 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.85,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      ListenableBuilder(
                        listenable: SessionStore.instance,
                        builder: (context, _) => _TokenBalancePill(
                          count: SessionStore.instance.me?.tokenBalance ?? 0,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        behavior: HitTestBehavior.opaque,
                        child: SizedBox(
                          width: 36,
                          height: 36,
                          child: Center(
                            child: SvgPicture.asset(
                              AppAssets.iconClose,
                              width: 28,
                              height: 28,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  AppText(
                    t.borderTitle,
                    style: AppTextStyles.profileBorderTitle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: ProfileFramedAvatar(
                      avatarUrl: widget.avatarUrl,
                      size: 86,
                      borderAsset: selected?.asset,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Figma: 284px genişlik — "öne" ilk satırda kalsın.
                  Center(
                    child: SizedBox(
                      width: 284,
                      child: AppText(
                        t.borderSubtitle,
                        style: AppTextStyles.profileBorderSubtitle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  AppText(
                    t.borderBuySection,
                    style: AppTextStyles.profileBorderSection,
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.only(bottom: 10),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 125 / 180,
                      ),
                      // İlk kart: çerçevesiz ("None").
                      itemCount: ProfileBorder.catalog.length + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return _BorderCard(
                            asset: null,
                            name: t.borderNone,
                            price: '',
                            selected: _selectedId == _kNoBorder,
                            onTap: () =>
                                setState(() => _selectedId = _kNoBorder),
                          );
                        }
                        final item = ProfileBorder.catalog[index - 1];
                        final isSelected = item.id == _selectedId;
                        return _BorderCard(
                          asset: item.asset,
                          name: _nameFor(item.id),
                          price: _owned(item.id)
                              ? t.borderOwned
                              : t.borderToken(count: _price(item)),
                          selected: isSelected,
                          onTap: () => setState(() => _selectedId = item.id),
                        );
                      },
                    ),
                  ),
                  AppPrimaryButton(
                    label: _buying ? '...' : cta,
                    onPressed: _selectedId == null || _buying || isCurrent
                        ? null
                        : _confirm,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BorderCard extends StatelessWidget {
  const _BorderCard({
    required this.asset,
    required this.name,
    required this.price,
    required this.selected,
    required this.onTap,
  });

  /// null = "None" kartı (çerçevesiz).
  final String? asset;
  final String name;
  final String price;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0x1A998FED), // #998FED @ 10% — Figma kart
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected
                ? AppColors.selectionBorder
                : const Color(0x3383A0B4),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: asset == null
                  ? const Center(
                      child: Icon(
                        Icons.block_rounded,
                        size: 48,
                        color: Color(0x3383A0B4),
                      ),
                    )
                  : Image.asset(
                      asset!,
                      fit: BoxFit.contain,
                      width: 105,
                      height: 124,
                    ),
            ),
            const SizedBox(height: 4),
            AppText(
              name,
              style: AppTextStyles.profileBorderName,
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
            const SizedBox(height: 2),
            AppText(
              price,
              style: AppTextStyles.profileBorderPrice,
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}

/// Token bakiyesi — Profil başlığındaki token pill ile aynı görünüm.
class _TokenBalancePill extends StatelessWidget {
  const _TokenBalancePill({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: const Color(0x337B2FFF),
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            AppAssets.iconTokens,
            width: 32,
            height: 32,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 4),
          AppText('$count', style: AppTextStyles.profileTokenCount),
        ],
      ),
    );
  }
}
