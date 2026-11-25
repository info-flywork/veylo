/// Ortam ayarları — canlı API.
abstract final class AppConfig {
  static const apiBaseUrl = 'https://veylo.fly-work.com';

  static String get apiUrl => '$apiBaseUrl/api/v1';

  /// Firebase "Web client ID" — Android'de Google girişi ID token almak için gerekli (gizli değil).
  static const googleServerClientId =
      '619173059299-qd0o6eji37no6q7me3ugo4qnr1vdl7jd.apps.googleusercontent.com';

  /// RevenueCat public SDK key (Apple). Gizli anahtar değil.
  static const revenueCatAppleApiKey =
      'appl_XgBEKbKfrANGtpsSKDNYHRNWWMc';

  /// Android Play için: `flutter run --dart-define=REVENUECAT_GOOGLE_API_KEY=goog_...`
  static const revenueCatGoogleApiKey = String.fromEnvironment(
    'REVENUECAT_GOOGLE_API_KEY',
  );

  /// Story GIF sheet — key gerektirmeyen public API.
  static const gifApiBaseUrl = 'https://gifsnap.com/api/v1';
}

/// Backend'deki TOKENS ile aynı (fiyatlar sunucuda uygulanır; burada sadece gösterim).
abstract final class TokenCosts {
  static const callGenderFilter = 10;
  static const videoCallPer15Min = 20;
  static const roomCreate = 50;
}
