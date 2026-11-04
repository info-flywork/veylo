import 'package:veylo/data/remote/api_client.dart';
import 'package:veylo/models/discover/post.dart';

typedef PostPage = ({List<Post> items, String? nextCursor});

/// Discover gönderi uç noktaları (`/posts`, `/media/post`).
class PostRepository {
  PostRepository._();

  static final PostRepository instance = PostRepository._();

  final _api = ApiClient.instance;

  PostPage _page(dynamic res) {
    final m = res as Map;
    return (
      items: [
        for (final j in (m['items'] as List).cast<Map>())
          Post.fromJson(Map<String, dynamic>.from(j)),
      ],
      nextCursor: m['nextCursor'] as String?,
    );
  }

  Post _post(dynamic res) => Post.fromJson(Map<String, dynamic>.from(res as Map));

  Map<String, dynamic> _feedQuery(
    String? cursor,
    String? query,
    DiscoverFilters filters,
  ) => {
    'cursor': ?cursor,
    if (query != null && query.isNotEmpty) 'q': query,
    ...filters.toQuery(),
  };

  Future<PostPage> feed({
    String? cursor,
    String? query,
    DiscoverFilters filters = const DiscoverFilters(),
  }) async => _page(
    await _api.get(
      '/posts/feed',
      query: _feedQuery(cursor, query, filters),
      // İlk sayfa diske yazılır: uygulama açılınca akış anında dolu gelir.
      cache: cursor == null,
    ),
  );

  /// Aynı arama/filtre için diskteki son ilk sayfa.
  Future<PostPage?> cachedFeed({
    String? query,
    DiscoverFilters filters = const DiscoverFilters(),
  }) async {
    try {
      final res = await _api.cached(
        '/posts/feed',
        query: _feedQuery(null, query, filters),
      );
      return res == null ? null : _page(res);
    } catch (_) {
      return null;
    }
  }

  /// Görseli yükler (tam boy + önizleme) ve gönderiyi oluşturur.
  /// [sourcePath]: yazı/çıkartma işlenmeden önceki fotoğraf; sonradan düzenlemek için saklanır.
  Future<Post> create({
    required String imagePath,
    String? sourcePath,
    Map<String, Object?>? editorState,
    String? caption,
    Map<String, Object?>? music,
    bool draft = false,
  }) async {
    final uploads = await Future.wait([
      _api.upload('/media/post', imagePath),
      if (sourcePath != null) _api.upload('/media/post', sourcePath),
    ]);
    final media = uploads.first as Map;
    final source = uploads.length > 1 ? uploads[1] as Map : null;
    return _post(
      await _api.post(
        '/posts',
        body: {
          'mediaId': media['mediaId'],
          'thumbId': media['thumbId'],
          if (source != null) 'sourceId': source['mediaId'],
          'editorState': ?editorState,
          if (caption != null && caption.isNotEmpty) 'caption': caption,
          'music': ?music,
          'draft': draft,
        },
      ),
    );
  }

  /// Editörde yeniden düzenlenen gönderiyi kaydeder (yeni görsel + katmanlar + müzik).
  /// [publish]: taslaksa aynı anda yayınlanır.
  Future<Post> saveEdit(
    String id, {
    required String imagePath,
    required Map<String, Object?> editorState,
    Map<String, Object?>? music,
    bool publish = false,
  }) async {
    final media = await _api.upload('/media/post', imagePath) as Map;
    return _post(
      await _api.patch(
        '/posts/$id',
        body: {
          'mediaId': media['mediaId'],
          'thumbId': media['thumbId'],
          'editorState': editorState,
          'music': music,
          if (publish) 'publish': true,
        },
      ),
    );
  }

  Future<Post> get(String id) async => _post(await _api.get('/posts/$id'));

  Future<Post> publish(String id) async =>
      _post(await _api.patch('/posts/$id', body: {'publish': true}));

  Future<void> delete(String id) => _api.delete('/posts/$id');

  /// Açıklamayı değiştirir; null açıklamayı kaldırır.
  Future<Post> updateCaption(String id, String? caption) async =>
      _post(await _api.patch('/posts/$id', body: {'caption': caption}));

  Future<Post> setLiked(String id, bool liked) async => _post(
    await (liked ? _api.post('/posts/$id/like') : _api.delete('/posts/$id/like')),
  );

  Future<Post> setSaved(String id, bool saved) async => _post(
    await (saved ? _api.post('/posts/$id/save') : _api.delete('/posts/$id/save')),
  );

  Future<void> view(String id) => _api.post('/posts/$id/view');

  Future<({int views, int likes, int comments, DateTime? boostedUntil})> stats(
    String id,
  ) async {
    final m = await _api.get('/posts/$id/stats') as Map;
    return (
      views: (m['viewCount'] as num?)?.toInt() ?? 0,
      likes: (m['likeCount'] as num?)?.toInt() ?? 0,
      comments: (m['commentCount'] as num?)?.toInt() ?? 0,
      boostedUntil: DateTime.tryParse(m['boostedUntil'] as String? ?? ''),
    );
  }

  /// 100 token, 24 saat. Yeni bakiye döner.
  Future<int> boost(String id) async {
    final m = await _api.post('/posts/$id/boost') as Map;
    return (m['balance'] as num).toInt();
  }

  Future<List<PostComment>> comments(String id) async {
    final m = await _api.get('/posts/$id/comments') as Map;
    return [
      for (final j in (m['items'] as List).cast<Map>())
        PostComment.fromJson(Map<String, dynamic>.from(j)),
    ];
  }

  Future<PostComment> addComment(String id, String body) async =>
      PostComment.fromJson(
        Map<String, dynamic>.from(
          await _api.post('/posts/$id/comments', body: {'body': body}) as Map,
        ),
      );

  Future<void> deleteComment(String commentId) =>
      _api.delete('/posts/comments/$commentId');

  Future<void> report(String id, {String reason = 'OTHER', String? details}) =>
      _api.post(
        '/posts/$id/report',
        body: {
          'reason': reason,
          if (details != null && details.isNotEmpty) 'details': details,
        },
      );

  Future<PostPage> byUser(String userId, {String? cursor}) async =>
      _page(await _api.get('/posts/user/$userId', query: {'cursor': ?cursor}));

  /// Kendi taslaklarım (en yeni önce).
  Future<List<Post>> drafts() async =>
      _page(await _api.get('/posts/drafts')).items;

  Future<PostPage> saved({String? cursor}) async =>
      _page(await _api.get('/posts/saved', query: {'cursor': ?cursor}));
}
