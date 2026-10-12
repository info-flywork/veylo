import 'package:flutter/foundation.dart';
import 'package:veylo/data/remote/vibe_repository.dart';
import 'package:veylo/models/vibes/vibe_post.dart';

/// Vibes akışı: liste ve harita görünümü aynı veriyi paylaşır.
class VibeStore extends ChangeNotifier {
  VibeStore._();

  static final VibeStore instance = VibeStore._();

  final _repo = VibeRepository.instance;

  List<VibePost> _posts = const [];
  String? _nextCursor;
  bool _loading = false;
  bool _loadingMore = false;
  bool _loaded = false;
  Object? _error;

  List<VibePost> get posts => _posts;
  bool get loading => _loading;
  bool get loaded => _loaded;
  bool get hasMore => _nextCursor != null;
  Object? get error => _error;

  Future<void> refresh() async {
    _loading = _posts.isEmpty;
    notifyListeners();
    try {
      final page = await _repo.feed();
      _posts = page.items;
      _nextCursor = page.nextCursor;
      _error = null;
      _loaded = true;
    } catch (e) {
      _error = e;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> loadMore() async {
    final cursor = _nextCursor;
    if (cursor == null || _loadingMore) return;
    _loadingMore = true;
    try {
      final page = await _repo.feed(cursor: cursor);
      _posts = [..._posts, ...page.items];
      _nextCursor = page.nextCursor;
      notifyListeners();
    } catch (_) {
    } finally {
      _loadingMore = false;
    }
  }

  Future<VibePost> share({
    required String body,
    required bool anonymous,
  }) async {
    final post = await _repo.create(body: body, anonymous: anonymous);
    _posts = [post, ..._posts];
    notifyListeners();
    return post;
  }

  /// Beğeni hemen ekranda değişir; sunucu hata verirse geri alınır.
  Future<void> toggleLike(VibePost post) async {
    final liked = !post.likedByMe;
    _replace(
      post.copyWith(
        likedByMe: liked,
        likeCount: (post.likeCount + (liked ? 1 : -1)).clamp(0, 1 << 31),
      ),
    );
    try {
      _replace(await _repo.setLiked(post.id, liked));
    } catch (_) {
      _replace(post);
    }
  }

  Future<void> delete(VibePost post) async {
    await _repo.delete(post.id);
    _posts = _posts.where((p) => p.id != post.id).toList();
    notifyListeners();
  }

  /// Çıkışta.
  void clear() {
    _posts = const [];
    _nextCursor = null;
    _loaded = false;
    notifyListeners();
  }

  void _replace(VibePost post) {
    _posts = [for (final p in _posts) p.id == post.id ? post : p];
    notifyListeners();
  }
}
