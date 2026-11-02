import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/models/chat/chat_message.dart';
import 'package:veylo/screens/chat/chat_sticker.dart';
import 'package:veylo/screens/chat/widgets/chat_attachment.dart';
import 'package:veylo/screens/chat/widgets/chat_note_card.dart';
import 'package:veylo/screens/chat/widgets/chat_swipe_action.dart';

/// Sohbet balonları (Direct ve Anonymous ekranlarının ortak listesi).
/// [leading] listenin başına eklenen öğeler (ör. Vibes alıntısı, istek bloğu).
class ChatMessageList extends StatefulWidget {
  const ChatMessageList({
    super.key,
    required this.messages,
    this.leading = const [],
    this.peerLastReadSeq,
    this.seenLabel,
    this.onRetry,
    this.onUnlockDecision,
    this.onLoadOlder,
    this.skipFirstIncoming = false,
    this.peerAvatarUrl,
    this.onDeleteMessage,
    this.onReportMessage,
  });

  final List<ChatMessage> messages;
  final List<Widget> leading;
  final int? peerLastReadSeq;
  final String? seenLabel;
  final ValueChanged<ChatMessage>? onRetry;
  final Future<void> Function(ChatMessage message, String decision)? onUnlockDecision;
  final VoidCallback? onLoadOlder;

  /// İlk gelen mesaj [leading] içinde (istek bloğu) gösterildiyse listede tekrar gösterme.
  final bool skipFirstIncoming;

  /// Verilirse gelen mesajların solunda karşı tarafın avatarı gösterilir (Figma).
  /// Boş/asset değilse anonim yer tutucu ikon kullanılır.
  final String? peerAvatarUrl;

  /// Verilirse balon sola kaydırılınca Sil (kendi mesajım: herkesten, diğerleri: benden) görünür.
  final ValueChanged<ChatMessage>? onDeleteMessage;

  /// Verilirse karşı tarafın mesajında Şikayet Et görünür.
  final ValueChanged<ChatMessage>? onReportMessage;

  @override
  State<ChatMessageList> createState() => _ChatMessageListState();
}

class _ChatMessageListState extends State<ChatMessageList> {
  final _scroll = ScrollController();

  /// Aksiyonları açık olan balon (aynı anda tek balon açık kalır).
  String? _openMessageId;

  /// Sola kaydırınca görünen aksiyonlar: Kopyala (metin), Şikayet Et (karşı taraf), Sil.
  List<_MessageAction> _actionsFor(ChatMessage m) {
    final copyable = m.type == 'TEXT' &&
        ChatSticker.assetOf(m.body) == null &&
        (m.body?.trim().isNotEmpty ?? false);
    final canReport = !m.isMine && m.id != null && widget.onReportMessage != null;
    final canDelete = widget.onDeleteMessage != null &&
        (m.isMine || m.id != null) &&
        m.status != ChatMessageStatus.sending;
    return [
      if (copyable)
        _MessageAction(
          color: kChatSwipePinBg,
          icon: Icons.content_copy_rounded,
          onTap: () => _copy(m),
        ),
      if (canReport)
        _MessageAction(
          color: kChatSwipeBlockBg,
          icon: Icons.flag_rounded,
          onTap: () => widget.onReportMessage!(m),
        ),
      if (canDelete)
        _MessageAction(
          color: kChatSwipeDeleteBg,
          iconAsset: AppAssets.iconTrash,
          onTap: () => widget.onDeleteMessage!(m),
        ),
    ];
  }

  void _copy(ChatMessage m) {
    Clipboard.setData(ClipboardData(text: m.body ?? ''));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(Translations.of(context).chats.messageCopied),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _scroll.addListener(() {
      // reverse: true → en üst (eski mesajlar) maxScrollExtent'te.
      if (_scroll.position.pixels > _scroll.position.maxScrollExtent - 200) {
        widget.onLoadOlder?.call();
      }
    });
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final maxBubble = MediaQuery.sizeOf(context).width * 0.78;
    var msgs = widget.messages;
    if (widget.skipFirstIncoming) {
      final i = msgs.indexWhere((m) => !m.isMine);
      if (i >= 0) msgs = [...msgs.sublist(0, i), ...msgs.sublist(i + 1)];
    }
    // "Görüldü": karşı tarafın okuduğu son kendi mesajım.
    final lastSeenMine = widget.peerLastReadSeq == null
        ? null
        : msgs.lastWhere(
            (m) =>
                m.isMine && m.seq != null && m.seq! <= widget.peerLastReadSeq!,
            orElse: () => ChatMessage(
              clientMsgId: '',
              isMine: false,
              createdAt: DateTime(2000),
            ),
          );

    final children = <Widget>[
      ...widget.leading,
      for (final (i, m) in msgs.indexed) ...[
        if (m.type == 'SYSTEM')
          _UnlockNotice(message: m, onDecision: widget.onUnlockDecision)
        else
        _SwipeableMessage(
          key: ValueKey('swipe_${m.clientMsgId}'),
          actions: _actionsFor(m),
          isOpen: _openMessageId == m.clientMsgId,
          onOpenChanged: (open) => setState(() {
            if (open) {
              _openMessageId = m.clientMsgId;
            } else if (_openMessageId == m.clientMsgId) {
              _openMessageId = null;
            }
          }),
          child: _Bubble(
            message: m,
            maxWidth: maxBubble,
            onRetry: widget.onRetry,
            peerAvatarUrl: widget.peerAvatarUrl,
            // Art arda gelen mesajlarda avatar ilkinde; diğerleri aynı hizada.
            showAvatar: !m.isMine && (i == 0 || msgs[i - 1].isMine),
          ),
        ),
        if (widget.seenLabel != null &&
            lastSeenMine != null &&
            m.clientMsgId == lastSeenMine.clientMsgId)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Align(
              alignment: Alignment.centerRight,
              child: AppText(
                widget.seenLabel!,
                style: TextStyle(
                  fontFamily: AppFonts.poppins,
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: AppColors.textOnLight.withValues(alpha: 0.45),
                ),
              ),
            ),
          ),
      ],
    ];

    // Ters liste: klavye açılınca ve yeni mesajda en altta kalır.
    return ListView.separated(
      controller: _scroll,
      reverse: true,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      itemCount: children.length,
      separatorBuilder: (_, _) => const SizedBox(height: 10),
      itemBuilder: (context, index) => children[children.length - 1 - index],
    );
  }
}

class _MessageAction {
  const _MessageAction({
    required this.color,
    required this.onTap,
    this.icon,
    this.iconAsset,
  });

  final Color color;
  final IconData? icon;
  final String? iconAsset;
  final VoidCallback onTap;
}

/// Balonu sola kaydırınca sohbet listesindeki satırla aynı kare butonlar açılır.
class _SwipeableMessage extends StatefulWidget {
  const _SwipeableMessage({
    super.key,
    required this.actions,
    required this.isOpen,
    required this.onOpenChanged,
    required this.child,
  });

  final List<_MessageAction> actions;
  final bool isOpen;
  final ValueChanged<bool> onOpenChanged;
  final Widget child;

  @override
  State<_SwipeableMessage> createState() => _SwipeableMessageState();
}

class _SwipeableMessageState extends State<_SwipeableMessage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 220),
    value: widget.isOpen ? 1 : 0,
  );
  late double _dragExtent = widget.isOpen ? -_revealWidth : 0;

  double get _revealWidth => chatSwipeRevealWidth(widget.actions.length);

  @override
  void didUpdateWidget(covariant _SwipeableMessage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isOpen != widget.isOpen) {
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
    if (notify) widget.onOpenChanged(true);
  }

  void _close({bool notify = true}) {
    _controller.animateTo(0, curve: Curves.easeOutCubic);
    _dragExtent = 0;
    if (notify) widget.onOpenChanged(false);
  }

  void _onDragUpdate(DragUpdateDetails details) {
    _dragExtent = (_dragExtent + details.delta.dx).clamp(-_revealWidth, 0.0);
    _controller.value = (-_dragExtent / _revealWidth).clamp(0.0, 1.0);
  }

  void _onDragEnd(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0;
    if (velocity < -400 || _dragExtent < -_revealWidth * 0.4) {
      _open();
    } else {
      _close();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.actions.isEmpty) return widget.child;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned.fill(
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: kChatSwipeActionsPadding),
              child: FadeTransition(
                opacity: _controller,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (final (i, action) in widget.actions.indexed) ...[
                      if (i > 0) const SizedBox(width: kChatSwipeActionGap),
                      ChatSwipeActionButton(
                        color: action.color,
                        icon: action.icon,
                        iconAsset: action.iconAsset,
                        onTap: () {
                          _close();
                          action.onTap();
                        },
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) => Transform.translate(
            offset: Offset(-_revealWidth * _controller.value, 0),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onHorizontalDragUpdate: _onDragUpdate,
              onHorizontalDragEnd: _onDragEnd,
              onTap: _controller.value > 0.05 ? () => _close() : null,
              // Açıkken balonun içindeki dokunuşlar (fotoğraf, tekrar dene) kapanmaya gider.
              child: AbsorbPointer(
                absorbing: _controller.value > 0.05,
                child: child,
              ),
            ),
          ),
          child: widget.child,
        ),
      ],
    );
  }
}

class _UnlockNotice extends StatefulWidget {
  const _UnlockNotice({required this.message, this.onDecision});

  final ChatMessage message;
  final Future<void> Function(ChatMessage message, String decision)? onDecision;

  @override
  State<_UnlockNotice> createState() => _UnlockNoticeState();
}

class _UnlockNoticeState extends State<_UnlockNotice> {
  bool _busy = false;

  Future<void> _decide(String decision) async {
    final send = widget.onDecision;
    if (send == null || _busy) return;
    setState(() => _busy = true);
    try {
      await send(widget.message, decision);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).chats;
    final body = widget.message.body;
    final title = switch (body) {
      'unlock:initial' || 'unlock:initial:approved' || 'unlock:initial:rejected' => t.milestoneInitial,
      'unlock:photo' || 'unlock:photo:approved' || 'unlock:photo:rejected' => t.milestonePhoto,
      'unlock:full' || 'unlock:full:approved' || 'unlock:full:rejected' => t.milestoneFull,
      _ => body ?? '',
    };
    final mine = widget.message.isMine;
    final text = switch (body) {
      'unlock:initial:approved' => mine ? t.unlockNameApprovedMine : t.unlockNameApprovedTheirs,
      'unlock:initial:rejected' => mine ? t.unlockNameRejectedMine : t.unlockNameRejectedTheirs,
      'unlock:initial' => mine ? t.unlockNamePendingMine : t.unlockNamePendingTheirs,
      'unlock:photo:approved' => mine ? t.unlockPhotoApprovedMine : t.unlockPhotoApprovedTheirs,
      'unlock:photo:rejected' => mine ? t.unlockPhotoRejectedMine : t.unlockPhotoRejectedTheirs,
      'unlock:photo' => mine ? t.unlockPhotoPendingMine : t.unlockPhotoPendingTheirs,
      'unlock:full:approved' => mine ? t.unlockFullApprovedMine : t.unlockFullApprovedTheirs,
      'unlock:full:rejected' => mine ? t.unlockFullRejectedMine : t.unlockFullRejectedTheirs,
      'unlock:full' => mine ? t.unlockFullPendingMine : t.unlockFullPendingTheirs,
      _ => mine ? t.unlockSent(title: title) : t.unlockReceived(title: title),
    };
    final canAnswer = (body == 'unlock:initial' || body == 'unlock:photo' || body == 'unlock:full') &&
        !mine &&
        widget.onDecision != null &&
        widget.message.id != null;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 320),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0x14998FED),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                AppText(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: AppFonts.poppins,
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    height: 18 / 13,
                    color: Color(0xA6000000),
                  ),
                ),
                if (canAnswer) ...[
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: _UnlockAction(
                          label: t.approve,
                          color: AppColors.strangerApprove,
                          enabled: !_busy,
                          onTap: () => _decide('approve'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _UnlockAction(
                          label: t.reject,
                          color: AppColors.strangerReject,
                          enabled: !_busy,
                          onTap: () => _decide('reject'),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _UnlockAction extends StatelessWidget {
  const _UnlockAction({
    required this.label,
    required this.color,
    required this.enabled,
    required this.onTap,
  });

  final String label;
  final Color color;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color.withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          height: 40,
          child: Center(
            child: AppText(
              label,
              style: TextStyle(
                fontFamily: AppFonts.poppins,
                fontWeight: FontWeight.w600,
                fontSize: 14,
                height: 1,
                color: enabled ? color : color.withValues(alpha: 0.4),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({
    required this.message,
    required this.maxWidth,
    this.onRetry,
    this.peerAvatarUrl,
    this.showAvatar = false,
  });

  final ChatMessage message;
  final double maxWidth;
  final ValueChanged<ChatMessage>? onRetry;
  final String? peerAvatarUrl;
  final bool showAvatar;

  static const _avatarSize = 36.0;
  static const _avatarGap = 8.0;

  @override
  Widget build(BuildContext context) {
    final mine = message.isMine;
    final failed = message.status == ChatMessageStatus.failed;
    final sticker = ChatSticker.assetOf(message.body);
    final bubble = ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Opacity(
        opacity: message.status == ChatMessageStatus.sending ? 0.6 : 1,
        child: sticker != null
            ? ChatStickerImage(asset: sticker)
            : Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: mine ? AppColors.selectionBorder : const Color(0x1A998FED),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(mine ? 16 : 0),
                    topRight: Radius.circular(mine ? 0 : 16),
                    bottomRight: const Radius.circular(16),
                    bottomLeft: const Radius.circular(16),
                  ),
                ),
                child: message.type == 'TEXT'
                    ? AppText(
                        message.displayText,
                        style: TextStyle(
                          fontFamily: AppFonts.poppins,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          height: 20 / 16,
                          letterSpacing: 16 * -0.02,
                          color: mine ? AppColors.white : AppColors.textOnLight,
                        ),
                      )
                    : ChatAttachment(
                        type: message.type,
                        url: message.mediaUrl,
                        mine: mine,
                      ),
              ),
      ),
    );

    if (!mine && peerAvatarUrl != null) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showAvatar)
            ChatPeerAvatar(url: peerAvatarUrl!, size: _avatarSize)
          else
            const SizedBox(width: _avatarSize),
          const SizedBox(width: _avatarGap),
          Flexible(child: bubble),
        ],
      );
    }

    return Align(
      alignment: mine ? Alignment.centerRight : Alignment.centerLeft,
      child: failed
          ? GestureDetector(
              onTap: () => onRetry?.call(message),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.error_outline_rounded,
                    size: 20,
                    color: AppColors.strangerReject,
                  ),
                  const SizedBox(width: 6),
                  Flexible(child: bubble),
                ],
              ),
            )
          : bubble,
    );
  }
}

/// Karşı tarafın vibe paylaşımı (sohbetin başında sol balon, tırnak içinde).
class ChatQuoteBubble extends StatelessWidget {
  const ChatQuoteBubble({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return _Bubble(
      message: ChatMessage(
        clientMsgId: 'quote',
        isMine: false,
        body: '“$text”',
        createdAt: DateTime(2000),
      ),
      maxWidth: MediaQuery.sizeOf(context).width * 0.78,
    );
  }
}

/// Sohbetteki karşı taraf avatarı: ağ adresi varsa o, yoksa anonim yer tutucu.
class ChatPeerAvatar extends StatelessWidget {
  const ChatPeerAvatar({super.key, required this.url, this.size = 36});

  final String url;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: url.startsWith('http')
          ? ChatAvatarImage(url: url, size: size)
          : Image.asset(
              url.isEmpty ? AppAssets.strangerAvatar : url,
              width: size,
              height: size,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Image.asset(
                AppAssets.strangerAvatar,
                width: size,
                height: size,
                fit: BoxFit.cover,
              ),
            ),
    );
  }
}
