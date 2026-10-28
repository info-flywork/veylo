import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:veylo/data/remote/api_client.dart';
import 'package:veylo/data/remote/chat_repository.dart';
import 'package:veylo/data/remote/chat_store.dart';
import 'package:veylo/data/remote/socket_service.dart';
import 'package:veylo/models/chat/chat_message.dart';
import 'package:veylo/models/chat/chat_thread.dart';

/// Açık bir sohbetin mesajları: yükleme, gönderme (önce ekranda, sonra sunucu onayı),
/// okundu, yazıyor ve bağlantı kopunca kaçırılanları tamamlama.
class ConversationController extends ChangeNotifier {
  ConversationController(ChatThread thread) : _thread = thread;

  final _repo = ChatRepository.instance;
  final _socket = SocketService.instance;
  final _subs = <StreamSubscription<dynamic>>[];
  static const _uuid = Uuid();

  ChatThread _thread;
  List<ChatMessage> _messages = const [];
  bool _loading = true;
  bool _hasMore = false;
  bool _loadingOlder = false;
  bool _peerTyping = false;
  Timer? _typingTimer;
  DateTime _lastTypingSent = DateTime(2000);
  bool _disposed = false;

  ChatThread get thread => _thread;
  List<ChatMessage> get messages => _messages;
  bool get loading => _loading;
  bool get hasMore => _hasMore;
  bool get peerTyping => _peerTyping;

  int get _lastSeq =>
      _messages.lastWhere((m) => m.seq != null, orElse: _noSeq).seq ?? 0;
  static ChatMessage _noSeq() =>
      ChatMessage(clientMsgId: '', isMine: false, createdAt: DateTime(2000));

  Future<void> start() async {
    if (_thread.isLocalOnly) {
      _loading = false;
      _notify();
      return;
    }
    ChatStore.instance.activeConversationId = _thread.id;
    _subs
      ..add(_socket.on('message:new').where(_mine).listen(_onMessage))
      ..add(
        _socket
            .on('conversation:updated')
            .where((e) => e['id'] == _thread.id)
            .listen(_onConversation),
      )
      ..add(
        _socket.on('conversation:read').where(_mine).listen((e) {
          _thread = _thread.copyWith(
            peerLastReadSeq: (e['seq'] as num?)?.toInt(),
          );
          _notify();
        }),
      )
      ..add(_socket.on('typing').where(_mine).listen((_) => _showTyping()))
      ..add(
        _socket.on('presence:update').where(_mine).listen((e) {
          _thread = _thread.copyWith(isOnline: e['isOnline'] == true);
          _notify();
        }),
      );
    _socket.reconnects.addListener(_syncMissed);

    try {
      final page = await _repo.messages(_thread.id);
      _messages = page.items;
      _hasMore = page.hasMore;
    } catch (_) {
      // Liste boş kalır; ekran tekrar açılınca yeniden denenir.
    }
    _loading = false;
    _notify();
    _markRead();
  }

  bool _mine(Map<String, dynamic> e) =>
      e['conversationId'] == _thread.id ||
      (e['message'] is Map && e['message']['conversationId'] == _thread.id);

  void _onMessage(Map<String, dynamic> e) {
    final msg = ChatMessage.fromJson(
      Map<String, dynamic>.from(e['message'] as Map),
    );
    _upsertMessage(msg);
    if (e['conversation'] is Map) {
      _onConversation(Map<String, dynamic>.from(e['conversation'] as Map));
    }
    if (!msg.isMine) {
      _peerTyping = false;
      _markRead();
    }
    _notify();
  }

  void _onConversation(Map<String, dynamic> raw) {
    _thread = ChatThread.fromApi(raw).copyWith(unreadCount: 0);
    _notify();
  }

  /// Aynı mesaj iki kez gelmesin (kendi gönderdiğim, ack + socket olayı ile).
  void _upsertMessage(ChatMessage msg) {
    final i = _messages.indexWhere(
      (m) =>
          (msg.id != null && m.id == msg.id) ||
          (m.isMine && msg.isMine && m.clientMsgId == msg.clientMsgId),
    );
    final list = List.of(_messages);
    if (i >= 0) {
      list[i] = msg;
    } else {
      list.add(msg);
    }
    list.sort((a, b) => (a.seq ?? 1 << 30).compareTo(b.seq ?? 1 << 30));
    _messages = list;
  }

  /// Yeniden bağlanınca kaçırılan mesajlar.
  Future<void> _syncMissed() async {
    try {
      final page = await _repo.messages(
        _thread.id,
        afterSeq: _lastSeq,
        limit: 100,
      );
      for (final m in page.items) {
        _upsertMessage(m);
      }
      _notify();
      _markRead();
    } catch (_) {}
  }

  Future<void> loadOlder() async {
    if (!_hasMore || _loadingOlder || _messages.isEmpty) return;
    final firstSeq = _messages
        .firstWhere((m) => m.seq != null, orElse: _noSeq)
        .seq;
    if (firstSeq == null || firstSeq <= 1) return;
    _loadingOlder = true;
    try {
      final page = await _repo.messages(_thread.id, beforeSeq: firstSeq);
      _messages = [...page.items, ..._messages];
      _hasMore = page.hasMore;
      _notify();
    } catch (_) {
    } finally {
      _loadingOlder = false;
    }
  }

  /// Mesaj hemen ekranda görünür ("gönderiliyor"), sunucu onaylayınca kesinleşir.
  Future<void> send(String text) async {
    final body = text.trim();
    if (body.isEmpty || _thread.isLocalOnly) return;
    final pending = ChatMessage(
      clientMsgId: _uuid.v4(),
      isMine: true,
      body: body,
      createdAt: DateTime.now(),
      status: ChatMessageStatus.sending,
    );
    _messages = [..._messages, pending];
    _notify();
    await _deliver(pending);
  }

  /// Bağlantı adımı için istek. Karşı tarafın sohbetinde bir satır olarak görünür.
  Future<void> requestUnlock(String milestone) async {
    if (_thread.isLocalOnly) return;
    final res = await _socket.request('connection:request', {
      'conversationId': _thread.id,
      'milestone': milestone,
    });
    _upsertMessage(ChatMessage.fromJson(Map<String, dynamic>.from(res as Map)));
    _notify();
  }

  /// Başarısız mesaja dokununca aynı clientMsgId ile tekrar (sunucu ikinci kez yazmaz).
  Future<void> retry(ChatMessage failed) async {
    _upsertMessage(failed.copyWith(status: ChatMessageStatus.sending));
    _notify();
    await _deliver(failed);
  }

  Future<void> _deliver(ChatMessage msg) async {
    final payload = {
      'conversationId': _thread.id,
      'clientMsgId': msg.clientMsgId,
      'type': 'TEXT',
      'body': msg.body,
    };
    try {
      final dynamic res = _socket.connected.value
          ? await _socket.request('message:send', payload)
          : await ApiClient.instance.post(
              '/conversations/${_thread.id}/messages',
              body: {
                'clientMsgId': msg.clientMsgId,
                'type': 'TEXT',
                'body': msg.body,
              },
            );
      _upsertMessage(
        ChatMessage.fromJson(Map<String, dynamic>.from(res as Map)),
      );
    } on ApiException catch (e) {
      _upsertMessage(msg.copyWith(status: ChatMessageStatus.failed));
      lastError = e;
    } catch (e) {
      _upsertMessage(msg.copyWith(status: ChatMessageStatus.failed));
    }
    _notify();
  }

  /// Ekranın gösterebileceği son hata (ör. REQUEST_PENDING_LIMIT, BLOCKED).
  ApiException? lastError;

  void _markRead() {
    final seq = _lastSeq;
    if (seq == 0 || _thread.isLocalOnly) return;
    ChatStore.instance.markReadLocally(_thread.id);
    _socket
        .request('message:read', {'conversationId': _thread.id, 'seq': seq})
        .catchError((_) => null);
  }

  /// Klavyede yazarken çağrılır; en fazla 2 sn'de bir gönderilir.
  void onTyping() {
    if (_thread.isLocalOnly) return;
    final now = DateTime.now();
    if (now.difference(_lastTypingSent) < const Duration(seconds: 2)) return;
    _lastTypingSent = now;
    _socket.emit('typing', {'conversationId': _thread.id});
  }

  void _showTyping() {
    _peerTyping = true;
    _typingTimer?.cancel();
    _typingTimer = Timer(const Duration(seconds: 3), () {
      _peerTyping = false;
      _notify();
    });
    _notify();
  }

  // ───────────── istek / güvenlik / açılma ─────────────

  Future<void> approve() async {
    _thread = await _repo.approve(_thread.id);
    ChatStore.instance.replace(_thread);
    _notify();
  }

  Future<void> reject() async {
    await _repo.reject(_thread.id);
    ChatStore.instance.remove(_thread.id);
  }

  Future<void> blockPeer() async {
    await _repo.blockPeer(_thread.id);
    ChatStore.instance.remove(_thread.id);
  }

  Future<void> reveal() async {
    _thread = await _repo.reveal(_thread.id);
    ChatStore.instance.replace(_thread);
    _notify();
  }

  void _notify() {
    if (!_disposed) notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    for (final s in _subs) {
      s.cancel();
    }
    _socket.reconnects.removeListener(_syncMissed);
    _typingTimer?.cancel();
    if (ChatStore.instance.activeConversationId == _thread.id) {
      ChatStore.instance.activeConversationId = null;
    }
    super.dispose();
  }
}
