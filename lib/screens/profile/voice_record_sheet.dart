import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:veylo/core/permissions/mic_permission.dart';
import 'package:just_audio/just_audio.dart';
import 'package:record/record.dart';
import 'package:veylo/core/errors/error_messages.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_primary_button.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/data/remote/session_store.dart';
import 'package:veylo/data/remote/user_repository.dart';

/// Add Voice: kaydet, dinle, isterse profilde paylaş.
Future<void> showVoiceRecordSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => const _VoiceRecordSheet(),
  );
}

class _VoiceRecordSheet extends StatefulWidget {
  const _VoiceRecordSheet();

  @override
  State<_VoiceRecordSheet> createState() => _VoiceRecordSheetState();
}

class _VoiceRecordSheetState extends State<_VoiceRecordSheet> {
  static const _maxSeconds = 30;

  final _recorder = AudioRecorder();
  final _player = AudioPlayer();
  StreamSubscription<PlayerState>? _playSub;
  Timer? _ticker;
  String? _filePath;
  bool _recording = false;
  bool _playing = false;
  bool _busy = false;
  int _seconds = 0;

  String? get _sharedUrl {
    final url = SessionStore.instance.me?.voiceIntroUrl;
    if (url == null || url.isEmpty) return null;
    return url;
  }

  @override
  void initState() {
    super.initState();
    _playSub = _player.playerStateStream.listen((state) {
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
    _ticker?.cancel();
    _playSub?.cancel();
    _recorder.dispose();
    _player.dispose();
    super.dispose();
  }

  Future<void> _toggleRecord() async {
    if (_busy) return;
    if (_recording) {
      await _stop();
      return;
    }
    // İzin yoksa sistem penceresini açar; reddedilmişse Ayarlar'a yönlendiren uyarı gösterir.
    if (!await ensureMicPermission(context)) return;
    if (!mounted) return;
    await _player.stop();
    final path =
        '${Directory.systemTemp.path}/veylo-voice-${DateTime.now().millisecondsSinceEpoch}.m4a';
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
      if (_seconds >= _maxSeconds) _stop();
    });
    setState(() {
      _recording = true;
      _filePath = null;
    });
  }

  Future<void> _stop() async {
    _ticker?.cancel();
    final path = await _recorder.stop();
    if (!mounted) return;
    setState(() {
      _recording = false;
      _filePath = path;
      _seconds = 0;
    });
  }

  Future<void> _togglePlay() async {
    final local = _filePath;
    final remote = _sharedUrl;
    final source = local ?? remote;
    if (source == null || _busy) return;
    if (_playing) {
      await _player.pause();
      return;
    }
    try {
      if (local != null) {
        await _player.setFilePath(local);
      } else {
        await _player.setUrl(remote!);
      }
      await _player.play();
    } on PlayerInterruptedException {
      // Yeni yükleme önceki yüklemeyi kestiğinde just_audio bunu fırlatır.
    } catch (e) {
      if (mounted) showErrorSnackBar(context, e);
    }
  }

  Future<void> _reRecord() async {
    if (_busy || _recording) return;
    try {
      await _player.stop();
    } catch (_) {}
    setState(() {
      _filePath = null;
      _playing = false;
      _seconds = 0;
    });
    await _toggleRecord();
  }

  Future<void> _share() async {
    final path = _filePath;
    if (path == null || _busy) return;
    setState(() => _busy = true);
    try {
      await UserRepository.instance.uploadVoiceIntro(path);
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) showErrorSnackBar(context, e);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _remove() async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      await UserRepository.instance.removeVoiceIntro();
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) showErrorSnackBar(context, e);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.paddingOf(context).bottom;
    final t = Translations.of(context).profile;
    final shared = _sharedUrl;
    final hasTake = _filePath != null;
    final status = _recording
        ? t.voiceRecording(seconds: '$_seconds')
        : hasTake
        ? t.voiceReady
        : shared != null
        ? t.voiceShared
        : t.voiceHint(seconds: '$_maxSeconds');

    return Padding(
      padding: EdgeInsets.fromLTRB(20, 16, 20, 16 + bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.progressTrack,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
          const SizedBox(height: 16),
          AppText(t.addVoice, style: AppTextStyles.filtersTitle),
          const SizedBox(height: 8),
          AppText(status, style: AppTextStyles.profileBio),
          const SizedBox(height: 20),
          Center(
            child: GestureDetector(
              onTap: _toggleRecord,
              child: Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // Profil düzenleme sayfalarındaki siyah butonlarla aynı (#1A1714).
                  color: _recording
                      ? const Color(0xFFE24B4B)
                      : AppColors.editSheetButton,
                ),
                child: Icon(
                  _recording ? Icons.stop_rounded : Icons.mic_rounded,
                  color: AppColors.white,
                  size: 32,
                ),
              ),
            ),
          ),
          if (hasTake) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _togglePlay,
                    icon: Icon(
                      _playing ? Icons.pause_rounded : Icons.play_arrow_rounded,
                    ),
                    label: Text(_playing ? t.voicePause : t.voicePlay),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _reRecord,
                    icon: const Icon(Icons.mic_rounded),
                    label: Text(t.voiceReRecord),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            AppPrimaryButton(
              label: _busy ? t.voiceSaving : t.voiceShare,
              onPressed: _busy ? null : _share,
            ),
          ] else if (shared != null) ...[
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: _togglePlay,
              icon: Icon(
                _playing ? Icons.pause_rounded : Icons.play_arrow_rounded,
              ),
              label: Text(_playing ? t.voicePause : t.voicePlay),
            ),
          ],
          if (shared != null && !hasTake) ...[
            const SizedBox(height: 12),
            TextButton(
              onPressed: _busy ? null : _remove,
              child: Text(t.voiceRemove),
            ),
          ],
        ],
      ),
    );
  }
}

/// Profilde, ilgi alanı metninin altında çalınan ses.
class VoiceIntroBar extends StatefulWidget {
  const VoiceIntroBar({super.key, required this.url});

  final String url;

  @override
  State<VoiceIntroBar> createState() => _VoiceIntroBarState();
}

class _VoiceIntroBarState extends State<VoiceIntroBar> {
  final _player = AudioPlayer();
  StreamSubscription<PlayerState>? _playSub;
  bool _playing = false;
  bool _busy = false;
  String? _loadedUrl;

  @override
  void initState() {
    super.initState();
    _playSub = _player.playerStateStream.listen((state) {
      if (!mounted) return;
      if (state.playing != _playing) setState(() => _playing = state.playing);
      if (state.processingState == ProcessingState.completed) {
        _player.seek(Duration.zero);
        _player.pause();
      }
    });
  }

  @override
  void didUpdateWidget(covariant VoiceIntroBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.url != widget.url) _loadedUrl = null;
  }

  @override
  void dispose() {
    _playSub?.cancel();
    _player.dispose();
    super.dispose();
  }

  Future<void> _toggle() async {
    if (_busy) return;
    if (_playing) {
      await _player.pause();
      return;
    }
    setState(() => _busy = true);
    try {
      if (_loadedUrl != widget.url) {
        await _player.setUrl(widget.url);
        _loadedUrl = widget.url;
      } else {
        await _player.seek(Duration.zero);
      }
      await _player.play();
    } on PlayerInterruptedException {
      // Çift tıklama veya yeni setUrl önceki yüklemeyi kestiğinde normal.
    } catch (e) {
      if (mounted) showErrorSnackBar(context, e);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.inputFill,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: _toggle,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              Icon(
                _playing ? Icons.pause_circle_filled : Icons.play_circle_fill,
                color: AppColors.brandPurple,
                size: 28,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: AppText(
                  Translations.of(context).profile.voiceLabel,
                  style: AppTextStyles.profileBio,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
