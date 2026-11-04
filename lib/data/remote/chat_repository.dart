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
    final res =
        await _api.get('/conversations', query: {'box': box}, cache: true)
            as Map;
    return _threads(res);
  }

  /// Diskteki son liste (açılışta anında göstermek için).
  Future<List<ChatThread>?> cachedList({String box = 'inbox'}) async {
    try {
      final res = await _api.cached('/conversations', query: {'box': box});
      return res is Map ? _threads(res) : null;
    } catch (_) {
      return null;
    }
  }

  List<ChatThread> _threads(Map res) => [
    for (final j in (res['items'] as List).cast<Map>())
      ChatThread.fromApi(Map<String, dynamic>.from(j)),
  ];

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
              // Son sayfa diske: sohbet açılınca mesajlar beklemeden görünür.
              cache: beforeSeq == null && afterSeq == null,
            )
            as Map;
    return _messagePage(res);
  }

  /// Diskteki son mesaj sayfası.
  Future<List<ChatMessage>?> cachedMessages(String id, {int limit = 30}) async {
    try {
      final res = await _api.cached(
        '/conversations/$id/messages',
        query: {'limit': '$limit'},
      );
      return res is Map ? _messagePage(res).items : null;
    } catch (_) {
      return null;
    }
  }

  ({List<ChatMessage> items, bool hasMore}) _messagePage(Map res) {
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

  /// Anonim sohbet (AI Match): karşı tarafa mesaj isteği olarak düşer.
  Future<ChatThread> createAnonymous(String userId) async => ChatThread.fromApi(
    Map<String, dynamic>.from(
      await _api.post('/conversations/anonymous', body: {'userId': userId})
          as Map,
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

  Future<void> setMuted(String id, bool muted) =>
      _api.patch('/conversations/$id/settings', body: {'muted': muted});

  /// Anonim sohbette karşı tarafın id'si bilinmediği için sohbet üzerinden.
  Future<void> blockPeer(String id) => _api.post('/conversations/$id/block');

  /// reason: HARASSMENT | HATE_SPEECH | NUDITY | UNDERAGE | SPAM | SCAM | VIOLENCE | IMPERSONATION | OTHER
  Future<void> reportPeer(
    String id, {
    required String reason,
    String? details,
    bool alsoBlock = false,
    String? messageId,
  }) => _api.post(
    '/conversations/$id/report',
    body: {
      'reason': reason,
      if (details != null && details.isNotEmpty) 'details': details,
      'alsoBlock': alsoBlock,
      'messageId': ?messageId,
    },
  );

  /// Kendi mesajımı herkes için geri alır.
  Future<void> deleteMessage(String id, String messageId) =>
      _api.delete('/conversations/$id/messages/$messageId');

  /// Kendi TEXT mesajını düzenler.
  Future<ChatMessage> editMessage(String id, String messageId, String body) async {
    final res = await _api.patch(
      '/conversations/$id/messages/$messageId',
      body: {'body': body},
    );
    return ChatMessage.fromJson(Map<String, dynamic>.from(res as Map));
  }

  /// Mesaja emoji tepkisi ekler / kaldırır.
  Future<List<ChatReaction>> reactMessage(
    String id,
    String messageId,
    String emoji,
  ) async {
    final res = await _api.post(
      '/conversations/$id/messages/$messageId/reactions',
      body: {'emoji': emoji},
    );
    final map = Map<String, dynamic>.from(res as Map);
    return [
      for (final r in (map['reactions'] as List? ?? const []))
        if (r is Map) ChatReaction.fromJson(Map<String, dynamic>.from(r)),
    ];
  }
}
