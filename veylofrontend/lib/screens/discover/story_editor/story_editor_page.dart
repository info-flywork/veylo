import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:veylo/screens/discover/story_editor/story_sticker_sheet.dart';
import 'package:veylo/screens/discover/story_editor/story_text_tools_sheet.dart';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;

/// Capture sonrası Stories tarzı müdahale ekranı.
class StoryEditorPage extends StatefulWidget {
  const StoryEditorPage({
    super.key,
    required this.file,
    this.saveAsDraft = false,
  });

  final File file;

  /// Kamerada TASLAK seçiliyse ana buton gönderiyi taslak olarak kaydeder.
  final bool saveAsDraft;

  @override
  State<StoryEditorPage> createState() => _StoryEditorPageState();
}

class _StoryEditorPageState extends State<StoryEditorPage> {
  final _audio = AudioPlayer();
  StreamSubscription<Duration>? _musicPosSub;

  StoryTextDraft _textDraft = const StoryTextDraft();
  bool _toolsExpanded = true;
  bool _textEditorOpen = false;
  /// Yazının ekran ortasına göre konumu, ölçeği ve açısı (iki parmakla büyüt/döndür).
  Offset _textOffset = const Offset(0, -80);
  double _textScale = 1;
  double _textRotation = 0;
  double _gestureStartScale = 1;
  double _gestureStartRotation = 0;
  /// Hareket yazının üstünde (ya da iki parmakla) başladıysa yazıyı taşır.
  bool _movingText = false;
  final _textKey = GlobalKey();
  StoryMusicTrack? _music;

  /// Görsele eklenen çıkartmalar (asset + ekran konumu, merkez).
  final _stickers = <({String asset, Offset center})>[];
  static const _stickerSize = 96.0;

  bool get _hasOverlay => _textDraft.hasContent || _stickers.isNotEmpty;

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

  /// Görsel ve üzerindeki yazıyı ekran çözünürlüğünde tek JPEG'e çevirir.
  /// PNG fotoğrafta 10 MB yükleme sınırını aşıyordu (FILE_TOO_LARGE).
  Future<File> _renderCanvas() async {
    final ratio = MediaQuery.devicePixelRatioOf(context).clamp(1.0, 3.0);
    setState(() => _capturing = true);
    await WidgetsBinding.instance.endOfFrame;
    try {
      final boundary =
          _canvasKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: ratio);
      final rgba = await image.toByteData(format: ImageByteFormat.rawRgba);
      final jpeg = await compute(_encodeJpeg, (
        bytes: rgba!.buffer.asUint8List(),
        width: image.width,
        height: image.height,
      ));
      image.dispose();
      final dir = await Directory.systemTemp.createTemp('veylo_post');
      final file = File('${dir.path}/post.jpg');
      await file.writeAsBytes(jpeg);
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
      final file = _hasOverlay ? await _renderCanvas() : widget.file;
      final music = _music;
      final post = await PostRepository.instance.create(
        imagePath: file.path,
        draft: draft,
        music: music == null
            ? null
            : {
                'title': music.title,
                if (music.artist.isNotEmpty) 'artist': music.artist,
                if (music.imageUrl != null && music.imageUrl!.isNotEmpty)
                  'coverUrl': music.imageUrl,
                if (music.audioUrl != null && music.audioUrl!.isNotEmpty)
                  'audioUrl': music.audioUrl,
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

  Future<void> _openStickers() async {
    final asset = await showStoryStickerSheet(context);
    if (asset == null || !mounted) return;
    final size = MediaQuery.sizeOf(context);
    setState(() {
      _stickers.add((
        asset: asset,
        center: Offset(size.width / 2, size.height / 2),
      ));
    });
  }

  Future<void> _openMusic() async {
    // Sheet kendi player'ını açmadan önce editör önizlemesini durdur.
    try {
      await _audio.pause();
    } catch (_) {}
    if (!mounted) return;
    final before = _music;
    // Sheet seçimde kapanmaz; her Kaydet'te müzik güncellenir.
    await showStoryMusicSheet(
      context,
      initial: before,
      onSelected: (track) {
        if (mounted) setState(() => _music = track);
      },
    );
    final track = _music;
    if (track == null || !mounted) return;
    if (identical(track, before)) {
      // Değişmedi: durdurduğumuz önizlemeye devam et.
      unawaited(_audio.play());
      return;
    }
    final url = track.audioUrl;
    if (url == null || url.isEmpty) return;
    try {
      await _audio.setUrl(url);
      final total = track.durationSec;
      final startSec = track.clipStartSec.clamp(0, total);
      final endSec = track.clipEndSec > startSec ? track.clipEndSec : total;
      await _musicPosSub?.cancel();
      await _audio.setLoopMode(LoopMode.off);
      await _audio.seek(Duration(seconds: startSec));
      _musicPosSub = _audio.positionStream.listen((pos) {
        if (!mounted || endSec <= 0) return;
        if (pos.inSeconds >= endSec) {
          unawaited(_audio.seek(Duration(seconds: startSec)));
        }
      });
      unawaited(_audio.play());
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
      // Yazı/çıkartma katmanıyla birlikte, ekranda görünen hali kaydedilir.
      final file = _hasOverlay ? await _renderCanvas() : widget.file;
      await Gal.putImage(file.path);
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
    final draft = widget.saveAsDraft;
    final messenger = ScaffoldMessenger.of(context);
    final savedText = Translations.of(context).discover.story.savedToDraft;
    await _audio.pause();
    final ok = await _publish(draft: draft);
    if (!ok || !mounted) return;
    Navigator.of(context)
      ..pop() // editor
      ..pop(); // camera
    if (draft) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(savedText),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  /// Yazı katmanı: editörde ve görsele işlenirken aynı konum/ölçek/açı.
  /// Hareketleri ekran boyu [_textGestures] yakalar; burası sadece çizer.
  Widget _textLayer(String text, Color color, {bool editing = false}) {
    Widget label = Text(
      text,
      textAlign: _textDraft.align,
      style: _textDraft.textStyle.copyWith(color: color),
    );
    if (editing) label = KeyedSubtree(key: _textKey, child: label);
    return IgnorePointer(
      child: Center(
        child: Transform.translate(
          offset: _textOffset,
          child: Transform.rotate(
            angle: _textRotation,
            child: Transform.scale(
              scale: _textScale,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: label,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Parmak yazının üstünde mi (döndürülmüş/büyütülmüş hâliyle, biraz pay bırakarak).
  bool _hitsText(Offset global) {
    final box = _textKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return false;
    final local = box.globalToLocal(global);
    return (Offset.zero & box.size).inflate(32 / _textScale).contains(local);
  }

  /// Ekran boyu: tek parmak yazıyı tutunca taşır; iki parmak ekranın her
  /// yerinde büyütür/küçültür/döndürür. Dokunuş ekran koordinatında ölçülür,
  /// böylece döndürülmüş yazı yukarı çekilince yana kaymaz.
  Widget _textGestures() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapUp: (d) {
        if (_hitsText(d.globalPosition)) _openTextTools();
      },
      onScaleStart: (d) {
        _gestureStartScale = _textScale;
        _gestureStartRotation = _textRotation;
        _movingText = d.pointerCount > 1 || _hitsText(d.focalPoint);
      },
      onScaleUpdate: (d) {
        if (!_movingText) return;
        setState(() {
          _textOffset += d.focalPointDelta;
          if (d.pointerCount > 1) {
            _textScale = (_gestureStartScale * d.scale).clamp(0.4, 5.0);
            _textRotation = _gestureStartRotation + d.rotation;
          }
        });
      },
      onScaleEnd: (_) => _movingText = false,
    );
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
                // Yazı hareketleri: görselin üstünde, çıkartmaların altında
                // (çıkartmaya dokununca o taşınır). Çizim yapmaz, görsele girmez.
                if (!_textEditorOpen && !_capturing && hasText)
                  Positioned.fill(child: _textGestures()),
                // Çıkartmalar: sürükle taşı, basılı tut kaldır.
                for (var i = 0; i < _stickers.length; i++)
                  Positioned(
                    left: _stickers[i].center.dx - _stickerSize / 2,
                    top: _stickers[i].center.dy - _stickerSize / 2,
                    width: _stickerSize,
                    height: _stickerSize,
                    child: GestureDetector(
                      onPanUpdate: (d) => setState(() {
                        final s = _stickers[i];
                        _stickers[i] = (
                          asset: s.asset,
                          center: s.center + d.delta,
                        );
                      }),
                      onLongPress: () => setState(() => _stickers.removeAt(i)),
                      child: Image.asset(
                        _stickers[i].asset,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                // Paylaşırken görsele işlenen yazı (editörde aşağıdaki katman görünür).
                if (_capturing && hasText)
                  Positioned.fill(child: _textLayer(displayText, _textDraft.color)),
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
                                onTap: _openStickers,
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
          if (!_textEditorOpen && !_capturing && !hasText)
            Positioned(
              left: 24,
              right: 56,
              top: size.height * 0.28,
              child: GestureDetector(
                onTap: () => _openTextTools(),
                child: Text(
                  t.textPlaceholder,
                  textAlign: _textDraft.align,
                  style: _textDraft.textStyle.copyWith(
                    color: AppColors.white.withValues(alpha: 0.55),
                  ),
                ),
              ),
            ),
          // Yazı: tek parmakla taşı, iki parmakla büyüt/küçült ve döndür, dokun düzenle.
          if (!_textEditorOpen && !_capturing && hasText)
            Positioned.fill(
              child: _textLayer(
                displayText,
                _textDraft.color,
                editing: true,
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
                                          widget.saveAsDraft
                                              ? t.saveToDraft
                                              : t.share,
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
                      ? Image(
                          image: CachedNetworkImageProvider(track.imageUrl!),
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

/// Arka planda (isolate) RGBA → JPEG.
Uint8List _encodeJpeg(({Uint8List bytes, int width, int height}) raw) {
  final frame = img.Image.fromBytes(
    width: raw.width,
    height: raw.height,
    bytes: raw.bytes.buffer,
    numChannels: 4,
  );
  return img.encodeJpg(frame, quality: 88);
}
