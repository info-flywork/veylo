import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/errors/error_messages.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/core/widgets/profile_tappable_avatar.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/data/remote/chat_store.dart';
import 'package:veylo/models/chat/chat_thread.dart';
import 'package:veylo/screens/chat/chat_actions_sheet.dart';
import 'package:veylo/screens/chat/widgets/chat_call_buttons.dart';
import 'package:veylo/screens/chat/chat_sticker.dart';
import 'package:veylo/screens/chat/connection_progress_sheet.dart';
import 'package:veylo/screens/chat/conversation_controller.dart';
import 'package:veylo/screens/chat/direct_chat_page.dart';
import 'package:veylo/screens/chat/message_forward_sheet.dart';
import 'package:veylo/screens/chat/reveal_profile_sheet.dart';
import 'package:veylo/screens/chat/widgets/chat_composer.dart';
import 'package:veylo/screens/chat/widgets/chat_composer_context.dart';
import 'package:veylo/screens/chat/widgets/chat_message_list.dart';
import 'package:veylo/screens/chat/widgets/stranger_request_block.dart';

/// Anonim kullanıcı ile birebir sohbet — Connection header + progress sheet.
class AnonymousChatPage extends StatefulWidget {
  const AnonymousChatPage({super.key, required this.thread});

  final ChatThread thread;

  static Future<void> open(BuildContext context, ChatThread thread) {
    ChatStore.instance.prefetchMessages(thread.id);
    return Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (_) => AnonymousChatPage(thread: thread),
      ),
    );
  }

  @override
  State<AnonymousChatPage> createState() => _AnonymousChatPageState();
}

class _AnonymousChatPageState extends State<AnonymousChatPage> {
  late final ConversationController _ctrl = ConversationController(
    widget.thread,
  );
  final _input = TextEditingController();
  bool _handlingRequest = false;
  bool _switched = false;

  @override
  void initState() {
    super.initState();
    _ctrl.addListener(_onControllerChanged);
    _ctrl.start();
  }

  @override
  void dispose() {
    _ctrl.removeListener(_onControllerChanged);
    _ctrl.dispose();
    _input.dispose();
    super.dispose();
  }

  /// Profiller açılınca (iki taraf onayladı) normal sohbet ekranına geçilir.
  void _onControllerChanged() {
    final error = _ctrl.lastError;
    if (error != null) {
      _ctrl.lastError = null;
      showErrorSnackBar(context, error);
    }
    if (_ctrl.thread.revealed && !_switched && mounted) {
      _switched = true;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (_) => DirectChatPage(thread: _ctrl.thread),
        ),
      );
    }
  }

  void _send() {
    final text = _input.text;
    if (text.trim().isEmpty) return;
    _input.clear();
    _ctrl.send(text);
  }

  Future<void> _requestAction(
    Future<void> Function() action, {
    bool close = false,
  }) async {
    if (_handlingRequest) return;
    setState(() => _handlingRequest = true);
    try {
      await action();
      if (close && mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) showErrorSnackBar(context, e);
    } finally {
      if (mounted) setState(() => _handlingRequest = false);
    }
  }

  Future<void> _onConnectionTap(ChatThread thread, int progress) async {
    final name = thread.peerUsername ?? thread.maskedName ?? thread.title;
    if (progress < 100) {
      await showConnectionProgressSheet(
        context,
        progress: progress,
        messages: _ctrl.messages,
        onRequest: _ctrl.requestUnlock,
      );
      return;
    }
    final reveal = await showRevealProfileSheet(
      context,
      peerUsername: name,
      myConsent: thread.myRevealConsent,
      peerConsent: thread.peerRevealConsent,
    );
    if (reveal == true && mounted) await _requestAction(_ctrl.reveal);
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).chats;
    final top = MediaQuery.viewPaddingOf(context).top;
    final bottom = MediaQuery.viewPaddingOf(context).bottom;

    return ListenableBuilder(
      listenable: _ctrl,
      builder: (context, _) {
        final thread = _ctrl.thread;
        final progress = thread.connectionProgress.clamp(0, 100);
        final masked = thread.maskedName ?? '**********';
        final messages = _ctrl.messages;
        final quote = thread.contextQuote?.trim();
        // Bana gelen istek: ilk mesaj Approve / Block / Reject ile gösterilir.
        final firstIncoming = thread.isStrangerRequest
            ? messages.where((m) => !m.isMine).firstOrNull
            : null;

        return Scaffold(
          backgroundColor: AppColors.white,
          resizeToAvoidBottomInset: true,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ColoredBox(
                color: AppColors.white,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(8, top + 4, 16, 12),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 44,
                          minHeight: 44,
                        ),
                        icon: SvgPicture.asset(
                          AppAssets.backButton,
                          width: 24,
                          height: 24,
                        ),
                      ),
                      ProfileTappableAvatar(
                        avatarUrl: thread.avatarUrl,
                        size: 44,
                        userId: thread.peerUserId,
                        displayName: thread.peerUserId != null ? thread.title : masked,
                        username: thread.peerUsername,
                        enabled: thread.peerUserId != null,
                        blurred: thread.isAnonymous && thread.peerAvatarBlurred,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: AppText(
                                    masked,
                                    style: const TextStyle(
                                      fontFamily: AppFonts.poppins,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      height: 24 / 16,
                                      letterSpacing: 16 * -0.02,
                                      color: AppColors.black,
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: thread.isOnline
                                        ? const Color(0xFF33C658)
                                        : AppColors.navInactive,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Flexible(
                                  child: AppText(
                                    _ctrl.peerTyping
                                        ? t.typing
                                        : (thread.isOnline
                                              ? t.online
                                              : t.offline),
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontFamily: AppFonts.poppins,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      height: 16 / 14,
                                      letterSpacing: 14 * -0.02,
                                      color: Color(0xA6000000),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      ChatCallButtons(thread: thread),
                      const SizedBox(width: 8),
                      ChatHeaderMoreButton(
                        onPressed: () => showChatActionsMenu(context, _ctrl),
                      ),
                    ],
                  ),
                ),
              ),
              // Bağlantı ilerlemesi başlığın altında, tam genişlikte.
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                child: _ConnectionPill(
                  label: t.connection,
                  percentLabel: t.connectionPercent(n: progress),
                  progress: progress / 100,
                  onTap: () => _onConnectionTap(thread, progress),
                ),
              ),
              Container(
                height: 1,
                color: AppColors.black.withValues(alpha: 0.10),
              ),
              Expanded(
                child: ChatMessageList(
                  messages: messages,
                  peerLastReadSeq: thread.peerLastReadSeq,
                  seenLabel: t.seen,
                  sendingLabel: t.messageSending,
                  onRetry: _ctrl.retry,
                  onUnlockDecision: _ctrl.respondUnlock,
                  onLoadOlder: _ctrl.loadOlder,
                  skipFirstIncoming: firstIncoming != null,
                  peerAvatarUrl: thread.avatarUrl,
                  onReply: _ctrl.setReplyTarget,
                  onForward: (m) => showMessageForwardSheet(
                    context,
                    controller: _ctrl,
                    message: m,
                  ),
                  onEdit: (m) {
                    _ctrl.setEditing(m);
                    _input.text = m.body ?? '';
                    _input.selection = TextSelection.collapsed(
                      offset: _input.text.length,
                    );
                  },
                  onDeleteMessage: (m) => deleteChatMessage(context, _ctrl, m),
                  onReportMessage: (m) => reportChatMessage(context, _ctrl, m),
                  onReact: (m, emoji) => _ctrl.reactToMessage(m, emoji),
                  leading: [
                    if (quote != null && quote.isNotEmpty)
                      ChatQuoteBubble(text: quote),
                    if (firstIncoming != null)
                      StrangerRequestBlock(
                        text: firstIncoming.displayText,
                        avatarUrl: thread.avatarUrl,
                        approveLabel: t.approve,
                        blockLabel: t.blockUser,
                        rejectLabel: t.reject,
                        showActions: !_handlingRequest,
                        onApprove: () => _requestAction(_ctrl.approve),
                        onBlock: () =>
                            _requestAction(_ctrl.blockPeer, close: true),
                        onReject: () =>
                            _requestAction(_ctrl.reject, close: true),
                      ),
                  ],
                ),
              ),
              ChatComposerContextBar(
                reply: _ctrl.replyTarget,
                editing: _ctrl.editingMessage,
                onClear: () {
                  final wasEditing = _ctrl.editingMessage != null;
                  _ctrl.clearComposerContext();
                  if (wasEditing) _input.clear();
                },
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  16,
                  8,
                  16,
                  bottom > 0 ? bottom : 8,
                ),
                child: ChatComposer(
                  hint: t.messageHint,
                  controller: _input,
                  onChanged: (_) => _ctrl.onTyping(),
                  onSend: _send,
                  onSticker: (asset) => _ctrl.send(ChatSticker.encode(asset)),
                  onMedia: (kind, path) => _ctrl.sendMedia(kind, path),
                  onImages: _ctrl.sendImages,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ConnectionPill extends StatelessWidget {
  const _ConnectionPill({
    required this.label,
    required this.percentLabel,
    required this.progress,
    required this.onTap,
  });

  final String label;
  final String percentLabel;
  final double progress;
  final VoidCallback onTap;

  static const _bg = Color(0xFFF4F3FD);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _bg,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: AppText(
                      label,
                      style: const TextStyle(
                        fontFamily: AppFonts.poppins,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        height: 18 / 14,
                        letterSpacing: 14 * -0.02,
                        color: AppColors.black,
                      ),
                      maxLines: 1,
                    ),
                  ),
                  AppText(
                    percentLabel,
                    style: const TextStyle(
                      fontFamily: AppFonts.poppins,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      height: 18 / 14,
                      letterSpacing: 14 * -0.02,
                      color: AppColors.selectionBorder,
                    ),
                  ),
                  const SizedBox(width: 2),
                  const Icon(
                    Icons.chevron_right_rounded,
                    size: 18,
                    color: AppColors.selectionBorder,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: LinearProgressIndicator(
                  value: progress.clamp(0.0, 1.0),
                  minHeight: 4,
                  backgroundColor: AppColors.selectionBorder.withValues(
                    alpha: 0.15,
                  ),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.selectionBorder,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
