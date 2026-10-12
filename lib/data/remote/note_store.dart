import 'package:flutter/foundation.dart';
import 'package:veylo/data/remote/api_client.dart';
import 'package:veylo/models/chat/chat_note.dart';

/// Sohbetler ekranının üstündeki notlar (`/notes`).
class NoteStore extends ChangeNotifier {
  NoteStore._();

  static final NoteStore instance = NoteStore._();

  final _api = ApiClient.instance;

  /// Benim notumun metni (yoksa null).
  String? _mine;
  List<ChatNote> _items = const [];

  String? get mine => _mine;
  List<ChatNote> get items => _items;

  Future<void> refresh() async {
    try {
      final res = await _api.get('/notes') as Map;
      final mine = res['mine'] as Map?;
      _mine = mine?['text'] as String?;
      _items = [
        for (final j in (res['items'] as List).cast<Map>())
          ChatNote.fromApi(Map<String, dynamic>.from(j)),
      ];
      notifyListeners();
    } catch (_) {
      // Liste eski haliyle kalır.
    }
  }

  Future<void> setMine(String text) async {
    final res = await _api.put('/notes/me', body: {'text': text}) as Map;
    _mine = res['text'] as String?;
    notifyListeners();
  }

  Future<void> deleteMine() async {
    await _api.delete('/notes/me');
    _mine = null;
    notifyListeners();
  }

  void clear() {
    _mine = null;
    _items = const [];
    notifyListeners();
  }
}
