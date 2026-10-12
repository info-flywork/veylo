import 'package:flutter/foundation.dart';
import 'package:veylo/data/remote/room_repository.dart';
import 'package:veylo/models/room/live_room.dart';

/// Rooms > öne çıkanlar + All Rooms listesi.
class RoomStore extends ChangeNotifier {
  RoomStore._();

  static final RoomStore instance = RoomStore._();

  final _repo = RoomRepository.instance;

  List<LiveRoomSummary> _rooms = const [];
  bool _loaded = false;

  List<LiveRoomSummary> get rooms => _rooms;
  bool get loaded => _loaded;

  Future<void> refresh() async {
    try {
      _rooms = await _repo.list();
      _loaded = true;
    } catch (e) {
      debugPrint('Odalar yüklenemedi: $e');
    }
    notifyListeners();
  }

  void markRequested(String id) {
    _rooms = [
      for (final r in _rooms) r.id == id ? r.copyWith(requested: true) : r,
    ];
    notifyListeners();
  }

  void clear() {
    _rooms = const [];
    _loaded = false;
    notifyListeners();
  }
}
