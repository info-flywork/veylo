import 'package:flutter/material.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/core/widgets/profile_tappable_avatar.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/models/chat/chat_thread.dart';
import 'package:veylo/screens/chat/widgets/chat_swipe_action.dart';

const _kThreadAvatarSize = 58.0;
const _kThreadRowHeight = 58.0;
const _kActionGap = kChatSwipeActionGap;
const _kActionsPadding = kChatSwipeActionsPadding;

const _kPinBg = kChatSwipePinBg;
const _kBlockBg = kChatSwipeBlockBg;
const _kDeleteBg = kChatSwipeDeleteBg;

/// Sunucu sohbet özetini İngilizce saklar. Listedeki satır seçilen dilde okunur.
String localizedChatPreview(BuildContext context, String raw) {
  final t = Translations.of(context).chats;
  return switch (raw) {
    'Unlock request' => t.previewUnlock,
    'Name shared' => t.previewNameShared,
    'Name request declined' => t.previewNameDeclined,
    'Photo shared' => t.previewPhotoShared,
    'Photo request declined' => t.previewPhotoDeclined,
    'Profile shared' => t.previewProfileShared,
    'Profile request declined' => t.previewProfileDeclined,
    '📷 Photo' => t.previewPhoto,
    '🎤 Voice message' => t.previewVoice,
    '🎭 Sticker' => t.previewSticker,
    _ when raw.startsWith('sticker:') => t.previewSticker,
    _ => raw,
  };
}

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

  /// Verilmeyen aksiyonun butonu gösterilmez; hiç aksiyon yoksa kaydırma kapalı.
  int get _actionCount => [
    widget.onPin,
    widget.onBlock,
    widget.onDelete,
  ].where((a) => a != null).length;

  double get _revealWidth => chatSwipeRevealWidth(_actionCount);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
      value: widget.isOpen ? 1 : 0,
    );
    _dragExtent = widget.isOpen ? -_revealWidth : 0;
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
    _dragExtent = -_revealWidth;
    if (notify) widget.onOpenChanged?.call(true);
  }

  void _close({bool notify = true}) {
    _controller.animateTo(0, curve: Curves.easeOutCubic);
    _dragExtent = 0;
    if (notify) widget.onOpenChanged?.call(false);
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    final next = (_dragExtent + details.delta.dx).clamp(-_revealWidth, 0.0);
    setState(() => _dragExtent = next);
    if (_revealWidth == 0) return;
    _controller.value = (-_dragExtent / _revealWidth).clamp(0.0, 1.0);
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0;
    final shouldOpen = velocity < -400 || _dragExtent < -_revealWidth * 0.4;
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
          // Figma: açıkken butonların arkası da satırla aynı açık mor zeminde.
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, _) => ColoredBox(
                color: Color.alphaBlend(
                  const Color(
                    0xFF998FED,
                  ).withValues(alpha: 0.1 * _controller.value),
                  AppColors.white,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: _kActionsPadding),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (final (i, action) in [
                      if (widget.onPin != null)
                        ChatSwipeActionButton(
                          color: _kPinBg,
                          iconAsset: AppAssets.iconPinAction,
                          // Sabitliyse buton sabitlemeyi kaldırır.
                          crossedOut: widget.thread.pinned,
                          onTap: () {
                            widget.onPin?.call();
                            _close();
                          },
                        ),
                      if (widget.onBlock != null)
                        ChatSwipeActionButton(
                          color: _kBlockBg,
                          iconAsset: AppAssets.iconBlock,
                          onTap: () {
                            widget.onBlock?.call();
                            _close();
                          },
                        ),
                      if (widget.onDelete != null)
                        ChatSwipeActionButton(
                          color: _kDeleteBg,
                          iconAsset: AppAssets.iconTrash,
                          onTap: () {
                            widget.onDelete?.call();
                            _close();
                          },
                        ),
                    ].indexed) ...[
                      if (i > 0) const SizedBox(width: _kActionGap),
                      action,
                    ],
                  ],
                ),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final offset = -_revealWidth * _controller.value;
              final openAmount = _controller.value;
              return Transform.translate(
                offset: Offset(offset, 0),
                child: GestureDetector(
                  onHorizontalDragUpdate: _actionCount == 0
                      ? null
                      : _onHorizontalDragUpdate,
                  onHorizontalDragEnd: _actionCount == 0
                      ? null
                      : _onHorizontalDragEnd,
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
            // Grupta ilk üye fotoğrafı (sohbet başlığındakiyle aynı).
            avatarUrl: thread.isGroup
                ? (thread.groupAvatarUrls?.firstOrNull ?? '')
                : thread.avatarUrl,
            size: _kThreadAvatarSize,
            userId: thread.peerUserId,
            displayName: thread.isAnonymous ? thread.maskedName : thread.title,
            username: thread.peerUsername,
            enabled: thread.peerUserId != null && !thread.isGroup,
            blurred: thread.isAnonymous && thread.peerAvatarBlurred,
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
                      child: Row(
                        children: [
                          Flexible(
                            child: AppText(
                              title,
                              style: AppTextStyles.chatsThreadName,
                              maxLines: 1,
                            ),
                          ),
                        ],
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
                Row(
                  children: [
                    Expanded(
                      child: AppText(
                        localizedChatPreview(context, thread.lastMessagePreview),
                        style: AppTextStyles.chatsThreadPreview,
                        maxLines: 1,
                      ),
                    ),
                    if (thread.unreadCount > 0) ...[
                      const SizedBox(width: 8),
                      _UnreadCount(count: thread.unreadCount),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime at) {
    final code = LocaleSettings.currentLocale.languageCode;
    final minute = at.minute.toString().padLeft(2, '0');
    final hour24 = at.hour.toString().padLeft(2, '0');
    final hour12 = at.hour % 12 == 0 ? 12 : at.hour % 12;
    final afternoon = at.hour >= 12;
    switch (code) {
      case 'tr':
        return '$hour12:$minute ${afternoon ? 'ös' : 'öö'}';
      case 'ja':
        return '${afternoon ? '午後' : '午前'}$hour12:$minute';
      case 'ko':
        return '${afternoon ? '오후' : '오전'} $hour12:$minute';
      case 'zh':
        return '${afternoon ? '下午' : '上午'}$hour12:$minute';
      case 'hi':
        return '$hour12:$minute ${afternoon ? 'pm' : 'am'}';
      case 'en':
        return '$hour12:$minute ${afternoon ? 'PM' : 'AM'}';
      default:
        return '$hour24:$minute';
    }
  }
}

class _UnreadCount extends StatelessWidget {
  const _UnreadCount({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final label = count > 99 ? '99+' : '$count';
    return Container(
      constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
      padding: const EdgeInsets.symmetric(horizontal: 6),
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppColors.selectionBorder,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: AppText(
        label,
        style: const TextStyle(
          fontFamily: AppFonts.poppins,
          fontWeight: FontWeight.w600,
          fontSize: 11,
          height: 1,
          color: AppColors.white,
        ),
      ),
    );
  }
}
