import 'package:veylo/data/remote/api_client.dart';

/// Boost ekranındaki bir seçenek (30 dk / 1 saat / 2 saat).
class BoostOption {
  const BoostOption({
    required this.id,
    required this.minutes,
    required this.cost,
    required this.visibility,
  });

  factory BoostOption.fromJson(Map<String, dynamic> j) => BoostOption(
    id: j['id'] as String,
    minutes: (j['minutes'] as num).toInt(),
    cost: (j['cost'] as num).toInt(),
    visibility: (j['visibility'] as num).toInt(),
  );

  final String id;
  final int minutes;
  final int cost;
  final int visibility;
}

/// Mağaza paketi (ürün id'si App Store / Play / RevenueCat ile aynı).
class TokenProduct {
  const TokenProduct({required this.id, required this.tokens});

  final String id;
  final int tokens;
}

/// `GET /tokens/boost`: bakiye, günlük ödül, aktif boost, seçenekler, paketler.
class BoostStatus {
  const BoostStatus({
    required this.balance,
    required this.checkinDay,
    required this.checkinCanCollect,
    required this.checkinReward,
    required this.rewards,
    required this.boostUntil,
    required this.boostVisibility,
    required this.options,
    required this.products,
  });

  factory BoostStatus.fromJson(Map<String, dynamic> j) {
    final checkin = Map<String, dynamic>.from(j['checkin'] as Map);
    final boost = Map<String, dynamic>.from(j['boost'] as Map);
    return BoostStatus(
      balance: (j['balance'] as num).toInt(),
      checkinDay: (checkin['day'] as num).toInt(),
      checkinCanCollect: checkin['canCollect'] == true,
      checkinReward: (checkin['reward'] as num).toInt(),
      rewards: [
        for (final r in checkin['rewards'] as List) (r as num).toInt(),
      ],
      boostUntil: boost['active'] == true
          ? DateTime.tryParse(boost['until'] as String? ?? '')?.toLocal()
          : null,
      boostVisibility: (boost['visibility'] as num?)?.toInt() ?? 0,
      options: [
        for (final o in (j['options'] as List).cast<Map>())
          BoostOption.fromJson(Map<String, dynamic>.from(o)),
      ],
      products: [
        for (final p in (j['products'] as List).cast<Map>())
          TokenProduct(
            id: p['id'] as String,
            tokens: (p['tokens'] as num).toInt(),
          ),
      ],
    );
  }

  final int balance;

  /// Vurgulanan gün (1-7): bugün toplanacak ya da toplanmış olan.
  final int checkinDay;
  final bool checkinCanCollect;
  final int checkinReward;
  final List<int> rewards;

  /// Aktif profil boost'unun bitişi (yoksa null).
  final DateTime? boostUntil;
  final int boostVisibility;
  final List<BoostOption> options;
  final List<TokenProduct> products;
}

/// Token geçmişi satırı.
class TokenHistoryItem {
  const TokenHistoryItem({
    required this.id,
    required this.delta,
    required this.balanceAfter,
    required this.reason,
    required this.meta,
    required this.createdAt,
  });

  factory TokenHistoryItem.fromJson(Map<String, dynamic> j) => TokenHistoryItem(
    id: j['id'] as String,
    delta: (j['delta'] as num).toInt(),
    balanceAfter: (j['balanceAfter'] as num).toInt(),
    reason: j['reason'] as String,
    meta: j['meta'] is Map ? Map<String, dynamic>.from(j['meta'] as Map) : const {},
    createdAt: DateTime.parse(j['createdAt'] as String).toLocal(),
  );

  final String id;
  final int delta;
  final int balanceAfter;

  /// PURCHASE, PROFILE_BOOST, DAILY_CHECKIN, CALL_GENDER_FILTER, VIDEO_CALL, ...
  final String reason;
  final Map<String, dynamic> meta;
  final DateTime createdAt;
}

/// Token uç noktaları (`/tokens`).
class TokenRepository {
  TokenRepository._();

  static final TokenRepository instance = TokenRepository._();

  final _api = ApiClient.instance;

  Future<BoostStatus> status() async => BoostStatus.fromJson(
    Map<String, dynamic>.from(await _api.get('/tokens/boost') as Map),
  );

  Future<BoostStatus> checkin() async => BoostStatus.fromJson(
    Map<String, dynamic>.from(
      await _api.post('/tokens/checkin', body: const {}) as Map,
    ),
  );

  Future<BoostStatus> boost(String option) async => BoostStatus.fromJson(
    Map<String, dynamic>.from(
      await _api.post('/tokens/boost', body: {'option': option}) as Map,
    ),
  );

  /// RevenueCat bağlanana kadar: paket ödemesiz yüklenir (sunucuda STORE_TEST_PURCHASES).
  Future<int> purchase(String productId) async {
    final res =
        await _api.post('/tokens/test-purchase', body: {'productId': productId})
            as Map;
    return (res['balance'] as num).toInt();
  }

  Future<({List<TokenHistoryItem> items, String? nextCursor})> history({
    String? cursor,
  }) async {
    final res =
        await _api.get('/tokens/history', query: {'cursor': ?cursor}) as Map;
    return (
      items: [
        for (final j in (res['items'] as List).cast<Map>())
          TokenHistoryItem.fromJson(Map<String, dynamic>.from(j)),
      ],
      nextCursor: res['nextCursor'] as String?,
    );
  }
}
