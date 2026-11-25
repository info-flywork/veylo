import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/errors/error_messages.dart';
import 'package:veylo/core/safety/content_filter.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/core/widgets/profile_tappable_avatar.dart';
import 'package:veylo/data/remote/api_client.dart';
import 'package:veylo/data/remote/group_repository.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/models/chat/chat_message.dart';
import 'package:veylo/models/chat/chat_thread.dart';
import 'package:veylo/models/group/group_models.dart';
import 'package:veylo/data/remote/chat_store.dart';
import 'package:veylo/screens/chat/chat_actions_sheet.dart';
import 'package:veylo/screens/chat/chat_sticker.dart';
import 'package:veylo/screens/chat/conversation_controller.dart';
import 'package:veylo/screens/chat/conversation_safety_sheet.dart';
import 'package:veylo/screens/chat/message_context_menu.dart';
import 'package:veylo/screens/chat/message_forward_sheet.dart';
import 'package:veylo/screens/chat/widgets/chat_attachment.dart';
import 'package:veylo/screens/chat/widgets/chat_composer.dart';
import 'package:veylo/screens/chat/widgets/chat_composer_context.dart';
import 'package:veylo/screens/discover/rooms/group_info_page.dart';
import 'package:veylo/screens/profile/profile_navigation.dart';

class _GroupMessage {
  const _GroupMessage({
    required this.name,
    required this.body,
    required this.type,
    required this.mediaUrl,
    required this.avatar,
    this.isMine = false,
    this.userId,
    this.blurred = false,
    this.failed = false,
    this.source,
  });

  final String name;
  final String body;
  final String type;
  final String? mediaUrl;
  final String avatar;
  final bool isMine;

  /// Anonim üyede null: profil açılmaz.
  final String? userId;
  final bool blurred;
  final bool failed;
  final ChatMessage? source;

  factory _GroupMessage.from(ChatMessage m) => _GroupMessage(
    name: m.senderName ?? '',
    body: m.body ?? '',
    type: m.type,
    mediaUrl: m.mediaUrl,
    avatar: (m.senderAvatarUrl?.isNotEmpty ?? false)
        ? m.senderAvatarUrl!
        : AppAssets.strangerAvatar,
    isMine: m.isMine,
    userId: m.senderId,
    blurred: m.senderBlurred,
    failed: m.status == ChatMessageStatus.failed,
    source: m,
  );
}

/// Grup kartına tıklanınca açılan sohbet ekranı (Nighttime Chats).
class GroupChatPage extends StatefulWidget {
  const GroupChatPage({
    super.key,
    required this.title,
    required this.memberCount,
    required this.thread,
  });

  final String title;
  final int memberCount;
  final ChatThread thread;

  /// Gerçek grup sohbeti.
  static Future<void> openThread(BuildContext context, ChatThread thread) {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => GroupChatPage(
          title: thread.title,
          memberCount: thread.memberCount,
          thread: thread,
        ),
      ),
    );
  }

  @override
  State<GroupChatPage> createState() => _GroupChatPageState();
}

class _GroupChatPageState extends State<GroupChatPage> {
  ConversationController? _ctrl;
  final _input = TextEditingController();
  final _scroll = ScrollController();
  List<GroupMember> _members = const [];
  String? _mentionQuery;
  int? _mentionStart;

  @override
  void initState() {
    super.initState();
    _ctrl = ConversationController(widget.thread)..start();
    _ctrl!.addListener(_onCtrlChanged);
    _scroll.addListener(_onScroll);
    _input.addListener(_onInputChanged);
    _loadMembers();
  }

  @override
  void dispose() {
    _input.removeListener(_onInputChanged);
    _ctrl?.removeListener(_onCtrlChanged);
    _scroll.removeListener(_onScroll);
    _scroll.dispose();
    _ctrl?.dispose();
    _input.dispose();
    super.dispose();
  }

  /// Direct sohbetle aynı: ters listede üste (eski) yaklaşınca sayfa çek.
  void _onScroll() {
    if (!_scroll.hasClients) return;
    final pos = _scroll.position;
    if (pos.pixels > pos.maxScrollExtent - 200) {
      _ctrl?.loadOlder();
    }
  }

  /// Kısa liste / ilk yüklemede kaydırma olmadan da devamını getir.
  void _onCtrlChanged() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_scroll.hasClients) return;
      final pos = _scroll.position;
      if (pos.maxScrollExtent < 200) _ctrl?.loadOlder();
    });
  }

  Future<void> _loadMembers() async {
    try {
      final info = await GroupRepository.instance.info(widget.thread.id);
      if (!mounted) return;
      setState(() => _members = info.members);
    } catch (_) {
      // Etiket listesi opsiyonel; sohbet yine çalışır.
    }
  }

  void _onInputChanged() {
    final mention = _activeMention();
    setState(() {
      _mentionQuery = mention?.query;
      _mentionStart = mention?.start;
    });
  }

  /// İmleç önünde `@sorgu` varsa aktif etiketleme.
  ({String query, int start})? _activeMention() {
    final text = _input.text;
    final cursor = _input.selection.baseOffset;
    if (cursor < 0 || cursor > text.length) return null;
    final before = text.substring(0, cursor);
    final match = RegExp(r'(^|[\s])@([^\s@]*)$').firstMatch(before);
    if (match == null) return null;
    final prefix = match.group(1) ?? '';
    return (query: match.group(2) ?? '', start: match.start + prefix.length);
  }

  String _mentionHandle(GroupMember m) {
    final u = m.username?.trim();
    if (u != null && u.isNotEmpty) {
      return u.startsWith('@') ? u.substring(1) : u;
    }
    return m.displayName.trim();
  }

  List<GroupMember> get _mentionCandidates {
    final q = (_mentionQuery ?? '').toLowerCase();
    return [
      for (final m in _members)
        if (!m.isYou && m.displayName.trim().isNotEmpty)
          if (q.isEmpty ||
              m.displayName.toLowerCase().contains(q) ||
              (m.username?.toLowerCase().contains(q) ?? false))
            m,
    ];
  }

  void _insertMention(GroupMember member) {
    final start = _mentionStart;
    if (start == null) return;
    final handle = _mentionHandle(member);
    if (handle.isEmpty) return;
    final tag = '@$handle ';
    final text = _input.text;
    final cursor = _input.selection.baseOffset.clamp(0, text.length);
    final next = text.replaceRange(start, cursor, tag);
    _input.value = TextEditingValue(
      text: next,
      selection: TextSelection.collapsed(offset: start + tag.length),
    );
    setState(() {
      _mentionQuery = null;
      _mentionStart = null;
    });
  }

  /// Yanıt + etiket: composer'a @ad ekler, replyTo bağlar.
  void _replyTo(ChatMessage message) {
    final ctrl = _ctrl;
    if (ctrl == null) return;
    ctrl.setReplyTarget(message);
    if (!message.isMine) {
      final raw = (message.senderName ?? '').trim();
      if (raw.isNotEmpty) {
        final tag = raw.startsWith('@') ? '$raw ' : '@$raw ';
        final text = _input.text;
        if (!text.contains(tag.trim())) {
          _input.text = '$tag$text';
          _input.selection = TextSelection.collapsed(offset: _input.text.length);
        }
      }
    }
  }

  /// İsme uzun basmadan etiketle (alıntısız).
  void _tagUser(String name) {
    final raw = name.trim();
    if (raw.isEmpty) return;
    final tag = raw.startsWith('@') ? '$raw ' : '@$raw ';
    final text = _input.text;
    if (text.startsWith(tag) || text.contains(' ${tag.trim()}')) return;
    final next = text.isEmpty || text.endsWith(' ') ? '$text$tag' : '$text $tag';
    _input.text = next;
    _input.selection = TextSelection.collapsed(offset: _input.text.length);
  }

  Future<void> _onLongPress(ChatMessage m) async {
    final ctrl = _ctrl;
    if (ctrl == null || m.type == 'SYSTEM' || m.status == ChatMessageStatus.sending) {
      return;
    }
    await showMessageContextMenu(
      context,
      message: m,
      onReact: (emoji) => ctrl.reactToMessage(m, emoji),
      onAction: (action) async {
        switch (action) {
          case MessageMenuAction.reply:
            _replyTo(m);
          case MessageMenuAction.forward:
            await showMessageForwardSheet(
              context,
              controller: ctrl,
              message: m,
            );
          case MessageMenuAction.copy:
            await copyChatMessageText(context, m);
          case MessageMenuAction.edit:
            ctrl.setEditing(m);
            _input.text = m.body ?? '';
            _input.selection = TextSelection.collapsed(
              offset: _input.text.length,
            );
          case MessageMenuAction.delete:
            await deleteChatMessage(context, ctrl, m);
          case MessageMenuAction.report:
            await reportChatMessage(context, ctrl, m);
          case MessageMenuAction.block:
            await blockChatMessageUser(
              context,
              ctrl,
              m,
              closeScreen: false,
            );
        }
      },
    );
  }

  Future<void> _openGroupSafetyMenu() async {
    final conversationId = _ctrl?.thread.id ?? widget.thread.id;
    final action = await showConversationSafetySheet(
      context,
      actions: const [
        ConversationSafetyAction.reportGroup,
        ConversationSafetyAction.leaveGroup,
      ],
    );
    if (!mounted || action == null) return;
    switch (action) {
      case ConversationSafetyAction.reportGroup:
        String? targetId;
        try {
          final info = await GroupRepository.instance.info(conversationId);
          // Önce gerçek (AI olmayan) üyeler; yoksa owner / herhangi biri.
          final others = info.members
              .where((m) => m.userId != null && !m.isYou)
              .toList();
          targetId = others
              .where((m) => !m.isAi)
              .map((m) => m.userId)
              .firstOrNull;
          targetId ??= others
              .where((m) => m.role == 'OWNER')
              .map((m) => m.userId)
              .firstOrNull;
          targetId ??= others.map((m) => m.userId).firstOrNull;
        } catch (_) {
          targetId = _ctrl?.messages
              .where((m) => !m.isMine && m.senderId != null)
              .map((m) => m.senderId!)
              .firstOrNull;
        }
        if (targetId == null) {
          if (mounted) {
            showErrorSnackBar(
              context,
              const ApiException(status: 404, code: 'PEER_UNAVAILABLE'),
            );
          }
          return;
        }
        if (!mounted) return;
        await reportTargetUser(
          context,
          userId: targetId,
          conversationId: conversationId,
          contextType: 'GROUP',
          contentId: conversationId,
        );
      case ConversationSafetyAction.leaveGroup:
        try {
          await GroupRepository.instance.leave(conversationId);
          ChatStore.instance.remove(conversationId);
          if (mounted) Navigator.of(context).pop();
        } catch (e) {
          if (mounted) showErrorSnackBar(context, e);
        }
      default:
        break;
    }
  }

  Future<void> _send() async {
    final ctrl = _ctrl;
    final text = _input.text.trim();
    if (ctrl == null || text.isEmpty) return;
    if (ContentFilter.isObjectionable(text)) {
      showErrorSnackBar(
        context,
        const ApiException(status: 400, code: 'CONTENT_BLOCKED'),
      );
      return;
    }
    _input.clear();
    await ctrl.send(text);
    final err = ctrl.lastError;
    if (err != null && mounted) {
      ctrl.lastError = null;
      showErrorSnackBar(context, err);
    }
  }

  Future<void> _openInfo(String title, int memberCount) async {
    final left = await GroupInfoPage.open(
      context,
      title: title,
      memberCount: memberCount,
      conversationId: _ctrl?.thread.id ?? widget.thread.id,
    );
    if (left == true && mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = _ctrl;
    if (ctrl == null) return _build(context, null);
    return ListenableBuilder(
      listenable: ctrl,
      builder: (context, _) => _build(context, ctrl),
    );
  }

  Widget _build(BuildContext context, ConversationController? ctrl) {
    final t = Translations.of(context).discover.groupChat;
    final live = Translations.of(context).discover.liveRoom;
    final top = MediaQuery.paddingOf(context).top;
    final bottom = MediaQuery.paddingOf(context).bottom;

    final thread = ctrl?.thread;
    final title = thread?.title ?? widget.title;
    final memberCount = thread?.memberCount ?? widget.memberCount;
    final avatars = (thread?.groupAvatarUrls?.isNotEmpty ?? false)
        ? thread!.groupAvatarUrls!
        : const [AppAssets.strangerAvatar];

    final messages = ctrl != null
        ? [for (final m in ctrl.messages) _GroupMessage.from(m)]
        : const <_GroupMessage>[];

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ColoredBox(
            color: AppColors.white,
            child: Padding(
              padding: EdgeInsets.fromLTRB(8, top + 4, 16, 10),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 18,
                      color: AppColors.black,
                    ),
                  ),
                  _HeaderAvatars(avatars: avatars),
                  const SizedBox(width: 8),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _openInfo(title, memberCount),
                      behavior: HitTestBehavior.opaque,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            title,
                            style: AppTextStyles.groupChatTitle,
                            maxLines: 1,
                          ),
                          const SizedBox(height: 2),
                          AppText(
                            t.usersCount(count: memberCount.toString()),
                            style: AppTextStyles.groupChatUsers,
                          ),
                        ],
                      ),
                    ),
                  ),
                  ChatHeaderMoreButton(onPressed: _openGroupSafetyMenu),
                ],
              ),
            ),
          ),
          Container(height: 1, color: AppColors.black.withValues(alpha: 0.10)),
          Expanded(
            child: ListView.separated(
              controller: _scroll,
              reverse: true,
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
              itemCount: messages.length,
              separatorBuilder: (_, _) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final message = messages[messages.length - 1 - index];
                final source = message.source;
                return _SwipeToReply(
                  enabled: source?.id != null,
                  onReply: () {
                    if (source != null) _replyTo(source);
                  },
                  child: _GroupChatBubble(
                    message: message,
                    onRetry: message.failed && source != null
                        ? () => ctrl?.retry(source)
                        : null,
                    onLongPress: source == null
                        ? null
                        : () => _onLongPress(source),
                    onTagName: message.isMine || message.name.isEmpty
                        ? null
                        : () => _tagUser(message.name),
                  ),
                );
              },
            ),
          ),
          if (ctrl != null)
            ChatComposerContextBar(
              reply: ctrl.replyTarget,
              editing: ctrl.editingMessage,
              onClear: () {
                final wasEditing = ctrl.editingMessage != null;
                ctrl.clearComposerContext();
                if (wasEditing) _input.clear();
              },
            ),
          if (_mentionQuery != null) _MentionSuggestions(
            members: _mentionCandidates,
            onPick: _insertMention,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, bottom > 0 ? bottom : 8),
            child: ChatComposer(
              hint: live.messageHint,
              controller: _input,
              onSend: _send,
              onChanged: (_) => ctrl?.onTyping(),
              onSticker: (asset) async {
                final current = _ctrl;
                if (current == null) return;
                await current.send(ChatSticker.encode(asset));
                if (!context.mounted) return;
                final err = current.lastError;
                if (err != null) {
                  current.lastError = null;
                  showErrorSnackBar(context, err);
                }
              },
              onMedia: (kind, path) async {
                final current = _ctrl;
                if (current == null) return;
                await current.sendMedia(kind, path);
                if (!context.mounted) return;
                final err = current.lastError;
                if (err != null) {
                  current.lastError = null;
                  showErrorSnackBar(context, err);
                }
              },
              onImages: (paths) async {
                final current = _ctrl;
                if (current == null) return;
                await current.sendImages(paths);
                if (!context.mounted) return;
                final err = current.lastError;
                if (err != null) {
                  current.lastError = null;
                  showErrorSnackBar(context, err);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// `@` yazılınca composer üstünde üye listesi.
class _MentionSuggestions extends StatelessWidget {
  const _MentionSuggestions({
    required this.members,
    required this.onPick,
  });

  final List<GroupMember> members;
  final ValueChanged<GroupMember> onPick;

  @override
  Widget build(BuildContext context) {
    if (members.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
      child: Material(
        color: AppColors.white,
        elevation: 6,
        shadowColor: AppColors.black.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(16),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 220),
          child: ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(vertical: 6),
            itemCount: members.length.clamp(0, 12),
            separatorBuilder: (_, _) => const Divider(
              height: 1,
              indent: 56,
              endIndent: 12,
              color: Color(0x14000000),
            ),
            itemBuilder: (context, index) {
              final m = members[index];
              final handle = () {
                final u = m.username?.trim();
                if (u != null && u.isNotEmpty) {
                  return u.startsWith('@') ? u : '@$u';
                }
                return '@${m.displayName.trim()}';
              }();
              return InkWell(
                onTap: () => onPick(m),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      ProfileTappableAvatar(
                        avatarUrl: m.avatarUrl ?? AppAssets.strangerAvatar,
                        size: 36,
                        enabled: false,
                        blurred: m.blurred,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              m.displayName,
                              maxLines: 1,
                              style: const TextStyle(
                                fontFamily: AppFonts.poppins,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                height: 18 / 14,
                                color: AppColors.black,
                              ),
                            ),
                            AppText(
                              handle,
                              maxLines: 1,
                              style: TextStyle(
                                fontFamily: AppFonts.poppins,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                height: 16 / 12,
                                color: AppColors.selectionBorder,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _SwipeToReply extends StatefulWidget {
  const _SwipeToReply({
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
                child: const Icon(
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

class _HeaderAvatars extends StatelessWidget {
  const _HeaderAvatars({required this.avatars});

  final List<String> avatars;

  @override
  Widget build(BuildContext context) {
    final shown = avatars.take(3).toList();
    const size = 28.0;
    const overlap = 16.0;
    final width = size + (shown.length - 1) * overlap;

    return SizedBox(
      width: width,
      height: size,
      child: Stack(
        children: [
          for (var i = 0; i < shown.length; i++)
            Positioned(
              left: i * overlap,
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.white, width: 1.5),
                ),
                child: ProfileTappableAvatar(avatarUrl: shown[i], size: size),
              ),
            ),
        ],
      ),
    );
  }
}

class _GroupChatBubble extends StatelessWidget {
  const _GroupChatBubble({
    required this.message,
    this.onRetry,
    this.onLongPress,
    this.onTagName,
  });

  final _GroupMessage message;

  /// Gönderilemeyen mesaja dokununca tekrar dener.
  final VoidCallback? onRetry;
  final VoidCallback? onLongPress;
  final VoidCallback? onTagName;

  static const _incomingBg = Color(0x1A998FED); // #998FED @ 10%

  @override
  Widget build(BuildContext context) {
    if (message.isMine) {
      return Align(
        alignment: Alignment.centerRight,
        child: GestureDetector(
          onTap: onRetry,
          onLongPress: onLongPress,
          child: Opacity(
            opacity: message.failed ? 0.5 : 1,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.sizeOf(context).width * 0.75,
              ),
              child: _GroupBubbleBody(message: message, mine: true),
            ),
          ),
        ),
      );
    }

    final canOpenProfile = message.source == null || message.userId != null;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileTappableAvatar(
          avatarUrl: message.avatar,
          size: 44,
          userId: message.userId,
          displayName: message.name,
          enabled: canOpenProfile,
          blurred: message.blurred,
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: canOpenProfile
                    ? () => openUserProfile(
                        context,
                        userId: message.userId,
                        displayName: message.name,
                        avatarUrl: message.avatar,
                      )
                    : null,
                onLongPress: onTagName,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: AppText(
                        message.name,
                        style: AppTextStyles.groupChatSender,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              GestureDetector(
                onLongPress: onLongPress,
                child: _GroupBubbleBody(message: message, mine: false),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _GroupBubbleBody extends StatelessWidget {
  const _GroupBubbleBody({required this.message, required this.mine});

  final _GroupMessage message;
  final bool mine;

  @override
  Widget build(BuildContext context) {
    final sticker = ChatSticker.assetOf(message.body);
    if (sticker != null) return ChatStickerImage(asset: sticker);
    final reply = message.source?.replyTo;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: mine ? AppColors.selectionBorder : _GroupChatBubble._incomingBg,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(mine ? 16 : 0),
          topRight: const Radius.circular(16),
          bottomRight: Radius.circular(mine ? 4 : 16),
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
              message.body,
              style: mine
                  ? AppTextStyles.groupChatOwnBody
                  : AppTextStyles.groupChatBody,
            )
          else
            ChatAttachment(
              type: message.type,
              url: message.mediaUrl,
              mine: mine,
            ),
        ],
      ),
    );
  }
}
