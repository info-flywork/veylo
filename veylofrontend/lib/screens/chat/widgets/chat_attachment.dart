import 'dart:io';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';

/// Sohbet balonunun içi: fotoğraf ya da oynatılabilir ses kaydı.
class ChatAttachment extends StatelessWidget {
  const ChatAttachment({
    super.key,
    required this.type,
    required this.url,
    required this.mine,
  });

  final String type;
  final String? url;
  final bool mine;

  @override
  Widget build(BuildContext context) {
    final link = url;
    if (link == null || link.isEmpty) {
      return AppText(
        type == 'VOICE'
            ? Translations.of(context).chats.previewVoice
            : Translations.of(context).chats.previewPhoto,
        style: TextStyle(
          fontFamily: AppFonts.poppins,
          fontSize: 14,
          color: mine ? AppColors.white : AppColors.textOnLight,
        ),
      );
    }
    if (type == 'VOICE') return _VoiceChip(url: link, mine: mine);
    return LayoutBuilder(
      builder: (context, constraints) {
        final max = constraints.maxWidth.isFinite ? constraints.maxWidth : 220.0;
        final side = max.clamp(120.0, 220.0).toDouble();
        return GestureDetector(
          onTap: () => ChatImageViewer.open(context, link),
          child: Hero(
            tag: ChatImageViewer.heroTag(link),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: side,
                height: side,
                child: _ChatImage(url: link, fit: BoxFit.cover),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Ağ ya da yerel (gönderiliyor) fotoğraf; yüklenirken ve hata olduğunda yer tutucu.
class _ChatImage extends StatelessWidget {
  const _ChatImage({required this.url, required this.fit, this.dark = false});

  final String url;
  final BoxFit fit;

  /// Tam ekran (siyah zemin) görünüm.
  final bool dark;

  Widget _placeholder(Widget child) => ColoredBox(
    color: dark ? AppColors.black : const Color(0x1A998FED),
    child: Center(child: child),
  );

  Widget _error(BuildContext context, Object _, StackTrace? _) => _placeholder(
    Icon(
      Icons.broken_image_outlined,
      size: 32,
      color: dark ? AppColors.white : AppColors.selectionBorder,
    ),
  );

  @override
  Widget build(BuildContext context) {
    if (!url.startsWith('http')) {
      return Image.file(File(url), fit: fit, errorBuilder: _error);
    }
    return Image.network(
      url,
      fit: fit,
      errorBuilder: _error,
      loadingBuilder: (context, child, progress) => progress == null
          ? child
          : _placeholder(
              SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: dark ? AppColors.white : AppColors.selectionBorder,
                  value: progress.expectedTotalBytes == null
                      ? null
                      : progress.cumulativeBytesLoaded /
                            progress.expectedTotalBytes!,
                ),
              ),
            ),
    );
  }
}

/// Sohbetteki fotoğrafın tam ekran görünümü: iki parmakla yakınlaştırma, kapatma butonu.
class ChatImageViewer extends StatelessWidget {
  const ChatImageViewer({super.key, required this.url});

  final String url;

  static Object heroTag(String url) => 'chat_image_$url';

  static Future<void> open(BuildContext context, String url) {
    return Navigator.of(context).push<void>(
      PageRouteBuilder<void>(
        opaque: false,
        barrierColor: AppColors.black,
        pageBuilder: (_, _, _) => ChatImageViewer(url: url),
        transitionsBuilder: (_, animation, _, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.viewPaddingOf(context).top;
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: InteractiveViewer(
              minScale: 1,
              maxScale: 4,
              child: Center(
                child: Hero(
                  tag: heroTag(url),
                  child: _ChatImage(url: url, fit: BoxFit.contain, dark: true),
                ),
              ),
            ),
          ),
          Positioned(
            top: top + 4,
            left: 8,
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
              icon: const Icon(
                Icons.close_rounded,
                size: 28,
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _VoiceChip extends StatefulWidget {
  const _VoiceChip({required this.url, required this.mine});

  final String url;
  final bool mine;

  @override
  State<_VoiceChip> createState() => _VoiceChipState();
}

class _VoiceChipState extends State<_VoiceChip> {
  final _player = AudioPlayer();
  bool _playing = false;

  @override
  void initState() {
    super.initState();
    _player.playerStateStream.listen((state) {
      if (!mounted) return;
      final playing = state.playing;
      if (playing != _playing) setState(() => _playing = playing);
      if (state.processingState == ProcessingState.completed) {
        _player.seek(Duration.zero);
        _player.pause();
      }
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Future<void> _toggle() async {
    try {
      if (_playing) {
        await _player.pause();
        return;
      }
      if (_player.processingState == ProcessingState.idle) {
        if (widget.url.startsWith('http')) {
          await _player.setUrl(widget.url);
        } else {
          await _player.setFilePath(widget.url);
        }
      }
      await _player.play();
    } catch (_) {
      if (mounted) setState(() => _playing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.mine ? AppColors.white : AppColors.textOnLight;
    return GestureDetector(
      onTap: _toggle,
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _playing ? Icons.pause_rounded : Icons.play_arrow_rounded,
            color: color,
            size: 28,
          ),
          const SizedBox(width: 6),
          AppText(
            Translations.of(context).chats.previewVoice,
            style: TextStyle(
              fontFamily: AppFonts.poppins,
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
