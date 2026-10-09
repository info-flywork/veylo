import 'package:veylo/data/remote/api_client.dart';
import 'package:veylo/models/chat/chat_message.dart';
import 'package:veylo/models/chat/chat_thread.dart';

/// Sohbet REST uç noktaları (`/conversations`).
class ChatRepository {
  ChatRepository._();

  static final ChatRepository instance = ChatRepository._();

  final _api = ApiClient.instance;

  /// box: inbox | requests
  Future<List<ChatThread>> list({String box = 'inbox'}) async {
    final res = await _api.get('/conversations', query: {'box': box}) as Map;
    return [
      for (final j in (res['items'] as List).cast<Map>())
        ChatThread.fromApi(Map<String, dynamic>.from(j)),
    ];
  }

  Future<ChatThread> get(String id) async => ChatThread.fromApi(
    Map<String, dynamic>.from(await _api.get('/conversations/$id') as Map),
  );

  /// Son mesajlar ([beforeSeq] ile daha eskiler, [afterSeq] ile kaçırılanlar).
  Future<({List<ChatMessage> items, bool hasMore})> messages(
    String id, {
    int? beforeSeq,
    int? afterSeq,
    int limit = 30,
  }) async {
    final res =
        await _api.get(
              '/conversations/$id/messages',
              query: {
                'limit': '$limit',
                if (beforeSeq != null) 'beforeSeq': '$beforeSeq',
                if (afterSeq != null) 'afterSeq': '$afterSeq',
              },
            )
            as Map;
    return (
      items: [
        for (final j in (res['items'] as List).cast<Map>())
          ChatMessage.fromJson(Map<String, dynamic>.from(j)),
      ],
      hasMore: res['hasMore'] as bool? ?? false,
    );
  }

  Future<ChatThread> createDirect(String userId) async => ChatThread.fromApi(
    Map<String, dynamic>.from(
      await _api.post('/conversations/direct', body: {'userId': userId}) as Map,
    ),
  );

  Future<ChatThread> approve(String id) async => ChatThread.fromApi(
    Map<String, dynamic>.from(
      await _api.post('/conversations/$id/approve') as Map,
    ),
  );

  Future<void> reject(String id) => _api.post('/conversations/$id/reject');

  Future<ChatThread> reveal(String id) async => ChatThread.fromApi(
    Map<String, dynamic>.from(
      await _api.post('/conversations/$id/reveal') as Map,
    ),
  );

  Future<void> deleteForMe(String id) => _api.delete('/conversations/$id');

  Future<void> deleteAll() => _api.delete('/conversations');

  Future<void> setPinned(String id, bool pinned) =>
      _api.patch('/conversations/$id/settings', body: {'pinned': pinned});

  /// Anonim sohbette karşı tarafın id'si bilinmediği için sohbet üzerinden.
  Future<void> blockPeer(String id) => _api.post('/conversations/$id/block');

  /// reason: HARASSMENT | HATE_SPEECH | NUDITY | UNDERAGE | SPAM | SCAM | VIOLENCE | IMPERSONATION | OTHER
  Future<void> reportPeer(
    String id, {
    required String reason,
    String? details,
    bool alsoBlock = false,
  }) => _api.post(
    '/conversations/$id/report',
    body: {
      'reason': reason,
      if (details != null && details.isNotEmpty) 'details': details,
      'alsoBlock': alsoBlock,
    },
  );
}
