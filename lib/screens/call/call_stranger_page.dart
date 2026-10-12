import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/errors/error_messages.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/ai_badge.dart';
import 'package:veylo/core/widgets/animated_profile_ripple.dart';
import 'package:veylo/core/widgets/app_primary_button.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/data/remote/agora_service.dart';
import 'package:veylo/data/remote/api_client.dart';
import 'package:veylo/data/remote/chat_store.dart';
import 'package:veylo/data/remote/session_store.dart';
import 'package:veylo/data/remote/socket_service.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/screens/chat/widgets/chat_note_card.dart';

enum _StrangerGender { female, male, nonBinary, preferNotToSay }

enum _CallPhase {
  setup,
  finding,
  inCall,
  timesUp,
  /// Keep Talking → önce gelen arama (Decline/Accept)
  namedCallRinging,
  /// Accept sonrası aktif sesli arama (kontroller)
  namedCall,
  videoIncoming,
  videoActive,
}

/// Navbar Call — 60 Second Stranger (setup → finding → call → time's up).
class CallStrangerPage extends StatefulWidget {
  const CallStrangerPage({super.key});

  static Future<void> open(BuildContext context) {
    return Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (_) => const CallStrangerPage(),
      ),
    );
  }

  @override
  State<CallStrangerPage> createState() => _CallStrangerPageState();
}

class _CallStrangerPageState extends State<CallStrangerPage> {
  static const _contentWidth = 398.0;
  static const _callSeconds = 60;

  final _socket = SocketService.instance;
  final _agora = AgoraService.instance;
  final List<StreamSubscription<Map<String, dynamic>>> _subs = [];

  _StrangerGender? _gender = _StrangerGender.male;
  _CallPhase _phase = _CallPhase.setup;
  int _secondsLeft = _callSeconds;
  bool _speakerOn = true;
  bool _micOn = true;
  bool _camOn = true;
  bool _waitingOther = false;

  String? _callId;
  DateTime? _endsAt;
  int? _peerUid;
  String _peerName = '';
  String _peerAvatar = '';
  bool _peerIsAi = false;
  DateTime? _videoStartedAt;

  Timer? _callTimer;
  Timer? _videoTimer;
  int _videoSeconds = 0;

  @override
  void initState() {
    super.initState();
    _subs.addAll([
      _socket.on('call:matched').listen(_onMatched),
      _socket.on('call:times_up').listen(_onTimesUp),
      _socket.on('call:revealed').listen(_onRevealed),
      _socket.on('call:video_requested').listen(_onVideoRequested),
      _socket.on('call:video_declined').listen(_onVideoDeclined),
      _socket.on('call:video_started').listen(_onVideoStarted),
      _socket.on('call:video_ended').listen(_onVideoEnded),
      _socket.on('call:ended').listen(_onEnded),
      _socket.on('call:error').listen(_onCallError),
    ]);
  }

  @override
  void dispose() {
    for (final s in _subs) {
      s.cancel();
    }
    _callTimer?.cancel();
    _videoTimer?.cancel();
    // Sayfa başka yoldan kapanırsa (geri hareketi vb.) sunucudaki durum da kapansın.
    final callId = _callId;
    if (callId != null) {
      _socket.emit('call:end', {'callId': callId});
    } else if (_phase == _CallPhase.finding) {
      _socket.emit('call:cancel', {});
    }
    _agora.leave();
    super.dispose();
  }

  bool _isMine(Map<String, dynamic> e) => e['callId'] == _callId;

  /// "Prefer not to say" = rastgele (ücretsiz); cinsiyet seçimi 10 token.
  String get _target => switch (_gender) {
    _StrangerGender.female => 'female',
    _StrangerGender.male => 'male',
    _StrangerGender.nonBinary => 'nonBinary',
    _ => 'any',
  };

  void _toast(String text) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }

  Future<void> _startFinding() async {
    if (_gender == null) return;
    // İzin baştan istenir; eşleşince karşı taraf beklemesin.
    if (!await _agora.requestMic()) {
      if (mounted) _toast(Translations.of(context).call.micDenied);
      return;
    }
    if (!mounted) return;
    setState(() {
      _phase = _CallPhase.finding;
      _waitingOther = false;
    });
    try {
      await _socket.request('call:queue', {'target': _target});
    } catch (e) {
      if (!mounted) return;
      setState(() => _phase = _CallPhase.setup);
      _toast(errorMessage(context, e));
    }
  }

  void _cancelFinding() {
    _socket.request('call:cancel', {}).ignore();
    setState(() => _phase = _CallPhase.setup);
  }

  void _onMatched(Map<String, dynamic> e) {
    if (!mounted || _phase != _CallPhase.finding) return;
    _callId = e['callId'] as String;
    _endsAt = DateTime.tryParse(e['endsAt'] as String? ?? '')?.toLocal();
    _peerUid = (e['peerUid'] as num?)?.toInt();
    _agora.join(RtcCredentials.fromJson(e['rtc'])).then((_) {
      _agora.setMic(_micOn);
      _agora.setPlayback(_speakerOn);
    });
    _startInCall();
  }

  void _startInCall() {
    _callTimer?.cancel();
    setState(() {
      _phase = _CallPhase.inCall;
      _secondsLeft = _remaining();
    });
    _callTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      // Süre sunucuda tutulur; burada sadece gösterim (bitişi call:times_up söyler).
      final left = _remaining();
      if (left != _secondsLeft) setState(() => _secondsLeft = left);
      if (left == 0) timer.cancel();
    });
  }

  int _remaining() {
    final endsAt = _endsAt;
    if (endsAt == null) return _callSeconds;
    final s = endsAt.difference(DateTime.now()).inMilliseconds / 1000;
    return s.ceil().clamp(0, _callSeconds);
  }

  void _onTimesUp(Map<String, dynamic> e) {
    if (!mounted || !_isMine(e)) return;
    _callTimer?.cancel();
    setState(() {
      _secondsLeft = 0;
      _waitingOther = false;
      _phase = _CallPhase.timesUp;
    });
  }

  Future<void> _keepTalking() async {
    final callId = _callId;
    if (callId == null) return;
    setState(() => _waitingOther = true);
    try {
      await _socket.request('call:keep', {'callId': callId});
    } catch (e) {
      if (!mounted) return;
      setState(() => _waitingOther = false);
      _toast(errorMessage(context, e));
    }
  }

  /// İkisi de devam dedi: kimlikler açıldı, sohbet oluştu.
  void _onRevealed(Map<String, dynamic> e) {
    if (!mounted || !_isMine(e)) return;
    final peer = Map<String, dynamic>.from(e['peer'] as Map);
    ChatStore.instance.refresh();
    // Gelen arama ekranı: kabul edilene kadar ses kapalı.
    _agora.setMic(false);
    _agora.setPlayback(false);
    setState(() {
      _peerName = peer['displayName'] as String? ?? '';
      _peerAvatar = peer['avatarUrl'] as String? ?? '';
      _peerIsAi = peer['isAi'] == true;
      _waitingOther = false;
      _phase = _CallPhase.namedCallRinging;
    });
  }

  void _acceptNamedCall() {
    _agora.setMic(_micOn);
    _agora.setPlayback(_speakerOn);
    setState(() => _phase = _CallPhase.namedCall);
  }

  void _toggleSpeaker() {
    setState(() => _speakerOn = !_speakerOn);
    _agora.setPlayback(_speakerOn);
  }

  void _toggleMic() {
    setState(() => _micOn = !_micOn);
    _agora.setMic(_micOn);
  }

  void _toggleCam() {
    setState(() => _camOn = !_camOn);
    _agora.setCamera(_camOn);
  }

  Future<void> _endCall() async {
    final callId = _callId;
    _callId = null;
    _callTimer?.cancel();
    _videoTimer?.cancel();
    if (callId != null) {
      _socket.request('call:end', {'callId': callId}).ignore();
    }
    await _agora.leave();
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  void _onEnded(Map<String, dynamic> e) {
    if (!mounted || !_isMine(e)) return;
    final t = Translations.of(context).call;
    final reason = e['reason'] as String?;
    if (reason == 'NO_KEEP') {
      _toast(t.noKeep);
    } else if (e['byPeer'] == true) {
      _toast(t.peerLeft);
    }
    _callId = null;
    _endCall();
  }

  void _onCallError(Map<String, dynamic> e) {
    if (!mounted || _phase != _CallPhase.finding) return;
    setState(() => _phase = _CallPhase.setup);
    _toast(
      errorMessage(context, ApiException(code: e['code'] as String? ?? '')),
    );
  }

  // ───────────── görüntülü ─────────────

  /// Kamera: görüntülüye geçme isteği (isteyen 20 token öder, kabul edilirse).
  Future<void> _onVideoCallSheet() async {
    final callId = _callId;
    if (callId == null) return;
    final accepted = await showVideoCallSheet(context);
    if (accepted != true || !mounted) return;
    if (!await _agora.requestCamera()) {
      if (mounted) _toast(Translations.of(context).call.micDenied);
      return;
    }
    try {
      await _socket.request('call:video_request', {'callId': callId});
      if (mounted) _toast(Translations.of(context).call.videoWaiting);
    } catch (e) {
      if (mounted) _toast(errorMessage(context, e));
    }
  }

  void _onVideoRequested(Map<String, dynamic> e) {
    if (!mounted || !_isMine(e)) return;
    setState(() => _phase = _CallPhase.videoIncoming);
  }

  Future<void> _respondVideo(bool accept) async {
    final callId = _callId;
    if (callId == null) return;
    if (accept && !await _agora.requestCamera()) accept = false;
    if (!accept && mounted) setState(() => _phase = _CallPhase.namedCall);
    try {
      await _socket.request('call:video_respond', {
        'callId': callId,
        'accept': accept,
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _phase = _CallPhase.namedCall);
      _toast(errorMessage(context, e));
    }
  }

  void _onVideoDeclined(Map<String, dynamic> e) {
    if (!mounted || !_isMine(e)) return;
    _toast(Translations.of(context).call.videoDeclined);
  }

  Future<void> _onVideoStarted(Map<String, dynamic> e) async {
    if (!mounted || !_isMine(e)) return;
    await _agora.startVideo();
    _videoTimer?.cancel();
    _videoStartedAt ??= DateTime.now();
    if (!mounted) return;
    setState(() {
      _camOn = true;
      _phase = _CallPhase.videoActive;
      _videoSeconds = DateTime.now().difference(_videoStartedAt!).inSeconds;
    });
    _videoTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(
        () => _videoSeconds = DateTime.now()
            .difference(_videoStartedAt!)
            .inSeconds,
      );
    });
  }

  /// 15 dakikalık görüntülü süre doldu: sesli devam.
  Future<void> _onVideoEnded(Map<String, dynamic> e) async {
    if (!mounted || !_isMine(e)) return;
    _videoTimer?.cancel();
    _videoStartedAt = null;
    await _agora.stopVideo();
    if (mounted) setState(() => _phase = _CallPhase.namedCall);
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
      child: _PeerPhoto(avatarUrl: _peerAvatar, gender: _gender),
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

  void _onBack() {
    switch (_phase) {
      case _CallPhase.finding:
        _cancelFinding();
      case _CallPhase.inCall:
      case _CallPhase.timesUp:
      case _CallPhase.namedCallRinging:
      case _CallPhase.namedCall:
      case _CallPhase.videoIncoming:
      case _CallPhase.videoActive:
        _endCall();
      case _CallPhase.setup:
        Navigator.of(context).pop();
    }
  }

  bool get _isSetupPhase =>
      _phase == _CallPhase.setup || _phase == _CallPhase.finding;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).call;
    final top = MediaQuery.viewPaddingOf(context).top;
    final bottom = MediaQuery.viewPaddingOf(context).bottom;
    final screenW = MediaQuery.sizeOf(context).width;
    final hPad = ((screenW - _contentWidth) / 2).clamp(16.0, 40.0);

    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(
            child: _SetupBackdrop(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: top + 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: _onBack,
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
              if (_isSetupPhase) ...[
                // Figma: tam genişlik 430×282 — kenardan kesilmeden
                SizedBox(
                  width: screenW,
                  height: screenW * 267 / 512,
                  child: _StrangerMap(
                    finding: _phase == _CallPhase.finding,
                    avatarSize: 50,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(hPad, 8, hPad, 16 + bottom),
                    child: _SetupFindingBody(
                      finding: _phase == _CallPhase.finding,
                      free: _target == 'any',
                      gender: _gender,
                      onGender: (g) => setState(() => _gender = g),
                      onPrimary: _phase == _CallPhase.finding
                          ? _cancelFinding
                          : _startFinding,
                      t: t,
                    ),
                  ),
                ),
              ] else
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(hPad, 0, hPad, 16 + bottom),
                    child: switch (_phase) {
                      _CallPhase.inCall => _InCallBody(
                          secondsLeft: _secondsLeft,
                          speakerOn: _speakerOn,
                          micOn: _micOn,
                          onToggleSpeaker: _toggleSpeaker,
                          onToggleMic: _toggleMic,
                          onEnd: _endCall,
                          t: t,
                        ),
                      _CallPhase.timesUp => _TimesUpBody(
                          waitingOther: _waitingOther,
                          onKeepTalking: _keepTalking,
                          onEnd: _endCall,
                          t: t,
                        ),
                      // İkisi de devam dedi: kimliği açılan kişiden gelen arama (Decline / Accept)
                      _CallPhase.namedCallRinging => _VideoIncomingBody(
                          gender: _gender,
                          name: _peerName,
                          avatarUrl: _peerAvatar,
                          isAi: _peerIsAi,
                          onDecline: _endCall,
                          onAccept: _acceptNamedCall,
                        ),
                      // Accept sonrası: aktif konuşma kontrolleri
                      _CallPhase.namedCall => _NamedCallBody(
                          gender: _gender,
                          name: _peerName,
                          avatarUrl: _peerAvatar,
                          isAi: _peerIsAi,
                          speakerOn: _speakerOn,
                          micOn: _micOn,
                          onToggleSpeaker: _toggleSpeaker,
                          onToggleMic: _toggleMic,
                          onCamera: _onVideoCallSheet,
                          onEnd: _endCall,
                        ),
                      _CallPhase.videoIncoming => _VideoIncomingBody(
                          gender: _gender,
                          name: _peerName,
                          avatarUrl: _peerAvatar,
                          isAi: _peerIsAi,
                          onDecline: () => _respondVideo(false),
                          onAccept: () => _respondVideo(true),
                        ),
                      _CallPhase.videoActive => _VideoActiveBody(
                          gender: _gender,
                          name: _peerName,
                          avatarUrl: _peerAvatar,
                          remoteVideo: _remoteVideo(),
                          localVideo: _localVideo(),
                          seconds: _videoSeconds,
                          camOn: _camOn,
                          micOn: _micOn,
                          onSwitchCamera: _agora.switchCamera,
                          onToggleCam: _toggleCam,
                          onToggleMic: _toggleMic,
                          onEnd: _endCall,
                        ),
                      _ => const SizedBox.shrink(),
                    },
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}


/// Keep Talking sonrası kimlik açılan görüntülü arama ekranı (Victoria / Calling).
class _NamedCallBody extends StatelessWidget {
  const _NamedCallBody({
    required this.gender,
    required this.name,
    required this.avatarUrl,
    required this.isAi,
    required this.speakerOn,
    required this.micOn,
    required this.onToggleSpeaker,
    required this.onToggleMic,
    required this.onCamera,
    required this.onEnd,
  });

  final _StrangerGender? gender;
  final String name;
  final String avatarUrl;
  final bool isAi;
  final bool speakerOn;
  final bool micOn;
  final VoidCallback onToggleSpeaker;
  final VoidCallback onToggleMic;
  final VoidCallback onCamera;
  final VoidCallback onEnd;

  /// Figma: #000000 @ 20%
  static const _lightBg = Color(0x33000000);
  static const _iconGray = Color(0xFF8E8E93);

  Widget _lightIcon(String asset, {bool dim = false}) {
    return SvgPicture.asset(
      asset,
      width: 26,
      height: 26,
      colorFilter: ColorFilter.mode(
        _iconGray.withValues(alpha: dim ? 0.45 : 1),
        BlendMode.srcIn,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tr = LocaleSettings.currentLocale == AppLocale.tr;
    return Column(
      children: [
        _PeerName(name: name, isAi: isAi),
        Text(
          tr ? 'Aranıyor' : 'Calling',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: AppFonts.poppins,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            height: 24 / 20,
            letterSpacing: -0.4,
            color: AppColors.black,
          ),
        ),
        const Spacer(flex: 2),
        _PeerPhoto(avatarUrl: avatarUrl, gender: gender, size: 220),
        const Spacer(flex: 3),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _CallControlButton(
              onTap: onCamera,
              background: _lightBg,
              child: _lightIcon(AppAssets.iconCameraVoiceCall),
            ),
            const SizedBox(width: 10),
            _CallControlButton(
              onTap: onToggleSpeaker,
              background: _lightBg,
              child: _lightIcon(AppAssets.iconSpeaker, dim: !speakerOn),
            ),
            const SizedBox(width: 10),
            _CallControlButton(
              onTap: onToggleMic,
              background: _lightBg,
              child: _lightIcon(AppAssets.iconVoiceCallMicrophone, dim: !micOn),
            ),
            const SizedBox(width: 10),
            _CallControlButton(
              onTap: onEnd,
              background: const Color(0xFFF44336),
              child: SvgPicture.asset(
                AppAssets.iconClosedPhone,
                width: 26,
                height: 26,
                colorFilter: const ColorFilter.mode(
                  AppColors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

/// "Görüntülü aramaya geç?" bottom sheet.
Future<bool?> showVideoCallSheet(BuildContext context) {
  return showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => const _VideoCallSheet(),
  );
}

class _VideoCallSheet extends StatelessWidget {
  const _VideoCallSheet();

  @override
  Widget build(BuildContext context) {
    final tr = LocaleSettings.currentLocale == AppLocale.tr;
    final bottom = MediaQuery.paddingOf(context).bottom;
    final title = tr
        ? 'Görüntülü aramaya geçmek ister misin?'
        : 'Would you like to switch to a video call?';
    final accept = tr ? 'Kabul et' : 'Accept';

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 44),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            ),
            padding: EdgeInsets.fromLTRB(20, 64, 20, 20 + bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: AppFonts.poppins,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    height: 1.3,
                    letterSpacing: -0.4,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  Translations.of(context).call.videoCost,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: AppFonts.poppins,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black.withValues(alpha: 0.55),
                  ),
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(true),
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    width: double.infinity,
                    height: 54,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9999),
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Color(0xFF7B2FFF), Color(0xFF998FED)],
                      ),
                    ),
                    child: Text(
                      accept,
                      style: const TextStyle(
                        fontFamily: AppFonts.poppins,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.32,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              width: 88,
              height: 88,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.10),
                    blurRadius: 18,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Image.asset(
                AppAssets.iconVideoCallCamera,
                fit: BoxFit.contain,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
          Positioned(
            top: 60,
            right: 18,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              behavior: HitTestBehavior.opaque,
              child: SvgPicture.asset(
                AppAssets.iconCloseButton,
                width: 28,
                height: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String _fmtClock(int s) {
  final m = (s ~/ 60).toString().padLeft(2, '0');
  final sec = (s % 60).toString().padLeft(2, '0');
  return '$m:$sec';
}

/// Gelen görüntülü arama ekranı — Decline (kırmızı) / Accept (yeşil).
class _VideoIncomingBody extends StatelessWidget {
  const _VideoIncomingBody({
    required this.gender,
    required this.name,
    required this.avatarUrl,
    required this.isAi,
    required this.onDecline,
    required this.onAccept,
  });

  final _StrangerGender? gender;
  final String name;
  final String avatarUrl;
  final bool isAi;
  final VoidCallback onDecline;
  final VoidCallback onAccept;

  @override
  Widget build(BuildContext context) {
    final tr = LocaleSettings.currentLocale == AppLocale.tr;
    return Column(
      children: [
        _PeerName(name: name, isAi: isAi),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppAssets.iconCameraVoiceCall,
              width: 22,
              height: 22,
              colorFilter: const ColorFilter.mode(
                AppColors.black,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              tr ? 'Aranıyor' : 'Calling',
              style: const TextStyle(
                fontFamily: AppFonts.poppins,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                height: 24 / 20,
                letterSpacing: -0.4,
                color: AppColors.black,
              ),
            ),
          ],
        ),
        const Spacer(flex: 2),
        _PeerPhoto(avatarUrl: avatarUrl, gender: gender, size: 220),
        const Spacer(flex: 3),
        Row(
          children: [
            Expanded(
              child: _VideoAnswerAction(
                asset: AppAssets.iconDeclineCall,
                background: const Color(0xFFFC4F41),
                label: tr ? 'Reddet' : 'Decline',
                onTap: onDecline,
              ),
            ),
            Expanded(
              child: _VideoAnswerAction(
                asset: AppAssets.iconAcceptCall,
                background: const Color(0xFF4CD964),
                label: tr ? 'Kabul et' : 'Accept',
                onTap: onAccept,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _VideoAnswerAction extends StatelessWidget {
  const _VideoAnswerAction({
    required this.asset,
    required this.background,
    required this.label,
    required this.onTap,
  });

  final String asset;
  final Color background;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 70,
            height: 70,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: background,
            ),
            child: SvgPicture.asset(
              asset,
              width: 30,
              height: 30,
              colorFilter: const ColorFilter.mode(
                AppColors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontFamily: AppFonts.poppins,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              height: 1,
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }
}

/// Aktif görüntülü arama — iki video karesi + kontroller.
class _VideoActiveBody extends StatelessWidget {
  const _VideoActiveBody({
    required this.gender,
    required this.name,
    required this.avatarUrl,
    required this.remoteVideo,
    required this.localVideo,
    required this.onSwitchCamera,
    required this.seconds,
    required this.camOn,
    required this.micOn,
    required this.onToggleCam,
    required this.onToggleMic,
    required this.onEnd,
  });

  final _StrangerGender? gender;
  final String name;
  final String avatarUrl;
  final Widget? remoteVideo;
  final Widget? localVideo;
  final VoidCallback onSwitchCamera;
  final int seconds;
  final bool camOn;
  final bool micOn;
  final VoidCallback onToggleCam;
  final VoidCallback onToggleMic;
  final VoidCallback onEnd;

  Widget _videoFrame(Widget content, {Widget? overlay}) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.white.withValues(alpha: 0.4),
          width: 1,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          content,
          if (overlay != null) overlay,
        ],
      ),
    );
  }

  Widget _ctrl(String asset, VoidCallback onTap,
      {Color background = const Color(0x40FFFFFF), bool dim = false}) {
    return _CallControlButton(
      onTap: onTap,
      background: background,
      child: SvgPicture.asset(
        asset,
        width: 24,
        height: 24,
        colorFilter: ColorFilter.mode(
          AppColors.white.withValues(alpha: dim ? 0.45 : 1),
          BlendMode.srcIn,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final controls = Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        color: AppColors.black.withValues(alpha: 0.5),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _ctrl(AppAssets.iconRevertCamera, onSwitchCamera),
            const SizedBox(width: 12),
            _ctrl(AppAssets.iconCameraVoiceCall, onToggleCam, dim: !camOn),
            const SizedBox(width: 12),
            _ctrl(AppAssets.iconVoiceCallMicrophone, onToggleMic, dim: !micOn),
            const SizedBox(width: 12),
            _ctrl(
              AppAssets.iconClosedPhone,
              onEnd,
              background: const Color(0xFFFC4F41),
            ),
          ],
        ),
      ),
    );

    return Column(
      children: [
        _PeerName(name: name),
        Text(
          _fmtClock(seconds),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: AppFonts.poppins,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            height: 24 / 20,
            letterSpacing: -0.4,
            color: AppColors.black,
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: _videoFrame(
                  remoteVideo ??
                      _PeerPhoto(
                        avatarUrl: avatarUrl,
                        gender: gender,
                        size: double.infinity,
                        square: true,
                      ),
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: _videoFrame(
                  localVideo ??
                      _PeerPhoto(
                        avatarUrl: SessionStore.instance.me?.avatarUrl ?? '',
                        gender: null,
                        size: double.infinity,
                        square: true,
                      ),
                  overlay: controls,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

/// Kimliği açılan kişinin adı (AI karakteriyse rozetli).
class _PeerName extends StatelessWidget {
  const _PeerName({required this.name, this.isAi = false});

  final String name;
  final bool isAi;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: AppFonts.poppins,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              height: 24 / 16,
              letterSpacing: -0.32,
              color: AppColors.black.withValues(alpha: 0.65),
            ),
          ),
        ),
        if (isAi) const AiBadge(),
      ],
    );
  }
}

/// Karşı tarafın fotoğrafı; yoksa tasarımdaki yer tutucu.
class _PeerPhoto extends StatelessWidget {
  const _PeerPhoto({
    required this.avatarUrl,
    required this.gender,
    this.size = 220,
    this.square = false,
  });

  final String avatarUrl;
  final _StrangerGender? gender;
  final double size;
  final bool square;

  @override
  Widget build(BuildContext context) {
    // Fotoğrafı yoksa yer tutucu (başka birinin fotoğrafı gösterilmez).
    final Widget image = size.isFinite
        ? ChatAvatarImage(url: avatarUrl, size: size)
        : LayoutBuilder(
            builder: (context, c) => ChatAvatarImage(
              url: avatarUrl,
              size: c.biggest.shortestSide,
            ),
          );
    return square ? image : ClipOval(child: image);
  }
}

class _SetupBackdrop extends StatelessWidget {
  const _SetupBackdrop();

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: AppColors.white,
      child: SizedBox.expand(
        child: Image(
          image: AssetImage(AppAssets.callStrangerBg),
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
      ),
    );
  }
}

class _StrangerMap extends StatelessWidget {
  const _StrangerMap({required this.finding, required this.avatarSize});

  final bool finding;
  final double avatarSize;

  // Harita (512x267) uzerindeki avatar merkezleri — (w, h) orani.
  static const _positions = <Offset>[
    Offset(0.16, 0.34),
    Offset(0.29, 0.70),
    Offset(0.47, 0.26),
    Offset(0.55, 0.60),
    Offset(0.80, 0.40),
  ];

  // Sol alt (index 1) belirgin; diğerleri soft
  static const _intensities = <double>[0.55, 1.0, 0.5, 0.55, 0.75];

  Widget _avatar() {
    return ClipOval(
      child: Image.asset(
        AppAssets.strangerAvatar,
        width: avatarSize,
        height: avatarSize,
        fit: BoxFit.cover,
        filterQuality: FilterQuality.high,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final w = c.maxWidth;
        final h = c.maxHeight;
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              child: Image.asset(
                AppAssets.callStrangerMapPlain,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                filterQuality: FilterQuality.high,
              ),
            ),
            for (var i = 0; i < _positions.length; i++)
              Positioned(
                left: _positions[i].dx * w - avatarSize / 2,
                top: _positions[i].dy * h - avatarSize / 2,
                child: finding
                    ? PreparingProfileRipple(
                        avatarSize: avatarSize,
                        phase: i / _positions.length,
                        intensity: _intensities[i],
                        ringCount: _intensities[i] >= 0.9 ? 4 : 3,
                        child: _avatar(),
                      )
                    : _avatar(),
              ),
          ],
        );
      },
    );
  }
}

class _SetupFindingBody extends StatelessWidget {
  const _SetupFindingBody({
    required this.finding,
    required this.free,
    required this.gender,
    required this.onGender,
    required this.onPrimary,
    required this.t,
  });

  final bool finding;
  final bool free;
  final _StrangerGender? gender;
  final ValueChanged<_StrangerGender> onGender;
  final VoidCallback onPrimary;
  final Translations$call$tr t;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppText(
          finding ? t.findingTitle : t.title,
          style: AppTextStyles.callStrangerTitle,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        AppText(
          finding ? t.findingSubtitle : t.subtitle,
          style: AppTextStyles.callStrangerSubtitle,
          textAlign: TextAlign.center,
        ),
        if (!finding) ...[
          const SizedBox(height: 20),
          _GenderGrid(
            selected: gender,
            onSelected: onGender,
            female: t.female,
            male: t.male,
            nonBinary: t.nonBinary,
            preferNotToSay: t.preferNotToSay,
          ),
        ],
        const Spacer(),
        _DarkCta(
          label: finding
              ? t.cancel
              : (free ? t.callStrangerFree : t.callStranger),
          onPressed: onPrimary,
        ),
      ],
    );
  }
}

class _InCallBody extends StatelessWidget {
  const _InCallBody({
    required this.secondsLeft,
    required this.speakerOn,
    required this.micOn,
    required this.onToggleSpeaker,
    required this.onToggleMic,
    required this.onEnd,
    required this.t,
  });

  final int secondsLeft;
  final bool speakerOn;
  final bool micOn;
  final VoidCallback onToggleSpeaker;
  final VoidCallback onToggleMic;
  final VoidCallback onEnd;
  final Translations$call$tr t;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(flex: 2),
        Transform.translate(
          offset: const Offset(0, -50),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const _AnonymousBadge(),
              const SizedBox(height: 16),
              const _StrangerAvatar(),
              const SizedBox(height: 16),
              AppText(
                t.stranger,
                style: AppTextStyles.callInCallName,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              AppText(
                t.secondsLeft(n: secondsLeft),
                style: AppTextStyles.callInCallTimer,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const Spacer(flex: 3),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _CallControlButton(
              onTap: onToggleSpeaker,
              background: const Color(0x33000000),
              child: SvgPicture.asset(
                AppAssets.iconSpeaker,
                width: 26,
                height: 26,
                colorFilter: ColorFilter.mode(
                  AppColors.white.withValues(alpha: speakerOn ? 1 : 0.45),
                  BlendMode.srcIn,
                ),
              ),
            ),
            const SizedBox(width: 10),
            _CallControlButton(
              onTap: onEnd,
              background: const Color(0xFFF44336),
              child: SvgPicture.asset(
                AppAssets.iconClosedPhone,
                width: 26,
                height: 26,
                colorFilter: const ColorFilter.mode(
                  AppColors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
            const SizedBox(width: 10),
            _CallControlButton(
              onTap: onToggleMic,
              background: const Color(0x33000000),
              child: SvgPicture.asset(
                AppAssets.iconVoiceCallMicrophone,
                width: 26,
                height: 26,
                colorFilter: ColorFilter.mode(
                  AppColors.white.withValues(alpha: micOn ? 1 : 0.45),
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

class _TimesUpBody extends StatelessWidget {
  const _TimesUpBody({
    required this.waitingOther,
    required this.onKeepTalking,
    required this.onEnd,
    required this.t,
  });

  final bool waitingOther;
  final VoidCallback onKeepTalking;
  final VoidCallback onEnd;
  final Translations$call$tr t;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(flex: 2),
        Image.asset(
          AppAssets.clock,
          width: 140,
          height: 140,
          filterQuality: FilterQuality.high,
        ),
        const SizedBox(height: 20),
        AppText(
          t.timesUpTitle,
          style: AppTextStyles.callStrangerTitle,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: AppText(
            t.timesUpSubtitle,
            style: AppTextStyles.callStrangerSubtitle,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 28),
        AppPrimaryButton(
          label: t.keepTalking,
          onPressed: waitingOther ? null : onKeepTalking,
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: onEnd,
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: AppText(
              t.endCall,
              style: AppTextStyles.callEndCall,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(height: 20),
        AppText(
          t.waitingOther,
          style: AppTextStyles.callWaiting,
          textAlign: TextAlign.center,
        ),
        const Spacer(flex: 3),
      ],
    );
  }
}

class _AnonymousBadge extends StatelessWidget {
  const _AnonymousBadge();

  @override
  Widget build(BuildContext context) {
    final label = Translations.of(context).call.anonymousBadge;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0x1A7B2FFF),
        borderRadius: BorderRadius.circular(999),
      ),
      child: AppText(
        label,
        style: AppTextStyles.callAnonymousBadge,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _StrangerAvatar extends StatelessWidget {
  const _StrangerAvatar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 214,
      height: 214,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.white.withValues(alpha: 0.4),
        border: Border.all(
          color: AppColors.white.withValues(alpha: 0.4),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.selectionBorder.withValues(alpha: 0.18),
            blurRadius: 40,
            spreadRadius: 4,
          ),
        ],
      ),
      child: Container(
        width: 186,
        height: 186,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.selectionBorder.withValues(alpha: 0.4),
        ),
        alignment: Alignment.center,
        child: const Icon(
          Icons.person_rounded,
          size: 96,
          color: AppColors.selectionBorder,
        ),
      ),
    );
  }
}

class _CallControlButton extends StatelessWidget {
  const _CallControlButton({
    required this.onTap,
    required this.background,
    required this.child,
  });

  final VoidCallback onTap;
  final Color background;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: background,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 56,
          height: 56,
          child: Center(child: child),
        ),
      ),
    );
  }
}

class _GenderGrid extends StatelessWidget {
  const _GenderGrid({
    required this.selected,
    required this.onSelected,
    required this.female,
    required this.male,
    required this.nonBinary,
    required this.preferNotToSay,
  });

  final _StrangerGender? selected;
  final ValueChanged<_StrangerGender> onSelected;
  final String female;
  final String male;
  final String nonBinary;
  final String preferNotToSay;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _GenderChip(
                label: female,
                selected: selected == _StrangerGender.female,
                onTap: () => onSelected(_StrangerGender.female),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _GenderChip(
                label: male,
                selected: selected == _StrangerGender.male,
                onTap: () => onSelected(_StrangerGender.male),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _GenderChip(
                label: nonBinary,
                selected: selected == _StrangerGender.nonBinary,
                onTap: () => onSelected(_StrangerGender.nonBinary),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _GenderChip(
                label: preferNotToSay,
                selected: selected == _StrangerGender.preferNotToSay,
                onTap: () => onSelected(_StrangerGender.preferNotToSay),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _GenderChip extends StatelessWidget {
  const _GenderChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  static const _fill = Color(0x1A998FED);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Ink(
          height: 52,
          decoration: BoxDecoration(
            color: _fill,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: selected ? AppColors.selectionBorder : Colors.transparent,
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: AppText(
                label,
                style: selected
                    ? AppTextStyles.callGenderSelected
                    : AppTextStyles.callGenderIdle,
                textAlign: TextAlign.center,
                maxLines: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DarkCta extends StatelessWidget {
  const _DarkCta({
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.editSheetButton,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(999),
        child: SizedBox(
          width: double.infinity,
          height: 54,
          child: Center(
            child: AppText(label, style: AppTextStyles.callStrangerCta),
          ),
        ),
      ),
    );
  }
}
