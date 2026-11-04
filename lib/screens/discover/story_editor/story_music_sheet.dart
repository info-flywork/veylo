import 'dart:async';
import 'dart:math' as math;
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:cached_network_image/cached_network_image.dart';
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

/// Seçim sheet'i kapatmaz: her Kaydet'te [onSelected] çağrılır, kullanıcı
/// sheet'i kendisi kapatır.
Future<void> showStoryMusicSheet(
  BuildContext context, {
  StoryMusicTrack? initial,
  required ValueChanged<StoryMusicTrack> onSelected,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black26,
    builder: (context) =>
        StoryMusicSheet(initial: initial, onSelected: onSelected),
  );
}

/// Jamendo müzik listesi (arama, tür, sonsuz kaydırma) + Zovi tarzı trim sheet.
class StoryMusicSheet extends StatefulWidget {
  const StoryMusicSheet({super.key, this.initial, required this.onSelected});

  final StoryMusicTrack? initial;
  final ValueChanged<StoryMusicTrack> onSelected;

  @override
  State<StoryMusicSheet> createState() => _StoryMusicSheetState();
}

class _StoryMusicSheetState extends State<StoryMusicSheet> {
  final _dio = Dio();
  List<StoryMusicTrack> _tracks = [];
  bool _loading = true;
  String? _error;
  StoryMusicTrack? _selected;

  /// Kaydedilmiş (editöre gönderilmiş) parça; listede işaretli görünür.
  StoryMusicTrack? _picked;

  // Katalog: arama ya da tür; sayfa sayfa yüklenir.
  static const _pageSize = 30;
  static const _genres = [
    'pop', 'rock', 'electronic', 'hiphop', 'dance', 'jazz', 'acoustic',
    'chillout', 'lounge', 'ambient', 'classical', 'soundtrack', 'rnb',
    'reggae', 'latin', 'folk', 'metal', 'world',
  ];
  String _genre = 'pop';
  String _search = '';
  int _offset = 0;
  bool _hasMore = true;
  bool _loadingMore = false;
  int _gen = 0;
  Timer? _searchDebounce;
  final _searchCtl = TextEditingController();
  ScrollController _scroll = ScrollController();
  AudioPlayer? _player;

  // Trim durumu — seçimin başlangıç/bitiş oranı (0–1).
  static const _minClipSec = 5;
  double _startNorm = 0;
  double _endNorm = 1;
  StreamSubscription<Duration>? _posSub;
  Timer? _rangeDebounce;
  bool _seeking = false;

  AudioPlayer get _audio {
    return _player ??= AudioPlayer();
  }

  @override
  void initState() {
    super.initState();
    _picked = widget.initial;
    // Translations.of(context) initState sırasında InheritedWidget'a bağlanamaz;
    // ilk frame'den sonra Jamendo listesini çek.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) unawaited(_reload());
    });
  }

  @override
  void dispose() {
    _rangeDebounce?.cancel();
    _searchDebounce?.cancel();
    _searchCtl.dispose();
    _scroll.dispose();
    _posSub?.cancel();
    _player?.dispose();
    super.dispose();
  }

  /// Arama varsa ada/sanatçıya göre, yoksa seçili türün en popülerleri.
  Map<String, Object> get _params => _search.isNotEmpty
      ? {'search': _search, 'include': 'musicinfo'}
      : {
          'fuzzytags': _genre,
          'order': 'popularity_total',
          'include': 'musicinfo',
        };

  /// Jamendo (paylaşılan istemci) aynı isteğe bazen boş liste dönüyor;
  /// boş gelirse birkaç kez tekrar dener.
  Future<List<StoryMusicTrack>> _fetchPage(int offset) async {
    Object? lastError;
    for (var attempt = 0; attempt < 4; attempt++) {
      if (attempt > 0) {
        await Future<void>.delayed(Duration(milliseconds: 300 * attempt));
      }
      try {
        final results = await _query({..._params, 'offset': offset});
        final tracks = results.map(_track)
            .where((track) => (track.audioUrl ?? '').isNotEmpty)
            .toList();
        if (tracks.isNotEmpty) return tracks;
        lastError = null;
      } catch (e) {
        lastError = e;
      }
    }
    if (lastError != null) throw lastError;
    return const [];
  }

  StoryMusicTrack _track(dynamic raw) {
    // Context'siz global çeviri — init/async güvenli.
    final unknown = t.discover.story.unknownTrack;
    final m = Map<String, dynamic>.from(raw as Map);
    final sec = (m['duration'] as num?)?.toInt() ?? 0;
    final genres =
        ((m['musicinfo'] as Map?)?['tags'] as Map?)?['genres'] as List?;
    String genre = _capitalize(_genre);
    if (genres != null && genres.isNotEmpty) {
      final first = genres.first;
      if (first is String && first.isNotEmpty) {
        genre = _capitalize(first);
      }
    }
    return StoryMusicTrack(
      title: (m['name'] as String?) ?? unknown,
      artist: (m['artist_name'] as String?) ?? unknown,
      durationSec: sec,
      durationLabel: _fmt(sec),
      imageUrl: m['image'] as String?,
      audioUrl: m['audio'] as String?,
      genre: genre,
    );
  }

  /// İlk sayfa (arama/tür değişince).
  Future<void> _reload() async {
    final gen = ++_gen;
    setState(() {
      _loading = true;
      _error = null;
      _tracks = [];
      _offset = 0;
      _hasMore = true;
    });
    if (_scroll.hasClients) _scroll.jumpTo(0);
    try {
      final tracks = await _fetchPage(0);
      if (!mounted || gen != _gen) return;
      setState(() {
        _tracks = tracks;
        _offset = _pageSize;
        _hasMore = tracks.isNotEmpty;
        _loading = false;
      });
    } catch (_) {
      if (!mounted || gen != _gen) return;
      setState(() {
        _loading = false;
        _error = t.discover.story.musicError;
      });
    }
  }

  /// Listenin sonuna gelince sonraki sayfa.
  Future<void> _loadMore() async {
    if (_loading || _loadingMore || !_hasMore) return;
    final gen = _gen;
    setState(() => _loadingMore = true);
    try {
      final page = await _fetchPage(_offset);
      if (!mounted || gen != _gen) return;
      final seen = {for (final tr in _tracks) tr.audioUrl};
      setState(() {
        _tracks = [
          ..._tracks,
          ...page.where((tr) => !seen.contains(tr.audioUrl)),
        ];
        _offset += _pageSize;
        _hasMore = page.isNotEmpty;
      });
    } catch (_) {
      // Ağ hatası: tekrar kaydırınca yeniden dener.
    } finally {
      if (mounted && gen == _gen) setState(() => _loadingMore = false);
    }
  }

  void _onSearchChanged(String value) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 400), () {
      final q = value.trim();
      if (q == _search || !mounted) return;
      _search = q;
      unawaited(_reload());
    });
  }

  void _pickGenre(String genre) {
    if (genre == _genre && _search.isEmpty) return;
    _searchDebounce?.cancel();
    _searchCtl.clear();
    _search = '';
    _genre = genre;
    unawaited(_reload());
  }

  Future<List<dynamic>> _query(Map<String, Object> extra) async {
    final response = await _dio.get<Map<String, dynamic>>(
      'https://api.jamendo.com/v3.0/tracks/',
      queryParameters: {
        'client_id': 'f34b0064',
        'format': 'json',
        'limit': _pageSize,
        'audioformat': 'mp32',
        ...extra,
      },
    );
    return response.data?['results'] as List<dynamic>? ?? const [];
  }

  static String _capitalize(String s) =>
      s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);

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
    // Trim'den dönünce liste aynı yerden devam etsin.
    final old = _scroll;
    _scroll = ScrollController(
      initialScrollOffset: old.hasClients ? old.offset : 0,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) => old.dispose());
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
      final player = _audio;
      await player.setUrl(url);
      await player.setLoopMode(LoopMode.off);

      await _posSub?.cancel();
      _posSub = player.positionStream.listen((pos) async {
        if (_seeking || !mounted) return;
        // duration 0 veya clip henüz hazır değilse seek döngüsüne girme
        if (_totalSec <= 0 || _clipEnd <= Duration.zero) return;
        if (pos < _clipEnd) return;
        _seeking = true;
        try {
          await player.seek(_clipStart);
          unawaited(player.play());
        } finally {
          _seeking = false;
        }
      });

      await player.seek(_clipStart);
      unawaited(player.play());
    } catch (_) {}
  }

  Future<void> _seekToClipStart() async {
    _seeking = true;
    try {
      final player = _audio;
      await player.seek(_clipStart);
      if (!player.playing) unawaited(player.play());
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
      await _player?.stop();
    } catch (_) {}
    await _posSub?.cancel();
    _posSub = null;
    if (mounted) setState(() => _selected = null);
  }

  /// Seçimi editöre bildirir ve listeye döner; sheet açık kalır.
  Future<void> _save() async {
    final track = _selected;
    if (track == null) return;
    final picked = track.copyWith(
      clipStartSec: _clipStart.inSeconds,
      clipEndSec: _clipEnd.inSeconds,
    );
    widget.onSelected(picked);
    setState(() => _picked = picked);
    await _back();
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
              _searchField(),
              const SizedBox(height: 10),
              _genreChips(),
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

  Widget _searchField() {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            size: 20,
            color: AppColors.white.withValues(alpha: 0.6),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _searchCtl,
              onChanged: _onSearchChanged,
              textInputAction: TextInputAction.search,
              cursorColor: AppColors.white,
              style: const TextStyle(
                fontFamily: AppFonts.poppins,
                fontSize: 14,
                color: AppColors.white,
              ),
              decoration: InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                hintText: Translations.of(context).discover.searchHint,
                hintStyle: TextStyle(
                  fontFamily: AppFonts.poppins,
                  fontSize: 14,
                  color: AppColors.white.withValues(alpha: 0.45),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _genreChips() {
    return SizedBox(
      height: 32,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _genres.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final genre = _genres[i];
          final active = _search.isEmpty && genre == _genre;
          return GestureDetector(
            onTap: () => _pickGenre(genre),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: active
                    ? AppColors.white
                    : AppColors.white.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                _capitalize(genre),
                style: TextStyle(
                  fontFamily: AppFonts.poppins,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: active ? AppColors.black : AppColors.white,
                ),
              ),
            ),
          );
        },
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

    return NotificationListener<ScrollNotification>(
      onNotification: (n) {
        if (n.metrics.extentAfter < 500) unawaited(_loadMore());
        return false;
      },
      child: ListView.separated(
      controller: _scroll,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemCount: _tracks.length + (_loadingMore ? 1 : 0),
      separatorBuilder: (_, _) => const SizedBox(height: 14),
      itemBuilder: (context, index) {
        if (index >= _tracks.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Center(
              child: SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.white,
                ),
              ),
            ),
          );
        }
        final track = _tracks[index];
        final picked = _picked?.audioUrl == track.audioUrl;
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
              if (picked) ...[
                const SizedBox(width: 8),
                const Icon(
                  Icons.check_circle,
                  size: 22,
                  color: AppColors.white,
                ),
              ],
            ],
          ),
        );
      },
      ),
    );
  }

  Widget _cover(StoryMusicTrack track, double size) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: size,
        height: size,
        child: track.imageUrl != null
            ? Image(
                image: CachedNetworkImageProvider(track.imageUrl!),
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
