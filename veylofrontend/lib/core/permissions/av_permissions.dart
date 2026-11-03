import 'dart:io';

import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

/// Mikrofon / kamera izni. iOS'ta doğrudan sistem API'si (AppDelegate'teki kanal):
/// permission_handler'ın Swift Package sürümü Xcode'dan derlenince izinleri sormadan
/// reddediyor. Android'de permission_handler sorunsuz.
abstract final class AvPermissions {
  static const _channel = MethodChannel('veylo/av_permissions');

  /// İzin verildiyse true. Hiç sorulmadıysa sistem penceresini açar.
  static Future<bool> microphone() => _ensure('microphone', Permission.microphone);

  static Future<bool> camera() => _ensure('camera', Permission.camera);

  static Future<void> openSettings() async {
    if (Platform.isIOS) {
      await _channel.invokeMethod<void>('openSettings');
    } else {
      await openAppSettings();
    }
  }

  static Future<bool> _ensure(String kind, Permission android) async {
    if (!Platform.isIOS) {
      final status = await android.request();
      return status.isGranted || status.isLimited;
    }
    final status = await _channel.invokeMethod<String>('status', kind);
    if (status == 'granted') return true;
    if (status == 'denied') return false; // iOS bir daha sormaz: Ayarlar gerekir.
    return await _channel.invokeMethod<bool>('request', kind) ?? false;
  }
}
