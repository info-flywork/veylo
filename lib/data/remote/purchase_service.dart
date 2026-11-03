import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:veylo/core/config/app_config.dart';
import 'package:veylo/data/remote/api_client.dart';
import 'package:veylo/data/remote/session_store.dart';
import 'package:veylo/data/remote/socket_service.dart';
import 'package:veylo/data/remote/token_repository.dart';

/// Kullanıcı iptal etti; hata snackbar gösterilmez.
class PurchaseCancelled implements Exception {
  const PurchaseCancelled();
}

/// RevenueCat: paket listesi + satın alma. Bakiye webhook ile sunucuda artar.
class PurchaseService {
  PurchaseService._();

  static final PurchaseService instance = PurchaseService._();

  bool _configured = false;
  String? _loggedInUserId;

  Future<void> configure() async {
    if (_configured || kIsWeb) return;
    final key = Platform.isIOS
        ? AppConfig.revenueCatAppleApiKey
        : AppConfig.revenueCatGoogleApiKey;
    if (key.isEmpty) {
      debugPrint('RevenueCat: bu platform için API key yok');
      return;
    }
    if (kDebugMode) await Purchases.setLogLevel(LogLevel.debug);
    await Purchases.configure(PurchasesConfiguration(key));
    _configured = true;
  }

  /// Backend user id (UUID). Webhook bu id ile bakiyeyi bulur.
  Future<void> logIn(String userId) async {
    await configure();
    if (!_configured || userId.isEmpty || userId == _loggedInUserId) return;
    await Purchases.logIn(userId);
    _loggedInUserId = userId;
  }

  Future<void> logOut() async {
    if (!_configured) return;
    try {
      await Purchases.logOut();
    } catch (_) {}
    _loggedInUserId = null;
  }

  /// Offering paketleri; product id → fiyat + Package.
  Future<List<StoreTokenPack>> loadPacks({
    List<TokenProduct> catalog = const [],
  }) async {
    await configure();
    if (!_configured) {
      return [
        for (final p in catalog)
          StoreTokenPack(productId: p.id, tokens: p.tokens, priceLabel: null),
      ];
    }
    final offerings = await Purchases.getOfferings();
    final packages = offerings.current?.availablePackages ?? const <Package>[];
    final byId = {
      for (final pkg in packages) pkg.storeProduct.identifier: pkg,
    };

    // Katalog sırasını koru; RevenueCat'te olanlara gerçek fiyat yaz.
    if (catalog.isNotEmpty) {
      return [
        for (final p in catalog)
          StoreTokenPack(
            productId: p.id,
            tokens: p.tokens,
            priceLabel: byId[p.id]?.storeProduct.priceString,
            package: byId[p.id],
          ),
      ];
    }
    return [
      for (final pkg in packages)
        StoreTokenPack(
          productId: pkg.storeProduct.identifier,
          tokens: _tokensFor(pkg.storeProduct.identifier),
          priceLabel: pkg.storeProduct.priceString,
          package: pkg,
        ),
    ];
  }

  int _tokensFor(String productId) => switch (productId) {
        'veylo.tokens.100' => 100,
        'veylo.tokens.400' => 400,
        'veylo.tokens.1000' => 1000,
        _ => 0,
      };

  /// Mağazadan satın alır; webhook bakiyeyi yazınca güncel bakiyeyi döner.
  Future<int> purchase(StoreTokenPack pack) async {
    await configure();
    final me = SessionStore.instance.me;
    if (me != null) await logIn(me.id);

    final pkg = pack.package;
    if (pkg == null) {
      throw const ApiException(code: 'PRODUCT_UNAVAILABLE');
    }

    final before = me?.tokenBalance ?? 0;
    final waitBalance = _waitPurchaseBalance(before);

    try {
      await Purchases.purchase(PurchaseParams.package(pkg));
    } on PlatformException catch (e) {
      final code = PurchasesErrorHelper.getErrorCode(e);
      if (code == PurchasesErrorCode.purchaseCancelledError) {
        throw const PurchaseCancelled();
      }
      rethrow;
    }

    return waitBalance;
  }

  Future<void> restore() async {
    await configure();
    if (!_configured) return;
    final me = SessionStore.instance.me;
    if (me != null) await logIn(me.id);
    await Purchases.restorePurchases();
    await SessionStore.instance.refreshMe();
  }

  /// Webhook `tokens:updated` gelsin diye kısa süre dinler; gelmezse me yenilenir.
  Future<int> _waitPurchaseBalance(int before) async {
    final done = Completer<int>();
    late final StreamSubscription<Map<String, dynamic>> sub;
    sub = SocketService.instance.on('tokens:updated').listen((e) {
      if (e['reason'] != 'PURCHASE') return;
      final balance = (e['balance'] as num?)?.toInt();
      if (balance == null || done.isCompleted) return;
      done.complete(balance);
    });

    try {
      final balance = await done.future.timeout(const Duration(seconds: 12));
      SessionStore.instance.updateTokenBalance(balance);
      return balance;
    } on TimeoutException {
      // Webhook gecikirse birkaç kez me çek.
      for (var i = 0; i < 6; i++) {
        await Future<void>.delayed(const Duration(milliseconds: 800));
        await SessionStore.instance.refreshMe();
        final bal = SessionStore.instance.me?.tokenBalance ?? before;
        if (bal > before) return bal;
      }
      return SessionStore.instance.me?.tokenBalance ?? before;
    } finally {
      await sub.cancel();
    }
  }
}

class StoreTokenPack {
  const StoreTokenPack({
    required this.productId,
    required this.tokens,
    this.priceLabel,
    this.package,
  });

  final String productId;
  final int tokens;
  final String? priceLabel;
  final Package? package;
}
