import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

import 'package:dio/dio.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

/// Instagram tarzı müzik seçici: listede dokununca önizleme çalar, ok/mini
/// oynatıcı kırpma ekranını açar; ✓ seçimi [onSelected] ile bildirip kapanır.
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

const _kSheetColor = Color(0xFF262626);
const _kMiniPlayerColor = Color(0xFF17484D);
const _kPlayingBlue = Color(0xFF85B7F7);

/// Jamendo müzik listesi (sekmeler, arama, sonsuz kaydırma) + kırpma ekranı.
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

  // Sekmeler: 0 Sana özel, 1 Trend, 2 Kaydedilenler, sonrası türler.
  static const _tabForYou = 0;
  static const _tabTrending = 1;
  static const _tabSaved = 2;
  static const _pageSize = 30;
  static const _genres = [
    'pop',
    'rock',
    'electronic',
    'hiphop',
    'dance',
    'jazz',
    'acoustic',
    'chillout',
    'lounge',
    'ambient',
    'classical',
    'soundtrack',
    'rnb',
    'reggae',
    'latin',
    'folk',
    'metal',
    'world',
  ];
  int _tab = _tabForYou;
  String _search = '';
  int _offset = 0;
  bool _hasMore = true;
  bool _loadingMore = false;
  int _gen = 0;
  Timer? _searchDebounce;
  final _searchCtl = TextEditingController();
  ScrollController _scroll = ScrollController();

  // Kaydedilenler (cihazda saklanır).
  static const _savedKey = 'story_music_saved';
  List<StoryMusicTrack> _saved = [];

  // Önizleme: listede dokunulan parça; kırpma ekranı da bunu kullanır.
  AudioPlayer? _player;
  StoryMusicTrack? _current;
  String? _loadedUrl;
  bool _playing = false;
  bool _trimming = false;
  StreamSubscription<Duration>? _posSub;
  StreamSubscription<bool>? _playingSub;
  final _pos = ValueNotifier<Duration>(Duration.zero);
  bool _seeking = false;

  // Kırpma: seçilen bölümün başlangıcı ve uzunluğu (sn).
  static const _clipOptions = [5, 10, 15, 20, 30, 45, 60];
  int _clipSec = 15;
  double _startSec = 0;

  AudioPlayer get _audio => _player ??= AudioPlayer();

  @override
  void initState() {
    super.initState();
    unawaited(_loadSaved());
    // Translations.of(context) initState sırasında InheritedWidget'a bağlanamaz;
    // ilk frame'den sonra Jamendo listesini çek.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) unawaited(_reload());
    });
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _searchCtl.dispose();
    _scroll.dispose();
    _posSub?.cancel();
    _playingSub?.cancel();
    _player?.dispose();
    _pos.dispose();
    super.dispose();
  }

  // ---- Kaydedilenler ----

  Future<void> _loadSaved() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getStringList(_savedKey) ?? const [];
      final list = <StoryMusicTrack>[];
      for (final s in raw) {
        final track = _trackFromJson(jsonDecode(s));
        if (track != null) list.add(track);
      }
      if (mounted) setState(() => _saved = list);
    } catch (_) {}
  }

  /// Jamendo ses adresindeki `from` her istekte değişir; parçayı trackid
  /// ile karşılaştır.
  static String _trackKey(StoryMusicTrack t) {
    final url = t.audioUrl ?? '';
    return Uri.tryParse(url)?.queryParameters['trackid'] ?? url;
  }

  static bool _sameTrack(StoryMusicTrack a, StoryMusicTrack b) =>
      _trackKey(a) == _trackKey(b);

  bool _isSaved(StoryMusicTrack track) =>
      _saved.any((s) => _sameTrack(s, track));

  Future<void> _toggleSaved(StoryMusicTrack track) async {
    setState(() {
      if (_isSaved(track)) {
        _saved = _saved.where((s) => !_sameTrack(s, track)).toList();
      } else {
        _saved = [track.copyWith(clipStartSec: 0, clipEndSec: 0), ..._saved];
      }
    });
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_savedKey, [
        for (final s in _saved) jsonEncode(_trackToJson(s)),
      ]);
    } catch (_) {}
  }

  static Map<String, Object?> _trackToJson(StoryMusicTrack t) => {
    'title': t.title,
    'artist': t.artist,
    'durationSec': t.durationSec,
    'imageUrl': t.imageUrl,
    'audioUrl': t.audioUrl,
    'genre': t.genre,
  };

  StoryMusicTrack? _trackFromJson(Object? raw) {
    if (raw is! Map) return null;
    final url = raw['audioUrl'];
    if (url is! String || url.isEmpty) return null;
    final sec = (raw['durationSec'] as num?)?.toInt() ?? 0;
    return StoryMusicTrack(
      title: (raw['title'] as String?) ?? t.discover.story.unknownTrack,
      artist: (raw['artist'] as String?) ?? t.discover.story.unknownTrack,
      durationSec: sec,
      durationLabel: _fmt(sec),
      imageUrl: raw['imageUrl'] as String?,
      audioUrl: url,
      genre: raw['genre'] as String?,
    );
  }

  // ---- Katalog ----

  /// Arama varsa ada/sanatçıya göre; yoksa sekmeye göre.
  Map<String, Object> get _params {
    if (_search.isNotEmpty) return {'search': _search, 'include': 'musicinfo'};
    return switch (_tab) {
      _tabForYou => {'order': 'popularity_month', 'include': 'musicinfo'},
      _tabTrending => {'order': 'popularity_week', 'include': 'musicinfo'},
      _ => {
        'fuzzytags': _genres[_tab - 3],
        'order': 'popularity_total',
        'include': 'musicinfo',
      },
    };
  }

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
        final tracks = results
            .map(_track)
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
    String? genre = _tab >= 3 ? _capitalize(_genres[_tab - 3]) : null;
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

  /// İlk sayfa (arama/sekme değişince).
  Future<void> _reload() async {
    final gen = ++_gen;
    if (_scroll.hasClients) _scroll.jumpTo(0);
    if (_tab == _tabSaved && _search.isEmpty) {
      setState(() {
        _loading = false;
        _error = null;
        _hasMore = false;
      });
      return;
    }
    setState(() {
      _loading = true;
      _error = null;
      _tracks = [];
      _offset = 0;
      _hasMore = true;
    });
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
      final seen = {for (final tr in _tracks) _trackKey(tr)};
      setState(() {
        _tracks = [
          ..._tracks,
          ...page.where((tr) => !seen.contains(_trackKey(tr))),
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

  void _pickTab(int tab) {
    if (tab == _tab && _search.isEmpty) return;
    _searchDebounce?.cancel();
    _searchCtl.clear();
    _search = '';
    _tab = tab;
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

  static String _fmt(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '$m:${s.toString().padLeft(2, '0')}';
  }

  // ---- Önizleme / kırpma ----

  int get _totalSec => _current?.durationSec ?? 0;

  /// Parça kısaysa bölüm parçanın tamamı olur.
  int get _effectiveClip =>
      _totalSec > 0 ? math.min(_clipSec, _totalSec) : _clipSec;

  Duration get _clipStart => Duration(milliseconds: (_startSec * 1000).round());

  Duration get _clipEnd =>
      Duration(milliseconds: ((_startSec + _effectiveClip) * 1000).round());

  double get _maxStart => math.max(0, _totalSec - _effectiveClip).toDouble();

  /// Listede satıra dokunma: aynı parçaysa durdur/devam, değilse çalmaya başla.
  Future<void> _preview(StoryMusicTrack track) async {
    if (_current != null && _sameTrack(_current!, track)) {
      await _togglePlay();
      return;
    }
    final initial = widget.initial;
    setState(() {
      _current = track;
      if (initial != null &&
          _sameTrack(initial, track) &&
          initial.clipEndSec > initial.clipStartSec) {
        // Editördeki seçim: aynı bölümden devam.
        _clipSec = initial.clipEndSec - initial.clipStartSec;
        _startSec = initial.clipStartSec.toDouble();
      } else {
        _clipSec = 15;
        // Varsayılan: parçanın ortası (nakarata yakın).
        _startSec = (_maxStart / 2).roundToDouble();
      }
      _startSec = _startSec.clamp(0, _maxStart);
    });
    await _play(track);
  }

  Future<void> _play(StoryMusicTrack track) async {
    final url = track.audioUrl;
    if (url == null || url.isEmpty) return;
    try {
      final player = _audio;
      _playingSub ??= player.playingStream.listen((p) {
        if (mounted) setState(() => _playing = p);
      });
      if (_loadedUrl != url) {
        _loadedUrl = url;
        await player.setUrl(url);
        if (_current?.audioUrl != url) return;
      }
      await _posSub?.cancel();
      _posSub = player.positionStream.listen((pos) async {
        _pos.value = pos;
        if (_seeking || !mounted) return;
        // Seçili bölümün sonuna gelince başa sar (döngü).
        if (_totalSec <= 0 || pos < _clipEnd) return;
        await _seekToClipStart();
      });
      await _seekToClipStart();
    } catch (_) {}
  }

  Future<void> _seekToClipStart() async {
    _seeking = true;
    try {
      final player = _audio;
      await player.seek(_clipStart);
      _pos.value = _clipStart;
      if (!player.playing) unawaited(player.play());
    } catch (_) {
    } finally {
      _seeking = false;
    }
  }

  Future<void> _togglePlay() async {
    final player = _player;
    if (player == null) return;
    if (player.playing) {
      await player.pause();
    } else {
      final pos = player.position;
      if (pos < _clipStart || pos >= _clipEnd) {
        await _seekToClipStart();
      } else {
        unawaited(player.play());
      }
    }
  }

  void _openTrim() {
    if (_current == null) return;
    FocusScope.of(context).unfocus();
    // Kırpmadan dönünce liste aynı yerden devam etsin.
    final old = _scroll;
    _scroll = ScrollController(
      initialScrollOffset: old.hasClients ? old.offset : 0,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) => old.dispose());
    setState(() => _trimming = true);
    if (!_playing) unawaited(_seekToClipStart());
  }

  void _cancelTrim() => setState(() => _trimming = false);

  void _cycleClip() {
    final options = _clipOptions.where((o) => _totalSec <= 0 || o <= _totalSec);
    final list = options.isEmpty ? [_effectiveClip] : options.toList();
    final i = list.indexOf(_clipSec);
    setState(() {
      _clipSec = list[(i + 1) % list.length];
      _startSec = _startSec.clamp(0, _maxStart);
    });
    unawaited(_seekToClipStart());
  }

  void _onScrub(double startSec) {
    setState(() => _startSec = startSec.clamp(0, _maxStart));
  }

  /// Seçimi editöre bildirir ve sheet'i kapatır.
  Future<void> _save() async {
    final track = _current;
    if (track == null) return;
    final start = _startSec.round();
    widget.onSelected(
      track.copyWith(clipStartSec: start, clipEndSec: start + _effectiveClip),
    );
    try {
      await _player?.stop();
    } catch (_) {}
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return _trimming ? _buildTrim() : _buildListSheet();
  }

  Widget _buildListSheet() {
    final tr = Translations.of(context);
    final st = tr.discover.story;
    final height = MediaQuery.sizeOf(context).height * 0.88;
    final bottom = MediaQuery.paddingOf(context).bottom;
    final tabs = [
      st.musicForYou,
      st.musicTrending,
      st.musicSaved,
      for (final g in _genres) _capitalize(g),
    ];

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: Container(
        height: height,
        color: _kSheetColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 12),
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.35),
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _searchField(tr.discover.searchHint),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 38,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: tabs.length,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemBuilder: (context, i) => _TabChip(
                  label: tabs[i],
                  active: _search.isEmpty && i == _tab,
                  onTap: () => _pickTab(i),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(child: _buildList(bottom)),
                  if (_current != null)
                    Positioned(
                      left: 12,
                      right: 12,
                      bottom: 10 + bottom,
                      child: _MiniPlayer(
                        track: _current!,
                        playing: _playing,
                        onTogglePlay: _togglePlay,
                        onNext: _openTrim,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _searchField(String hint) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            size: 22,
            color: AppColors.white.withValues(alpha: 0.7),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _searchCtl,
              onChanged: _onSearchChanged,
              textInputAction: TextInputAction.search,
              cursorColor: AppColors.white,
              style: const TextStyle(
                fontFamily: AppFonts.poppins,
                fontSize: 15,
                color: AppColors.white,
              ),
              decoration: InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                hintText: hint,
                hintStyle: TextStyle(
                  fontFamily: AppFonts.poppins,
                  fontSize: 15,
                  color: AppColors.white.withValues(alpha: 0.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(double bottomInset) {
    final st = Translations.of(context).discover.story;
    final savedTab = _tab == _tabSaved && _search.isEmpty;
    final items = savedTab ? _saved : _tracks;
    if (!savedTab && _loading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.white),
      );
    }
    if (!savedTab && _error != null) {
      return Center(
        child: AppText(
          _error!,
          style: const TextStyle(color: Color(0xFFFF6B6B)),
        ),
      );
    }
    if (items.isEmpty) {
      return Center(
        child: AppText(
          savedTab ? st.musicSavedEmpty : st.musicEmpty,
          style: TextStyle(color: AppColors.white.withValues(alpha: 0.7)),
        ),
      );
    }

    // Mini oynatıcı son satırların üstünü kapatmasın.
    final listBottom = bottomInset + (_current != null ? 90 : 16);
    return NotificationListener<ScrollNotification>(
      onNotification: (n) {
        if (!savedTab && n.metrics.extentAfter < 500) unawaited(_loadMore());
        return false;
      },
      child: ListView.builder(
        controller: _scroll,
        padding: EdgeInsets.only(bottom: listBottom),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        itemCount: items.length + (!savedTab && _loadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= items.length) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
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
          final track = items[index];
          final active = _current != null && _sameTrack(_current!, track);
          return _TrackRow(
            track: track,
            active: active,
            playing: active && _playing,
            saved: _isSaved(track),
            onTap: () => _preview(track),
            onToggleSaved: () => _toggleSaved(track),
          );
        },
      ),
    );
  }

  Widget _buildTrim() {
    final st = Translations.of(context).discover.story;
    final track = _current!;
    final size = MediaQuery.sizeOf(context);
    // Sheet üst boşluğu sıfırlar; durum çubuğu payını ekrandan al.
    final pad = MediaQueryData.fromView(View.of(context)).padding;
    const shadow = [Shadow(color: Color(0x66000000), blurRadius: 8)];

    // Dikey sürükleme sheet'i kapatmasın (kırpma tam ekran).
    return GestureDetector(
      onVerticalDragStart: (_) {},
      child: SizedBox(
        height: size.height,
        child: ColoredBox(
          color: AppColors.black.withValues(alpha: 0.35),
          child: Stack(
            children: [
              Positioned(
                top: pad.top + 8,
                left: 8,
                right: 8,
                height: 52,
                child: Row(
                  children: [
                    TextButton(
                      onPressed: _cancelTrim,
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.white,
                      ),
                      child: Text(
                        st.musicCancel,
                        style: const TextStyle(
                          fontFamily: AppFonts.poppins,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          shadows: shadow,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        border: Border.all(color: AppColors.white, width: 2),
                      ),
                      child: _Cover(track: track, size: 40, radius: 7),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: _save,
                      icon: const Icon(
                        Icons.check,
                        size: 32,
                        color: AppColors.white,
                        shadows: shadow,
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        track.title,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: AppFonts.poppins,
                          fontWeight: FontWeight.w500,
                          fontSize: 26,
                          color: AppColors.white,
                          shadows: shadow,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        track.artist,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: AppFonts.poppins,
                          fontSize: 15,
                          color: AppColors.white.withValues(alpha: 0.85),
                          shadows: shadow,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: pad.bottom + 24,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        children: [
                          _ClipLengthButton(
                            seconds: _effectiveClip,
                            onTap: _cycleClip,
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: ValueListenableBuilder<Duration>(
                              valueListenable: _pos,
                              builder: (context, pos, _) => _TrackOverview(
                                startFrac: _totalSec > 0
                                    ? _startSec / _totalSec
                                    : 0,
                                posFrac: _totalSec > 0
                                    ? pos.inMilliseconds / (_totalSec * 1000)
                                    : 0,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          GestureDetector(
                            onTap: _togglePlay,
                            child: Container(
                              width: 48,
                              height: 48,
                              decoration: const BoxDecoration(
                                color: AppColors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                _playing
                                    ? Icons.stop_rounded
                                    : Icons.play_arrow_rounded,
                                size: 30,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),
                    _WaveScrubber(
                      seed: track.audioUrl.hashCode,
                      totalSec: _totalSec,
                      clipSec: _effectiveClip,
                      startSec: _startSec,
                      position: _pos,
                      onChanged: _onScrub,
                      onChangeEnd: () => unawaited(_seekToClipStart()),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TabChip extends StatelessWidget {
  const _TabChip({
    required this.label,
    required this.active,
    required this.onTap,
  });

  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: active
              ? AppColors.white
              : AppColors.white.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: AppFonts.poppins,
            fontWeight: FontWeight.w500,
            fontSize: 15,
            color: active ? AppColors.black : AppColors.white,
          ),
        ),
      ),
    );
  }
}

class _Cover extends StatelessWidget {
  const _Cover({required this.track, required this.size, this.radius = 6});

  final StoryMusicTrack track;
  final double size;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final placeholder = ColoredBox(
      color: AppColors.white.withValues(alpha: 0.1),
      child: const Icon(Icons.music_note, color: AppColors.white),
    );
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: SizedBox(
        width: size,
        height: size,
        child: track.imageUrl != null
            ? Image(
                image: CachedNetworkImageProvider(track.imageUrl!),
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => placeholder,
              )
            : placeholder,
      ),
    );
  }
}

class _TrackRow extends StatelessWidget {
  const _TrackRow({
    required this.track,
    required this.active,
    required this.playing,
    required this.saved,
    required this.onTap,
    required this.onToggleSaved,
  });

  final StoryMusicTrack track;
  final bool active;
  final bool playing;
  final bool saved;
  final VoidCallback onTap;
  final VoidCallback onToggleSaved;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        color: active
            ? AppColors.white.withValues(alpha: 0.07)
            : Colors.transparent,
        padding: const EdgeInsets.fromLTRB(16, 8, 6, 8),
        child: Row(
          children: [
            _Cover(track: track, size: 56),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (active) ...[
                        _EqualizerIcon(animate: playing),
                        const SizedBox(width: 6),
                      ],
                      Flexible(
                        child: Text(
                          track.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: AppFonts.poppins,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: active ? _kPlayingBlue : AppColors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${track.artist} • ${track.durationLabel}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: AppFonts.poppins,
                      fontSize: 14,
                      color: AppColors.white.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onToggleSaved,
              icon: Icon(
                saved ? Icons.bookmark : Icons.bookmark_border,
                size: 28,
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Çalan satırdaki küçük ekolayzır (çalmıyorsa sabit).
class _EqualizerIcon extends StatefulWidget {
  const _EqualizerIcon({required this.animate});

  final bool animate;

  @override
  State<_EqualizerIcon> createState() => _EqualizerIconState();
}

class _EqualizerIconState extends State<_EqualizerIcon>
    with SingleTickerProviderStateMixin {
  late final _ctl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  );

  @override
  void initState() {
    super.initState();
    if (widget.animate) _ctl.repeat();
  }

  @override
  void didUpdateWidget(_EqualizerIcon old) {
    super.didUpdateWidget(old);
    if (widget.animate && !_ctl.isAnimating) _ctl.repeat();
    if (!widget.animate && _ctl.isAnimating) _ctl.stop();
  }

  @override
  void dispose() {
    _ctl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctl,
      builder: (context, _) => SizedBox(
        width: 16,
        height: 14,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (var i = 0; i < 3; i++)
              Container(
                width: 3.5,
                height:
                    14 *
                    (0.45 +
                        0.55 *
                            (0.5 +
                                0.5 *
                                    math.sin(
                                      _ctl.value * 2 * math.pi + i * 2.1,
                                    ))),
                decoration: BoxDecoration(
                  color: _kPlayingBlue,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _MiniPlayer extends StatelessWidget {
  const _MiniPlayer({
    required this.track,
    required this.playing,
    required this.onTogglePlay,
    required this.onNext,
  });

  final StoryMusicTrack track;
  final bool playing;
  final VoidCallback onTogglePlay;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onNext,
      child: Container(
        height: 68,
        padding: const EdgeInsets.fromLTRB(14, 0, 12, 0),
        decoration: BoxDecoration(
          color: _kMiniPlayerColor,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(color: Color(0x66000000), blurRadius: 16),
          ],
        ),
        child: Row(
          children: [
            _Cover(track: track, size: 42),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                    track.artist,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: AppFonts.poppins,
                      fontSize: 14,
                      color: AppColors.white.withValues(alpha: 0.75),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onTogglePlay,
              icon: Icon(
                playing ? Icons.pause_rounded : Icons.play_arrow_rounded,
                size: 36,
                color: AppColors.white,
              ),
            ),
            const SizedBox(width: 4),
            GestureDetector(
              onTap: onNext,
              child: Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_forward,
                  size: 24,
                  color: AppColors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Bölüm süresi; dokununca 5/10/15/20/30/45/60 sn arasında döner.
class _ClipLengthButton extends StatelessWidget {
  const _ClipLengthButton({required this.seconds, required this.onTap});

  final int seconds;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.white, width: 2),
        ),
        child: Text(
          '$seconds',
          style: const TextStyle(
            fontFamily: AppFonts.poppins,
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}

/// Parçanın tamamı: beyaz işaret bölümün başı, pembe nokta çalan konum.
class _TrackOverview extends StatelessWidget {
  const _TrackOverview({required this.startFrac, required this.posFrac});

  final double startFrac;
  final double posFrac;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 16,
      child: LayoutBuilder(
        builder: (context, c) {
          final w = c.maxWidth;
          return Stack(
            alignment: Alignment.centerLeft,
            children: [
              Container(
                height: 2,
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
              Positioned(
                left: (posFrac.clamp(0.0, 1.0) * w - 3).clamp(0.0, w - 6),
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF2D6F),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                left: (startFrac.clamp(0.0, 1.0) * w - 9).clamp(0.0, w - 18),
                child: Container(
                  width: 18,
                  height: 6,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// Instagram tarzı kırpma: pencere ortada sabit, dalga formu altında kayar.
class _WaveScrubber extends StatelessWidget {
  const _WaveScrubber({
    required this.seed,
    required this.totalSec,
    required this.clipSec,
    required this.startSec,
    required this.position,
    required this.onChanged,
    required this.onChangeEnd,
  });

  final int seed;
  final int totalSec;
  final int clipSec;
  final double startSec;
  final ValueNotifier<Duration> position;
  final ValueChanged<double> onChanged;
  final VoidCallback onChangeEnd;

  static const _height = 64.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final width = c.maxWidth;
        final windowW = width * 0.36;
        final pxPerSec = windowW / math.max(1, clipSec);
        var start = startSec;
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onHorizontalDragStart: (_) => start = startSec,
          onHorizontalDragUpdate: (d) {
            start -= d.delta.dx / pxPerSec;
            onChanged(start);
          },
          onHorizontalDragEnd: (_) => onChangeEnd(),
          child: ValueListenableBuilder<Duration>(
            valueListenable: position,
            builder: (context, pos, _) {
              final played = (pos.inMilliseconds / 1000 - startSec) / clipSec;
              return CustomPaint(
                size: Size(width, _height),
                painter: _WavePainter(
                  seed: seed,
                  totalSec: totalSec,
                  startSec: startSec,
                  windowW: windowW,
                  pxPerSec: pxPerSec,
                  progress: played.clamp(0.0, 1.0),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _WavePainter extends CustomPainter {
  _WavePainter({
    required this.seed,
    required this.totalSec,
    required this.startSec,
    required this.windowW,
    required this.pxPerSec,
    required this.progress,
  });

  final int seed;
  final int totalSec;
  final double startSec;
  final double windowW;
  final double pxPerSec;
  final double progress;

  static const _step = 9.0;
  static const _barW = 3.5;
  static const _border = 4.0;
  static const _gradient = [
    Color(0xFFFFC107),
    Color(0xFFFF5722),
    Color(0xFFE91E63),
    Color(0xFF7C4DFF),
  ];

  /// Parçaya özgü sabit yükseklik: uzun çubuk / kısa nokta sırayla.
  double _barHeight(int i) {
    final r = math.sin((i + 1) * 12.9898 + seed * 0.001) * 43758.5453;
    final rand = r - r.floorToDouble();
    return i.isEven ? 0.45 + 0.45 * rand : 0.16 + 0.12 * rand;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final h = size.height;
    final windowLeft = (size.width - windowW) / 2;
    final window = Rect.fromLTWH(windowLeft, 0, windowW, h);
    final windowRRect = RRect.fromRectAndRadius(
      window,
      const Radius.circular(10),
    );
    // Dalga formunun ekrandaki başlangıcı (parçanın 0. saniyesi).
    final originX = windowLeft - startSec * pxPerSec;
    final trackW = math.max(totalSec * pxPerSec, windowW);

    // Pencere dolgusu + çalınan kısım.
    canvas.drawRRect(windowRRect, Paint()..color = AppColors.white);
    if (progress > 0) {
      canvas.save();
      canvas.clipRRect(windowRRect);
      canvas.drawRect(
        Rect.fromLTWH(windowLeft, 0, windowW * progress, h),
        Paint()..color = const Color(0xFFFFC107),
      );
      canvas.restore();
    }

    final outside = Paint()..color = AppColors.white.withValues(alpha: 0.55);
    final inside = Paint()..color = const Color(0xFFBDBDBD);
    final first = math.max(0, ((0 - originX) / _step).floor());
    final last = math.min(
      (trackW / _step).floor(),
      ((size.width - originX) / _step).ceil(),
    );
    for (var i = first; i <= last; i++) {
      final x = originX + i * _step + _step / 2;
      if (x < 0 || x > size.width) continue;
      final bh = h * _barHeight(i);
      final inWindow = x > windowLeft + _border && x < window.right - _border;
      final bar = RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(x, h / 2), width: _barW, height: bh),
        const Radius.circular(2),
      );
      canvas.drawRRect(bar, inWindow ? inside : outside);
    }

    // Degrade çerçeve.
    canvas.drawRRect(
      windowRRect.deflate(_border / 2),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = _border
        ..shader = const LinearGradient(colors: _gradient).createShader(window),
    );
  }

  @override
  bool shouldRepaint(_WavePainter old) =>
      old.startSec != startSec ||
      old.progress != progress ||
      old.windowW != windowW ||
      old.pxPerSec != pxPerSec ||
      old.seed != seed ||
      old.totalSec != totalSec;
}
