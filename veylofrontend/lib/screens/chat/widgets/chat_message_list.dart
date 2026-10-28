import 'package:flutter/material.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/models/chat/chat_message.dart';
import 'package:veylo/screens/chat/widgets/chat_note_card.dart';

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
    this.onLoadOlder,
    this.skipFirstIncoming = false,
    this.peerAvatarUrl,
  });

  final List<ChatMessage> messages;
  final List<Widget> leading;
  final int? peerLastReadSeq;
  final String? seenLabel;
  final ValueChanged<ChatMessage>? onRetry;
  final VoidCallback? onLoadOlder;

  /// İlk gelen mesaj [leading] içinde (istek bloğu) gösterildiyse listede tekrar gösterme.
  final bool skipFirstIncoming;

  /// Verilirse gelen mesajların solunda karşı tarafın avatarı gösterilir (Figma).
  /// Boş/asset değilse anonim yer tutucu ikon kullanılır.
  final String? peerAvatarUrl;

  @override
  State<ChatMessageList> createState() => _ChatMessageListState();
}

class _ChatMessageListState extends State<ChatMessageList> {
  final _scroll = ScrollController();

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
          _UnlockNotice(message: m)
        else
        _Bubble(
          message: m,
          maxWidth: maxBubble,
          onRetry: widget.onRetry,
          peerAvatarUrl: widget.peerAvatarUrl,
          // Art arda gelen mesajlarda avatar ilkinde; diğerleri aynı hizada.
          showAvatar: !m.isMine && (i == 0 || msgs[i - 1].isMine),
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

class _UnlockNotice extends StatelessWidget {
  const _UnlockNotice({required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).chats;
    final title = switch (message.body) {
      'unlock:initial' => t.milestoneInitial,
      'unlock:photo' => t.milestonePhoto,
      'unlock:full' => t.milestoneFull,
      _ => message.body ?? '',
    };
    final text = message.isMine
        ? 'You sent a request: $title'
        : 'The person you\'re chatting with sent you a request about $title';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0x14998FED),
            borderRadius: BorderRadius.circular(12),
          ),
          child: AppText(
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
    final bubble = ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Opacity(
        opacity: message.status == ChatMessageStatus.sending ? 0.6 : 1,
        child: Container(
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
          child: AppText(
            message.displayText,
            style: TextStyle(
              fontFamily: AppFonts.poppins,
              fontWeight: FontWeight.w400,
              fontSize: 16,
              height: 20 / 16,
              letterSpacing: 16 * -0.02,
              color: mine ? AppColors.white : AppColors.textOnLight,
            ),
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
