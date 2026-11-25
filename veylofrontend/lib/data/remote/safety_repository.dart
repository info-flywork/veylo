import 'package:veylo/data/remote/api_client.dart';
import 'package:veylo/data/remote/chat_repository.dart';

/// Engelle / kısıtla / raporla. [conversationId] verilirse işlem sohbet üzerinden yapılır
/// (anonim sohbette istemci karşı tarafın kullanıcı id'sini bilmez).
class SafetyRepository {
  SafetyRepository._();

  static final SafetyRepository instance = SafetyRepository._();

  final _api = ApiClient.instance;

  static final _uuid = RegExp(
    r'^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$',
  );

  /// Backend kullanıcısı mı (Keşfet gibi henüz sahte veriyle çalışan ekranlardaki profiller değil).
  static bool isRealUser(String? id) => id != null && _uuid.hasMatch(id);

  Future<void> block({String? userId, String? conversationId}) async {
    if (conversationId != null) {
      return ChatRepository.instance.blockPeer(conversationId);
    }
    if (!isRealUser(userId)) return;
    await _api.post(
      '/safety/blocks',
      body: {'userId': userId, 'type': 'BLOCK'},
    );
  }

  Future<void> restrict(String? userId) async {
    // Örnek profilde başarı taklidi yapılmaz.
    if (!isRealUser(userId)) throw const ApiException(status: 404, code: 'PEER_UNAVAILABLE');
    await _api.post(
      '/safety/blocks',
      body: {'userId': userId, 'type': 'RESTRICT'},
    );
  }

  Future<void> unblock(String userId) => _api.delete('/safety/blocks/$userId');

  /// Engellenen kullanıcı listesi (`GET /safety/blocks`).
  Future<List<BlockedUserEntry>> listBlocks() async {
    final res = await _api.get('/safety/blocks');
    final items = (res as Map)['items'] as List? ?? const [];
    return [
      for (final raw in items)
        if (raw is Map)
          BlockedUserEntry.fromJson(Map<String, dynamic>.from(raw)),
    ];
  }

  /// Bildirim nedenleri — backend `ReportReason` enum'u ile aynı sıra.
  static const reportReasons = [
    'HARASSMENT',
    'HATE_SPEECH',
    'NUDITY',
    'UNDERAGE',
    'SPAM',
    'SCAM',
    'VIOLENCE',
    'IMPERSONATION',
    'OTHER',
  ];

  /// [context]: PROFILE | CHAT | CALL | ROOM | GROUP | POST | VIBE
  /// [reason]: [reportReasons] değerlerinden biri.
  Future<void> report({
    String? userId,
    String? conversationId,
    String reason = 'OTHER',
    String? details,
    String context = 'PROFILE',
    String? contentId,
  }) async {
    // Sohbet üzerinden mesaj şikayeti (messageId = contentId).
    if (conversationId != null && contentId != null) {
      return ChatRepository.instance.reportPeer(
        conversationId,
        reason: reason,
        details: details,
        messageId: contentId,
      );
    }
    if (conversationId != null && contentId == null && context == 'CHAT') {
      return ChatRepository.instance.reportPeer(
        conversationId,
        reason: reason,
        details: details,
      );
    }
    if (!isRealUser(userId)) {
      throw const ApiException(status: 404, code: 'PEER_UNAVAILABLE');
    }
    await _api.post(
      '/safety/reports',
      body: {
        'targetUserId': userId,
        'context': context,
        'reason': reason,
        if (details != null && details.isNotEmpty) 'details': details,
        if (conversationId != null) 'conversationId': conversationId,
        if (contentId != null) 'contentId': contentId,
      },
    );
  }
}

class BlockedUserEntry {
  const BlockedUserEntry({
    required this.type,
    required this.anonymous,
    this.userId,
    this.username,
    this.displayName,
    this.avatarUrl,
  });

  final String type;
  final bool anonymous;
  final String? userId;
  final String? username;
  final String? displayName;
  final String? avatarUrl;

  bool get isBlock => type == 'BLOCK';

  factory BlockedUserEntry.fromJson(Map<String, dynamic> j) {
    final user = j['user'];
    final map = user is Map ? Map<String, dynamic>.from(user) : null;
    return BlockedUserEntry(
      type: j['type'] as String? ?? 'BLOCK',
      anonymous: j['anonymous'] == true,
      userId: j['userId'] as String? ?? map?['id'] as String?,
      username: map?['username'] as String?,
      displayName: map?['displayName'] as String?,
      avatarUrl: map?['avatarUrl'] as String?,
    );
  }
}
