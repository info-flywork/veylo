import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  /// "Benim için sil" ile gizlenen karşı taraf mesajları (cihazda saklanır).
  Set<String> _hidden = const {};

  ChatThread get thread => _thread;
  List<ChatMessage> get messages => _hidden.isEmpty
      ? _messages
      : _messages.where((m) => m.id == null || !_hidden.contains(m.id)).toList();
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
      ..add(_socket.on('message:edited').where(_mine).listen(_onMessage))
      ..add(
        _socket.on('message:deleted').where(_mine).listen((e) {
          _removeMessage(e['messageId'] as String?);
          _notify();
        }),
      )
      ..add(
        _socket.on('message:reaction').where(_mine).listen((e) {
          final id = e['messageId'] as String?;
          if (id == null) return;
          final raw = e['reactions'] as List? ?? const [];
          final reactions = [
            for (final r in raw)
              if (r is Map)
                ChatReaction.fromJson(Map<String, dynamic>.from(r)),
          ];
          final i = _messages.indexWhere((m) => m.id == id);
          if (i < 0) return;
          final list = List.of(_messages);
          list[i] = list[i].copyWith(reactions: reactions);
          _messages = list;
          _notify();
        }),
      )
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

    // Önce cache: boş ekran / 1–2 sn beklemeyi keser.
    final cached = ChatStore.instance.cachedMessages(_thread.id);
    if (cached != null && cached.isNotEmpty) {
      _messages = cached;
      _loading = false;
      _notify();
    }

    // Ağ + gizli mesaj listesi paralel; get mesajları bloklamasın.
    final hiddenFuture = _loadHidden();
    final messagesFuture = _repo.messages(_thread.id);
    final threadFuture = _repo.get(_thread.id);

    try {
      final page = await messagesFuture;
      if (_disposed) return;
      _messages = page.items;
      _hasMore = page.hasMore;
      ChatStore.instance.cacheMessages(_thread.id, page.items);
    } catch (_) {
      // Cache varsa ekranda kalsın.
    }

    try {
      final fresh = await threadFuture;
      if (!_disposed) _thread = fresh.copyWith(unreadCount: 0);
    } catch (_) {}

    _hidden = await hiddenFuture;
    if (_disposed) return;
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
    if (!_thread.isLocalOnly) {
      ChatStore.instance.cacheUpsertMessage(_thread.id, msg);
    }
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

  ChatMessage? _replyTarget;
  ChatMessage? _editing;

  ChatMessage? get replyTarget => _replyTarget;
  ChatMessage? get editingMessage => _editing;

  void setReplyTarget(ChatMessage? message) {
    _replyTarget = message?.id == null || message?.type == 'SYSTEM' ? null : message;
    _editing = null;
    _notify();
  }

  void setEditing(ChatMessage? message) {
    _editing = message?.canEdit == true ? message : null;
    _replyTarget = null;
    _notify();
  }

  void clearComposerContext() {
    _replyTarget = null;
    _editing = null;
    _notify();
  }

  ChatReplyPreview? _consumeReplyPreview() {
    final reply = _replyTarget;
    _replyTarget = null;
    if (reply == null) return null;
    return ChatReplyPreview(
      id: reply.id!,
      type: reply.type,
      body: reply.type == 'TEXT'
          ? (reply.body?.startsWith('sticker:') == true
                ? '🎭 Sticker'
                : reply.body)
          : reply.displayText,
      isMine: reply.isMine,
    );
  }

  /// Fotoğraf veya ses: önce dosya yüklenir, sonra mesaj gider.
  Future<void> sendMedia(String kind, String path) async {
    if (_thread.isLocalOnly || path.isEmpty) return;
    final replyTo = _consumeReplyPreview();
    final pending = ChatMessage(
      clientMsgId: _uuid.v4(),
      isMine: true,
      type: kind == 'voice' ? 'VOICE' : 'IMAGE',
      mediaUrl: path,
      createdAt: DateTime.now(),
      status: ChatMessageStatus.sending,
      replyToId: replyTo?.id,
      replyTo: replyTo,
    );
    _messages = [..._messages, pending];
    _notify();
    await _deliver(pending);
  }

  /// Birden fazla fotoğrafı anında balon olarak ekler, sonra sırayla yükler.
  Future<void> sendImages(List<String> paths) async {
    if (_thread.isLocalOnly || paths.isEmpty) return;
    final replyTo = _consumeReplyPreview();
    final pending = <ChatMessage>[
      for (var i = 0; i < paths.length; i++)
        ChatMessage(
          clientMsgId: _uuid.v4(),
          isMine: true,
          type: 'IMAGE',
          mediaUrl: paths[i],
          createdAt: DateTime.now().add(Duration(milliseconds: i)),
          status: ChatMessageStatus.sending,
          replyToId: i == 0 ? replyTo?.id : null,
          replyTo: i == 0 ? replyTo : null,
        ),
    ];
    _messages = [..._messages, ...pending];
    _notify();
    for (final msg in pending) {
      await _deliver(msg);
    }
  }

  /// Başka sohbete ilet (metin veya mevcut medya id / yerel dosya).
  Future<void> forwardTo(ChatThread target, ChatMessage message) async {
    if (target.isLocalOnly || target.id.isEmpty) return;
    final payload = <String, dynamic>{
      'conversationId': target.id,
      'clientMsgId': _uuid.v4(),
      'type': message.type == 'VOICE'
          ? 'VOICE'
          : message.type == 'IMAGE'
          ? 'IMAGE'
          : 'TEXT',
    };
    if (payload['type'] == 'TEXT') {
      final body = message.body?.trim() ?? '';
      if (body.isEmpty) return;
      payload['body'] = body;
    } else {
      var mediaId = message.mediaId;
      if (mediaId == null || mediaId.isEmpty) {
        final url = message.mediaUrl;
        if (url == null || url.isEmpty) return;
        final kind = message.type == 'VOICE' ? 'voice' : 'image';
        final uploaded = await ApiClient.instance.upload(
          '/media/chat',
          url,
          query: {'kind': kind},
        );
        mediaId = Map<String, dynamic>.from(uploaded as Map)['mediaId'] as String?;
        if (mediaId == null || mediaId.isEmpty) return;
      }
      payload['mediaId'] = mediaId;
    }
    if (_socket.connected.value) {
      await _socket.request('message:send', payload);
    } else {
      await ApiClient.instance.post(
        '/conversations/${target.id}/messages',
        body: {
          'clientMsgId': payload['clientMsgId'],
          'type': payload['type'],
          if (payload['body'] != null) 'body': payload['body'],
          if (payload['mediaId'] != null) 'mediaId': payload['mediaId'],
        },
      );
    }
    // Hedef sohbet listede taze önizleme alsın.
    unawaited(ChatStore.instance.refresh());
  }

  /// Mesaj hemen ekranda görünür ("gönderiliyor"), sunucu onaylayınca kesinleşir.
  Future<void> send(String text) async {
    final body = text.trim();
    if (body.isEmpty || _thread.isLocalOnly) return;
    final editing = _editing;
    if (editing != null) {
      _editing = null;
      _notify();
      await editMessage(editing, body);
      return;
    }
    final replyTo = _consumeReplyPreview();
    final pending = ChatMessage(
      clientMsgId: _uuid.v4(),
      isMine: true,
      body: body,
      createdAt: DateTime.now(),
      status: ChatMessageStatus.sending,
      replyToId: replyTo?.id,
      replyTo: replyTo,
    );
    _messages = [..._messages, pending];
    _notify();
    await _deliver(pending);
  }

  Future<void> editMessage(ChatMessage message, String body) async {
    final id = message.id;
    final text = body.trim();
    if (id == null || text.isEmpty || !message.canEdit) return;
    final before = message;
    _upsertMessage(message.copyWith(body: text, editedAt: DateTime.now()));
    _notify();
    try {
      final dynamic res = _socket.connected.value
          ? await _socket.request('message:edit', {
              'conversationId': _thread.id,
              'messageId': id,
              'body': text,
            })
          : await _repo.editMessage(_thread.id, id, text);
      _upsertMessage(
        ChatMessage.fromJson(Map<String, dynamic>.from(res as Map)),
      );
    } catch (_) {
      _upsertMessage(before);
      rethrow;
    }
    _notify();
  }

  Future<void> reactToMessage(ChatMessage message, String emoji) async {
    final id = message.id;
    if (id == null || _thread.isLocalOnly) return;
    try {
      final dynamic res = _socket.connected.value
          ? await _socket.request('message:react', {
              'conversationId': _thread.id,
              'messageId': id,
              'emoji': emoji,
            })
          : null;
      final reactions = res is Map
          ? [
              for (final r in (res['reactions'] as List? ?? const []))
                if (r is Map)
                  ChatReaction.fromJson(Map<String, dynamic>.from(r)),
            ]
          : await _repo.reactMessage(_thread.id, id, emoji);
      final i = _messages.indexWhere((m) => m.id == id);
      if (i < 0) return;
      final list = List.of(_messages);
      list[i] = list[i].copyWith(reactions: reactions);
      _messages = list;
      _notify();
    } catch (_) {
      rethrow;
    }
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

  /// İsim isteğini onayla veya reddet. Onayda karşı tarafın adı kalıcı açılır.
  Future<void> respondUnlock(ChatMessage message, String decision) async {
    final id = message.id;
    if (id == null || _thread.isLocalOnly) return;
    final res = await _socket.request('connection:respond', {
      'conversationId': _thread.id,
      'messageId': id,
      'decision': decision,
    });
    final map = Map<String, dynamic>.from(res as Map);
    if (map['message'] is Map) {
      _upsertMessage(ChatMessage.fromJson(Map<String, dynamic>.from(map['message'] as Map)));
    }
    if (map['conversation'] is Map) {
      _onConversation(Map<String, dynamic>.from(map['conversation'] as Map));
    }
    _notify();
  }

  /// Başarısız mesaja dokununca aynı clientMsgId ile tekrar (sunucu ikinci kez yazmaz).
  Future<void> retry(ChatMessage failed) async {
    _upsertMessage(failed.copyWith(status: ChatMessageStatus.sending));
    _notify();
    await _deliver(failed);
  }

  Future<void> _deliver(ChatMessage msg) async {
    var current = msg;
    try {
      if (current.type != 'TEXT' && (current.mediaId == null || current.mediaId!.isEmpty)) {
        final kind = current.type == 'VOICE' ? 'voice' : 'image';
        final uploaded = await ApiClient.instance.upload(
          '/media/chat',
          current.mediaUrl!,
          query: {'kind': kind},
        );
        final map = Map<String, dynamic>.from(uploaded as Map);
        current = current.copyWith(
          mediaId: map['mediaId'] as String?,
          mediaUrl: map['url'] as String? ?? current.mediaUrl,
        );
        _upsertMessage(current);
      }
      final payload = {
        'conversationId': _thread.id,
        'clientMsgId': current.clientMsgId,
        'type': current.type,
        if (current.type == 'TEXT') 'body': current.body,
        if (current.type != 'TEXT') 'mediaId': current.mediaId,
        if (current.replyToId != null) 'replyToId': current.replyToId,
      };
      final dynamic res = _socket.connected.value
          ? await _socket.request('message:send', payload)
          : await ApiClient.instance.post(
              '/conversations/${_thread.id}/messages',
              body: {
                'clientMsgId': current.clientMsgId,
                'type': current.type,
                if (current.type == 'TEXT') 'body': current.body,
                if (current.type != 'TEXT') 'mediaId': current.mediaId,
                if (current.replyToId != null) 'replyToId': current.replyToId,
              },
            );
      _upsertMessage(
        ChatMessage.fromJson(Map<String, dynamic>.from(res as Map)),
      );
    } on ApiException catch (e) {
      _upsertMessage(current.copyWith(status: ChatMessageStatus.failed));
      lastError = e;
    } catch (e) {
      _upsertMessage(current.copyWith(status: ChatMessageStatus.failed));
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

  // ───────────── mesaj işlemleri ─────────────

  String get _hiddenKey => 'chat_hidden_messages_${_thread.id}';

  Future<Set<String>> _loadHidden() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return (prefs.getStringList(_hiddenKey) ?? const <String>[]).toSet();
    } catch (_) {
      return const {};
    }
  }

  void _removeMessage(String? id) {
    if (id == null) return;
    _messages = _messages.where((m) => m.id != id).toList();
  }

  /// Kendi mesajım: herkes için geri alınır. Karşı tarafın mesajı: yalnızca bende gizlenir.
  Future<void> deleteMessage(ChatMessage message) async {
    final id = message.id;
    if (!message.isMine) {
      if (id == null) return;
      _hidden = {..._hidden, id};
      _notify();
      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setStringList(_hiddenKey, _hidden.toList());
      } catch (_) {}
      return;
    }
    // Sunucuya ulaşmamış (gönderiliyor / başarısız) mesaj sadece ekrandan kalkar.
    if (id == null) {
      _messages = _messages
          .where((m) => m.clientMsgId != message.clientMsgId)
          .toList();
      _notify();
      return;
    }
    final before = _messages;
    _removeMessage(id);
    _notify();
    try {
      await _repo.deleteMessage(_thread.id, id);
    } catch (_) {
      _messages = before;
      _notify();
      rethrow;
    }
  }

  /// Tek bir mesajı şikayet et (sunucuda mesaj id'si içerik olarak saklanır).
  Future<void> reportMessage(ChatMessage message, String reason) async {
    final id = message.id;
    if (id == null || message.isMine) return;
    await _repo.reportPeer(_thread.id, reason: reason, messageId: id);
  }

  Future<void> setMuted(bool muted) async {
    await _repo.setMuted(_thread.id, muted);
    _thread = _thread.copyWith(muted: muted);
    ChatStore.instance.replace(_thread);
    _notify();
  }

  /// Sohbeti yalnızca benim için siler.
  Future<void> deleteChat() async {
    await _repo.deleteForMe(_thread.id);
    ChatStore.instance.remove(_thread.id);
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
    if (_messages.isNotEmpty && !_thread.isLocalOnly) {
      ChatStore.instance.cacheMessages(_thread.id, _messages);
    }
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
