import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gal/gal.dart';
import 'package:just_audio/just_audio.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/state/discover_highlight.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/errors/error_messages.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/data/remote/discover_store.dart';
import 'package:veylo/data/remote/post_repository.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/screens/discover/story_editor/story_draft_sheet.dart';
import 'package:veylo/screens/discover/story_editor/story_music_sheet.dart';
import 'package:veylo/screens/discover/story_editor/story_text_tools_sheet.dart';

/// Capture sonrası Stories tarzı müdahale ekranı.
class StoryEditorPage extends StatefulWidget {
  const StoryEditorPage({super.key, required this.file});

  final File file;

  @override
  State<StoryEditorPage> createState() => _StoryEditorPageState();
}

class _StoryEditorPageState extends State<StoryEditorPage> {
  final _audio = AudioPlayer();
  StreamSubscription<Duration>? _musicPosSub;

  StoryTextDraft _textDraft = const StoryTextDraft();
  bool _toolsExpanded = true;
  bool _textEditorOpen = false;
  Offset _textOffset = const Offset(0, -80);
  StoryMusicTrack? _music;

  /// Görsel + yazı katmanı: paylaşırken tek görsele çevrilir.
  final _canvasKey = GlobalKey();

  /// Çekim sırasında "buraya yaz" ipucu görsele girmesin.
  bool _capturing = false;
  bool _busy = false;

  @override
  void dispose() {
    _musicPosSub?.cancel();
    _audio.dispose();
    super.dispose();
  }

  Future<void> _onClose() async {
    final result = await showStoryDraftSheet(context);
    if (!mounted) return;
    if (result == true) {
      // Taslak: sunucuya taslak olarak kaydedilir (akışta görünmez).
      final ok = await _publish(draft: true);
      if (ok && mounted) Navigator.of(context).pop();
    } else if (result == false) {
      Navigator.of(context).pop();
    }
  }

  /// Görsel ve üzerindeki yazıyı ekran çözünürlüğünde tek PNG'ye çevirir.
  Future<File> _renderCanvas() async {
    final ratio = MediaQuery.devicePixelRatioOf(context).clamp(1.0, 3.0);
    setState(() => _capturing = true);
    await WidgetsBinding.instance.endOfFrame;
    try {
      final boundary =
          _canvasKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: ratio);
      final bytes = await image.toByteData(format: ImageByteFormat.png);
      final dir = await Directory.systemTemp.createTemp('veylo_post');
      final file = File('${dir.path}/post.png');
      await file.writeAsBytes(bytes!.buffer.asUint8List());
      return file;
    } finally {
      if (mounted) setState(() => _capturing = false);
    }
  }

  /// Gönderiyi oluşturur (yayın ya da taslak). Başarılıysa true.
  Future<bool> _publish({required bool draft}) async {
    if (_busy) return false;
    setState(() => _busy = true);
    final navigator = Navigator.of(context);
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
    try {
      final file = _textDraft.hasContent ? await _renderCanvas() : widget.file;
      final music = _music;
      final post = await PostRepository.instance.create(
        imagePath: file.path,
        draft: draft,
        music: music == null
            ? null
            : {
                'title': music.title,
                if (music.artist.isNotEmpty) 'artist': music.artist,
                'coverUrl': ?music.imageUrl,
                'audioUrl': ?music.audioUrl,
                'clipStartSec': music.clipStartSec,
                'clipEndSec': music.clipEndSec,
              },
      );
      navigator.pop(); // yükleniyor
      if (!draft) {
        DiscoverHighlight.instance.set(file.path, postId: post.id);
        DiscoverStore.instance.refresh();
      }
      return true;
    } catch (e) {
      navigator.pop();
      if (mounted) showErrorSnackBar(context, e);
      return false;
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _openTextTools({
    StoryTextToolMode mode = StoryTextToolMode.keyboard,
  }) async {
    final t = Translations.of(context).discover.story;
    setState(() => _textEditorOpen = true);
    final result = await showStoryTextEditor(
      context,
      initial: _textDraft,
      initialText: _textDraft.text,
      initialMode: mode,
      hintText: t.textPlaceholder,
    );
    if (!mounted) return;
    setState(() => _textEditorOpen = false);
    if (result == null) return;
    setState(() {
      _textDraft = result.style.copyWith(text: result.text);
    });
  }

  Future<void> _openMusic() async {
    final track = await showStoryMusicSheet(context);
    if (track == null || !mounted) return;
    setState(() => _music = track);
    final url = track.audioUrl;
    if (url == null) return;
    try {
      await _audio.setUrl(url);
      final total = track.durationSec;
      final startSec = track.clipStartSec.clamp(0, total);
      final endSec = track.clipEndSec > startSec ? track.clipEndSec : total;
      await _musicPosSub?.cancel();
      await _audio.setLoopMode(LoopMode.off);
      await _audio.seek(Duration(seconds: startSec));
      _musicPosSub = _audio.positionStream.listen((pos) {
        if (!mounted) return;
        if (endSec > 0 && pos.inSeconds >= endSec) {
          _audio.seek(Duration(seconds: startSec));
        }
      });
      _audio.play();
    } catch (_) {}
  }

  Future<void> _clearMusic() async {
    await _musicPosSub?.cancel();
    _musicPosSub = null;
    await _audio.stop();
    setState(() => _music = null);
  }

  Future<void> _download() async {
    final t = Translations.of(context).discover.story;
    try {
      await Gal.putImage(widget.file.path);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(t.downloaded)),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(t.downloadFailed)),
      );
    }
  }

  Future<void> _share() async {
    await _audio.pause();
    final ok = await _publish(draft: false);
    if (!ok || !mounted) return;
    Navigator.of(context)
      ..pop() // editor
      ..pop(); // camera
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).discover.story;
    final top = MediaQuery.paddingOf(context).top;
    final bottom = MediaQuery.paddingOf(context).bottom;
    final size = MediaQuery.sizeOf(context);

    final displayText = _textDraft.displayText;
    final hasText = _textDraft.hasContent;

    return Scaffold(
      backgroundColor: AppColors.black,
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          RepaintBoundary(
            key: _canvasKey,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.file(
                  widget.file,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),
                // Paylaşırken görsele işlenen yazı (editörde aşağıdaki katman görünür).
                if (_capturing && hasText)
                  Positioned(
                    left: 24,
                    right: 56,
                    top: size.height / 2 + _textOffset.dy,
                    child: Text(
                      displayText,
                      textAlign: _textDraft.align,
                      style: _textDraft.textStyle.copyWith(
                        color: _textDraft.color,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Top chrome — Figma/Zovi: close + music pill | settings + tools
          Positioned(
            top: top + 10,
            left: 16,
            right: 16,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: _onClose,
                  behavior: HitTestBehavior.opaque,
                  child: SvgPicture.asset(
                    AppAssets.iconStoryClose,
                    width: 32,
                    height: 32,
                    colorFilter: const ColorFilter.mode(
                      AppColors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                if (_music != null) ...[
                  const SizedBox(width: 10),
                  _MusicChip(
                    track: _music!,
                    onClear: _clearMusic,
                  ),
                ],
                const Spacer(),
                SizedBox(
                  width: 44,
                  child: Column(
                    children: [
                      _ToolIcon(
                        asset: AppAssets.iconStorySetting,
                        onTap: () => setState(
                          () => _toolsExpanded = !_toolsExpanded,
                        ),
                      ),
                      ClipRect(
                        child: TweenAnimationBuilder<double>(
                          tween: Tween<double>(
                            end: _toolsExpanded ? 1 : 0,
                          ),
                          duration: const Duration(milliseconds: 280),
                          curve: Curves.easeOutCubic,
                          builder: (context, value, child) {
                            return Align(
                              alignment: Alignment.topCenter,
                              heightFactor: value,
                              widthFactor: 1,
                              child: Opacity(
                                opacity: value.clamp(0.0, 1.0),
                                child: child,
                              ),
                            );
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 20),
                              _ToolIcon(
                                asset: AppAssets.iconStoryTextAa,
                                onTap: () => _openTextTools(),
                              ),
                              const SizedBox(height: 20),
                              _ToolIcon(
                                asset: AppAssets.iconStorySticker,
                                onTap: () => _openTextTools(
                                  mode: StoryTextToolMode.style,
                                ),
                              ),
                              const SizedBox(height: 20),
                              _ToolIcon(
                                asset: AppAssets.iconStoryMusic,
                                onTap: _openMusic,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Canvas text — overlay açıkken gizle (çift placeholder olmasın)
          if (!_textEditorOpen && !_capturing)
            Positioned(
              left: 24,
              right: 56,
              top: hasText
                  ? size.height / 2 + _textOffset.dy
                  : size.height * 0.28,
              child: GestureDetector(
                onPanUpdate: hasText
                    ? (d) {
                        setState(() {
                          _textOffset += Offset(0, d.delta.dy);
                        });
                      }
                    : null,
                onTap: () => _openTextTools(),
                child: Text(
                  hasText ? displayText : t.textPlaceholder,
                  textAlign: _textDraft.align,
                  style: _textDraft.textStyle.copyWith(
                    color: hasText
                        ? _textDraft.color
                        : AppColors.white.withValues(alpha: 0.55),
                  ),
                ),
              ),
            ),

          // Bottom bar — download + mevcut Share buton yapısı
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + bottom),
                  color: AppColors.black.withValues(alpha: 0.70),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: _download,
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.black.withValues(alpha: 0.50),
                          ),
                          alignment: Alignment.center,
                          child: SvgPicture.asset(
                            AppAssets.iconStoryDownload,
                            width: 24,
                            height: 24,
                            colorFilter: const ColorFilter.mode(
                              AppColors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: SizedBox(
                          height: 52,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(999),
                              gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  AppColors.brandPurpleSoft,
                                  AppColors.brandPurpleDeep,
                                ],
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(3),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: _share,
                                  borderRadius: BorderRadius.circular(999),
                                  child: Ink(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(999),
                                      gradient: const LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          AppColors.brandPurple,
                                          AppColors.brandPurpleLight,
                                        ],
                                      ),
                                      border: Border.all(
                                        width: 0.6,
                                        color: AppColors.white
                                            .withValues(alpha: 0.33),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          AppAssets.iconStorySend,
                                          width: 22,
                                          height: 22,
                                          colorFilter: const ColorFilter.mode(
                                            AppColors.white,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        AppText(
                                          t.share,
                                          style: AppTextStyles.storyShare,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ToolIcon extends StatelessWidget {
  const _ToolIcon({required this.asset, required this.onTap});

  final String asset;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SvgPicture.asset(
        asset,
        width: 32,
        height: 32,
        colorFilter: const ColorFilter.mode(
          AppColors.white,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}

class _MusicChip extends StatelessWidget {
  const _MusicChip({required this.track, required this.onClear});

  final StoryMusicTrack track;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          height: 36,
          constraints: const BoxConstraints(maxWidth: 200),
          padding: const EdgeInsets.fromLTRB(4, 4, 6, 4),
          decoration: BoxDecoration(
            color: AppColors.white.withValues(alpha: 0.20),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipOval(
                child: SizedBox(
                  width: 28,
                  height: 28,
                  child: track.imageUrl != null && track.imageUrl!.isNotEmpty
                      ? Image.network(
                          track.imageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => ColoredBox(
                            color: AppColors.black.withValues(alpha: 0.4),
                            child: const Icon(
                              Icons.music_note,
                              color: AppColors.white,
                              size: 16,
                            ),
                          ),
                        )
                      : ColoredBox(
                          color: AppColors.black.withValues(alpha: 0.4),
                          child: const Icon(
                            Icons.music_note,
                            color: AppColors.white,
                            size: 16,
                          ),
                        ),
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      track.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: AppFonts.poppins,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 16 / 14,
                        letterSpacing: 14 * -0.02,
                        color: AppColors.white,
                      ),
                    ),
                    Text(
                      track.subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: AppFonts.poppins,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        height: 12 / 10,
                        letterSpacing: 10 * -0.02,
                        color: Color(0xFFB3B3B3),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 4),
              GestureDetector(
                onTap: onClear,
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Icon(
                    Icons.close,
                    size: 16,
                    color: AppColors.white.withValues(alpha: 0.9),
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
