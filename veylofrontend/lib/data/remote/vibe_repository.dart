import 'package:uuid/uuid.dart';
import 'package:veylo/data/remote/api_client.dart';
import 'package:veylo/models/chat/chat_thread.dart';
import 'package:veylo/models/vibes/vibe_post.dart';

/// Vibes uç noktaları (`/vibes`).
class VibeRepository {
  VibeRepository._();

  static final VibeRepository instance = VibeRepository._();

  final _api = ApiClient.instance;
  static const _uuid = Uuid();

  Future<({List<VibePost> items, String? nextCursor})> feed({
    String? cursor,
  }) async {
    final res = await _api.get('/vibes', query: {'cursor': ?cursor}) as Map;
    return (
      items: [
        for (final j in (res['items'] as List).cast<Map>())
          VibePost.fromJson(Map<String, dynamic>.from(j)),
      ],
      nextCursor: res['nextCursor'] as String?,
    );
  }

  Future<VibePost> create({
    required String body,
    required bool anonymous,
  }) async => VibePost.fromJson(
    Map<String, dynamic>.from(
      await _api.post('/vibes', body: {'body': body, 'anonymous': anonymous})
          as Map,
    ),
  );

  Future<void> delete(String id) => _api.delete('/vibes/$id');

  Future<VibePost> setLiked(String id, bool liked) async => VibePost.fromJson(
    Map<String, dynamic>.from(
      await (liked
              ? _api.post('/vibes/$id/like')
              : _api.delete('/vibes/$id/like'))
          as Map,
    ),
  );

  /// Cevap yazara anonim mesaj isteği olarak gider; açılan sohbet döner.
  Future<ChatThread> reply(String id, String body) async => ChatThread.fromApi(
    Map<String, dynamic>.from(
      await _api.post(
            '/vibes/$id/reply',
            body: {'body': body, 'clientMsgId': _uuid.v4()},
          )
          as Map,
    ),
  );

  Future<void> report(String id, {String reason = 'OTHER', String? details}) =>
      _api.post(
        '/vibes/$id/report',
        body: {
          'reason': reason,
          if (details != null && details.isNotEmpty) 'details': details,
        },
      );
}
