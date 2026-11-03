part of 'call_stranger_page.dart';

enum _DirectPhase {
  /// Arayan: karşı taraf çalıyor.
  outgoing,

  /// Aranan: Decline / Accept.
  incoming,

  /// Görüşme sürüyor (sesli ya da görüntülü).
  active,
}

/// Sohbet ekranından başlatılan birebir sesli/görüntülü arama.
/// Ücretsizdir ve süre sınırı yoktur. Arayüz rastgele aramadaki ekranları kullanır.
///
/// Socket akışı: `call:direct` → (karşıya `call:incoming` kind=direct) → `call:accept` /
/// `call:decline` / `call:direct_cancel` → `call:direct_started` → `call:end` / `call:ended`.
class DirectCallPage extends StatefulWidget {
  const DirectCallPage._({
    required this.outgoing,
    required this.conversationId,
    required this.name,
    required this.avatarUrl,
    required this.video,
    this.inviteId,
  });

  final bool outgoing;
  final String conversationId;
  final String name;
  final String avatarUrl;
  final bool video;
  final String? inviteId;

  /// Sohbet başlığındaki telefon / kamera simgesi. İzin verilmezse ekran açılmaz.
  static Future<void> start(
    BuildContext context, {
    required String conversationId,
    required String name,
    required String avatarUrl,
    required bool video,
  }) async {
    final t = Translations.of(context).call;
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context, rootNavigator: true);
    void toast(String text) => messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));

    final agora = AgoraService.instance;
    if (!await agora.requestMic()) {
      toast(t.micDenied);
      return;
    }
    if (video && !await agora.requestCamera()) {
      toast(t.cameraDenied);
      return;
    }
    await navigator.push<void>(
      MaterialPageRoute<void>(
        builder: (_) => DirectCallPage._(
          outgoing: true,
          conversationId: conversationId,
          name: name,
          avatarUrl: avatarUrl,
          video: video,
        ),
      ),
    );
  }

  /// Gelen birebir arama: socket `call:incoming` (kind=direct) ya da arama bildirimi.
  static Future<void> openIncoming(
    BuildContext context,
    Map<String, dynamic> event,
  ) {
    final caller = event['caller'];
    final callerMap = caller is Map ? caller : const {};
    final rawVideo = event['video'];
    return Navigator.of(context, rootNavigator: true).push<void>(
      MaterialPageRoute<void>(
        builder: (_) => DirectCallPage._(
          outgoing: false,
          inviteId: event['inviteId'] as String?,
          conversationId: event['conversationId'] as String? ?? '',
          name:
              (callerMap['displayName'] ?? event['name']) as String? ?? '',
          avatarUrl:
              (callerMap['avatarUrl'] ?? event['avatarUrl']) as String? ?? '',
          video: rawVideo == true || rawVideo == '1' || rawVideo == 'true',
        ),
      ),
    );
  }

  @override
  State<DirectCallPage> createState() => _DirectCallPageState();
}

class _DirectCallPageState extends State<DirectCallPage> {
  static const _contentWidth = 398.0;

  final _socket = SocketService.instance;
  final _agora = AgoraService.instance;
  final List<StreamSubscription<Map<String, dynamic>>> _subs = [];

  late _DirectPhase _phase =
      widget.outgoing ? _DirectPhase.outgoing : _DirectPhase.incoming;
  String? _inviteId;
  String? _callId;
  int? _peerUid;
  bool _videoAllowed = false;
  bool _accepting = false;
  bool _closed = false;

  /// Agora kanalına bu ekran girdiyse çıkarken bırakılır (ör. açık canlı oda bozulmasın).
  bool _usedAgora = false;

  bool _micOn = true;
  bool _speakerOn = true;

  /// Kendi kameramız yayında mı.
  bool _camOn = false;
  bool _videoStarted = false;

  DateTime? _startedAt;
  int _seconds = 0;
  Timer? _clock;

  @override
  void initState() {
    super.initState();
    _inviteId = widget.inviteId;
    _subs.addAll([
      _socket.on('call:direct_started').listen(_onStarted),
      _socket.on('call:direct_declined').listen(_onDeclined),
      _socket.on('call:direct_no_answer').listen(_onNoAnswer),
      _socket.on('call:invite_ended').listen(_onInviteEnded),
      _socket.on('call:ended').listen(_onEnded),
    ]);
    // Çalarken ve görüşmede ekran kararmasın.
    WakelockPlus.enable().ignore();
    if (widget.outgoing) _dial();
  }

  @override
  void dispose() {
    for (final s in _subs) {
      s.cancel();
    }
    _clock?.cancel();
    WakelockPlus.disable().ignore();
    // Sayfa başka yoldan kapanırsa (geri hareketi vb.) sunucudaki durum da kapansın.
    _releaseServerState();
    if (_usedAgora) _agora.leave();
    super.dispose();
  }

  void _releaseServerState() {
    final callId = _callId;
    final inviteId = _inviteId;
    _callId = null;
    _inviteId = null;
    if (callId != null) {
      _socket.emit('call:end', {'callId': callId});
    } else if (inviteId != null) {
      _socket.emit(
        widget.outgoing ? 'call:direct_cancel' : 'call:decline',
        {'inviteId': inviteId},
      );
    }
  }

  void _toast(String text) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }

  /// Ekranı kapatır; [message] varsa önceki ekranda gösterilir.
  Future<void> _close([String? message]) async {
    if (_closed) return;
    _closed = true;
    _clock?.cancel();
    _releaseServerState();
    if (_usedAgora) {
      _usedAgora = false;
      await _agora.leave();
    }
    if (!mounted) return;
    if (message != null) _toast(message);
    Navigator.of(context).pop();
  }

  Future<void> _dial() async {
    try {
      final res = await _socket.request('call:direct', {
        'conversationId': widget.conversationId,
        'video': widget.video,
      });
      final id = res is Map ? res['inviteId'] as String? : null;
      if (_closed) {
        // Yanıt gelmeden kapatıldı: çalan aramayı da düşür.
        if (id != null) {
          _socket.emit('call:direct_cancel', {'inviteId': id});
        }
        return;
      }
      _inviteId = id;
    } catch (e) {
      if (!mounted || _closed) return;
      await _close(errorMessage(context, e));
    }
  }

  bool _isMyInvite(Map<String, dynamic> e) =>
      e['inviteId'] != null && e['inviteId'] == _inviteId;

  Future<void> _accept() async {
    final id = _inviteId;
    if (id == null || _accepting) return;
    final t = Translations.of(context).call;
    if (!await _agora.requestMic()) {
      _toast(t.micDenied);
      return;
    }
    if (!mounted) return;
    setState(() => _accepting = true);
    try {
      await _socket.request('call:accept', {'inviteId': id});
    } catch (e) {
      if (!mounted) return;
      _inviteId = null;
      await _close(errorMessage(context, e));
    }
  }

  void _decline() => _close();

  void _onStarted(Map<String, dynamic> e) {
    if (!mounted || _closed || !_isMyInvite(e)) return;
    // Aynı hesabın başka cihazı açtı: bu cihazdaki çalma ekranı kapanır.
    if (!widget.outgoing && !_accepting) {
      _inviteId = null;
      _close();
      return;
    }
    _inviteId = null;
    _callId = e['callId'] as String?;
    _peerUid = (e['peerUid'] as num?)?.toInt();
    _videoAllowed = e['videoAllowed'] == true;
    _startedAt = DateTime.now();
    setState(() {
      _phase = _DirectPhase.active;
      _seconds = 0;
    });
    _clock?.cancel();
    _clock = Timer.periodic(const Duration(seconds: 1), (timer) {
      final start = _startedAt;
      if (!mounted || start == null) {
        timer.cancel();
        return;
      }
      setState(() => _seconds = DateTime.now().difference(start).inSeconds);
    });
    _joinChannel(RtcCredentials.fromJson(e['rtc']), video: e['video'] == true);
  }

  Future<void> _joinChannel(RtcCredentials? rtc, {required bool video}) async {
    _usedAgora = true;
    final joined = await _agora.join(rtc, micOn: _micOn);
    if (!joined) return;
    if (!mounted || _closed) {
      // Kanala girilirken ekran kapandı.
      await _agora.leave();
      return;
    }
    await _agora.setPlayback(_speakerOn);
    if (!_videoAllowed) return;
    await _agora.enableVideoReceive();
    if (video && mounted && !_closed) await _startCamera();
  }

  Future<bool> _startCamera() async {
    final denied = Translations.of(context).call.cameraDenied;
    if (!await _agora.requestCamera()) {
      _toast(denied);
      return false;
    }
    final ok = await _agora.startVideo();
    if (!mounted || _closed) return false;
    if (ok) {
      setState(() {
        _videoStarted = true;
        _camOn = true;
      });
    }
    return ok;
  }

  void _onDeclined(Map<String, dynamic> e) {
    if (!mounted || !_isMyInvite(e)) return;
    _inviteId = null;
    _close(Translations.of(context).call.callDeclined);
  }

  void _onNoAnswer(Map<String, dynamic> e) {
    if (!mounted || !_isMyInvite(e)) return;
    _inviteId = null;
    _close(Translations.of(context).call.noAnswer);
  }

  /// Arayan vazgeçti / süre doldu / başka cihazda reddedildi.
  void _onInviteEnded(Map<String, dynamic> e) {
    if (!mounted || widget.outgoing || !_isMyInvite(e)) return;
    _inviteId = null;
    _close();
  }

  void _onEnded(Map<String, dynamic> e) {
    if (!mounted || _callId == null || e['callId'] != _callId) return;
    _callId = null;
    _close(e['byPeer'] == true ? Translations.of(context).call.peerLeft : null);
  }

  void _toggleSpeaker() {
    setState(() => _speakerOn = !_speakerOn);
    _agora.setPlayback(_speakerOn);
  }

  void _toggleMic() {
    setState(() => _micOn = !_micOn);
    _agora.setMic(_micOn);
  }

  /// Sesli görüşmede kamera: görüntüyü açar (anonim sohbette profiller açılana kadar kapalı).
  Future<void> _onCamera() async {
    if (_phase != _DirectPhase.active) return;
    if (!_videoAllowed) {
      _toast(Translations.of(context).chats.videoLocked);
      return;
    }
    if (_videoStarted) {
      setState(() => _camOn = true);
      await _agora.setCamera(true);
      return;
    }
    await _startCamera();
  }

  /// Görüntülü ekranda kamera aç/kapa.
  Future<void> _toggleCam() async {
    if (!_videoStarted) {
      await _startCamera();
      return;
    }
    setState(() => _camOn = !_camOn);
    await _agora.setCamera(_camOn);
  }

  Widget? _remoteVideo() {
    final engine = _agora.engine;
    final uid = _peerUid;
    final channel = _agora.channel;
    if (engine == null || uid == null || channel == null) return null;
    return ValueListenableBuilder<Set<int>>(
      valueListenable: _agora.remoteVideo,
      builder: (context, on, fallback) => on.contains(uid)
          ? AgoraVideoView(
              controller: VideoViewController.remote(
                rtcEngine: engine,
                canvas: VideoCanvas(uid: uid),
                connection: RtcConnection(channelId: channel),
              ),
            )
          : fallback!,
      child: _PeerPhoto(avatarUrl: widget.avatarUrl, gender: null),
    );
  }

  Widget? _localVideo() {
    final engine = _agora.engine;
    if (engine == null || !_camOn) return null;
    return AgoraVideoView(
      controller: VideoViewController(
        rtcEngine: engine,
        canvas: const VideoCanvas(uid: 0),
      ),
    );
  }

  Widget _body() {
    final t = Translations.of(context).call;
    switch (_phase) {
      case _DirectPhase.outgoing:
        return _NamedCallBody(
          gender: null,
          name: widget.name,
          avatarUrl: widget.avatarUrl,
          isAi: false,
          status: t.ringing,
          speakerOn: _speakerOn,
          micOn: _micOn,
          onToggleSpeaker: _toggleSpeaker,
          onToggleMic: _toggleMic,
          onCamera: _onCamera,
          onEnd: _close,
        );
      case _DirectPhase.incoming:
        return _VideoIncomingBody(
          gender: null,
          name: widget.name,
          avatarUrl: widget.avatarUrl,
          isAi: false,
          icon: widget.video
              ? AppAssets.iconCameraVoiceCall
              : AppAssets.navPhone,
          onDecline: _decline,
          onAccept: _accept,
        );
      case _DirectPhase.active:
        // Taraflardan birinin kamerası açıksa görüntülü düzen, değilse sesli.
        return ValueListenableBuilder<Set<int>>(
          valueListenable: _agora.remoteVideo,
          builder: (context, remote, _) {
            final showVideo = _camOn || remote.contains(_peerUid);
            if (!showVideo) {
              return _NamedCallBody(
                gender: null,
                name: widget.name,
                avatarUrl: widget.avatarUrl,
                isAi: false,
                status: _fmtClock(_seconds),
                speakerOn: _speakerOn,
                micOn: _micOn,
                onToggleSpeaker: _toggleSpeaker,
                onToggleMic: _toggleMic,
                onCamera: _onCamera,
                onEnd: _close,
              );
            }
            return _VideoActiveBody(
              gender: null,
              name: widget.name,
              avatarUrl: widget.avatarUrl,
              remoteVideo: _remoteVideo(),
              localVideo: _localVideo(),
              seconds: _seconds,
              camOn: _camOn,
              micOn: _micOn,
              onSwitchCamera: _agora.switchCamera,
              onToggleCam: _toggleCam,
              onToggleMic: _toggleMic,
              onEnd: _close,
            );
          },
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.viewPaddingOf(context).top;
    final bottom = MediaQuery.viewPaddingOf(context).bottom;
    final screenW = MediaQuery.sizeOf(context).width;
    final hPad = ((screenW - _contentWidth) / 2).clamp(16.0, 40.0);

    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(child: _SetupBackdrop()),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: top + 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: _close,
                    padding: EdgeInsets.zero,
                    constraints:
                        const BoxConstraints(minWidth: 44, minHeight: 44),
                    icon: SvgPicture.asset(
                      AppAssets.backButton,
                      width: 24,
                      height: 24,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(hPad, 0, hPad, 16 + bottom),
                  child: _body(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
