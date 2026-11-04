import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

/// Liste ekranlarının son sunucu cevabı (ham JSON) diskte, kullanıcıya özel.
/// Ekran açılınca önce bununla dolar, taze veri gelince yerine geçer.
class ResponseCache {
  ResponseCache._();

  static final ResponseCache instance = ResponseCache._();

  /// Giriş yapan kullanıcı; çıkışta null. Başka hesabın verisi görünmesin.
  String? userId;

  Directory? _root;

  Future<File?> _file(String key) async {
    final uid = userId;
    if (uid == null || uid.isEmpty) return null;
    _root ??= Directory(
      '${(await getApplicationSupportDirectory()).path}/api_cache',
    );
    final dir = Directory('${_root!.path}/$uid');
    if (!await dir.exists()) await dir.create(recursive: true);
    return File('${dir.path}/${Uri.encodeComponent(key)}.json');
  }

  Future<Object?> read(String key) async {
    try {
      final f = await _file(key);
      if (f == null || !await f.exists()) return null;
      return jsonDecode(await f.readAsString());
    } catch (_) {
      return null;
    }
  }

  Future<void> write(String key, Object? data) async {
    try {
      final f = await _file(key);
      if (f == null) return;
      await f.writeAsString(jsonEncode(data), flush: false);
    } catch (_) {}
  }

  /// Çıkışta tüm hesapların önbelleği silinir.
  Future<void> clear() async {
    userId = null;
    try {
      final root =
          _root ??
          Directory('${(await getApplicationSupportDirectory()).path}/api_cache');
      if (await root.exists()) await root.delete(recursive: true);
    } catch (_) {}
  }
}
