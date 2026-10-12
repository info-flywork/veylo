import 'package:veylo/data/remote/api_client.dart';

/// AI Match sonucu (sadece gerçek kullanıcılar).
class MatchCandidate {
  const MatchCandidate({
    required this.userId,
    required this.displayName,
    required this.vibePercent,
    this.avatarUrl,
    this.bio,
  });

  final String userId;
  final String displayName;
  final String? avatarUrl;
  final String? bio;
  final int vibePercent;

  factory MatchCandidate.fromJson(Map<String, dynamic> j) => MatchCandidate(
    userId: j['userId'] as String,
    displayName: (j['displayName'] ?? j['username'] ?? '') as String,
    avatarUrl: j['avatarUrl'] as String?,
    bio: j['bio'] as String?,
    vibePercent: (j['vibePercent'] as num?)?.toInt() ?? 0,
  );
}

class MatchRepository {
  MatchRepository._();

  static final MatchRepository instance = MatchRepository._();

  final _api = ApiClient.instance;

  Future<List<MatchCandidate>> search({
    required String mood,
    required String intent,
  }) async {
    final res =
        await _api.post(
              '/match/search',
              body: {'mood': mood, 'intent': intent},
            )
            as Map;
    return [
      for (final j in (res['items'] as List).cast<Map>())
        MatchCandidate.fromJson(Map<String, dynamic>.from(j)),
    ];
  }

  /// Şu an çevrimiçi kullanıcı sayısı.
  Future<int> onlineCount() async {
    final res = await _api.get('/match/stats') as Map;
    return (res['onlineCount'] as num?)?.toInt() ?? 0;
  }
}
