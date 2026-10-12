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

  Future<PostPage> feed({
    String? cursor,
    String? query,
    DiscoverFilters filters = const DiscoverFilters(),
  }) async => _page(
    await _api.get(
      '/posts/feed',
      query: {
        'cursor': ?cursor,
        if (query != null && query.isNotEmpty) 'q': query,
        ...filters.toQuery(),
      },
    ),
  );

  /// Görseli yükler (tam boy + önizleme) ve gönderiyi oluşturur.
  Future<Post> create({
    required String imagePath,
    String? caption,
    Map<String, Object?>? music,
    bool draft = false,
  }) async {
    final media = await _api.upload('/media/post', imagePath) as Map;
    return _post(
      await _api.post(
        '/posts',
        body: {
          'mediaId': media['mediaId'],
          'thumbId': media['thumbId'],
          if (caption != null && caption.isNotEmpty) 'caption': caption,
          'music': ?music,
          'draft': draft,
        },
      ),
    );
  }

  Future<Post> get(String id) async => _post(await _api.get('/posts/$id'));

  Future<Post> publish(String id) async =>
      _post(await _api.patch('/posts/$id', body: {'publish': true}));

  Future<void> delete(String id) => _api.delete('/posts/$id');

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

  Future<PostPage> saved({String? cursor}) async =>
      _page(await _api.get('/posts/saved', query: {'cursor': ?cursor}));
}
