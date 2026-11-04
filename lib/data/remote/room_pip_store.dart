import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:veylo/data/remote/agora_service.dart';
import 'package:veylo/data/remote/room_repository.dart';
import 'package:veylo/data/remote/room_store.dart';
import 'package:veylo/data/remote/socket_service.dart';
import 'package:veylo/models/room/live_room.dart';

/// Küçültülmüş canlı oda (HelloTalk tarzı mini kart). Agora/socket oturumu sürer.
class RoomPipStore extends ChangeNotifier {
  RoomPipStore._() {
    final socket = SocketService.instance;
    _subs.add(socket.on('room:ended').listen(_onEnded));
    _subs.add(socket.on('room:kicked').listen(_onKicked));
    _subs.add(socket.on('room:participant_joined').listen(_onJoined));
    _subs.add(socket.on('room:participant_updated').listen(_onUpdated));
    _subs.add(socket.on('room:participant_left').listen(_onLeft));
    socket.reconnects.addListener(_rejoin);
    _agora.speaking.addListener(_onSpeaking);
  }

  static final RoomPipStore instance = RoomPipStore._();

  final _repo = RoomRepository.instance;
  final _agora = AgoraService.instance;
  final List<StreamSubscription<Map<String, dynamic>>> _subs = [];

  String? roomId;
  String title = '';
  bool isHost = false;
  bool anonymous = false;
  List<RoomParticipant> participants = const [];

  /// Sağ altta baloncuk görünür mü.
  bool get visible => roomId != null;

  /// Küçültülüyken oda bitti / atıldık — UI snackbar + rooms'a gitsin.
  bool pendingRemoteExit = false;
  bool pendingWasKick = false;

  /// Konuşan varsa o; yoksa host; yoksa ilk katılımcı.
  RoomParticipant? get featured {
    if (participants.isEmpty) return null;
    final speaking = _agora.speaking.value;
    for (final p in participants) {
      if (speaking.contains(p.uid)) return p;
    }
    return participants.where((p) => p.isHost).firstOrNull ?? participants.first;
  }

  bool get featuredSpeaking {
    final f = featured;
    if (f == null) return false;
    return _agora.speaking.value.contains(f.uid);
  }

  void show({
    required String roomId,
    required String title,
    required bool isHost,
    required bool anonymous,
    List<RoomParticipant> participants = const [],
  }) {
    this.roomId = roomId;
    this.title = title;
    this.isHost = isHost;
    this.anonymous = anonymous;
    this.participants = List.unmodifiable(participants);
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
    participants = const [];
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

  bool _mine(Map<String, dynamic> e) => e['roomId'] == roomId;

  void _onSpeaking() {
    if (visible) notifyListeners();
  }

  void _upsert(RoomParticipant p) {
    if (!visible) return;
    final i = participants.indexWhere((x) => x.uid == p.uid);
    participants = List.unmodifiable(
      i == -1
          ? [...participants, p]
          : [for (final x in participants) x.uid == p.uid ? p : x],
    );
    notifyListeners();
  }

  RoomParticipant _participant(Object? json) =>
      RoomParticipant.fromJson(Map<String, dynamic>.from(json as Map));

  void _onJoined(Map<String, dynamic> e) {
    if (!_mine(e)) return;
    _upsert(_participant(e['participant']));
  }

  void _onUpdated(Map<String, dynamic> e) {
    if (!_mine(e)) return;
    _upsert(_participant(e['participant']));
  }

  void _onLeft(Map<String, dynamic> e) {
    if (!_mine(e)) return;
    final uid = (e['uid'] as num).toInt();
    participants = List.unmodifiable([
      ...participants.where((p) => p.uid != uid),
    ]);
    notifyListeners();
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
      participants = List.unmodifiable(s.participants);
      title = s.title;
      isHost = s.isHost;
      notifyListeners();
      return _agora.join(s.rtc, micOn: s.me.micOn);
    }).ignore();
  }
}
