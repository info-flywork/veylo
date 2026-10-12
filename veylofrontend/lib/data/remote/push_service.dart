import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veylo/core/i18n/notification_texts.dart';
import 'package:veylo/data/local/language_store.dart';
import 'package:veylo/data/remote/api_client.dart';
import 'package:veylo/data/remote/chat_store.dart';
import 'package:veylo/data/remote/socket_service.dart';
import 'package:veylo/models/chat/chat_thread.dart';

/// Bildirimler iki yoldan gelir:
/// - Uygulama açıkken: socket `message:new` → yerel bildirim (flutter_local_notifications).
/// - Uygulama arka planda/kapalıyken: backend FCM push gönderir (socket kopuk olduğu için).
/// Dokunulan bildirimin sohbet id'si [taps] ile ana ekrana iletilir.
class PushService {
  PushService._();

  static final PushService instance = PushService._();

  /// Backend'deki ANDROID_CHANNEL_ID ve AndroidManifest ile aynı.
  static const _channelId = 'messages';

  /// Ayarlar > Bildirimler anahtarı.
  static const _kEnabled = 'push.enabled';

  final _messaging = FirebaseMessaging.instance;
  final _local = FlutterLocalNotificationsPlugin();
  final _api = ApiClient.instance;
  final _taps = StreamController<String>.broadcast();
  final List<StreamSubscription<dynamic>> _subs = [];

  String? _pendingTap;
  String? _token;
  String _language = 'en';
  bool _started = false;

  /// Bildirime dokunulunca açılacak sohbet id'si.
  Stream<String> get taps => _taps.stream;

  /// Uygulama bildirime dokunularak açıldıysa (ana ekran hazır olunca bir kez okunur).
  String? takePendingTap() {
    final id = _pendingTap;
    _pendingTap = null;
    return id;
  }

  /// main(): Firebase'den hemen sonra. İzin istemez.
  Future<void> init() async {
    _language = await LanguageStore.instance.current();
    await _local.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(
          requestAlertPermission: false,
          requestSoundPermission: false,
          requestBadgePermission: false,
        ),
      ),
      onDidReceiveNotificationResponse: (r) => _onTap(r.payload),
    );
    await _createAndroidChannel();

    final launch = await _local.getNotificationAppLaunchDetails();
    if (launch?.didNotificationLaunchApp == true) {
      _pendingTap = launch!.notificationResponse?.payload;
    }
    final initial = await _messaging.getInitialMessage();
    if (initial != null) {
      _pendingTap = initial.data['conversationId'] as String?;
    }

    FirebaseMessaging.onMessageOpenedApp.listen(
      (m) => _onTap(m.data['conversationId'] as String?),
    );
    FirebaseMessaging.onMessage.listen(_onForegroundPush);
  }

  Future<bool> isEnabled() async =>
      (await SharedPreferences.getInstance()).getBool(_kEnabled) ?? true;

  /// Kapatınca cihaz kaydı silinir (push gelmez) ve uygulama içi bildirimler durur.
  Future<void> setEnabled(bool enabled) async {
    await (await SharedPreferences.getInstance()).setBool(_kEnabled, enabled);
    if (enabled) {
      await start();
    } else {
      await stop();
    }
  }

  /// Girişten sonra: izin ister, cihazı backend'e kaydeder, socket mesajlarını dinler.
  Future<void> start() async {
    if (_started || !await isEnabled()) return;
    _started = true;
    _subs
      ..add(SocketService.instance.on('message:new').listen(_onSocketMessage))
      // Yöneticiyim: gizli grubuma katılma isteği geldi.
      ..add(
        SocketService.instance.on('group:request').listen((e) {
          final t = NotificationTexts.of(_language);
          _show(
            conversationId: e['conversationId'] as String? ?? '',
            title: t.groupRequestTitle(e['title'] as String? ?? ''),
            body: t.groupRequestBody(e['name'] as String? ?? '?'),
          );
        }),
      );
    try {
      final settings = await _messaging.requestPermission();
      if (settings.authorizationStatus == AuthorizationStatus.denied) {
        debugPrint('Push: bildirim izni verilmedi');
        return;
      }
      // iOS'ta FCM token'ı APNs token'ı gelmeden alınamaz.
      if (Platform.isIOS) {
        for (
          var i = 0;
          i < 10 && await _messaging.getAPNSToken() == null;
          i++
        ) {
          await Future<void>.delayed(const Duration(seconds: 1));
        }
        if (await _messaging.getAPNSToken() == null) {
          debugPrint('Push: APNs token alınamadı');
          return;
        }
      }
      final token = await _messaging.getToken();
      if (token != null) await _register(token);
      debugPrint('Push: cihaz kaydı ${token != null ? 'tamam' : 'token yok'}');
      _subs.add(_messaging.onTokenRefresh.listen(_register));
    } catch (e) {
      debugPrint('Push kaydı yapılamadı: $e');
    }
  }

  /// Çıkışta (Firebase oturumu kapanmadan önce): cihaz kaydını siler.
  Future<void> stop() async {
    for (final s in _subs) {
      s.cancel();
    }
    _subs.clear();
    _started = false;
    final token = _token;
    _token = null;
    if (token == null) return;
    try {
      await _api
          .delete('/users/me/devices', body: {'token': token})
          .timeout(const Duration(seconds: 5));
      await _messaging.deleteToken();
    } catch (_) {
      // Kayıt kalırsa bir sonraki girişte token yeni kullanıcıya taşınır.
    }
  }

  /// Profil > Languages değişince bildirim dili de değişir.
  Future<void> setLanguage(String code) async {
    _language = code;
    await LanguageStore.instance.set(code);
    await _createAndroidChannel();
    final token = _token;
    if (token != null) await _register(token);
  }

  Future<void> _register(String token) async {
    _token = token;
    try {
      await _api.post(
        '/users/me/devices',
        body: {
          'token': token,
          'platform': Platform.isIOS ? 'ios' : 'android',
          'locale': _language,
        },
      );
    } catch (e) {
      debugPrint('Cihaz kaydedilemedi: $e');
    }
  }

  Future<void> _createAndroidChannel() async {
    await _local
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(
          AndroidNotificationChannel(
            _channelId,
            NotificationTexts.of(_language).channelName,
            importance: Importance.high,
          ),
        );
  }

  void _onTap(String? conversationId) {
    if (conversationId == null || conversationId.isEmpty) return;
    if (_taps.hasListener) {
      _taps.add(conversationId);
    } else {
      _pendingTap = conversationId;
    }
  }

  /// Uygulama açıkken socket'ten gelen mesaj: o sohbet ekranda değilse bildir.
  void _onSocketMessage(Map<String, dynamic> e) {
    final message = e['message'];
    final rawConversation = e['conversation'];
    if (message is! Map || rawConversation is! Map) return;
    if (message['isMine'] == true) return;
    final thread = ChatThread.fromApi(
      Map<String, dynamic>.from(rawConversation),
    );
    if (thread.muted || thread.id == ChatStore.instance.activeConversationId) {
      return;
    }

    final t = NotificationTexts.of(_language);
    final body = switch (message['type']) {
      'IMAGE' => t.photo,
      'VOICE' => t.voice,
      _ => (message['body'] as String?) ?? '',
    };
    final sender = (message['sender'] as Map?)?['displayName'] as String?;
    final title = thread.isGroup && sender != null
        ? '$sender · ${thread.title}'
        : thread.title;
    _show(
      conversationId: thread.id,
      title: thread.isStrangerRequest ? t.messageRequestTitle : title,
      body: thread.isStrangerRequest
          ? t.messageRequestBody(thread.title)
          : body,
    );
  }

  /// Uygulama açıkken FCM gelirse (socket o an kopuksa) yerel bildirim olarak göster.
  /// iOS'ta sistem bunu zaten gösterir (AppDelegate willPresent).
  void _onForegroundPush(RemoteMessage m) {
    if (Platform.isIOS || SocketService.instance.connected.value) return;
    final conversationId = m.data['conversationId'] as String?;
    if (conversationId == ChatStore.instance.activeConversationId) return;
    final n = m.notification;
    if (n == null) return;
    _show(
      conversationId: conversationId ?? '',
      title: n.title ?? '',
      body: n.body ?? '',
    );
  }

  Future<void> _show({
    required String conversationId,
    required String title,
    required String body,
  }) {
    return _local.show(
      id: conversationId.hashCode & 0x7fffffff,
      title: title,
      body: body,
      payload: conversationId,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          NotificationTexts.of(_language).channelName,
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBanner: true,
          presentList: true,
          presentSound: true,
          threadIdentifier: conversationId,
        ),
      ),
    );
  }
}
