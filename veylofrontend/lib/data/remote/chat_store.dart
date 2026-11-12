import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:veylo/data/remote/chat_repository.dart';
import 'package:veylo/data/remote/session_store.dart';
import 'package:veylo/data/remote/socket_service.dart';
import 'package:veylo/models/chat/chat_message.dart';
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

  /// Açılan sohbetlerin son mesaj sayfası — tekrar girince boş ekran olmasın.
  final Map<String, List<ChatMessage>> _messageCache = {};
  final Set<String> _prefetching = {};

  /// Şu an ekranda açık sohbet: okunmamış sayacı artmaz.
  String? activeConversationId;

  List<ChatThread> get inbox => _inbox;
  List<ChatThread> get requests => _requests;
  bool get loading => _loading;
  Object? get error => _error;

  List<ChatMessage>? cachedMessages(String conversationId) {
    final list = _messageCache[conversationId];
    if (list == null || list.isEmpty) return null;
    return List.of(list);
  }

  void cacheMessages(String conversationId, List<ChatMessage> messages) {
    if (conversationId.isEmpty) return;
    _messageCache[conversationId] = List.of(messages);
  }

  void cacheUpsertMessage(String conversationId, ChatMessage message) {
    if (conversationId.isEmpty) return;
    final list = List.of(_messageCache[conversationId] ?? const <ChatMessage>[]);
    final i = list.indexWhere(
      (m) =>
          (message.id != null && m.id == message.id) ||
          (m.isMine && message.isMine && m.clientMsgId == message.clientMsgId),
    );
    if (i >= 0) {
      list[i] = message;
    } else {
      list.add(message);
    }
    list.sort((a, b) => (a.seq ?? 1 << 30).compareTo(b.seq ?? 1 << 30));
    // Bellekte son ~80 mesaj yeterli (sohbet açılış sayfası).
    _messageCache[conversationId] =
        list.length > 80 ? list.sublist(list.length - 80) : list;
  }

  void cacheRemoveMessage(String conversationId, String messageId) {
    final list = _messageCache[conversationId];
    if (list == null) return;
    _messageCache[conversationId] =
        list.where((m) => m.id != messageId).toList();
  }

  /// Sohbete tıklanınca navigasyon animasyonu sırasında mesajları çekmeye başlar.
  Future<void> prefetchMessages(String conversationId) async {
    if (conversationId.isEmpty ||
        _messageCache.containsKey(conversationId) ||
        _prefetching.contains(conversationId)) {
      return;
    }
    _prefetching.add(conversationId);
    try {
      final page = await _repo.messages(conversationId);
      cacheMessages(conversationId, page.items);
    } catch (_) {
    } finally {
      _prefetching.remove(conversationId);
    }
  }

  /// Girişten sonra bir kez: socket'e bağlanır, listeyi yükler, olayları dinler.
  void start() {
    if (_started) return;
    _started = true;
    _socket.connect();
    _subs
      ..add(_socket.on('message:new').listen(_onMessageNew))
      ..add(_socket.on('message:edited').listen(_onMessageEdited))
      ..add(
        _socket.on('message:deleted').listen((e) {
          final cid = e['conversationId'] as String?;
          final mid = e['messageId'] as String?;
          if (cid != null && mid != null) cacheRemoveMessage(cid, mid);
        }),
      )
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

  void _onMessageNew(Map<String, dynamic> e) {
    _upsert(e['conversation']);
    final raw = e['message'];
    if (raw is! Map) return;
    final map = Map<String, dynamic>.from(raw);
    final cid =
        map['conversationId'] as String? ??
        (e['conversation'] is Map
            ? (e['conversation'] as Map)['id'] as String?
            : null);
    if (cid == null) return;
    cacheUpsertMessage(cid, ChatMessage.fromJson(map));
  }

  void _onMessageEdited(Map<String, dynamic> e) {
    final raw = e['message'];
    if (raw is! Map) return;
    final map = Map<String, dynamic>.from(raw);
    final cid =
        map['conversationId'] as String? ?? e['conversationId'] as String?;
    if (cid == null) return;
    cacheUpsertMessage(cid, ChatMessage.fromJson(map));
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
    _messageCache.clear();
    _prefetching.clear();
    activeConversationId = null;
    notifyListeners();
  }

  Future<void> refresh() async {
    final net = Future.wait([_repo.list(), _repo.list(box: 'requests')]);
    // Disk okunurken ağ hata verirse yakalanmamış hata sayılmasın; aşağıda await edilir.
    unawaited(net.then((_) {}, onError: (_) {}));
    if (_inbox.isEmpty && _requests.isEmpty) {
      // Ağı beklerken diskteki son sohbet listesi hemen görünsün.
      final cached = await Future.wait([
        _repo.cachedList(),
        _repo.cachedList(box: 'requests'),
      ]);
      if (_inbox.isEmpty && _requests.isEmpty) {
        _inbox = _sorted(cached[0] ?? const []);
        _requests = _sorted(cached[1] ?? const []);
      }
    }
    _loading = _inbox.isEmpty;
    notifyListeners();
    try {
      final results = await net;
      _inbox = _sorted(results[0]);
      _requests = _sorted(results[1]);
      _error = null;
      // Üstteki sohbetleri arka planda ısıt — tıklayınca boş ekran azalır.
      for (final t in _inbox.take(5)) {
        unawaited(prefetchMessages(t.id));
      }
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
    // Kullanıcı silene kadar kalsın. Boş önizleme yüzünden listeden düşürme.
    final keep = thread.status != 'REJECTED' || thread.isInitiator;
    if (keep) {
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
      'avatarBlurred': t.peerAvatarBlurred,
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
