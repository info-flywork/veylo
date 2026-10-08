import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_primary_button.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/screens/discover/rooms/group_chat_page.dart';
import 'package:veylo/screens/discover/rooms/room_live_page.dart';

/// Admin private request'i kabul edince açılan başarı sheet'i.
Future<void> showRoomApprovedSheet(
  BuildContext context, {
  required String roomTitle,
  bool isGroup = false,
  int memberCount = 1,
}) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) => _RoomApprovedSheet(
      roomTitle: roomTitle,
      isGroup: isGroup,
      memberCount: memberCount,
    ),
  );
}

class _RoomApprovedSheet extends StatelessWidget {
  const _RoomApprovedSheet({
    required this.roomTitle,
    this.isGroup = false,
    this.memberCount = 1,
  });

  final String roomTitle;
  final bool isGroup;
  final int memberCount;

  static const _sheetBg = Color(0xFFF6F6FB);

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).discover.roomApproved;
    final bottom = MediaQuery.paddingOf(context).bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 50),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: _sheetBg,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 66, 16, 16 + bottom),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText(
                    t.title,
                    style: AppTextStyles.filtersTitle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  AppText(
                    t.subtitle(name: roomTitle),
                    style: AppTextStyles.roomApprovedSubtitle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  AppPrimaryButton(
                    label: t.continueLabel,
                    onPressed: () {
                      final title = roomTitle;
                      final group = isGroup;
                      final count = memberCount;
                      final navigator = Navigator.of(context);
                      navigator.pop();
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (group) {
                          GroupChatPage.open(
                            navigator.context,
                            title: title,
                            memberCount: count,
                          );
                        } else {
                          RoomLivePage.open(
                            navigator.context,
                            roomTitle: title,
                          );
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 58,
            right: 16,
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
          Positioned(
            top: 0,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: 0.08),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Image.asset(
                AppAssets.iconApproved,
                width: 64,
                height: 64,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
