import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:record/record.dart';
import 'package:veylo/core/errors/error_messages.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_primary_button.dart';
import 'package:veylo/core/widgets/app_text.dart';
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
    final allowed = await _recorder.hasPermission();
    if (!allowed) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Allow the microphone to record.')),
        );
      }
      return;
    }
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
    if (source == null) return;
    if (_playing) {
      await _player.pause();
      return;
    }
    if (local != null) {
      await _player.setFilePath(local);
    } else {
      await _player.setUrl(remote!);
    }
    await _player.play();
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
    final shared = _sharedUrl;
    final hasTake = _filePath != null;
    final status = _recording
        ? 'Recording $_seconds s'
        : hasTake
        ? 'Your voice is ready'
        : shared != null
        ? 'Shared on your profile'
        : 'Record a short intro, up to $_maxSeconds seconds';

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
          const AppText('Add Voice', style: AppTextStyles.filtersTitle),
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
                  color: _recording
                      ? const Color(0xFFE24B4B)
                      : AppColors.brandPurple,
                ),
                child: Icon(
                  _recording ? Icons.stop_rounded : Icons.mic_rounded,
                  color: AppColors.white,
                  size: 32,
                ),
              ),
            ),
          ),
          if (hasTake || (shared != null && !hasTake)) ...[
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: _togglePlay,
              icon: Icon(_playing ? Icons.pause_rounded : Icons.play_arrow_rounded),
              label: Text(_playing ? 'Pause' : 'Play'),
            ),
          ],
          if (hasTake) ...[
            const SizedBox(height: 12),
            AppPrimaryButton(
              label: _busy ? 'Saving…' : 'Share on profile',
              onPressed: _busy ? null : _share,
            ),
          ],
          if (shared != null && !hasTake) ...[
            const SizedBox(height: 12),
            TextButton(
              onPressed: _busy ? null : _remove,
              child: const Text('Remove from profile'),
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
  void dispose() {
    _playSub?.cancel();
    _player.dispose();
    super.dispose();
  }

  Future<void> _toggle() async {
    if (_playing) {
      await _player.pause();
      return;
    }
    await _player.setUrl(widget.url);
    await _player.play();
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
              const Expanded(
                child: AppText('Voice', style: AppTextStyles.profileBio),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
