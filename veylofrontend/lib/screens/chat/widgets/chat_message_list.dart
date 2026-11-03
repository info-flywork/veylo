import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/models/chat/chat_message.dart';
import 'package:veylo/screens/chat/chat_sticker.dart';
import 'package:veylo/screens/chat/message_context_menu.dart';
import 'package:veylo/screens/chat/widgets/chat_attachment.dart';
import 'package:veylo/screens/chat/widgets/chat_note_card.dart';

/// Sohbet balonları (Direct ve Anonymous ekranlarının ortak listesi).
/// Kaydır → yanıtla; basılı tut → emoji + düzenle/sil; fotoğrafa dokun → büyüt.
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
    this.onReply,
    this.onEdit,
    this.onDeleteMessage,
    this.onReportMessage,
    this.onReact,
  });

  final List<ChatMessage> messages;
  final List<Widget> leading;
  final int? peerLastReadSeq;
  final String? seenLabel;
  final ValueChanged<ChatMessage>? onRetry;
  final Future<void> Function(ChatMessage message, String decision)? onUnlockDecision;
  final VoidCallback? onLoadOlder;
  final bool skipFirstIncoming;
  final String? peerAvatarUrl;
  final ValueChanged<ChatMessage>? onReply;
  final ValueChanged<ChatMessage>? onEdit;
  final ValueChanged<ChatMessage>? onDeleteMessage;
  final ValueChanged<ChatMessage>? onReportMessage;
  final Future<void> Function(ChatMessage message, String emoji)? onReact;

  @override
  State<ChatMessageList> createState() => _ChatMessageListState();
}

class _ChatMessageListState extends State<ChatMessageList> {
  final _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    _scroll.addListener(() {
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

  Future<void> _onLongPress(ChatMessage m) async {
    if (m.type == 'SYSTEM' || m.status == ChatMessageStatus.sending) return;
    await showMessageContextMenu(
      context,
      message: m,
      onReact: (emoji) => widget.onReact?.call(m, emoji),
      onAction: (action) async {
        switch (action) {
          case MessageMenuAction.reply:
            widget.onReply?.call(m);
          case MessageMenuAction.copy:
            await copyChatMessageText(context, m);
          case MessageMenuAction.edit:
            widget.onEdit?.call(m);
          case MessageMenuAction.delete:
            widget.onDeleteMessage?.call(m);
          case MessageMenuAction.report:
            widget.onReportMessage?.call(m);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final maxBubble = MediaQuery.sizeOf(context).width * 0.78;
    var msgs = widget.messages;
    if (widget.skipFirstIncoming) {
      final i = msgs.indexWhere((m) => !m.isMine);
      if (i >= 0) msgs = [...msgs.sublist(0, i), ...msgs.sublist(i + 1)];
    }
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
          _SwipeToReply(
            key: ValueKey('swipe_${m.clientMsgId}'),
            enabled: m.id != null && widget.onReply != null,
            onReply: () => widget.onReply?.call(m),
            child: _Bubble(
              message: m,
              maxWidth: maxBubble,
              onRetry: widget.onRetry,
              peerAvatarUrl: widget.peerAvatarUrl,
              showAvatar: !m.isMine && (i == 0 || msgs[i - 1].isMine),
              onLongPress: () => _onLongPress(m),
              onReactTap: widget.onReact == null
                  ? null
                  : (emoji) => widget.onReact!(m, emoji),
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

/// WhatsApp gibi kaydırınca yanıtla (eşiği geçince tetiklenir, geri yaylanır).
class _SwipeToReply extends StatefulWidget {
  const _SwipeToReply({
    super.key,
    required this.child,
    required this.enabled,
    required this.onReply,
  });

  final Widget child;
  final bool enabled;
  final VoidCallback onReply;

  @override
  State<_SwipeToReply> createState() => _SwipeToReplyState();
}

class _SwipeToReplyState extends State<_SwipeToReply> {
  double _dx = 0;
  bool _fired = false;
  static const _threshold = 56.0;

  void _end() {
    if (_fired) widget.onReply();
    setState(() {
      _dx = 0;
      _fired = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) return widget.child;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onHorizontalDragUpdate: (d) {
        final next = (_dx + d.delta.dx).clamp(-80.0, 80.0);
        final crossed = next.abs() >= _threshold;
        if (crossed && !_fired) {
          _fired = true;
          HapticFeedback.mediumImpact();
        } else if (!crossed) {
          _fired = false;
        }
        setState(() => _dx = next);
      },
      onHorizontalDragEnd: (_) => _end(),
      onHorizontalDragCancel: _end,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (_dx.abs() > 8)
            Align(
              alignment: _dx > 0 ? Alignment.centerLeft : Alignment.centerRight,
              child: Opacity(
                opacity: (_dx.abs() / _threshold).clamp(0.2, 1),
                child: Icon(
                  Icons.reply_rounded,
                  color: AppColors.selectionBorder,
                  size: 22,
                ),
              ),
            ),
          Transform.translate(
            offset: Offset(_dx * 0.35, 0),
            child: widget.child,
          ),
        ],
      ),
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
    this.onLongPress,
    this.onReactTap,
  });

  final ChatMessage message;
  final double maxWidth;
  final ValueChanged<ChatMessage>? onRetry;
  final String? peerAvatarUrl;
  final bool showAvatar;
  final VoidCallback? onLongPress;
  final ValueChanged<String>? onReactTap;

  static const _avatarSize = 36.0;
  static const _avatarGap = 8.0;

  @override
  Widget build(BuildContext context) {
    final mine = message.isMine;
    final failed = message.status == ChatMessageStatus.failed;
    final sticker = ChatSticker.assetOf(message.body);
    final t = Translations.of(context).chats;
    final reply = message.replyTo;
    final bubble = ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Opacity(
        opacity: message.status == ChatMessageStatus.sending ? 0.6 : 1,
        child: Column(
          crossAxisAlignment: mine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onLongPress: onLongPress,
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (reply != null) ...[
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(bottom: 8),
                              padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
                              decoration: BoxDecoration(
                                color: mine
                                    ? AppColors.white.withValues(alpha: 0.18)
                                    : AppColors.selectionBorder.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(8),
                                border: Border(
                                  left: BorderSide(
                                    color: mine ? AppColors.white : AppColors.selectionBorder,
                                    width: 3,
                                  ),
                                ),
                              ),
                              child: AppText(
                                reply.body ?? '',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: AppFonts.poppins,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  height: 16 / 12,
                                  color: mine
                                      ? AppColors.white.withValues(alpha: 0.9)
                                      : AppColors.textOnLight.withValues(alpha: 0.75),
                                ),
                              ),
                            ),
                          ],
                          if (message.type == 'TEXT')
                            AppText(
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
                          else
                            ChatAttachment(
                              type: message.type,
                              url: message.mediaUrl,
                              mine: mine,
                            ),
                          if (message.editedAt != null) ...[
                            const SizedBox(height: 4),
                            AppText(
                              t.messageEdited,
                              style: TextStyle(
                                fontFamily: AppFonts.poppins,
                                fontSize: 11,
                                color: mine
                                    ? AppColors.white.withValues(alpha: 0.7)
                                    : AppColors.textOnLight.withValues(alpha: 0.45),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
            ),
            if (message.reactions.isNotEmpty) ...[
              const SizedBox(height: 4),
              Wrap(
                spacing: 4,
                runSpacing: 4,
                children: [
                  for (final r in message.reactions)
                    GestureDetector(
                      onTap: onReactTap == null ? null : () => onReactTap!(r.emoji),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: r.mine
                              ? AppColors.selectionBorder.withValues(alpha: 0.15)
                              : AppColors.inputFill,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: r.mine
                                ? AppColors.selectionBorder
                                : AppColors.black.withValues(alpha: 0.06),
                          ),
                        ),
                        child: Text(
                          '${r.emoji} ${r.count}',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ],
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
