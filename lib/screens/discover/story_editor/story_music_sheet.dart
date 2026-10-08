import 'dart:async';
import 'dart:math' as math;
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';

class StoryMusicTrack {
  const StoryMusicTrack({
    required this.title,
    required this.artist,
    required this.durationSec,
    required this.durationLabel,
    this.imageUrl,
    this.audioUrl,
    this.genre,
    this.clipStartSec = 0,
    this.clipEndSec = 0,
  });

  final String title;
  final String artist;
  final int durationSec;
  final String durationLabel;
  final String? imageUrl;
  final String? audioUrl;
  final String? genre;

  /// Seçilen bölümün başlangıcı (sn). 0 = baştan.
  final int clipStartSec;

  /// Seçilen bölümün bitişi (sn). 0 = tüm parça.
  final int clipEndSec;

  String get subtitle {
    if (genre != null && genre!.isNotEmpty) {
      return '$artist | $genre';
    }
    return artist;
  }

  StoryMusicTrack copyWith({int? clipStartSec, int? clipEndSec}) {
    return StoryMusicTrack(
      title: title,
      artist: artist,
      durationSec: durationSec,
      durationLabel: durationLabel,
      imageUrl: imageUrl,
      audioUrl: audioUrl,
      genre: genre,
      clipStartSec: clipStartSec ?? this.clipStartSec,
      clipEndSec: clipEndSec ?? this.clipEndSec,
    );
  }
}

Future<StoryMusicTrack?> showStoryMusicSheet(BuildContext context) {
  return showModalBottomSheet<StoryMusicTrack>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black26,
    builder: (context) => const StoryMusicSheet(),
  );
}

/// Jamendo müzik listesi + Zovi tarzı trim sheet.
class StoryMusicSheet extends StatefulWidget {
  const StoryMusicSheet({super.key});

  @override
  State<StoryMusicSheet> createState() => _StoryMusicSheetState();
}

class _StoryMusicSheetState extends State<StoryMusicSheet> {
  final _dio = Dio();
  List<StoryMusicTrack> _tracks = [];
  bool _loading = true;
  String? _error;
  StoryMusicTrack? _selected;
  final _player = AudioPlayer();

  // Trim durumu — seçimin başlangıç/bitiş oranı (0–1).
  static const _minClipSec = 5;
  double _startNorm = 0;
  double _endNorm = 1;
  StreamSubscription<Duration>? _posSub;
  Timer? _rangeDebounce;
  bool _seeking = false;

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  @override
  void dispose() {
    _rangeDebounce?.cancel();
    _posSub?.cancel();
    _player.dispose();
    super.dispose();
  }

  Future<void> _fetch() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        'https://api.jamendo.com/v3.0/tracks/',
        queryParameters: {
          'client_id': 'f34b0064',
          'format': 'json',
          'limit': 20,
          'tags': 'pop',
        },
      );
      final results = response.data?['results'] as List<dynamic>? ?? [];
      final tracks = results.map((raw) {
        final m = raw as Map<String, dynamic>;
        final sec = (m['duration'] as num?)?.toInt() ?? 0;
        return StoryMusicTrack(
          title: (m['name'] as String?) ?? 'Unknown',
          artist: (m['artist_name'] as String?) ?? 'Unknown',
          durationSec: sec,
          durationLabel: _fmt(sec),
          imageUrl: m['image'] as String?,
          audioUrl: m['audio'] as String?,
          genre: 'House',
        );
      }).toList();
      if (!mounted) return;
      setState(() {
        _tracks = tracks;
        _loading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = Translations.of(context).discover.story.musicError;
      });
    }
  }

  String _fmt(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '$m:${s.toString().padLeft(2, '0')}';
  }

  int get _totalSec => _selected?.durationSec ?? 0;

  Duration get _clipStart =>
      Duration(milliseconds: (_startNorm * _totalSec * 1000).round());

  Duration get _clipEnd =>
      Duration(milliseconds: (_endNorm * _totalSec * 1000).round());

  double get _minNorm {
    if (_totalSec <= 0) return 0.1;
    return (_minClipSec / _totalSec).clamp(0.05, 1.0);
  }

  Future<void> _select(StoryMusicTrack track) async {
    final total = track.durationSec;
    const preferred = 30;
    final clip = math.min(preferred, total);
    final start = total <= 0 ? 0 : ((total - clip) / 2).round();
    setState(() {
      _selected = track;
      _startNorm = total == 0 ? 0 : start / total;
      _endNorm = total == 0 ? 1 : (start + clip) / total;
    });
    await _startPreview(track);
  }

  Future<void> _startPreview(StoryMusicTrack track) async {
    final url = track.audioUrl;
    if (url == null || url.isEmpty) return;
    try {
      await _player.setUrl(url);
      await _player.setLoopMode(LoopMode.off);

      await _posSub?.cancel();
      _posSub = _player.positionStream.listen((pos) async {
        if (_seeking || !mounted) return;
        if (pos < _clipEnd) return;
        _seeking = true;
        try {
          await _player.seek(_clipStart);
          _player.play();
        } finally {
          _seeking = false;
        }
      });

      await _player.seek(_clipStart);
      _player.play();
    } catch (_) {}
  }

  Future<void> _seekToClipStart() async {
    _seeking = true;
    try {
      await _player.seek(_clipStart);
      if (_player.playing != true) _player.play();
    } catch (_) {
    } finally {
      _seeking = false;
    }
  }

  void _onRangeChanged(double start, double end) {
    final previousStart = _startNorm;
    setState(() {
      _startNorm = start.clamp(0.0, 1.0);
      _endNorm = end.clamp(_startNorm + _minNorm, 1.0);
      if (_endNorm - _startNorm < _minNorm) {
        _startNorm = (_endNorm - _minNorm).clamp(0.0, 1.0);
      }
    });

    // Sadece başlangıç değişince başa sar; bitiş sürüklenirken çalmaya devam.
    final startChanged = (_startNorm - previousStart).abs() > 0.0005;
    if (!startChanged) return;
    _rangeDebounce?.cancel();
    _rangeDebounce = Timer(const Duration(milliseconds: 120), () {
      unawaited(_seekToClipStart());
    });
  }

  Future<void> _back() async {
    try {
      await _player.stop();
    } catch (_) {}
    await _posSub?.cancel();
    _posSub = null;
    setState(() => _selected = null);
  }

  Future<void> _save() async {
    final track = _selected;
    if (track == null) return;
    try {
      await _player.stop();
    } catch (_) {}
    Navigator.of(context).pop(
      track.copyWith(
        clipStartSec: _clipStart.inSeconds,
        clipEndSec: _clipEnd.inSeconds,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _selected == null ? _buildListSheet() : _buildTrimSheet();
  }

  Widget _buildListSheet() {
    final maxH = MediaQuery.sizeOf(context).height * 0.72;
    final bottom = MediaQuery.paddingOf(context).bottom;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: maxH,
          color: AppColors.black.withValues(alpha: 0.90),
          padding: EdgeInsets.fromLTRB(16, 10, 16, 16 + bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _handle(),
              const SizedBox(height: 12),
              Expanded(child: _buildList()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _handle() {
    return Center(
      child: Container(
        width: 56,
        height: 5,
        decoration: BoxDecoration(
          color: AppColors.white.withValues(alpha: 0.25),
          borderRadius: BorderRadius.circular(999),
        ),
      ),
    );
  }

  Widget _buildList() {
    final t = Translations.of(context).discover.story;
    if (_loading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.white),
      );
    }
    if (_error != null) {
      return Center(
        child: AppText(
          _error!,
          style: const TextStyle(color: Color(0xFFFF6B6B)),
        ),
      );
    }
    if (_tracks.isEmpty) {
      return Center(
        child: AppText(
          t.musicEmpty,
          style: TextStyle(color: AppColors.white.withValues(alpha: 0.7)),
        ),
      );
    }

    return ListView.separated(
      itemCount: _tracks.length,
      separatorBuilder: (_, _) => const SizedBox(height: 14),
      itemBuilder: (context, index) {
        final track = _tracks[index];
        return GestureDetector(
          onTap: () => _select(track),
          behavior: HitTestBehavior.opaque,
          child: Row(
            children: [
              _cover(track, 56),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      track.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: AppFonts.poppins,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      track.subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: AppFonts.poppins,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: AppColors.white.withValues(alpha: 0.65),
                      ),
                    ),
                    Text(
                      track.durationLabel,
                      style: TextStyle(
                        fontFamily: AppFonts.poppins,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: AppColors.white.withValues(alpha: 0.45),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _cover(StoryMusicTrack track, double size) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: size,
        height: size,
        child: track.imageUrl != null
            ? Image.network(
                track.imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => ColoredBox(
                  color: AppColors.white.withValues(alpha: 0.1),
                  child: const Icon(Icons.music_note, color: AppColors.white),
                ),
              )
            : ColoredBox(
                color: AppColors.white.withValues(alpha: 0.1),
                child: const Icon(Icons.music_note, color: AppColors.white),
              ),
      ),
    );
  }

  Widget _buildTrimSheet() {
    final t = Translations.of(context).discover.story;
    final track = _selected!;
    final bottom = MediaQuery.paddingOf(context).bottom;
    final clipDurSec = (_clipEnd - _clipStart).inSeconds;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: double.infinity,
          color: AppColors.black.withValues(alpha: 0.90),
          padding: EdgeInsets.fromLTRB(16, 10, 16, 16 + bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _handle(),
              const SizedBox(height: 16),
              Row(
                children: [
                  GestureDetector(
                    onTap: _back,
                    behavior: HitTestBehavior.opaque,
                    child: const Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        size: 20,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  _cover(track, 64),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          track.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: AppFonts.poppins,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: AppColors.white,
                          ),
                        ),
                        Text(
                          track.subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: AppFonts.poppins,
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: AppColors.white.withValues(alpha: 0.65),
                          ),
                        ),
                        Text(
                          '${_fmt(clipDurSec)} / ${track.durationLabel}',
                          style: TextStyle(
                            fontFamily: AppFonts.poppins,
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: AppColors.white.withValues(alpha: 0.65),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _MusicWaveformTrim(
                startNorm: _startNorm,
                endNorm: _endNorm,
                minNorm: _minNorm,
                onChanged: _onRangeChanged,
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: _save,
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: double.infinity,
                  height: 52,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: Text(
                    t.save,
                    style: const TextStyle(
                      fontFamily: AppFonts.poppins,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: AppColors.black,
                    ),
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

enum _TrimDragKind { none, move, start, end }

@immutable
final class _MusicWaveformTrim extends StatefulWidget {
  const _MusicWaveformTrim({
    required this.startNorm,
    required this.endNorm,
    required this.minNorm,
    required this.onChanged,
  });

  final double startNorm;
  final double endNorm;
  final double minNorm;
  final void Function(double start, double end) onChanged;

  @override
  State<_MusicWaveformTrim> createState() => _MusicWaveformTrimState();
}

final class _MusicWaveformTrimState extends State<_MusicWaveformTrim> {
  static const _handleHit = 28.0;

  static const _heights = [
    0.35, 0.55, 0.42, 0.78, 0.50, 0.90, 0.62, 0.40, 0.72, 0.48,
    0.85, 0.58, 0.36, 0.70, 0.92, 0.45, 0.66, 0.80, 0.52, 0.38,
    0.74, 0.60, 0.88, 0.44, 0.68, 0.56, 0.82, 0.46, 0.64, 0.76,
    0.50, 0.90, 0.42, 0.70, 0.58, 0.84, 0.48, 0.62, 0.78, 0.40,
    0.72, 0.54, 0.86, 0.46, 0.66, 0.80, 0.52, 0.74, 0.60, 0.88,
  ];

  var _dragKind = _TrimDragKind.none;
  double _dragStartNorm = 0;
  double _dragEndNorm = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final left = widget.startNorm * width;
        final right = widget.endNorm * width;
        final windowWidth = math.max(0.0, right - left);

        return GestureDetector(
          onHorizontalDragStart: (details) {
            final x = details.localPosition.dx;
            _dragStartNorm = widget.startNorm;
            _dragEndNorm = widget.endNorm;
            if ((x - left).abs() <= _handleHit) {
              _dragKind = _TrimDragKind.start;
            } else if ((x - right).abs() <= _handleHit) {
              _dragKind = _TrimDragKind.end;
            } else if (x >= left && x <= right) {
              _dragKind = _TrimDragKind.move;
            } else {
              _dragKind = _TrimDragKind.none;
            }
          },
          onHorizontalDragUpdate: (details) {
            if (_dragKind == _TrimDragKind.none || width <= 0) return;
            final dxNorm = details.delta.dx / width;
            switch (_dragKind) {
              case _TrimDragKind.start:
                final nextStart = (_dragStartNorm + dxNorm).clamp(
                  0.0,
                  _dragEndNorm - widget.minNorm,
                );
                _dragStartNorm = nextStart;
                widget.onChanged(nextStart, _dragEndNorm);
              case _TrimDragKind.end:
                final nextEnd = (_dragEndNorm + dxNorm).clamp(
                  _dragStartNorm + widget.minNorm,
                  1.0,
                );
                _dragEndNorm = nextEnd;
                widget.onChanged(_dragStartNorm, nextEnd);
              case _TrimDragKind.move:
                final span = _dragEndNorm - _dragStartNorm;
                var nextStart = _dragStartNorm + dxNorm;
                var nextEnd = _dragEndNorm + dxNorm;
                if (nextStart < 0) {
                  nextStart = 0;
                  nextEnd = span;
                } else if (nextEnd > 1) {
                  nextEnd = 1;
                  nextStart = 1 - span;
                }
                _dragStartNorm = nextStart;
                _dragEndNorm = nextEnd;
                widget.onChanged(nextStart, nextEnd);
              case _TrimDragKind.none:
                break;
            }
          },
          onHorizontalDragEnd: (_) => _dragKind = _TrimDragKind.none,
          onHorizontalDragCancel: () => _dragKind = _TrimDragKind.none,
          child: SizedBox(
            height: 56,
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Row(
                  children: [
                    for (var i = 0; i < _heights.length; i++)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: Align(
                            alignment: Alignment.center,
                            child: FractionallySizedBox(
                              heightFactor: _heights[i],
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color:
                                      _isInWindow(i, left, windowWidth, width)
                                      ? AppColors.white
                                      : AppColors.white.withValues(alpha: 0.28),
                                  borderRadius: BorderRadius.circular(99),
                                ),
                                child: const SizedBox.expand(),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                Positioned(
                  left: left,
                  width: windowWidth,
                  top: 0,
                  bottom: 0,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.white, width: 2),
                    ),
                    child: Row(
                      children: [
                        _TrimHandle(),
                        const Spacer(),
                        _TrimHandle(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  bool _isInWindow(int index, double left, double windowWidth, double width) {
    final barCenter = (index + 0.5) / _heights.length * width;
    return barCenter >= left && barCenter <= left + windowWidth;
  }
}

@immutable
final class _TrimHandle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 14,
      alignment: Alignment.center,
      child: Container(
        width: 3,
        height: 22,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(999),
        ),
      ),
    );
  }
}
