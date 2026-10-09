import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/core/widgets/profile_tappable_avatar.dart';
import 'package:veylo/models/chat/chat_thread.dart';

const _kThreadAvatarSize = 58.0;
const _kThreadRowHeight = 58.0;
const _kActionSize = 44.0;
const _kActionGap = 10.0;
const _kActionsPadding = 4.0;

/// 3 buton + 2 gap + sağ padding
const _kRevealWidth = (_kActionSize * 3) + (_kActionGap * 2) + _kActionsPadding;

const _kPinBg = Color(0xFF7C6CD6);
const _kBlockBg = Color(0xFF6B6480);
const _kDeleteBg = Color(0xFFD4537E);

class ChatThreadTile extends StatefulWidget {
  const ChatThreadTile({
    super.key,
    required this.thread,
    required this.onTap,
    this.isOpen = false,
    this.onOpenChanged,
    this.onPin,
    this.onBlock,
    this.onDelete,
  });

  final ChatThread thread;
  final VoidCallback onTap;
  final bool isOpen;
  final ValueChanged<bool>? onOpenChanged;
  final VoidCallback? onPin;
  final VoidCallback? onBlock;
  final VoidCallback? onDelete;

  @override
  State<ChatThreadTile> createState() => _ChatThreadTileState();
}

class _ChatThreadTileState extends State<ChatThreadTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  double _dragExtent = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
      value: widget.isOpen ? 1 : 0,
    );
    _dragExtent = widget.isOpen ? -_kRevealWidth : 0;
  }

  @override
  void didUpdateWidget(covariant ChatThreadTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isOpen != widget.isOpen) {
      // Parent state sync — tekrar onOpenChanged çağırma (build sırasında setState olmasın).
      if (widget.isOpen) {
        _open(notify: false);
      } else {
        _close(notify: false);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _open({bool notify = true}) {
    _controller.animateTo(1, curve: Curves.easeOutCubic);
    _dragExtent = -_kRevealWidth;
    if (notify) widget.onOpenChanged?.call(true);
  }

  void _close({bool notify = true}) {
    _controller.animateTo(0, curve: Curves.easeOutCubic);
    _dragExtent = 0;
    if (notify) widget.onOpenChanged?.call(false);
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    final next = (_dragExtent + details.delta.dx).clamp(-_kRevealWidth, 0.0);
    setState(() => _dragExtent = next);
    _controller.value = (-_dragExtent / _kRevealWidth).clamp(0.0, 1.0);
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0;
    final shouldOpen = velocity < -400 || _dragExtent < -_kRevealWidth * 0.4;
    if (shouldOpen) {
      _open();
    } else {
      _close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _kThreadRowHeight,
      child: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: _kActionsPadding),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _SwipeActionButton(
                      color: _kPinBg,
                      iconAsset: AppAssets.iconPinned,
                      onTap: () {
                        widget.onPin?.call();
                        _close();
                      },
                    ),
                    const SizedBox(width: _kActionGap),
                    _SwipeActionButton(
                      color: _kBlockBg,
                      iconAsset: AppAssets.iconBlock,
                      onTap: () {
                        widget.onBlock?.call();
                        _close();
                      },
                    ),
                    const SizedBox(width: _kActionGap),
                    _SwipeActionButton(
                      color: _kDeleteBg,
                      iconAsset: AppAssets.iconTrash,
                      onTap: () {
                        widget.onDelete?.call();
                        _close();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final offset = -_kRevealWidth * _controller.value;
              final openAmount = _controller.value;
              return Transform.translate(
                offset: Offset(offset, 0),
                child: GestureDetector(
                  onHorizontalDragUpdate: _onHorizontalDragUpdate,
                  onHorizontalDragEnd: _onHorizontalDragEnd,
                  onTap: () {
                    if (_controller.value > 0.05) {
                      _close();
                    } else {
                      widget.onTap();
                    }
                  },
                  child: ColoredBox(
                    color: Color.alphaBlend(
                      const Color(
                        0xFF998FED,
                      ).withValues(alpha: 0.1 * openAmount),
                      AppColors.white,
                    ),
                    child: child,
                  ),
                ),
              );
            },
            child: _ThreadContent(thread: widget.thread),
          ),
        ],
      ),
    );
  }
}

class _ThreadContent extends StatelessWidget {
  const _ThreadContent({required this.thread});

  final ChatThread thread;

  @override
  Widget build(BuildContext context) {
    final title = thread.isAnonymous
        ? (thread.maskedName ?? thread.title)
        : thread.title;

    return SizedBox(
      height: _kThreadRowHeight,
      child: Row(
        children: [
          ProfileTappableAvatar(
            avatarUrl: thread.avatarUrl,
            size: _kThreadAvatarSize,
            userId: thread.peerUserId,
            displayName: thread.isAnonymous ? thread.maskedName : thread.title,
            username: thread.peerUsername,
            enabled: !thread.isAnonymous,
            blurred: thread.isAnonymous,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: AppText(
                        title,
                        style: AppTextStyles.chatsThreadName,
                        maxLines: 1,
                      ),
                    ),
                    if (thread.lastMessageAt != null)
                      AppText(
                        _formatTime(thread.lastMessageAt!),
                        style: AppTextStyles.chatsThreadTime,
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                AppText(
                  thread.lastMessagePreview,
                  style: AppTextStyles.chatsThreadPreview,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static String _formatTime(DateTime at) {
    final hour = at.hour % 12 == 0 ? 12 : at.hour % 12;
    final minute = at.minute.toString().padLeft(2, '0');
    final period = at.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }
}

class _SwipeActionButton extends StatelessWidget {
  const _SwipeActionButton({
    required this.color,
    required this.iconAsset,
    required this.onTap,
  });

  final Color color;
  final String iconAsset;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          width: _kActionSize,
          height: _kActionSize,
          child: Center(
            child: SvgPicture.asset(
              iconAsset,
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                AppColors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
