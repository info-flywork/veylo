import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_bottom_nav.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/data/remote/room_pip_store.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/screens/discover/discover_page.dart';
import 'package:veylo/screens/discover/rooms/room_close_confirm_sheet.dart';
import 'package:veylo/screens/discover/rooms/room_live_page.dart';

/// Root Overlay'de sağ altta küçültülmüş oda — tıkla = geri dön, X = kapat.
class RoomPipOverlayHost extends StatefulWidget {
  const RoomPipOverlayHost({super.key, required this.child});

  final Widget child;

  @override
  State<RoomPipOverlayHost> createState() => _RoomPipOverlayHostState();
}

class _RoomPipOverlayHostState extends State<RoomPipOverlayHost> {
  OverlayEntry? _entry;

  @override
  void initState() {
    super.initState();
    RoomPipStore.instance.addListener(_sync);
  }

  @override
  void dispose() {
    RoomPipStore.instance.removeListener(_sync);
    _entry?.remove();
    _entry = null;
    super.dispose();
  }

  void _sync() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final pip = RoomPipStore.instance;
      if (pip.takePendingRemoteExit()) {
        final t = Translations.of(context).discover.liveRoom;
        final msg = pip.pendingWasKick ? t.removed : t.roomEnded;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
        Navigator.of(context, rootNavigator: true).popUntil((r) => r.isFirst);
        DiscoverShell.showRooms();
      }
      final visible = pip.visible;
      final overlay = Overlay.maybeOf(context, rootOverlay: true);
      if (overlay == null) return;

      if (visible && _entry == null) {
        _entry = OverlayEntry(builder: (_) => const _RoomPipBubble());
        overlay.insert(_entry!);
      } else if (!visible && _entry != null) {
        _entry!.remove();
        _entry = null;
      } else {
        _entry?.markNeedsBuild();
      }
    });
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

class _RoomPipBubble extends StatelessWidget {
  const _RoomPipBubble();

  Future<void> _expand(BuildContext context) async {
    final pip = RoomPipStore.instance;
    final id = pip.roomId;
    final title = pip.title;
    final anonymous = pip.anonymous;
    if (id == null) return;
    pip.hideBubble();
    await RoomLivePage.open(
      context,
      roomId: id,
      roomTitle: title,
      anonymous: anonymous,
    );
  }

  Future<void> _close(BuildContext context) async {
    final pip = RoomPipStore.instance;
    if (pip.roomId == null) return;
    final host = pip.isHost;
    final ok = await showRoomCloseConfirmSheet(context, isHost: host);
    if (!ok || !context.mounted) return;
    await pip.closeAndLeave(endRoom: host);
    if (!context.mounted) return;
    Navigator.of(context, rootNavigator: true).popUntil((r) => r.isFirst);
    DiscoverShell.showRooms();
  }

  @override
  Widget build(BuildContext context) {
    final pip = RoomPipStore.instance;
    if (!pip.visible) return const SizedBox.shrink();

    final bottom = MediaQuery.paddingOf(context).bottom;
    final lift =
        AppBottomNav.barHeight + (AppBottomNav.callBgSize / 2) + bottom + 12;

    return Positioned(
      right: 12,
      bottom: lift,
      child: Material(
        color: Colors.transparent,
        elevation: 8,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap: () => _expand(context),
          borderRadius: BorderRadius.circular(14),
          child: Ink(
            width: 148,
            height: 96,
            decoration: BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: AppColors.white.withValues(alpha: 0.18),
              ),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 14, 36, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Color(0xFF4ADE80),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const Spacer(),
                      AppText(
                        pip.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: AppFonts.poppins,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: GestureDetector(
                    onTap: () => _close(context),
                    behavior: HitTestBehavior.opaque,
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: DecoratedBox(
                        decoration: const BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          AppAssets.iconCloseButton,
                          width: 28,
                          height: 28,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
