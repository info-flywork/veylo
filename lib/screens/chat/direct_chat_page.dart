import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/core/widgets/profile_tappable_avatar.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/models/chat/chat_thread.dart';

class _ChatLine {
  const _ChatLine({required this.text, required this.isMine});
  final String text;
  final bool isMine;
}

/// Bireysel (1:1) sohbet — tek avatar + isim, grup UI yok.
class DirectChatPage extends StatelessWidget {
  const DirectChatPage({super.key, required this.thread});

  final ChatThread thread;

  static Future<void> open(BuildContext context, ChatThread thread) {
    return Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (_) => DirectChatPage(thread: thread),
      ),
    );
  }

  List<_ChatLine> _lines(String hint) {
    final preview = thread.lastMessagePreview.trim();
    return [
      if (preview.isNotEmpty) _ChatLine(text: preview, isMine: false),
      _ChatLine(text: hint, isMine: true),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).chats;
    final top = MediaQuery.viewPaddingOf(context).top;
    final bottom = MediaQuery.viewPaddingOf(context).bottom;
    final lines = _lines(t.messageHint);
    final maxBubble = MediaQuery.sizeOf(context).width * 0.78;
    final online = thread.isOnline;

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
                    constraints:
                        const BoxConstraints(minWidth: 44, minHeight: 44),
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
                              online ? t.online : t.offline,
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
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              itemCount: lines.length,
              separatorBuilder: (_, _) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final line = lines[index];
                return Align(
                  alignment: line.isMine
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxBubble),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: line.isMine
                            ? AppColors.selectionBorder
                            : const Color(0x1A998FED),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(line.isMine ? 16 : 0),
                          topRight: Radius.circular(line.isMine ? 0 : 16),
                          bottomRight: const Radius.circular(16),
                          bottomLeft: const Radius.circular(16),
                        ),
                      ),
                      child: AppText(
                        line.text,
                        style: TextStyle(
                          fontFamily: AppFonts.poppins,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          height: 20 / 16,
                          letterSpacing: 16 * -0.02,
                          color: line.isMine
                              ? AppColors.white
                              : AppColors.textOnLight,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, bottom > 0 ? bottom : 8),
            child: _DirectMessageInput(hint: t.messageHint),
          ),
        ],
      ),
    );
  }
}

class _DirectMessageInput extends StatelessWidget {
  const _DirectMessageInput({required this.hint});

  final String hint;

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
          Container(
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
        ],
      ),
    );
  }
}
