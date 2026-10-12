import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/errors/error_messages.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/ai_badge.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/core/widgets/profile_tappable_avatar.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/models/chat/chat_message.dart';
import 'package:veylo/models/chat/chat_thread.dart';
import 'package:veylo/screens/chat/conversation_controller.dart';
import 'package:veylo/screens/discover/rooms/group_info_page.dart';
import 'package:veylo/screens/profile/profile_navigation.dart';

class _GroupMessage {
  const _GroupMessage({
    required this.name,
    required this.body,
    required this.avatar,
    this.isMine = false,
    this.userId,
    this.blurred = false,
    this.failed = false,
    this.source,
    this.isAi = false,
  });

  final String name;
  final String body;
  final String avatar;
  final bool isMine;

  /// Anonim üyede null: profil açılmaz.
  final String? userId;
  final bool blurred;
  final bool failed;
  final ChatMessage? source;
  final bool isAi;

  factory _GroupMessage.from(ChatMessage m) => _GroupMessage(
    name: m.senderName ?? '',
    body: m.displayText,
    avatar: (m.senderAvatarUrl?.isNotEmpty ?? false)
        ? m.senderAvatarUrl!
        : AppAssets.strangerAvatar,
    isMine: m.isMine,
    userId: m.senderId,
    blurred: m.senderBlurred,
    failed: m.status == ChatMessageStatus.failed,
    source: m,
    isAi: m.senderIsAi,
  );
}

/// Grup kartına tıklanınca açılan sohbet ekranı (Nighttime Chats).
/// [thread] verilirse gerçek grup sohbeti; verilmezse (AI Match gibi henüz
/// bağlanmamış akışlar) örnek mesajlarla gösterilir.
class GroupChatPage extends StatefulWidget {
  const GroupChatPage({
    super.key,
    required this.title,
    required this.memberCount,
    this.avatars = const [
      AppAssets.fakePerson02,
      AppAssets.fakePerson01,
      AppAssets.fakePerson05,
    ],
    this.thread,
  });

  final String title;
  final int memberCount;
  final List<String> avatars;
  final ChatThread? thread;

  static Future<void> open(
    BuildContext context, {
    required String title,
    required int memberCount,
    List<String>? avatars,
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => GroupChatPage(
          title: title,
          memberCount: memberCount,
          avatars:
              avatars ??
              const [
                AppAssets.fakePerson02,
                AppAssets.fakePerson01,
                AppAssets.fakePerson05,
              ],
        ),
      ),
    );
  }

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

  @override
  void initState() {
    super.initState();
    final thread = widget.thread;
    if (thread != null) {
      _ctrl = ConversationController(thread)..start();
    }
    _input.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _ctrl?.dispose();
    _input.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final ctrl = _ctrl;
    final text = _input.text.trim();
    if (ctrl == null || text.isEmpty) return;
    _input.clear();
    await ctrl.send(text);
    final err = ctrl.lastError;
    if (err != null && mounted) {
      ctrl.lastError = null;
      showErrorSnackBar(context, err);
    }
  }

  Future<void> _openInfo(String title, int memberCount) async {
    final thread = _ctrl?.thread;
    final left = await GroupInfoPage.open(
      context,
      title: title,
      memberCount: memberCount,
      conversationId: thread?.id,
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
    final avatars = thread == null
        ? widget.avatars
        : ((thread.groupAvatarUrls?.isNotEmpty ?? false)
              ? thread.groupAvatarUrls!
              : const [AppAssets.strangerAvatar]);

    final messages = ctrl != null
        ? [for (final m in ctrl.messages) _GroupMessage.from(m)]
        : [
            _GroupMessage(
              name: 'Victoria',
              body: t.sampleVictoria,
              avatar: AppAssets.fakePerson05,
            ),
            _GroupMessage(
              name: 'Sona',
              body: t.sampleSona,
              avatar: AppAssets.fakePerson03,
            ),
            _GroupMessage(
              name: '',
              body: t.sampleOwn,
              avatar: AppAssets.fakePerson01,
              isMine: true,
            ),
          ];

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
                ],
              ),
            ),
          ),
          Container(height: 1, color: AppColors.black.withValues(alpha: 0.10)),
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (n) {
                // Ters liste: üste yaklaşınca eski mesajlar.
                if (n.metrics.extentAfter < 300) ctrl?.loadOlder();
                return false;
              },
              child: ListView.separated(
                reverse: true,
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
                itemCount: messages.length,
                separatorBuilder: (_, _) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final message = messages[messages.length - 1 - index];
                  return _GroupChatBubble(
                    message: message,
                    onRetry: message.failed && message.source != null
                        ? () => ctrl?.retry(message.source!)
                        : null,
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, bottom > 0 ? bottom : 8),
            child: _GroupMessageInput(
              hint: live.messageHint,
              controller: _input,
              onSend: _send,
              onChanged: (_) => ctrl?.onTyping(),
            ),
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
  const _GroupChatBubble({required this.message, this.onRetry});

  final _GroupMessage message;

  /// Gönderilemeyen mesaja dokununca tekrar dener.
  final VoidCallback? onRetry;

  static const _incomingBg = Color(0x1A998FED); // #998FED @ 10%

  @override
  Widget build(BuildContext context) {
    if (message.isMine) {
      return Align(
        alignment: Alignment.centerRight,
        child: GestureDetector(
          onTap: onRetry,
          child: Opacity(
            opacity: message.failed ? 0.5 : 1,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.sizeOf(context).width * 0.75,
              ),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: AppColors.selectionBorder,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(4),
                  ),
                ),
                child: AppText(
                  message.body,
                  style: AppTextStyles.groupChatOwnBody,
                ),
              ),
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
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: AppText(
                        message.name,
                        style: AppTextStyles.groupChatSender,
                      ),
                    ),
                    if (message.isAi) const AiBadge(compact: true),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: _incomingBg,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                ),
                child: AppText(
                  message.body,
                  style: AppTextStyles.groupChatBody,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _GroupMessageInput extends StatelessWidget {
  const _GroupMessageInput({
    required this.hint,
    required this.controller,
    required this.onSend,
    this.onChanged,
  });

  final String hint;
  final TextEditingController controller;
  final VoidCallback onSend;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.fromLTRB(6, 6, 10, 6),
      decoration: BoxDecoration(
        color: AppColors.sheetMuted,
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.selectionBorder,
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              AppAssets.cameraIcon,
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                AppColors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              onSubmitted: (_) => onSend(),
              textInputAction: TextInputAction.send,
              style: AppTextStyles.liveRoomMessageHint,
              cursorColor: AppColors.selectionBorder,
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: hint,
                hintStyle: AppTextStyles.liveRoomMessageHint,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          const SizedBox(width: 6),
          SvgPicture.asset(AppAssets.iconSticker, width: 28, height: 28),
          const SizedBox(width: 8),
          SvgPicture.asset(AppAssets.imageIcon, width: 28, height: 28),
          const SizedBox(width: 8),
          // Yazı varken mikrofon yerine gönder (direkt sohbetteki düğmeyle aynı).
          if (controller.text.trim().isEmpty)
            SvgPicture.asset(AppAssets.iconMicrophone, width: 28, height: 28)
          else
            GestureDetector(
              onTap: onSend,
              child: Container(
                width: 28,
                height: 28,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.selectionBorder,
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.send_rounded,
                  size: 15,
                  color: AppColors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
