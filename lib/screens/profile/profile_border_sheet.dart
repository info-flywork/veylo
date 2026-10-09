import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/errors/error_messages.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_primary_button.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/data/local/local_profile_store.dart';
import 'package:veylo/data/mock/profile_mock_repository.dart';
import 'package:veylo/data/remote/session_store.dart';
import 'package:veylo/data/remote/user_repository.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/models/profile/profile_border.dart';
import 'package:veylo/screens/profile/widgets/profile_framed_avatar.dart';

/// Figma Profile Border — çerçeve seç / satın al bottom sheet.
///
/// Seçim onaylanınca local store’a yazılır ve id döner.
Future<String?> showProfileBorderSheet(
  BuildContext context, {
  String? avatarUrl,
  String? initialBorderId,
}) {
  final store = LocalProfileStore.instance;
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => ProfileBorderSheet(
      avatarUrl: avatarUrl ??
          store.apply(ProfileMockRepository.currentUser()).avatarUrl,
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

class _ProfileBorderSheetState extends State<ProfileBorderSheet> {
  late String? _selectedId;

  @override
  void initState() {
    super.initState();
    _selectedId = widget.initialBorderId;
  }

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

  /// Token ile satın alır (sahipse ücret alınmaz) ve takar. Bakiye yetmezse uyarı.
  Future<void> _confirm() async {
    final id = _selectedId;
    if (id == null || _buying) return;
    setState(() => _buying = true);
    try {
      await UserRepository.instance.purchaseBorder(id);
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
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
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
                      itemCount: ProfileBorder.catalog.length,
                      itemBuilder: (context, index) {
                        final item = ProfileBorder.catalog[index];
                        final isSelected = item.id == _selectedId;
                        return _BorderCard(
                          asset: item.asset,
                          name: _nameFor(item.id),
                          price: t.borderToken(count: item.tokenCost),
                          selected: isSelected,
                          onTap: () => setState(() => _selectedId = item.id),
                        );
                      },
                    ),
                  ),
                  AppPrimaryButton(
                    label: t.borderBuyCta,
                    onPressed: _selectedId == null || _buying ? null : _confirm,
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

  final String asset;
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
              child: Image.asset(
                asset,
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
