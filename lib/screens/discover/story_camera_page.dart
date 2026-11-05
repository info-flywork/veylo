import 'dart:io';

import 'package:camera/camera.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/permissions/av_permissions.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/screens/discover/story_drafts_page.dart';
import 'package:veylo/screens/discover/story_editor/story_editor_page.dart';

/// Discover (+) → Story / Draft camera.
class StoryCameraPage extends StatefulWidget {
  const StoryCameraPage({super.key});

  @override
  State<StoryCameraPage> createState() => _StoryCameraPageState();
}

class _StoryCameraPageState extends State<StoryCameraPage>
    with WidgetsBindingObserver {
  final _picker = ImagePicker();

  /// Canlı önizleme: sayfa açılır açılmaz kamera izni sorulur, görüntü siyah kalmaz.
  CameraController? _camera;
  List<CameraDescription> _cameras = const [];
  bool _cameraDenied = false;
  bool _shooting = false;

  /// 0 = Draft, 1 = Story
  int _mode = 1;
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initCamera();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _camera?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Arka plana geçince kamerayı bırak, dönünce (Ayarlar'dan izin verilmiş olabilir) yeniden aç.
    if (state == AppLifecycleState.inactive) {
      final cam = _camera;
      _camera = null;
      cam?.dispose();
      if (mounted) setState(() {});
    } else if (state == AppLifecycleState.resumed && _camera == null) {
      _initCamera();
    }
  }

  Future<void> _initCamera() async {
    if (_cameraUnavailable) return;
    try {
      if (_cameras.isEmpty) _cameras = await availableCameras();
      if (_cameras.isEmpty) return;
      final lens = _useFront
          ? CameraLensDirection.front
          : CameraLensDirection.back;
      final desc = _cameras.firstWhere(
        (c) => c.lensDirection == lens,
        orElse: () => _cameras.first,
      );
      final controller = CameraController(
        desc,
        ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );
      await controller.initialize();
      if (!mounted) {
        await controller.dispose();
        return;
      }
      final old = _camera;
      setState(() {
        _camera = controller;
        _cameraDenied = false;
      });
      await old?.dispose();
    } on CameraException catch (e) {
      if (!mounted) return;
      setState(() => _cameraDenied = e.code.startsWith('CameraAccess'));
    }
  }

  Future<void> _flip() async {
    setState(() => _useFront = !_useFront);
    await _initCamera();
  }

  Future<void> _openEditor(File file) async {
    if (!mounted) return;
    await Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (_) => StoryEditorPage(file: file, saveAsDraft: _mode == 0),
      ),
    );
  }

  Future<void> _capture() async {
    if (_cameraUnavailable) {
      await _pickGallery();
      return;
    }
    final cam = _camera;
    if (cam != null && cam.value.isInitialized) {
      if (_shooting) return;
      _shooting = true;
      try {
        final shot = await cam.takePicture();
        if (mounted) await _openEditor(File(shot.path));
      } catch (_) {
        if (mounted) await _pickGallery();
      } finally {
        _shooting = false;
      }
      return;
    }
    if (_cameraDenied) {
      // İzin reddedilmiş: iOS bir daha sormaz, Ayarlar'a yönlendir.
      await AvPermissions.openSettings();
      return;
    }
    try {
      final file = await _picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: _useFront
            ? CameraDevice.front
            : CameraDevice.rear,
        maxWidth: 2048,
        maxHeight: 2048,
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
        maxWidth: 2048,
        maxHeight: 2048,
        imageQuality: 90,
      );
      if (file == null || !mounted) return;
      setState(() => _galleryThumb = File(file.path));
      await _openEditor(File(file.path));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(Translations.of(context).storyText.galleryError),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cam = _camera;
    return _CameraView(
      preview: cam != null && cam.value.isInitialized
          ? _CameraPreviewFill(controller: cam)
          : null,
      denied: _cameraDenied,
      onOpenSettings: AvPermissions.openSettings,
      mode: _mode,
      galleryThumb: _galleryThumb,
      onClose: () => Navigator.of(context).pop(),
      // TASLAK: Instagram gibi kayıtlı taslakların galerisini açar.
      onModeChanged: (m) =>
          m == 0 ? StoryDraftsPage.open(context) : setState(() => _mode = m),
      onFlip: _flip,
      onCapture: _capture,
      onGallery: _pickGallery,
    );
  }
}

class _CameraView extends StatelessWidget {
  const _CameraView({
    required this.preview,
    required this.denied,
    required this.onOpenSettings,
    required this.mode,
    required this.galleryThumb,
    required this.onClose,
    required this.onModeChanged,
    required this.onFlip,
    required this.onCapture,
    required this.onGallery,
  });

  /// Canlı kamera görüntüsü (yoksa siyah zemin).
  final Widget? preview;
  final bool denied;
  final VoidCallback onOpenSettings;
  final int mode;
  final File? galleryThumb;
  final VoidCallback onClose;
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
      // Önizleme tüm ekranı kaplar (alt bar üstünde durur): editör de fotoğrafı
      // tam ekran gösterdiği için kadraj birebir aynı kalır, çekince zoom olmaz.
      body: Stack(
        fit: StackFit.expand,
        children: [
          ?preview,
          Column(
            children: [
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (denied)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AppText(
                                t.cameraDenied,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontFamily: AppFonts.poppins,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: AppColors.white,
                                ),
                              ),
                              const SizedBox(height: 14),
                              OutlinedButton(
                                onPressed: onOpenSettings,
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppColors.white,
                                  side: const BorderSide(
                                    color: AppColors.white,
                                  ),
                                  shape: const StadiumBorder(),
                                ),
                                child: Text(
                                  Translations.of(context).chats.openSettings,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
                          // Flaş: çekim sistem kamerasında yapılır, flaş orada seçilir.
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
                              : ColoredBox(
                                  color: AppColors.white.withValues(
                                    alpha: 0.12,
                                  ),
                                  child: const Icon(
                                    Icons.photo_library_outlined,
                                    color: AppColors.white,
                                    size: 24,
                                  ),
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
        ],
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({required this.onTap, required this.child});

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

/// Önizlemeyi ekranı kaplayacak şekilde (kırparak) gösterir.
class _CameraPreviewFill extends StatelessWidget {
  const _CameraPreviewFill({required this.controller});

  final CameraController controller;

  @override
  Widget build(BuildContext context) {
    final size = controller.value.previewSize;
    if (size == null) return CameraPreview(controller);
    // previewSize yatay verilir; dikey ekranda en/boy yer değiştirir.
    return ClipRect(
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: size.height,
          height: size.width,
          child: CameraPreview(controller),
        ),
      ),
    );
  }
}
