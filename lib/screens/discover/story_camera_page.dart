import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/screens/discover/story_editor/story_editor_page.dart';

/// Discover (+) → Story / Draft camera.
class StoryCameraPage extends StatefulWidget {
  const StoryCameraPage({super.key});

  @override
  State<StoryCameraPage> createState() => _StoryCameraPageState();
}

class _StoryCameraPageState extends State<StoryCameraPage> {
  final _picker = ImagePicker();

  /// 0 = Draft, 1 = Story
  int _mode = 1;
  bool _flashOff = true;
  bool _useFront = false;
  File? _galleryThumb;

  /// iOS Simulator'da kamera yok; native "Camera not available" diyaloğunu atla.
  bool get _cameraUnavailable {
    if (kIsWeb) return true;
    if (Platform.isIOS) {
      return Platform.environment.containsKey('SIMULATOR_DEVICE_NAME');
    }
    return false;
  }

  Future<void> _openEditor(File file) async {
    if (!mounted) return;
    await Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (_) => StoryEditorPage(file: file),
      ),
    );
  }

  Future<void> _capture() async {
    if (_cameraUnavailable) {
      await _pickGallery();
      return;
    }
    try {
      final file = await _picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice:
            _useFront ? CameraDevice.front : CameraDevice.rear,
        imageQuality: 90,
      );
      if (file == null || !mounted) return;
      await _openEditor(File(file.path));
    } catch (_) {
      // Cihazda kamera yok / izin reddi → galeri ile devam.
      if (!mounted) return;
      await _pickGallery();
    }
  }

  Future<void> _pickGallery() async {
    try {
      final file = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 90,
      );
      if (file == null || !mounted) return;
      setState(() => _galleryThumb = File(file.path));
      await _openEditor(File(file.path));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Galeri açılamadı: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _CameraView(
      mode: _mode,
      flashOff: _flashOff,
      galleryThumb: _galleryThumb,
      onClose: () => Navigator.of(context).pop(),
      onToggleFlash: () => setState(() => _flashOff = !_flashOff),
      onModeChanged: (m) => setState(() => _mode = m),
      onFlip: () => setState(() => _useFront = !_useFront),
      onCapture: _capture,
      onGallery: _pickGallery,
    );
  }
}

class _CameraView extends StatelessWidget {
  const _CameraView({
    required this.mode,
    required this.flashOff,
    required this.galleryThumb,
    required this.onClose,
    required this.onToggleFlash,
    required this.onModeChanged,
    required this.onFlip,
    required this.onCapture,
    required this.onGallery,
  });

  final int mode;
  final bool flashOff;
  final File? galleryThumb;
  final VoidCallback onClose;
  final VoidCallback onToggleFlash;
  final ValueChanged<int> onModeChanged;
  final VoidCallback onFlip;
  final VoidCallback onCapture;
  final VoidCallback onGallery;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).discover.story;
    final top = MediaQuery.paddingOf(context).top;
    final bottom = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      backgroundColor: AppColors.black,
      body: Column(
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                const ColoredBox(color: AppColors.black),
                Positioned(
                  top: top + 8,
                  left: 16,
                  right: 16,
                  child: Row(
                    children: [
                      _CircleIconButton(
                        onTap: onClose,
                        child: const Icon(
                          Icons.close,
                          color: AppColors.white,
                          size: 20,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: onToggleFlash,
                        behavior: HitTestBehavior.opaque,
                        child: SizedBox(
                          width: 32,
                          height: 32,
                          child: Icon(
                            flashOff
                                ? Icons.flash_off_rounded
                                : Icons.flash_on_rounded,
                            color: AppColors.white,
                            size: 26,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 24,
                  child: Center(
                    child: GestureDetector(
                      onTap: onCapture,
                      child: SvgPicture.asset(
                        AppAssets.iconClickCamera,
                        width: 98,
                        height: 98,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 96 + bottom,
            padding: EdgeInsets.fromLTRB(16, 10, 16, 10 + bottom),
            color: const Color(0xFF151515),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: onGallery,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      width: 48,
                      height: 48,
                      child: galleryThumb != null
                          ? Image.file(galleryThumb!, fit: BoxFit.cover)
                          : Image.asset(
                              AppAssets.fakePerson07,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () => onModeChanged(0),
                      child: AppText(
                        t.draft,
                        style: mode == 0
                            ? AppTextStyles.storyModeActive
                            : AppTextStyles.storyModeIdle,
                      ),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () => onModeChanged(1),
                      child: AppText(
                        t.story,
                        style: mode == 1
                            ? AppTextStyles.storyModeActive
                            : AppTextStyles.storyModeIdle,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: onFlip,
                  behavior: HitTestBehavior.opaque,
                  child: SizedBox(
                    width: 48,
                    height: 48,
                    child: Center(
                      child: SvgPicture.asset(
                        AppAssets.iconConvert,
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({
    required this.onTap,
    required this.child,
  });

  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.white, width: 1.5),
        ),
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}
