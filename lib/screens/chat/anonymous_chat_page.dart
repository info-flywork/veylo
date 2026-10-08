import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/core/widgets/profile_tappable_avatar.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/models/chat/chat_thread.dart';
import 'package:veylo/screens/chat/connection_progress_sheet.dart';
import 'package:veylo/screens/chat/reveal_profile_sheet.dart';

class _ChatLine {
  const _ChatLine({required this.text, required this.isMine});
  final String text;
  final bool isMine;
}

/// Anonim kullanıcı ile birebir sohbet — Connection header + progress sheet.
class AnonymousChatPage extends StatefulWidget {
  const AnonymousChatPage({
    super.key,
    required this.thread,
    this.vibeQuote,
    this.initialOutgoingMessage,
  });

  final ChatThread thread;
  /// Vibe cevabı akışında karşı tarafın vibe metni (sol balon).
  final String? vibeQuote;
  /// Kullanıcının vibe cevabı (sağ balon).
  final String? initialOutgoingMessage;

  static Future<void> open(
    BuildContext context,
    ChatThread thread, {
    String? vibeQuote,
    String? initialOutgoingMessage,
  }) {
    return Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (_) => AnonymousChatPage(
          thread: thread,
          vibeQuote: vibeQuote,
          initialOutgoingMessage: initialOutgoingMessage,
        ),
      ),
    );
  }

  @override
  State<AnonymousChatPage> createState() => _AnonymousChatPageState();
}

class _AnonymousChatPageState extends State<AnonymousChatPage> {
  late bool _showStrangerActions = widget.thread.isStrangerRequest;

  List<_ChatLine> _lines(String sample) {
    final quote = widget.vibeQuote?.trim();
    final outgoing = widget.initialOutgoingMessage?.trim();
    if ((quote != null && quote.isNotEmpty) ||
        (outgoing != null && outgoing.isNotEmpty)) {
      return [
        if (quote != null && quote.isNotEmpty)
          _ChatLine(text: '“$quote”', isMine: false),
        if (outgoing != null && outgoing.isNotEmpty)
          _ChatLine(text: outgoing, isMine: true),
      ];
    }
    return [_ChatLine(text: sample, isMine: false)];
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).chats;
    final top = MediaQuery.viewPaddingOf(context).top;
    final bottom = MediaQuery.viewPaddingOf(context).bottom;
    final thread = widget.thread;
    final progress = thread.connectionProgress.clamp(0, 100);
    final masked = thread.maskedName ?? '**********';
    // Liste önizlemesi ile balon metni tutarlı kalsın.
    final preview = thread.lastMessagePreview.trim();
    final sample = thread.isStrangerRequest
        ? (preview.isNotEmpty ? preview : t.strangerSampleMessage)
        : (preview.isNotEmpty ? preview : t.sampleAnonymousMessage);
    final lines = _lines(sample);
    final maxBubble = MediaQuery.sizeOf(context).width * 0.78;

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
                    displayName: masked,
                    username: thread.peerUsername,
                    enabled: false,
                    blurred: true,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
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
                            AppText(
                              thread.isOnline ? t.online : t.offline,
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
                  const SizedBox(width: 8),
                  _ConnectionPill(
                    label: t.connection,
                    percentLabel: t.connectionPercent(n: progress),
                    progress: progress / 100,
                    onTap: () {
                      final name = thread.peerUsername ?? thread.title;
                      if (progress >= 100) {
                        showRevealProfileSheet(
                          context,
                          peerUsername: name,
                        );
                      } else {
                        showConnectionProgressSheet(
                          context,
                          progress: progress,
                        );
                      }
                    },
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
                // Stranger isteği: avatar + balon kalsın; Approve sadece butonları kapatır.
                if (thread.isStrangerRequest && index == 0 && !line.isMine) {
                  return _StrangerMessageBlock(
                    text: line.text,
                    avatarUrl: thread.avatarUrl,
                    approveLabel: t.approve,
                    blockLabel: t.blockUser,
                    rejectLabel: t.reject,
                    showActions: _showStrangerActions,
                    onAction: () =>
                        setState(() => _showStrangerActions = false),
                  );
                }

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
            child: _AnonymousMessageInput(hint: t.messageHint),
          ),
        ],
      ),
    );
  }
}

/// Takip edilmeyen gönderenden gelen mesaj + Approve / Block / Reject.
class _StrangerMessageBlock extends StatelessWidget {
  const _StrangerMessageBlock({
    required this.text,
    required this.avatarUrl,
    required this.approveLabel,
    required this.blockLabel,
    required this.rejectLabel,
    required this.showActions,
    required this.onAction,
  });

  final String text;
  final String avatarUrl;
  final String approveLabel;
  final String blockLabel;
  final String rejectLabel;
  final bool showActions;
  final VoidCallback onAction;

  static const _bubble = Color(0x1A998FED);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipOval(
              child: Image.asset(
                avatarUrl,
                width: 36,
                height: 36,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => ColoredBox(
                  color: AppColors.sheetMuted,
                  child: Image.asset(
                    AppAssets.strangerAvatar,
                    width: 36,
                    height: 36,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: _bubble,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                ),
                child: AppText(
                  text,
                  style: const TextStyle(
                    fontFamily: AppFonts.poppins,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    height: 20 / 16,
                    letterSpacing: 16 * -0.02,
                    color: AppColors.textOnLight,
                  ),
                ),
              ),
            ),
          ],
        ),
        if (showActions) ...[
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _StrangerActionButton(
                  label: approveLabel,
                  foreground: AppColors.strangerApprove,
                  onTap: onAction,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _StrangerActionButton(
                  label: blockLabel,
                  foreground: AppColors.strangerBlock,
                  onTap: onAction,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _StrangerActionButton(
                  label: rejectLabel,
                  foreground: AppColors.strangerReject,
                  onTap: onAction,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class _StrangerActionButton extends StatelessWidget {
  const _StrangerActionButton({
    required this.label,
    required this.foreground,
    required this.onTap,
  });

  final String label;
  final Color foreground;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: foreground.withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          height: 44,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: AppText(
                  label,
                  style: TextStyle(
                    fontFamily: AppFonts.poppins,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    height: 24 / 16,
                    letterSpacing: 16 * -0.02,
                    color: foreground,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ),
              ),
            ),
          ),
        ),
      ),
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
          width: 180,
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

class _AnonymousMessageInput extends StatelessWidget {
  const _AnonymousMessageInput({required this.hint});

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
