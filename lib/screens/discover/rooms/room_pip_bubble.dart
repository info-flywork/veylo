import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_bottom_nav.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/data/remote/room_pip_store.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/models/room/live_room.dart';
import 'package:veylo/screens/chat/widgets/chat_note_card.dart';
import 'package:veylo/screens/discover/discover_page.dart';
import 'package:veylo/screens/discover/rooms/room_close_confirm_sheet.dart';
import 'package:veylo/screens/discover/rooms/room_live_page.dart';

/// Root Overlay'de HelloTalk tarzı mini oda kartı — sürükle, tıkla = geri dön, X = kapat.
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

class _RoomPipBubble extends StatefulWidget {
  const _RoomPipBubble();

  @override
  State<_RoomPipBubble> createState() => _RoomPipBubbleState();
}

class _RoomPipBubbleState extends State<_RoomPipBubble> {
  static const _w = 112.0;
  static const _h = 138.0;
  static const _pad = 8.0;
  static const _avatar = 64.0;

  double? _left;
  double? _top;

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

  double _defaultLeft(Size size) => size.width - _pad - _w;

  /// Varsayılan: alt nav’ın hemen üstü (HelloTalk gibi).
  double _defaultTop(Size size, double bottomInset) {
    final lift = AppBottomNav.barHeight + bottomInset + 10;
    return size.height - lift - _h;
  }

  /// En alta kadar: safe area + küçük boşluk.
  double _maxTop(Size size, double bottomInset) =>
      size.height - bottomInset - _pad - _h;

  void _ensurePosition(Size size, EdgeInsets padding) {
    final minL = _pad;
    final maxL = (size.width - _pad - _w).clamp(minL, size.width);
    final minT = padding.top + _pad;
    final maxT = _maxTop(size, padding.bottom).clamp(minT, size.height);
    _left = (_left ?? _defaultLeft(size)).clamp(minL, maxL);
    _top = (_top ?? _defaultTop(size, padding.bottom)).clamp(minT, maxT);
  }

  void _onPanUpdate(DragUpdateDetails d, Size size, EdgeInsets padding) {
    final minL = _pad;
    final maxL = (size.width - _pad - _w).clamp(minL, size.width);
    final minT = padding.top + _pad;
    final maxT = _maxTop(size, padding.bottom).clamp(minT, size.height);
    setState(() {
      _left = ((_left ?? _defaultLeft(size)) + d.delta.dx).clamp(minL, maxL);
      _top = ((_top ?? _defaultTop(size, padding.bottom)) + d.delta.dy)
          .clamp(minT, maxT);
    });
  }

  @override
  Widget build(BuildContext context) {
    final pip = RoomPipStore.instance;
    if (!pip.visible) return const SizedBox.shrink();

    final size = MediaQuery.sizeOf(context);
    final padding = MediaQuery.paddingOf(context);
    _ensurePosition(size, padding);

    final person = pip.featured;
    final speaking = pip.featuredSpeaking;

    return Positioned(
      left: _left,
      top: _top,
      child: Material(
        color: Colors.transparent,
        elevation: 10,
        shadowColor: Colors.black54,
        borderRadius: BorderRadius.circular(16),
        child: GestureDetector(
          onTap: () => _expand(context),
          onPanUpdate: (d) => _onPanUpdate(d, size, padding),
          child: Container(
            width: _w,
            height: _h,
            decoration: BoxDecoration(
              color: const Color(0xFF1C1C1E),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.white.withValues(alpha: 0.12),
              ),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 18, 10, 10),
                  child: Column(
                    children: [
                      _PipAvatar(person: person, speaking: speaking),
                      const SizedBox(height: 10),
                      AppText(
                        person?.displayName.isNotEmpty == true
                            ? person!.displayName
                            : pip.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: AppFonts.poppins,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(height: 2),
                      AppText(
                        pip.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: AppFonts.poppins,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          height: 1.2,
                          color: AppColors.white.withValues(alpha: 0.55),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 6,
                  left: 8,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFF4ADE80),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  top: 2,
                  right: 2,
                  child: GestureDetector(
                    onTap: () => _close(context),
                    behavior: HitTestBehavior.opaque,
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: AppColors.white.withValues(alpha: 0.92),
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          AppAssets.iconCloseButton,
                          width: 22,
                          height: 22,
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

class _PipAvatar extends StatelessWidget {
  const _PipAvatar({required this.person, required this.speaking});

  final RoomParticipant? person;
  final bool speaking;

  @override
  Widget build(BuildContext context) {
    Widget photo = ChatAvatarImage(
      url: person?.avatarUrl ?? '',
      size: _RoomPipBubbleState._avatar,
    );
    if (person?.blurred == true) {
      photo = ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: photo,
      );
    }
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: _RoomPipBubbleState._avatar,
      height: _RoomPipBubbleState._avatar,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: speaking
              ? AppColors.selectionBorder
              : AppColors.white.withValues(alpha: 0.25),
          width: speaking ? 3 : 2,
        ),
      ),
      child: ClipOval(child: photo),
    );
  }
}
