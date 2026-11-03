import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:veylo/data/remote/agora_service.dart';
import 'package:veylo/data/remote/room_repository.dart';
import 'package:veylo/data/remote/room_store.dart';
import 'package:veylo/data/remote/socket_service.dart';

/// Küçültülmüş canlı oda (YouTube PiP). Agora/socket oturumu sayfa kapalıyken de sürer.
class RoomPipStore extends ChangeNotifier {
  RoomPipStore._() {
    final socket = SocketService.instance;
    _subs.add(socket.on('room:ended').listen(_onEnded));
    _subs.add(socket.on('room:kicked').listen(_onKicked));
    socket.reconnects.addListener(_rejoin);
  }

  static final RoomPipStore instance = RoomPipStore._();

  final _repo = RoomRepository.instance;
  final _agora = AgoraService.instance;
  final List<StreamSubscription<Map<String, dynamic>>> _subs = [];

  String? roomId;
  String title = '';
  bool isHost = false;
  bool anonymous = false;

  /// Sağ altta baloncuk görünür mü.
  bool get visible => roomId != null;

  /// Küçültülüyken oda bitti / atıldık — UI snackbar + rooms'a gitsin.
  bool pendingRemoteExit = false;
  bool pendingWasKick = false;

  void show({
    required String roomId,
    required String title,
    required bool isHost,
    required bool anonymous,
  }) {
    this.roomId = roomId;
    this.title = title;
    this.isHost = isHost;
    this.anonymous = anonymous;
    pendingRemoteExit = false;
    pendingWasKick = false;
    notifyListeners();
  }

  /// Odaya geri dönülürken baloncuğu kaldır (oturum Agora'da kalır).
  void hideBubble() {
    if (roomId == null) return;
    roomId = null;
    title = '';
    isHost = false;
    anonymous = false;
    notifyListeners();
  }

  bool takePendingRemoteExit() {
    if (!pendingRemoteExit) return false;
    pendingRemoteExit = false;
    return true;
  }

  Future<void> closeAndLeave({required bool endRoom}) async {
    final id = roomId;
    if (id == null) return;
    final host = isHost;
    hideBubble();
    try {
      if (endRoom && host) {
        await _repo.end(id);
      } else {
        await _repo.leave(id);
      }
    } catch (_) {}
    await _agora.leave();
    RoomStore.instance.refresh();
  }

  void _onEnded(Map<String, dynamic> e) {
    if (e['roomId'] != roomId) return;
    pendingRemoteExit = true;
    pendingWasKick = false;
    hideBubble();
    _agora.leave();
    RoomStore.instance.refresh();
  }

  void _onKicked(Map<String, dynamic> e) {
    if (e['roomId'] != roomId) return;
    pendingRemoteExit = true;
    pendingWasKick = true;
    hideBubble();
    _agora.leave();
    RoomStore.instance.refresh();
  }

  void _rejoin() {
    final id = roomId;
    if (id == null) return;
    _repo.join(id, anonymous: anonymous).then((s) {
      return _agora.join(s.rtc, micOn: s.me.micOn);
    }).ignore();
  }
}
