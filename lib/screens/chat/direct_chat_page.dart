import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/errors/error_messages.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/core/widgets/profile_tappable_avatar.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/models/chat/chat_thread.dart';
import 'package:veylo/screens/chat/conversation_controller.dart';
import 'package:veylo/screens/chat/widgets/chat_message_list.dart';
import 'package:veylo/screens/chat/widgets/stranger_request_block.dart';

/// Bireysel (1:1) sohbet — tek avatar + isim, grup UI yok.
class DirectChatPage extends StatefulWidget {
  const DirectChatPage({super.key, required this.thread});

  final ChatThread thread;

  static Future<void> open(BuildContext context, ChatThread thread) {
    return Navigator.of(context).push<void>(
      MaterialPageRoute<void>(builder: (_) => DirectChatPage(thread: thread)),
    );
  }

  @override
  State<DirectChatPage> createState() => _DirectChatPageState();
}

class _DirectChatPageState extends State<DirectChatPage> {
  late final ConversationController _ctrl = ConversationController(
    widget.thread,
  );
  final _input = TextEditingController();
  bool _handlingRequest = false;

  @override
  void initState() {
    super.initState();
    _ctrl.addListener(_showErrors);
    _ctrl.start();
  }

  @override
  void dispose() {
    _ctrl.removeListener(_showErrors);
    _ctrl.dispose();
    _input.dispose();
    super.dispose();
  }

  void _showErrors() {
    final error = _ctrl.lastError;
    if (error == null || !mounted) return;
    _ctrl.lastError = null;
    showErrorSnackBar(context, error);
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

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).chats;
    final top = MediaQuery.viewPaddingOf(context).top;
    final bottom = MediaQuery.viewPaddingOf(context).bottom;

    return ListenableBuilder(
      listenable: _ctrl,
      builder: (context, _) {
        final thread = _ctrl.thread;
        final online = thread.isOnline;
        // Bana gelen istek: ilk mesaj Approve / Block / Reject ile gösterilir.
        final firstIncoming = thread.isStrangerRequest
            ? _ctrl.messages.where((m) => !m.isMine).firstOrNull
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
                        displayName: thread.title,
                        username: thread.peerUsername,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              thread.title,
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
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: online
                                        ? const Color(0xFF33C658)
                                        : AppColors.navInactive,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                AppText(
                                  _ctrl.peerTyping
                                      ? t.typing
                                      : (online ? t.online : t.offline),
                                  style: const TextStyle(
                                    fontFamily: AppFonts.poppins,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    height: 16 / 14,
                                    letterSpacing: 14 * -0.02,
                                    color: Color(0xA6000000),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 1,
                color: AppColors.black.withValues(alpha: 0.10),
              ),
              Expanded(
                child: ChatMessageList(
                  messages: _ctrl.messages,
                  peerLastReadSeq: thread.peerLastReadSeq,
                  seenLabel: t.seen,
                  onRetry: _ctrl.retry,
                  onLoadOlder: _ctrl.loadOlder,
                  skipFirstIncoming: firstIncoming != null,
                  peerAvatarUrl: thread.avatarUrl,
                  leading: [
                    if (thread.contextQuote?.trim().isNotEmpty ?? false)
                      ChatQuoteBubble(text: thread.contextQuote!.trim()),
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
              Padding(
                padding: EdgeInsets.fromLTRB(
                  16,
                  8,
                  16,
                  bottom > 0 ? bottom : 8,
                ),
                child: _DirectMessageInput(
                  hint: t.messageHint,
                  controller: _input,
                  onChanged: (_) => _ctrl.onTyping(),
                  onSend: _send,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DirectMessageInput extends StatelessWidget {
  const _DirectMessageInput({
    required this.hint,
    required this.controller,
    required this.onSend,
    this.onChanged,
  });

  final String hint;
  final TextEditingController controller;
  final VoidCallback onSend;
  final ValueChanged<String>? onChanged;

  static const _fill = Color(0xFFF4F4F9);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _fill,
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              onSubmitted: (_) => onSend(),
              textInputAction: TextInputAction.send,
              style: const TextStyle(
                fontFamily: AppFonts.poppins,
                fontWeight: FontWeight.w400,
                fontSize: 16,
                height: 18 / 16,
                letterSpacing: 16 * -0.02,
                color: AppColors.textOnLight,
              ),
              cursorColor: AppColors.selectionBorder,
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: hint,
                hintStyle: TextStyle(
                  fontFamily: AppFonts.poppins,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  height: 18 / 16,
                  letterSpacing: 16 * -0.02,
                  color: AppColors.textOnLight.withValues(alpha: 0.45),
                ),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onSend,
            child: Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.selectionBorder,
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.send_rounded,
                size: 18,
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
