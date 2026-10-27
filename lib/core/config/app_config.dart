import 'dart:io';

import 'package:flutter/foundation.dart';

/// Ortam ayarları. Farklı bir makinede:
/// `flutter run --dart-define=API_BASE_URL=http://192.168.1.20:4000`
abstract final class AppConfig {
  static const _apiOverride = String.fromEnvironment('API_BASE_URL');

  /// TODO: sunucu adresi belli olunca güncellenecek.
  static const _productionApi = 'https://api.veylo.app';

  /// Fiziksel iPhone `localhost`'u kendisi sanır. Mac bu adla aynı ağda dinliyor.
  static const _iosDevApi = 'http://flywork-MacBook-Air-2.local:4000';

  static String get apiBaseUrl {
    if (_apiOverride.isNotEmpty) return _apiOverride;
    if (kReleaseMode) return _productionApi;
    // Android emülatörü bilgisayarın localhost'una 10.0.2.2 ile ulaşır.
    if (Platform.isAndroid) return 'http://10.0.2.2:4000';
    if (Platform.isIOS) return _iosDevApi;
    return 'http://localhost:4000';
  }

  static String get apiUrl => '$apiBaseUrl/api/v1';

  /// Firebase "Web client ID" — Android'de Google girişi ID token almak için gerekli (gizli değil).
  static const googleServerClientId =
      '619173059299-qd0o6eji37no6q7me3ugo4qnr1vdl7jd.apps.googleusercontent.com';
}

/// Backend'deki TOKENS ile aynı (fiyatlar sunucuda uygulanır; burada sadece gösterim).
abstract final class TokenCosts {
  static const callGenderFilter = 10;
  static const videoCallPer15Min = 20;
  static const roomCreate = 50;
}
