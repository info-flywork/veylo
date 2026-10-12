import 'package:flutter/foundation.dart';
import 'package:veylo/data/remote/group_repository.dart';
import 'package:veylo/models/group/group_models.dart';

/// Rooms > All Groups listesi.
class GroupStore extends ChangeNotifier {
  GroupStore._();

  static final GroupStore instance = GroupStore._();

  final _repo = GroupRepository.instance;

  List<GroupSummary> _groups = const [];
  bool _loaded = false;
  Object? _error;

  List<GroupSummary> get groups => _groups;
  bool get loaded => _loaded;
  Object? get error => _error;

  Future<void> refresh() async {
    try {
      _groups = await _repo.discover();
      _loaded = true;
      _error = null;
    } catch (e) {
      _error = e;
    }
    notifyListeners();
  }

  void markRequested(String id) =>
      _update(id, (g) => g.copyWith(requested: true));

  void markJoined(String id) =>
      _update(id, (g) => g.copyWith(isMember: true, requested: false));

  void clear() {
    _groups = const [];
    _loaded = false;
    notifyListeners();
  }

  void _update(String id, GroupSummary Function(GroupSummary) fn) {
    _groups = [for (final g in _groups) g.id == id ? fn(g) : g];
    notifyListeners();
  }
}
