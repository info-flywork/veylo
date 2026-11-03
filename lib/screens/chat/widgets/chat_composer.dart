import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:veylo/core/permissions/mic_permission.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:record/record.dart';
import 'package:sticker_keyboard/sticker_keyboard.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/errors/error_messages.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/screens/chat/chat_sticker.dart';
import 'package:veylo/screens/chat/chat_sticker_pack.dart';

/// Sohbet kutusu: kamera, galeri ve ses kaydı gönderir.
class ChatComposer extends StatefulWidget {
  const ChatComposer({
    super.key,
    required this.hint,
    required this.controller,
    required this.onSend,
    this.onChanged,
    this.onMedia,
    this.onImages,
    this.onSticker,
  });

  final String hint;
  final TextEditingController controller;
  final VoidCallback onSend;
  final ValueChanged<String>? onChanged;

  /// `image` veya `voice` ve dosya yolu.
  final Future<void> Function(String kind, String path)? onMedia;

  /// Birden fazla galeri fotoğrafı — hepsi birden ekrana düşer.
  final Future<void> Function(List<String> paths)? onImages;

  /// Seçilen çıkartmanın asset yolu.
  final ValueChanged<String>? onSticker;

  @override
  State<ChatComposer> createState() => _ChatComposerState();
}

class _ChatComposerState extends State<ChatComposer> {
  static const _maxImages = 10;

  final _picker = ImagePicker();
  final _recorder = AudioRecorder();
  Timer? _ticker;
  bool _recording = false;
  bool _picking = false;
  bool _stickers = false;
  int _seconds = 0;
  final List<String> _pendingImages = [];

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_redraw);
  }

  @override
  void dispose() {
    _ticker?.cancel();
    widget.controller.removeListener(_redraw);
    _recorder.dispose();
    super.dispose();
  }

  void _redraw() {
    if (mounted) setState(() {});
  }

  Future<void> _pick(ImageSource source) async {
    if ((widget.onMedia == null && widget.onImages == null) ||
        _picking ||
        _recording) {
      return;
    }
    final room = _maxImages - _pendingImages.length;
    if (room <= 0) return;
    setState(() => _picking = true);
    try {
      // Sıkıştırmayı seçicide yapma — 6 foto anında önizlemeye düşsün.
      // Yüklemede sunucu / istemci boyutu yönetir.
      if (source == ImageSource.gallery) {
        final files = await _picker.pickMultiImage(limit: room);
        if (files.isEmpty || !mounted) return;
        setState(() {
          for (final f in files) {
            if (_pendingImages.length >= _maxImages) break;
            if (!_pendingImages.contains(f.path)) _pendingImages.add(f.path);
          }
          _stickers = false;
        });
      } else {
        final file = await _picker.pickImage(source: source);
        if (file == null || !mounted) return;
        setState(() {
          if (_pendingImages.length < _maxImages &&
              !_pendingImages.contains(file.path)) {
            _pendingImages.add(file.path);
          }
          _stickers = false;
        });
      }
    } catch (e) {
      if (mounted) showErrorSnackBar(context, e);
    } finally {
      if (mounted) setState(() => _picking = false);
    }
  }

  void _removePending(int index) {
    if (index < 0 || index >= _pendingImages.length) return;
    setState(() => _pendingImages.removeAt(index));
  }

  Future<void> _submit() async {
    if (_recording || _picking) return;
    final sendMedia = widget.onMedia;
    final sendImages = widget.onImages;
    final images = List<String>.of(_pendingImages);
    final hasText = widget.controller.text.trim().isNotEmpty;
    if (images.isEmpty && !hasText) return;

    // Önizleme ve input hemen temizlensin; buton loading'de kalmasın.
    setState(() => _pendingImages.clear());
    if (hasText) widget.onSend();

    if (images.isEmpty) return;

    // Yükleme arka planda; balonlarda "Gönderiliyor…" görünür.
    Future<void> upload() async {
      if (sendImages != null) {
        await sendImages(images);
      } else {
        for (final path in images) {
          await sendMedia?.call('image', path);
        }
      }
    }

    unawaited(
      upload().catchError((Object e) {
        if (mounted) showErrorSnackBar(context, e);
      }),
    );
  }

  Future<void> _toggleRecord() async {
    final send = widget.onMedia;
    if (send == null || _picking) return;
    if (_recording) {
      await _finishRecord(send);
      return;
    }
    // İzin yoksa sistem penceresini açar; reddedilmişse Ayarlar'a yönlendiren uyarı gösterir.
    if (!await ensureMicPermission(context)) return;
    if (!mounted) return;
    final path =
        '${Directory.systemTemp.path}/veylo-chat-${DateTime.now().millisecondsSinceEpoch}.m4a';
    try {
      await _recorder.start(
        const RecordConfig(encoder: AudioEncoder.aacLc),
        path: path,
      );
    } catch (e) {
      if (mounted) showErrorSnackBar(context, e);
      return;
    }
    _ticker?.cancel();
    _seconds = 0;
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() => _seconds++);
      if (_seconds >= 60) _finishRecord(send);
    });
    setState(() => _recording = true);
  }

  Future<void> _finishRecord(Future<void> Function(String kind, String path) send) async {
    if (!_recording) return;
    _ticker?.cancel();
    final seconds = _seconds;
    setState(() => _recording = false);
    final path = await _recorder.stop();
    if (!mounted) return;
    if (path == null || path.isEmpty || seconds < 1) return;
    try {
      await send('voice', path);
    } catch (e) {
      if (mounted) showErrorSnackBar(context, e);
    }
  }

  Future<void> _cancelRecord() async {
    if (!_recording) return;
    _ticker?.cancel();
    setState(() => _recording = false);
    await _recorder.stop();
  }

  String get _clock {
    final m = (_seconds ~/ 60).toString().padLeft(2, '0');
    final s = (_seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  void _toggleStickers() {
    if (_recording || _picking) return;
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() => _stickers = !_stickers);
  }

  void _sendSticker(Sticker sticker) {
    final asset = ChatSticker.assetOf(ChatSticker.encode(sticker.assetUrl));
    if (asset == null) return;
    setState(() => _stickers = false);
    widget.onSticker?.call(asset);
  }

  IconData _tabIcon(String category) => switch (category) {
    'Recents' => Icons.schedule_rounded,
    'faces' => Icons.sentiment_satisfied_alt_rounded,
    'hearts' => Icons.favorite_rounded,
    'hands' => Icons.back_hand_rounded,
    'animals' => Icons.pets_rounded,
    'food' => Icons.restaurant_rounded,
    _ => Icons.emoji_emotions_rounded,
  };

  @override
  Widget build(BuildContext context) {
    final hasText = widget.controller.text.trim().isNotEmpty;
    final canSend = hasText || _pendingImages.isNotEmpty;
    final t = Translations.of(context).chats;
    final categories = [
      for (final entry in chatStickerPack.entries)
        CategorySticker(
          category: entry.key,
          stickers: [
            for (final asset in entry.value)
              Sticker(assetUrl: asset, category: entry.key),
          ],
        ),
    ];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (_stickers) ...[
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              height: 280,
              child: StickerKeyboard(
                onStickerSelected: _sendSticker,
                keyboardConfig: KeyboardConfig(
                  stickers: categories,
                  stickerColumns: 4,
                  stickerHorizontalSpacing: 8,
                  stickerVerticalSpacing: 8,
                  gridPadding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                  withSafeArea: false,
                  showBottomNav: false,
                  showSearchButton: false,
                  showRecentsTab: true,
                  bgColor: AppColors.sheetMuted,
                  indicatorColor: AppColors.selectionBorder,
                  iconColor: AppColors.textPlaceholder,
                  iconColorSelected: AppColors.selectionBorder,
                  noRecents: Text(
                    t.stickerEmpty,
                    style: AppTextStyles.liveRoomMessageHint,
                    textAlign: TextAlign.center,
                  ),
                  categoryTabBuilder: (context, category, selected) => Icon(
                    _tabIcon(category.category),
                    size: 22,
                    color: selected
                        ? AppColors.selectionBorder
                        : AppColors.textPlaceholder,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
        if (_picking)
          const Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: LinearProgressIndicator(
              minHeight: 2,
              color: AppColors.selectionBorder,
              backgroundColor: Color(0x22998FED),
            ),
          ),
        if (_pendingImages.isNotEmpty) ...[
          _imagePreview(),
          const SizedBox(height: 8),
        ],
        _bar(canSend),
      ],
    );
  }

  Widget _imagePreview() {
    return SizedBox(
      height: 88,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _pendingImages.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final path = _pendingImages[i];
          return Stack(
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  File(path),
                  width: 88,
                  height: 88,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => Container(
                    width: 88,
                    height: 88,
                    color: AppColors.sheetMuted,
                    alignment: Alignment.center,
                    child: const Icon(Icons.broken_image_outlined, size: 28),
                  ),
                ),
              ),
              Positioned(
                top: -4,
                right: -4,
                child: Material(
                  color: AppColors.black.withValues(alpha: 0.65),
                  shape: const CircleBorder(),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () => _removePending(i),
                    child: const SizedBox(
                      width: 24,
                      height: 24,
                      child: Icon(
                        Icons.close_rounded,
                        size: 16,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _bar(bool canSend) {
    return Container(
      height: 56,
      padding: const EdgeInsets.fromLTRB(6, 6, 10, 6),
      decoration: BoxDecoration(
        color: AppColors.sheetMuted,
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Row(
        children: [
          _roundIcon(
            AppAssets.cameraIcon,
            onTap: () => _pick(ImageSource.camera),
            filled: true,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _recording
                ? AppText(
                    _clock,
                    style: AppTextStyles.liveRoomMessageHint.copyWith(
                      color: AppColors.selectionBorder,
                    ),
                  )
                : TextField(
                    controller: widget.controller,
                    onTap: () {
                      if (_stickers) setState(() => _stickers = false);
                    },
                    onChanged: widget.onChanged,
                    onSubmitted: (_) => _submit(),
                    textInputAction: TextInputAction.send,
                    style: AppTextStyles.liveRoomMessageHint.copyWith(
                      color: AppColors.textOnLight,
                    ),
                    cursorColor: AppColors.selectionBorder,
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      hintText: widget.hint,
                      hintStyle: AppTextStyles.liveRoomMessageHint,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
          ),
          if (_recording) ...[
            GestureDetector(
              onTap: _cancelRecord,
              child: const Icon(Icons.close_rounded, size: 26, color: AppColors.textOnLight),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: _toggleRecord,
              child: const Icon(Icons.send_rounded, size: 26, color: AppColors.selectionBorder),
            ),
          ] else ...[
            const SizedBox(width: 6),
            GestureDetector(
              onTap: _toggleStickers,
              behavior: HitTestBehavior.opaque,
              child: SvgPicture.asset(
                AppAssets.iconSticker,
                width: 28,
                height: 28,
                colorFilter: _stickers
                    ? const ColorFilter.mode(AppColors.selectionBorder, BlendMode.srcIn)
                    : null,
              ),
            ),
            const SizedBox(width: 8),
            _roundIcon(AppAssets.imageIcon, onTap: () => _pick(ImageSource.gallery)),
            const SizedBox(width: 8),
            if (!canSend)
              _roundIcon(AppAssets.iconMicrophone, onTap: _toggleRecord)
            else
              GestureDetector(
                onTap: _submit,
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
        ],
      ),
    );
  }

  Widget _roundIcon(String asset, {VoidCallback? onTap, bool filled = false}) {
    final icon = SvgPicture.asset(
      asset,
      width: filled ? 24 : 28,
      height: filled ? 24 : 28,
      colorFilter: filled
          ? const ColorFilter.mode(AppColors.white, BlendMode.srcIn)
          : null,
    );
    final child = filled
        ? Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.selectionBorder,
            ),
            alignment: Alignment.center,
            child: icon,
          )
        : icon;
    return GestureDetector(onTap: onTap, behavior: HitTestBehavior.opaque, child: child);
  }
}
