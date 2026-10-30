import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:veylo/data/remote/chat_repository.dart';
import 'package:veylo/data/remote/session_store.dart';
import 'package:veylo/data/remote/socket_service.dart';
import 'package:veylo/models/chat/chat_thread.dart';

/// Sohbet listesi ve mesaj istekleri; socket olaylarıyla canlı güncellenir.
class ChatStore extends ChangeNotifier {
  ChatStore._();

  static final ChatStore instance = ChatStore._();

  final _repo = ChatRepository.instance;
  final _socket = SocketService.instance;

  List<ChatThread> _inbox = const [];
  List<ChatThread> _requests = const [];
  bool _loading = false;
  Object? _error;
  bool _started = false;
  final List<StreamSubscription<dynamic>> _subs = [];
  AppLifecycleListener? _lifecycle;

  /// Şu an ekranda açık sohbet: okunmamış sayacı artmaz.
  String? activeConversationId;

  List<ChatThread> get inbox => _inbox;
  List<ChatThread> get requests => _requests;
  bool get loading => _loading;
  Object? get error => _error;

  /// Girişten sonra bir kez: socket'e bağlanır, listeyi yükler, olayları dinler.
  void start() {
    if (_started) return;
    _started = true;
    _socket.connect();
    _subs
      ..add(_socket.on('message:new').listen((e) => _upsert(e['conversation'])))
      ..add(_socket.on('conversation:updated').listen(_upsert))
      ..add(_socket.on('conversation:read').listen(_onRead))
      // Gruptan çıkarıldım.
      ..add(
        _socket
            .on('conversation:removed')
            .listen((e) => remove(e['conversationId'] as String? ?? '')),
      )
      ..add(_socket.on('presence:update').listen(_onPresence))
      ..add(
        _socket.on('tokens:updated').listen((e) {
          final balance = (e['balance'] as num?)?.toInt();
          if (balance != null) {
            SessionStore.instance.updateTokenBalance(balance);
          }
        }),
      );
    _socket.reconnects.addListener(refresh);
    // Arka planda bağlantı açık kalır. Böylece uygulama önde değilken de
    // anonim arama düşer. İşletim sistemi süreci kapatırsa dönüşte yeniden bağlanır.
    _lifecycle = AppLifecycleListener(
      onResume: () => _socket.connect(resync: true),
    );
    refresh();
  }

  /// Çıkışta: bağlantıyı ve listeyi sıfırla.
  void stop() {
    for (final s in _subs) {
      s.cancel();
    }
    _subs.clear();
    _lifecycle?.dispose();
    _lifecycle = null;
    _socket.reconnects.removeListener(refresh);
    _socket.disconnect();
    _started = false;
    _inbox = const [];
    _requests = const [];
    activeConversationId = null;
    notifyListeners();
  }

  Future<void> refresh() async {
    _loading = _inbox.isEmpty;
    notifyListeners();
    try {
      final results = await Future.wait([
        _repo.list(),
        _repo.list(box: 'requests'),
      ]);
      _inbox = _sorted(results[0]);
      _requests = _sorted(results[1]);
      _error = null;
    } catch (e) {
      _error = e;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  ChatThread? byId(String id) {
    for (final t in [..._inbox, ..._requests]) {
      if (t.id == id) return t;
    }
    return null;
  }

  /// Sunucudan gelen sohbet halini doğru kutuya (gelen kutusu / istekler) yerleştirir.
  void _upsert(dynamic raw) {
    if (raw is! Map) return;
    var thread = ChatThread.fromApi(Map<String, dynamic>.from(raw));
    if (thread.id == activeConversationId) {
      thread = thread.copyWith(unreadCount: 0);
    }
    _inbox = _inbox.where((t) => t.id != thread.id).toList();
    _requests = _requests.where((t) => t.id != thread.id).toList();
    final visible = thread.status != 'REJECTED' || thread.isInitiator;
    if (visible && (thread.lastMessagePreview.isNotEmpty || thread.isGroup)) {
      if (thread.isStrangerRequest) {
        _requests = _sorted([..._requests, thread]);
      } else {
        _inbox = _sorted([..._inbox, thread]);
      }
    }
    notifyListeners();
  }

  /// Ekran kendi listesini güncellediğinde (onay, silme vb.).
  void replace(ChatThread thread) => _upsert(_toApiShape(thread));

  void remove(String id) {
    _inbox = _inbox.where((t) => t.id != id).toList();
    _requests = _requests.where((t) => t.id != id).toList();
    notifyListeners();
  }

  void markReadLocally(String id) {
    _inbox = [
      for (final t in _inbox) t.id == id ? t.copyWith(unreadCount: 0) : t,
    ];
    notifyListeners();
  }

  void _onRead(Map<String, dynamic> e) {
    final id = e['conversationId'];
    final seq = (e['seq'] as num?)?.toInt();
    _inbox = [
      for (final t in _inbox) t.id == id ? t.copyWith(peerLastReadSeq: seq) : t,
    ];
    notifyListeners();
  }

  void _onPresence(Map<String, dynamic> e) {
    final id = e['conversationId'];
    final online = e['isOnline'] == true;
    _inbox = [
      for (final t in _inbox) t.id == id ? t.copyWith(isOnline: online) : t,
    ];
    _requests = [
      for (final t in _requests) t.id == id ? t.copyWith(isOnline: online) : t,
    ];
    notifyListeners();
  }

  /// Sabitlenenler üstte, sonra en yeni mesaj.
  static List<ChatThread> _sorted(List<ChatThread> list) {
    final copy = List.of(list);
    copy.sort((a, b) {
      if (a.pinned != b.pinned) return a.pinned ? -1 : 1;
      final at = a.lastMessageAt ?? DateTime(2000);
      final bt = b.lastMessageAt ?? DateTime(2000);
      return bt.compareTo(at);
    });
    return copy;
  }

  /// [replace] için ChatThread → sunucu biçimi (fromApi ile geri okunabilir).
  static Map<String, dynamic> _toApiShape(ChatThread t) => {
    'id': t.id,
    'type': t.isGroup
        ? 'GROUP'
        : (t.isAnonymous || t.revealed ? 'ANONYMOUS' : 'DIRECT'),
    'status': t.status,
    'isRequest': t.isStrangerRequest,
    'isInitiator': t.isInitiator,
    'title': t.title,
    'peer': {
      'id': t.peerUserId,
      'username': t.peerUsername,
      'displayName': t.maskedName ?? t.title,
      'avatarUrl': t.avatarUrl.isEmpty ? null : t.avatarUrl,
      'isAi': t.peerIsAi,
    },
    'isOnline': t.isOnline,
    'memberCount': t.memberCount,
    'connection': {
      'progress': t.connectionProgress,
      'revealed': t.revealed,
      'myConsent': t.myRevealConsent,
      'peerConsent': t.peerRevealConsent,
    },
    'contextQuote': t.contextQuote,
    'group': t.isGroup
        ? {
            'isPrivate': t.groupIsPrivate,
            'myRole': t.groupRole,
            'avatars': t.groupAvatarUrls ?? const <String>[],
          }
        : null,
    'lastMessage': {
      'preview': t.lastMessagePreview,
      'at': t.lastMessageAt?.toUtc().toIso8601String(),
    },
    'unreadCount': t.unreadCount,
    'peerLastReadSeq': t.peerLastReadSeq,
    'pinned': t.pinned,
    'muted': t.muted,
  };
}
