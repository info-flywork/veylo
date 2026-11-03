import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/models/chat/chat_thread.dart';
import 'package:veylo/screens/call/call_stranger_page.dart';

/// Sohbet başlığında menünün solundaki sesli / görüntülü arama simgeleri (gruplarda yok).
/// Anonim sohbette profiller açılana kadar görüntülü arama kilitli.
class ChatCallButtons extends StatelessWidget {
  const ChatCallButtons({
    super.key,
    required this.thread,
    this.compact = false,
    this.hideLockedVideo = false,
  });

  final ChatThread thread;

  /// Dar başlık (anonim sohbetteki Connection kutusu): simgeler arası boşluk küçülür.
  final bool compact;

  /// Dar ekranda kilitli (profiller açılmamış) görüntülü arama simgesi hiç gösterilmez.
  final bool hideLockedVideo;

  void _call(BuildContext context, {required bool video}) {
    if (video && thread.isAnonymous) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(Translations.of(context).chats.videoLocked),
            behavior: SnackBarBehavior.floating,
          ),
        );
      return;
    }
    DirectCallPage.start(
      context,
      conversationId: thread.id,
      // Anonim sohbette arama ekranında da maskeli ad, fotoğraf yok.
      name: thread.isAnonymous
          ? (thread.maskedName ?? thread.title)
          : thread.title,
      avatarUrl: thread.isAnonymous ? '' : thread.avatarUrl,
      video: video,
    );
  }

  // Figma: 28×28, #5F5F5F çizgi (renk SVG'nin kendisinde).
  Widget _icon(String asset, {double opacity = 1}) => Opacity(
    opacity: opacity,
    child: SvgPicture.asset(asset, width: 28, height: 28),
  );

  @override
  Widget build(BuildContext context) {
    if (thread.isGroup) return const SizedBox.shrink();
    final t = Translations.of(context).chats;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _HeaderIconTap(
          tooltip: t.voiceCall,
          onTap: () => _call(context, video: false),
          child: _icon(AppAssets.iconChatHeaderVoiceCall),
        ),
        if (!(hideLockedVideo && thread.isAnonymous)) ...[
          // Simgeler arası 8 (IconButton'un 48'lik kutusu boşluğu büyütüyordu).
          const SizedBox(width: 8),
          // Telefonla aynı renk; kilitliyse dokununca nedenini anlatan uyarı çıkar.
          _HeaderIconTap(
            tooltip: t.videoCall,
            onTap: () => _call(context, video: true),
            child: _icon(AppAssets.iconChatHeaderVideoCall),
          ),
        ],
      ],
    );
  }
}

/// Simge boyutunda dokunma alanı (yükseklik 44: parmakla rahat basılır).
class _HeaderIconTap extends StatelessWidget {
  const _HeaderIconTap({
    required this.tooltip,
    required this.onTap,
    required this.child,
  });

  final String tooltip;
  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: SizedBox(height: 44, child: Center(child: child)),
      ),
    );
  }
}
