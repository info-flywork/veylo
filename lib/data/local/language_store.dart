import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

/// Profil > Languages'ta seçilen dil. Bildirim metinleri bu dilde gösterilir
/// (backend'e cihaz kaydıyla birlikte gönderilir).
class LanguageStore {
  LanguageStore._();

  static final LanguageStore instance = LanguageStore._();

  static const _kLanguage = 'app.language';

  /// Language sheet'teki 12 dil.
  static const supported = [
    'en', 'de', 'it', 'fr', 'tr', 'ja', 'es', 'ru', 'ko', 'hi', 'pt', 'zh', //
  ];

  /// Seçim yapılmadıysa cihaz dili (destekleniyorsa), yoksa İngilizce.
  Future<String> current() async {
    final saved = (await SharedPreferences.getInstance()).getString(_kLanguage);
    if (saved != null && supported.contains(saved)) return saved;
    final device = PlatformDispatcher.instance.locale.languageCode;
    return supported.contains(device) ? device : 'en';
  }

  Future<void> set(String code) async {
    await (await SharedPreferences.getInstance()).setString(_kLanguage, code);
  }
}
