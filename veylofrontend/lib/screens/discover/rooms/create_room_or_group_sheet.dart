import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_primary_button.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/screens/discover/rooms/create_room_name_sheet.dart';

enum CreateSpaceType { room, group }

Future<void> showCreateRoomOrGroupSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: AppColors.white,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => const _CreateRoomOrGroupSheet(),
  );
}

class _CreateRoomOrGroupSheet extends StatefulWidget {
  const _CreateRoomOrGroupSheet();

  @override
  State<_CreateRoomOrGroupSheet> createState() =>
      _CreateRoomOrGroupSheetState();
}

class _CreateRoomOrGroupSheetState extends State<_CreateRoomOrGroupSheet> {
  CreateSpaceType _type = CreateSpaceType.room;
  bool _hideAccount = true;

  static const _selectedFill = Color(0x0D998FED); // #998FED @ 5%

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).discover.createSpace;
    final bottom = MediaQuery.paddingOf(context).bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 30, 16, 10 + bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              behavior: HitTestBehavior.opaque,
              child: SvgPicture.asset(
                AppAssets.iconClose,
                width: 32,
                height: 32,
              ),
            ),
          ),
          AppText(
            t.title,
            style: AppTextStyles.filtersTitle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          AppText(
            t.subtitle,
            style: AppTextStyles.createSpaceSubtitle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          _TypeOption(
            icon: AppAssets.iconRadar,
            label: t.room,
            selected: _type == CreateSpaceType.room,
            selectedFill: _selectedFill,
            onTap: () => setState(() => _type = CreateSpaceType.room),
          ),
          const SizedBox(height: 10),
          _TypeOption(
            icon: AppAssets.iconGroup,
            label: t.group,
            selected: _type == CreateSpaceType.group,
            selectedFill: _selectedFill,
            onTap: () => setState(() => _type = CreateSpaceType.group),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                SvgPicture.asset(
                  AppAssets.iconHideLock,
                  width: 24,
                  height: 24,
                  colorFilter: const ColorFilter.mode(
                    AppColors.black,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: AppText(
                    t.hideAccount,
                    style: AppTextStyles.createSpaceOption,
                  ),
                ),
                _NotificationsToggle(
                  value: _hideAccount,
                  onChanged: (v) => setState(() => _hideAccount = v),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          AppPrimaryButton(
            label: t.create,
            onPressed: () {
              final type = _type;
              final hideAccount = _hideAccount;
              final nav = Navigator.of(context, rootNavigator: true);
              nav.pop();
              showCreateRoomNameSheet(
                nav.context,
                type: type,
                hideAccount: hideAccount,
              );
            },
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            behavior: HitTestBehavior.opaque,
            child: SizedBox(
              width: double.infinity,
              height: 30,
              child: Center(
                child: AppText(
                  t.cancel,
                  style: AppTextStyles.privateRoomCancel,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TypeOption extends StatelessWidget {
  const _TypeOption({
    required this.icon,
    required this.label,
    required this.selected,
    required this.selectedFill,
    required this.onTap,
  });

  final String icon;
  final String label;
  final bool selected;
  final Color selectedFill;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.selectionBorder : AppColors.black;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 54,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          // #998FED @ 5% — seçili / seçili değil ortak fill
          color: selectedFill,
          borderRadius: BorderRadius.circular(10),
          border: selected
              ? Border.all(color: AppColors.selectionBorder, width: 1)
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
            const SizedBox(width: 10),
            AppText(
              label,
              style: AppTextStyles.createSpaceOption.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}

/// Figma notifications.svg — 45.29×28, on: #33C658.
class _NotificationsToggle extends StatelessWidget {
  const _NotificationsToggle({required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  static const double _width = 45.29;
  static const double _height = 28;
  static const double _thumb = 23.06;
  static const double _pad = 2.47;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: _width,
        height: _height,
        child: value
            ? SvgPicture.asset(
                AppAssets.iconNotifications,
                width: _width,
                height: _height,
                fit: BoxFit.contain,
              )
            : Container(
                width: _width,
                height: _height,
                padding: const EdgeInsets.all(_pad),
                decoration: BoxDecoration(
                  color: AppColors.sliderTrackIdle,
                  borderRadius: BorderRadius.circular(_height / 2),
                ),
                alignment: Alignment.centerLeft,
                child: Container(
                  width: _thumb,
                  height: _thumb,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withValues(alpha: 0.05),
                        blurRadius: 2.5,
                        offset: const Offset(0, 1.6),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
