import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_primary_button.dart';
import 'package:veylo/core/widgets/ai_badge.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/core/errors/error_messages.dart';
import 'package:veylo/data/remote/chat_store.dart';
import 'package:veylo/data/remote/vibe_repository.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/models/vibes/vibe_post.dart';
import 'package:veylo/screens/chat/anonymous_chat_page.dart';
import 'package:veylo/screens/chat/widgets/chat_note_card.dart';
import 'package:veylo/screens/vibes/vibe_share_sheet.dart';

/// Vibe kartı → Mesaj Gönder → Vibe'a Cevap Ver → anonim sohbet.
/// Cevap yazara mesaj isteği olarak gider; onaylarsa sohbet devam eder.
Future<void> showVibeTalkSheet(BuildContext context, VibePost post) async {
  final wantsReply = await showModalBottomSheet<bool>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    useSafeArea: false,
    builder: (sheetContext) => _VibeTalkSheet(
      post: post,
      onSend: () => Navigator.of(sheetContext).pop(true),
      onClose: () => Navigator.of(sheetContext).pop(false),
    ),
  );
  if (wantsReply != true || !context.mounted) return;

  final reply = await showVibeReplySheet(context);
  if (reply == null || reply.trim().isEmpty || !context.mounted) return;

  // Sohbet açılana kadar ekran kilitlenir (çift gönderimi de engeller).
  final navigator = Navigator.of(context);
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (_) => const Center(child: CircularProgressIndicator()),
  );
  try {
    final thread = await VibeRepository.instance.reply(post.id, reply.trim());
    ChatStore.instance.replace(thread);
    navigator.pop();
    if (!context.mounted) return;
    await AnonymousChatPage.open(context, thread);
  } catch (e) {
    navigator.pop();
    if (context.mounted) showErrorSnackBar(context, e);
  }
}

class _VibeTalkSheet extends StatelessWidget {
  const _VibeTalkSheet({
    required this.post,
    required this.onSend,
    required this.onClose,
  });

  final VibePost post;
  final VoidCallback onSend;
  final VoidCallback onClose;

  static const _nameStyle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 24,
    height: 1,
    letterSpacing: -0.48,
    color: Color(0xFF000000),
  );

  static const _subtitleStyle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 30 / 14,
    letterSpacing: -0.28,
    color: Color(0x73000000),
  );

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final bottom = MediaQuery.viewPaddingOf(context).bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 50),
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            padding: const EdgeInsets.fromLTRB(16, 62, 16, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: AppText(
                        post.name,
                        style: _nameStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    if (post.isAi) const AiBadge(),
                  ],
                ),
                const SizedBox(height: 10),
                AppText(
                  '“${post.body}”',
                  style: AppTextStyles.vibesQuote,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                AppText(
                  t.vibes.wantsToTalk,
                  style: _subtitleStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                AppPrimaryButton(label: t.vibes.sendMessage, onPressed: onSend),
              ],
            ),
          ),
          Positioned(
            top: 58,
            right: 16,
            child: _SheetCloseButton(onTap: onClose),
          ),
          Positioned(
            top: 0,
            child: _SheetAvatar(asset: post.avatarAsset, blurred: post.blurred),
          ),
        ],
      ),
    );
  }
}

class _SheetAvatar extends StatelessWidget {
  const _SheetAvatar({required this.asset, required this.blurred});

  final String asset;
  final bool blurred;

  @override
  Widget build(BuildContext context) {
    Widget image = ChatAvatarImage(url: asset, size: 100);
    if (blurred) {
      image = ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Transform.scale(scale: 1.35, child: image),
      );
    }

    return Container(
      width: 100,
      height: 100,
      decoration: const BoxDecoration(
        color: Color(0xFFF6F6FB),
        shape: BoxShape.circle,
      ),
      clipBehavior: Clip.antiAlias,
      child: image,
    );
  }
}

class _SheetCloseButton extends StatelessWidget {
  const _SheetCloseButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SvgPicture.asset(AppAssets.iconClose, width: 26.67, height: 26.67),
    );
  }
}
