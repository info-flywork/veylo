import 'package:shared_preferences/shared_preferences.dart';

/// 18+ / EULA onayı (App Store Guideline 1.2).
abstract final class EulaStore {
  static const _key = 'veylo_eula_accepted_v1';

  static Future<bool> isAccepted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_key) ?? false;
  }

  static Future<void> accept() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, true);
  }
}
