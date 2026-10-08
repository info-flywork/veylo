import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_primary_button.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/models/profile/follow_user.dart';

/// Sırala bottom sheet — seçilen filtreyi döner (iptalde null).
Future<FollowSortFilter?> showFollowSortSheet(
  BuildContext context, {
  FollowSortFilter initial = FollowSortFilter.notFollowingMeBack,
}) {
  return showModalBottomSheet<FollowSortFilter>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    useSafeArea: false,
    builder: (context) => _FollowSortSheet(initial: initial),
  );
}

class _FollowSortSheet extends StatefulWidget {
  const _FollowSortSheet({required this.initial});

  final FollowSortFilter initial;

  @override
  State<_FollowSortSheet> createState() => _FollowSortSheetState();
}

class _FollowSortSheetState extends State<_FollowSortSheet> {
  late FollowSortFilter _selected = widget.initial;

  static const _titleStyle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 24,
    height: 36 / 24,
    letterSpacing: 24 * -0.02,
    color: AppColors.black,
  );

  static const _optionStyle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 20 / 16,
    letterSpacing: 16 * -0.02,
  );

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).profile;
    final bottom = MediaQuery.viewPaddingOf(context).bottom;

    final options = <(FollowSortFilter, String)>[
      (FollowSortFilter.recent, t.followSortRecent),
      (FollowSortFilter.notFollowingMeBack, t.followSortNotFollowingMe),
      (FollowSortFilter.notFollowedByMe, t.followSortNotFollowedByMe),
    ];

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.fromLTRB(16, 10, 16, 10 + bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFE2E2E2),
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 36,
            child: Row(
              children: [
                Expanded(
                  child: AppText(t.followSortTitle, style: _titleStyle),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  behavior: HitTestBehavior.opaque,
                  child: SvgPicture.asset(
                    AppAssets.iconClose,
                    width: 26.67,
                    height: 26.67,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          for (final (filter, label) in options) ...[
            _SortOptionTile(
              label: label,
              selected: _selected == filter,
              style: _optionStyle,
              onTap: () => setState(() => _selected = filter),
            ),
            const SizedBox(height: 10),
          ],
          AppPrimaryButton(
            label: t.followSortShowResult,
            onPressed: () => Navigator.of(context).pop(_selected),
          ),
        ],
      ),
    );
  }
}

class _SortOptionTile extends StatelessWidget {
  const _SortOptionTile({
    required this.label,
    required this.selected,
    required this.style,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final TextStyle style;
  final VoidCallback onTap;

  static const _selectedFill = Color(0x0D998FED); // #998FED @ 5%
  static const _idleFill = Color(0xFFF4F4F9);
  static const _idleText = Color(0x66000000); // #000 @ 40%

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? _selectedFill : _idleFill,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: selected
                  ? AppColors.selectionBorder
                  : Colors.transparent,
              width: 1,
            ),
          ),
          child: AppText(
            label,
            style: style.copyWith(
              color: selected ? AppColors.selectionBorder : _idleText,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
