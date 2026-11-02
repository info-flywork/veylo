import 'package:veylo/data/remote/api_client.dart';

/// AI Match sonucu (sadece gerçek kullanıcılar).
class MatchCandidate {
  const MatchCandidate({
    required this.userId,
    required this.displayName,
    required this.vibePercent,
    this.avatarUrl,
    this.bio,
    this.age,
  });

  final String userId;
  final String displayName;
  final String? avatarUrl;
  final String? bio;
  final int vibePercent;

  /// Sunucu doğum tarihi tutmadığı için şimdilik hep null.
  final int? age;

  factory MatchCandidate.fromJson(Map<String, dynamic> j) => MatchCandidate(
    userId: j['userId'] as String,
    displayName: (j['displayName'] ?? j['username'] ?? '') as String,
    avatarUrl: j['avatarUrl'] as String?,
    bio: j['bio'] as String?,
    vibePercent: (j['vibePercent'] as num?)?.toInt() ?? 0,
    age: (j['age'] as num?)?.toInt(),
  );
}

/// `/match/stats`: oran ve süre, henüz arama yapılmadıysa null.
class MatchStats {
  const MatchStats({
    required this.onlineCount,
    this.matchRatePercent,
    this.avgResponseMs,
  });

  final int onlineCount;
  final int? matchRatePercent;
  final int? avgResponseMs;
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

  /// AI Match istatistikleri: çevrimiçi sayısı, eşleşme oranı, ortalama süre.
  Future<MatchStats> stats() async {
    final res = await _api.get('/match/stats') as Map;
    return MatchStats(
      onlineCount: (res['onlineCount'] as num?)?.toInt() ?? 0,
      matchRatePercent: (res['matchRatePercent'] as num?)?.toInt(),
      avgResponseMs: (res['avgResponseMs'] as num?)?.toInt(),
    );
  }
}
