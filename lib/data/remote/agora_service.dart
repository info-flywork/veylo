import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

/// Backend'in verdiği ses/görüntü kanalı bilgisi (`rtc`). Agora ayarlı değilse null gelir.
class RtcCredentials {
  const RtcCredentials({
    required this.appId,
    required this.channel,
    required this.uid,
    required this.token,
  });

  final String appId;
  final String channel;
  final int uid;
  final String token;

  static RtcCredentials? fromJson(Object? json) {
    if (json is! Map) return null;
    return RtcCredentials(
      appId: json['appId'] as String,
      channel: json['channel'] as String,
      uid: (json['uid'] as num).toInt(),
      token: json['token'] as String,
    );
  }
}

/// Tek bir Agora motoru: aynı anda bir arama ya da bir oda.
/// Agora yapılandırılmamışsa (rtc null) akış sessiz devam eder.
class AgoraService {
  AgoraService._();

  static final AgoraService instance = AgoraService._();

  RtcEngine? _engine;
  String? _appId;
  String? _channel;

  /// Kanaldaki diğer kişilerin uid'leri.
  final ValueNotifier<Set<int>> remoteUids = ValueNotifier(const {});

  /// Şu an konuşanlar. Kendimiz [localUid] ile yer alırız.
  final ValueNotifier<Set<int>> speaking = ValueNotifier(const {});

  /// Görüntüsü açık olan uzak kişiler.
  final ValueNotifier<Set<int>> remoteVideo = ValueNotifier(const {});

  int localUid = 0;

  RtcEngine? get engine => _engine;
  String? get channel => _channel;
  bool get inChannel => _channel != null;

  Future<bool> _ensureEngine(String appId) async {
    if (_engine != null && _appId == appId) return true;
    await _disposeEngine();
    final engine = createAgoraRtcEngine();
    await engine.initialize(
      RtcEngineContext(
        appId: appId,
        channelProfile: ChannelProfileType.channelProfileCommunication,
      ),
    );
    engine.registerEventHandler(
      RtcEngineEventHandler(
        onUserJoined: (_, uid, _) =>
            remoteUids.value = {...remoteUids.value, uid},
        onUserOffline: (_, uid, _) {
          remoteUids.value = {...remoteUids.value}..remove(uid);
          remoteVideo.value = {...remoteVideo.value}..remove(uid);
          speaking.value = {...speaking.value}..remove(uid);
        },
        onRemoteVideoStateChanged: (_, uid, state, _, _) {
          final on =
              state == RemoteVideoState.remoteVideoStateDecoding ||
              state == RemoteVideoState.remoteVideoStateStarting;
          final next = {...remoteVideo.value};
          on ? next.add(uid) : next.remove(uid);
          remoteVideo.value = next;
        },
        onAudioVolumeIndication: (_, speakers, _, _) {
          // Yerel rapor uid=0 ile gelir, uzak rapor gerçek uid'lerle.
          final local = speakers.any((s) => s.uid == 0);
          final next = {...speaking.value};
          if (local) {
            next.remove(localUid);
          } else {
            next.removeWhere((u) => u != localUid);
          }
          for (final s in speakers) {
            if ((s.volume ?? 0) < 20) continue;
            if (s.uid == 0 && s.vad != 1) continue;
            next.add(s.uid == 0 ? localUid : s.uid!);
          }
          speaking.value = next;
        },
        onError: (err, msg) => debugPrint('Agora hata: $err $msg'),
      ),
    );
    await engine.enableAudio();
    await engine.enableAudioVolumeIndication(
      interval: 400,
      smooth: 3,
      reportVad: true,
    );
    _engine = engine;
    _appId = appId;
    return true;
  }

  /// Mikrofon iznini ister. Reddedilirse false.
  Future<bool> requestMic() async =>
      (await Permission.microphone.request()).isGranted;

  Future<bool> requestCamera() async =>
      (await Permission.camera.request()).isGranted;

  /// Kanala ses ile girer. [micOn] false ise dinleyici gibi (yayın kapalı) başlar.
  Future<bool> join(RtcCredentials? rtc, {bool micOn = true}) async {
    if (rtc == null) {
      debugPrint('Agora: kanal bilgisi yok (sunucuda AGORA_APP_ID boş)');
      return false;
    }
    if (micOn && !await requestMic()) micOn = false;
    try {
      await _ensureEngine(rtc.appId);
      if (_channel != null) await leave();
      localUid = rtc.uid;
      final engine = _engine!;
      await engine.setDefaultAudioRouteToSpeakerphone(true);
      await engine.joinChannel(
        token: rtc.token,
        channelId: rtc.channel,
        uid: rtc.uid,
        options: ChannelMediaOptions(
          clientRoleType: ClientRoleType.clientRoleBroadcaster,
          publishMicrophoneTrack: true,
          autoSubscribeAudio: true,
          autoSubscribeVideo: true,
        ),
      );
      await engine.muteLocalAudioStream(!micOn);
      _channel = rtc.channel;
      return true;
    } catch (e) {
      debugPrint('Agora kanala girilemedi: $e');
      return false;
    }
  }

  Future<void> setMic(bool on) async {
    if (on && !await requestMic()) return;
    await _engine?.muteLocalAudioStream(!on);
  }

  Future<void> setSpeaker(bool on) async {
    if (_channel == null) return;
    await _engine?.setEnableSpeakerphone(on);
  }

  /// Uzaktan gelen sesi kapatır/açar (hoparlör kapalıyken sessiz).
  Future<void> setPlayback(bool on) async =>
      _engine?.muteAllRemoteAudioStreams(!on);

  Future<bool> startVideo() async {
    final engine = _engine;
    if (engine == null || _channel == null) return false;
    if (!await requestCamera()) return false;
    await engine.enableVideo();
    await engine.startPreview();
    await engine.updateChannelMediaOptions(
      const ChannelMediaOptions(publishCameraTrack: true),
    );
    return true;
  }

  Future<void> setCamera(bool on) async {
    final engine = _engine;
    if (engine == null) return;
    await engine.enableLocalVideo(on);
    await engine.muteLocalVideoStream(!on);
  }

  Future<void> switchCamera() async => _engine?.switchCamera();

  Future<void> stopVideo() async {
    final engine = _engine;
    if (engine == null) return;
    await engine.updateChannelMediaOptions(
      const ChannelMediaOptions(publishCameraTrack: false),
    );
    await engine.stopPreview();
    await engine.disableVideo();
    remoteVideo.value = const {};
  }

  Future<void> leave() async {
    final engine = _engine;
    _channel = null;
    remoteUids.value = const {};
    remoteVideo.value = const {};
    speaking.value = const {};
    if (engine == null) return;
    try {
      await engine.stopPreview();
      await engine.disableVideo();
      await engine.leaveChannel();
    } catch (e) {
      debugPrint('Agora çıkış: $e');
    }
  }

  Future<void> _disposeEngine() async {
    final engine = _engine;
    _engine = null;
    _appId = null;
    if (engine == null) return;
    await engine.leaveChannel();
    await engine.release();
  }
}
