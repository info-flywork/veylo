import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:veylo/core/config/app_config.dart';
import 'package:veylo/data/remote/api_client.dart';

/// Sunucudan gelen anlık olay.
class SocketEvent {
  const SocketEvent(this.name, this.data);

  final String name;
  final Map<String, dynamic> data;
}

/// Tek Socket.IO bağlantısı: giriş yapınca bağlanır, çıkışta kapanır.
/// Kopunca kendiliğinden yeniden bağlanır; her bağlanışta güncel token gönderilir.
class SocketService {
  SocketService._();

  static final SocketService instance = SocketService._();

  static const _events = [
    'message:new',
    'conversation:updated',
    'conversation:read',
    'conversation:removed',
    'group:request',
    'group:approved',
    'typing',
    'presence:update',
    'tokens:updated',
  ];

  io.Socket? _socket;
  final _controller = StreamController<SocketEvent>.broadcast();

  /// Yeniden bağlanınca açık ekranlar kaçırdıklarını tamamlar (`conversation:sync`).
  final ValueNotifier<int> reconnects = ValueNotifier(0);
  final ValueNotifier<bool> connected = ValueNotifier(false);

  Stream<SocketEvent> get events => _controller.stream;

  Stream<Map<String, dynamic>> on(String name) =>
      events.where((e) => e.name == name).map((e) => e.data);

  /// [resync]: uygulama arka plandan dönünce ilk bağlantıda da [reconnects]
  /// tetiklenir, açık ekranlar kaçırdıklarını tamamlar.
  void connect({bool resync = false}) {
    if (_socket != null) return;
    final socket = io.io(
      AppConfig.apiBaseUrl,
      io.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .enableReconnection()
          .setReconnectionDelay(1000)
          .setReconnectionDelayMax(10000)
          .setAuthFn((callback) async {
            callback({'token': await _token()});
          })
          .build(),
    );
    var everConnected = resync;
    socket.onConnect((_) {
      connected.value = true;
      if (everConnected) reconnects.value++;
      everConnected = true;
    });
    socket.onDisconnect((_) => connected.value = false);
    for (final name in _events) {
      socket.on(name, (data) {
        // Sunucuda connectionStateRecovery açıkken olaya bir sıra numarası eklenir;
        // paket o zaman veriyi [veri, sıraNo] listesi olarak iletir.
        final payload = data is List && data.isNotEmpty ? data.first : data;
        if (payload is Map) {
          _controller.add(
            SocketEvent(name, Map<String, dynamic>.from(payload)),
          );
        }
      });
    }
    _socket = socket..connect();
  }

  void disconnect() {
    _socket?.dispose();
    _socket = null;
    connected.value = false;
  }

  /// Ack'li gönderim. Sunucu `{ok, data}` / `{ok:false, error}` döner.
  Future<dynamic> request(
    String event,
    Map<String, dynamic> payload, {
    Duration timeout = const Duration(seconds: 15),
  }) {
    final socket = _socket;
    if (socket == null || !socket.connected) {
      return Future.error(const ApiException(code: 'NETWORK'));
    }
    final completer = Completer<dynamic>();
    final timer = Timer(timeout, () {
      if (!completer.isCompleted) {
        completer.completeError(const ApiException(code: 'NETWORK'));
      }
    });
    socket.emitWithAck(
      event,
      payload,
      ack: (res) {
        timer.cancel();
        if (completer.isCompleted) return;
        if (res is Map && res['ok'] == true) {
          completer.complete(res['data']);
        } else {
          final err = res is Map ? res['error'] as Map? : null;
          completer.completeError(
            ApiException(
              status: 400,
              code: err?['code']?.toString() ?? 'UNKNOWN',
              message: err?['message']?.toString(),
            ),
          );
        }
      },
    );
    return completer.future;
  }

  /// Ack beklemeyen olay (ör. "yazıyor").
  void emit(String event, Map<String, dynamic> payload) =>
      _socket?.emit(event, payload);

  Future<String?> _token() async {
    if (kDebugMode && ApiClient.devUser != null) {
      return 'dev:${ApiClient.devUser}';
    }
    return FirebaseAuth.instance.currentUser?.getIdToken();
  }
}
