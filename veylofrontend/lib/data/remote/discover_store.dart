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
  String _query = '';
  DiscoverFilters _filters = const DiscoverFilters();
  Timer? _debounce;
  int _generation = 0;

  List<Post> get posts => _posts;
  bool get loaded => _loaded;
  DiscoverFilters get filters => _filters;

  Future<void> refresh() async {
    final gen = ++_generation;
    try {
      final page = await _repo.feed(query: _query, filters: _filters);
      // Yazarken eski istek sonradan dönerse yeni sonucu ezmesin.
      if (gen != _generation) return;
      _posts = page.items;
      _nextCursor = page.nextCursor;
      _loaded = true;
      notifyListeners();
    } catch (_) {}
  }

  Future<void> loadMore() async {
    final cursor = _nextCursor;
    if (cursor == null || _loadingMore) return;
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
  void replace(Post post) {
    _posts = [for (final p in _posts) p.id == post.id ? post : p];
    notifyListeners();
  }

  void remove(String id) {
    _posts = _posts.where((p) => p.id != id).toList();
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
