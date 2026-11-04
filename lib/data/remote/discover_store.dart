import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:veylo/data/remote/post_repository.dart';
import 'package:veylo/models/discover/post.dart';

/// Discover akışı: arama + filtreler, sayfalama, beğeni/kaydetme sonrası güncelleme.
class DiscoverStore extends ChangeNotifier {
  DiscoverStore._();

  static final DiscoverStore instance = DiscoverStore._();

  final _repo = PostRepository.instance;

  List<Post> _posts = const [];
  String? _nextCursor;
  bool _loaded = false;
  bool _loadingMore = false;
  int _savedEpoch = 0;
  int _postsEpoch = 0;
  String _query = '';
  DiscoverFilters _filters = const DiscoverFilters();
  Timer? _debounce;
  int _generation = 0;

  List<Post> get posts => _posts;
  bool get loaded => _loaded;
  DiscoverFilters get filters => _filters;

  /// Arama kutusu sekme değişiminde yeniden kurulunca bununla dolar.
  String get query => _query;

  /// Kaydet / kaydı kaldır. Profildeki Saved sekmesi bunu dinler.
  int get savedEpoch => _savedEpoch;

  /// Kendi gönderim düzenlendi / silindi. Profildeki Gönderiler sekmesi bunu dinler.
  int get postsEpoch => _postsEpoch;

  Future<void> refresh() async {
    final gen = ++_generation;
    final net = _repo.feed(query: _query, filters: _filters);
    // Disk okunurken ağ hata verirse yakalanmamış hata sayılmasın; aşağıda await edilir.
    unawaited(net.then((_) {}, onError: (_) {}));
    // Liste boşsa ağı beklerken diskteki son akışı hemen göster.
    if (_posts.isEmpty) {
      final cached = await _repo.cachedFeed(query: _query, filters: _filters);
      if (cached != null && gen == _generation && _posts.isEmpty) {
        _posts = cached.items;
        _nextCursor = cached.nextCursor;
        _loaded = true;
        notifyListeners();
      }
    }
    try {
      final page = await net;
      // Yazarken eski istek sonradan dönerse yeni sonucu ezmesin.
      if (gen != _generation) return;
      _posts = page.items;
      _nextCursor = page.nextCursor;
      _loaded = true;
      notifyListeners();
    } catch (_) {}
  }

  Future<void> loadMore() async {
    if (_loadingMore) return;
    final cursor = _nextCursor;
    if (cursor == null) return;
    _loadingMore = true;
    try {
      final page = await _repo.feed(
        cursor: cursor,
        query: _query,
        filters: _filters,
      );
      final seen = {for (final p in _posts) p.id};
      _posts = [..._posts, ...page.items.where((p) => !seen.contains(p.id))];
      _nextCursor = page.nextCursor;
      notifyListeners();
    } catch (_) {
    } finally {
      _loadingMore = false;
    }
  }

  /// Arama: yazmayı bırakınca (400 ms) sunucuya sorar.
  void search(String q) {
    _query = q.trim();
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), refresh);
  }

  void applyFilters(DiscoverFilters f) {
    _filters = f;
    refresh();
  }

  /// Detay ekranında beğeni/kaydetme değişince ızgaradaki kopya da güncellenir.
  void replace(Post post, {bool edited = false}) {
    Post? prev;
    for (final p in _posts) {
      if (p.id == post.id) prev = p;
    }
    _posts = [for (final p in _posts) p.id == post.id ? post : p];
    if (prev?.savedByMe != post.savedByMe) _savedEpoch++;
    if (edited) _postsEpoch++;
    notifyListeners();
  }

  void remove(String id) {
    _posts = _posts.where((p) => p.id != id).toList();
    _postsEpoch++;
    notifyListeners();
  }

  void clear() {
    _posts = const [];
    _nextCursor = null;
    _loaded = false;
    _query = '';
    _filters = const DiscoverFilters();
    notifyListeners();
  }
}
