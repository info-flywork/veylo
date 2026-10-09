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
    if (!isRealUser(userId)) return;
    await _api.post(
      '/safety/blocks',
      body: {'userId': userId, 'type': 'RESTRICT'},
    );
  }

  Future<void> unblock(String userId) => _api.delete('/safety/blocks/$userId');

  /// Ekranda neden listesi olmadığı için serbest metin "OTHER" olarak gönderilir.
  Future<void> report({
    String? userId,
    String? conversationId,
    String reason = 'OTHER',
    String? details,
  }) async {
    if (conversationId != null) {
      return ChatRepository.instance.reportPeer(
        conversationId,
        reason: reason,
        details: details,
      );
    }
    if (!isRealUser(userId)) return;
    await _api.post(
      '/safety/reports',
      body: {
        'targetUserId': userId,
        'context': 'PROFILE',
        'reason': reason,
        if (details != null && details.isNotEmpty) 'details': details,
      },
    );
  }
}
