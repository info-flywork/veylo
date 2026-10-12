import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/errors/error_messages.dart';
import 'package:veylo/data/remote/group_repository.dart';
import 'package:veylo/data/remote/group_store.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_primary_button.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/screens/discover/rooms/room_approved_sheet.dart';
import 'package:veylo/i18n/strings.g.dart';

/// Kilitli (private) odalar — Request to join bottom sheet.
Future<void> showPrivateRoomRequestSheet(
  BuildContext context, {
  required String roomTitle,
  required int memberCount,
  bool isGroup = false,
  String? groupId,
}) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) => _PrivateRoomRequestSheet(
      roomTitle: roomTitle,
      memberCount: memberCount,
      isGroup: isGroup,
      groupId: groupId,
    ),
  );
}

class _PrivateRoomRequestSheet extends StatefulWidget {
  const _PrivateRoomRequestSheet({
    required this.roomTitle,
    required this.memberCount,
    this.isGroup = false,
    this.groupId,
  });

  final String roomTitle;
  final int memberCount;
  final bool isGroup;

  /// Gerçek gizli grup: istek yöneticilere gider, onaylanınca bildirim gelir.
  final String? groupId;

  @override
  State<_PrivateRoomRequestSheet> createState() =>
      _PrivateRoomRequestSheetState();
}

class _PrivateRoomRequestSheetState extends State<_PrivateRoomRequestSheet> {
  final _messageController = TextEditingController();

  static const _sheetBg = Color(0xFFF6F6FB);
  // #998FED @ 5%
  static const _inputBg = Color(0x0D998FED);

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).discover.privateRequest;
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
                    t.roomInfo(
                      name: widget.roomTitle,
                      count: widget.memberCount.toString(),
                    ),
                    style: AppTextStyles.privateRequestRoomInfo,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 54,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: _inputBg,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.centerLeft,
                    child: TextField(
                      controller: _messageController,
                      style: AppTextStyles.privateRequestInput.copyWith(
                        color: AppColors.black,
                      ),
                      cursorColor: AppColors.selectionBorder,
                      decoration: InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        hintText: t.messageHint,
                        hintStyle: AppTextStyles.privateRequestInput,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  AppPrimaryButton(
                    label: t.sendRequest,
                    onPressed: () async {
                      final groupId = widget.groupId;
                      if (groupId != null) {
                        final navigator = Navigator.of(context);
                        try {
                          await GroupRepository.instance.requestJoin(
                            groupId,
                            message: _messageController.text.trim(),
                          );
                          GroupStore.instance.markRequested(groupId);
                          navigator.pop();
                        } catch (e) {
                          if (context.mounted) showErrorSnackBar(context, e);
                        }
                        return;
                      }
                      final title = widget.roomTitle;
                      final navigator = Navigator.of(context);
                      navigator.pop();
                      // Demo: admin kabulü sonrası başarı sheet'i
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        showRoomApprovedSheet(
                          navigator.context,
                          roomTitle: title,
                          isGroup: widget.isGroup,
                          memberCount: widget.memberCount,
                        );
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  AppText(
                    t.adminReview,
                    style: AppTextStyles.privateRequestFooter,
                    textAlign: TextAlign.center,
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
                AppAssets.iconRequestAiLock,
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
