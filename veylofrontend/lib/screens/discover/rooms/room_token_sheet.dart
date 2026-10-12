import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_primary_button.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/screens/discover/rooms/room_live_page.dart';

/// Açık (public) odalar — token ile katılma bottom sheet.
Future<void> showRoomTokenSheet(
  BuildContext context, {
  required String roomTitle,
  int accessCost = 50,
  int balance = 125,
}) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) => _RoomTokenSheet(
      roomTitle: roomTitle,
      accessCost: accessCost,
      balance: balance,
    ),
  );
}

class _RoomTokenSheet extends StatelessWidget {
  const _RoomTokenSheet({
    required this.roomTitle,
    required this.accessCost,
    required this.balance,
  });

  final String roomTitle;
  final int accessCost;
  final int balance;

  static const _sheetBg = Color(0xFFF6F6FB);
  static const _rowBg = Color(0x0D998FED);

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).discover.roomToken;
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
                    roomTitle,
                    style: AppTextStyles.filtersTitle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  AppText(
                    t.subtitle,
                    style: AppTextStyles.privateRoomSubtitle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  _TokenRow(
                    label: t.roomAccess,
                    amount: t.tokensAmount(count: accessCost.toString()),
                    background: _rowBg,
                  ),
                  const SizedBox(height: 10),
                  _TokenRow(
                    label: t.yourBalance,
                    amount: t.tokensAmount(count: balance.toString()),
                    background: _rowBg,
                  ),
                  const SizedBox(height: 24),
                  AppPrimaryButton(
                    label: t.joinForTokens(count: accessCost.toString()),
                    onPressed: () {
                      final title = roomTitle;
                      final navigator = Navigator.of(context);
                      navigator.pop();
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        RoomLivePage.open(navigator.context, roomTitle: title);
                      });
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
                AppAssets.iconAiLock,
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

class _TokenRow extends StatelessWidget {
  const _TokenRow({
    required this.label,
    required this.amount,
    required this.background,
  });

  final String label;
  final String amount;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: AppText(label, style: AppTextStyles.privateRoomRowLabel),
          ),
          AppText(amount, style: AppTextStyles.privateRoomTokenAmount),
          const SizedBox(width: 6),
          Image.asset(
            AppAssets.iconTokens,
            width: 32,
            height: 32,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
