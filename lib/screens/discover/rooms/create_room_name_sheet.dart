import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_primary_button.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/screens/discover/rooms/create_room_or_group_sheet.dart';
import 'package:veylo/screens/discover/rooms/group_chat_page.dart';
import 'package:veylo/screens/discover/rooms/room_live_page.dart';

Future<void> showCreateRoomNameSheet(
  BuildContext context, {
  required CreateSpaceType type,
}) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: AppColors.white,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => _CreateRoomNameSheet(type: type),
  );
}

class _CreateRoomNameSheet extends StatefulWidget {
  const _CreateRoomNameSheet({required this.type});

  final CreateSpaceType type;

  @override
  State<_CreateRoomNameSheet> createState() => _CreateRoomNameSheetState();
}

class _CreateRoomNameSheetState extends State<_CreateRoomNameSheet> {
  final _controller = TextEditingController();

  static const _inputBg = Color(0x0D998FED);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).discover.createSpace;
    final bottom = MediaQuery.paddingOf(context).bottom;
    final isRoom = widget.type == CreateSpaceType.room;

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 30,
        bottom: 10 + bottom + MediaQuery.viewInsetsOf(context).bottom,
      ),
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
            isRoom ? t.createRoomTitle : t.createGroupTitle,
            style: AppTextStyles.filtersTitle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          AppText(
            t.nameSubtitle,
            style: AppTextStyles.createSpaceSubtitle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Container(
            height: 54,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: _inputBg,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.centerLeft,
            child: TextField(
              controller: _controller,
              style: AppTextStyles.createSpaceOption,
              cursorColor: AppColors.selectionBorder,
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: t.nameHint,
                hintStyle: AppTextStyles.privateRequestInput,
              ),
            ),
          ),
          const SizedBox(height: 20),
          AppPrimaryButton(
            label: t.create,
            onPressed: () {
              final name = _controller.text.trim().isEmpty
                  ? t.nameHint
                  : _controller.text.trim();
              final navigator = Navigator.of(context);
              navigator.pop();
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (widget.type == CreateSpaceType.group) {
                  GroupChatPage.open(
                    navigator.context,
                    title: name,
                    memberCount: 1,
                  );
                } else {
                  RoomLivePage.open(navigator.context, roomTitle: name);
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
