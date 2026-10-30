import 'package:veylo/data/remote/agora_service.dart';
import 'package:veylo/data/remote/api_client.dart';
import 'package:veylo/data/remote/socket_service.dart';
import 'package:veylo/models/room/live_room.dart';

/// `room:join` cevabı: ses kanalı + katılımcılar + son mesajlar.
class RoomSession {
  const RoomSession({
    required this.roomId,
    required this.title,
    required this.isHost,
    required this.rtc,
    required this.me,
    required this.participants,
    required this.messages,
  });

  factory RoomSession.fromJson(Map<String, dynamic> j) {
    final room = Map<String, dynamic>.from(j['room'] as Map);
    return RoomSession(
      roomId: room['id'] as String,
      title: room['title'] as String? ?? '',
      isHost: room['isHost'] == true,
      rtc: RtcCredentials.fromJson(j['rtc']),
      me: RoomParticipant.fromJson(Map<String, dynamic>.from(j['me'] as Map)),
      participants: [
        for (final p in (j['participants'] as List).cast<Map>())
          RoomParticipant.fromJson(Map<String, dynamic>.from(p)),
      ],
      messages: [
        for (final m in (j['messages'] as List).cast<Map>())
          RoomChatLine.fromJson(Map<String, dynamic>.from(m)),
      ],
    );
  }

  final String roomId;
  final String title;
  final bool isHost;
  final RtcCredentials? rtc;
  final RoomParticipant me;
  final List<RoomParticipant> participants;
  final List<RoomChatLine> messages;
}

/// Canlı odalar: liste/oluşturma/istekler REST, katılım ve sohbet socket.
class RoomRepository {
  RoomRepository._();

  static final RoomRepository instance = RoomRepository._();

  final _api = ApiClient.instance;
  final _socket = SocketService.instance;

  Future<List<LiveRoomSummary>> list() async {
    final res = await _api.get('/rooms') as Map;
    return [
      for (final j in (res['items'] as List).cast<Map>())
        LiveRoomSummary.fromJson(Map<String, dynamic>.from(j)),
    ];
  }

  /// Oda açmak 50 token.
  Future<String> create({
    required String title,
    required bool anonymous,
    bool isPrivate = false,
  }) async {
    final res =
        await _api.post(
              '/rooms',
              body: {
                'title': title,
                'anonymous': anonymous,
                'isPrivate': isPrivate,
              },
            )
            as Map;
    return res['id'] as String;
  }

  Future<void> requestJoin(String roomId, {String? message}) => _api.post(
    '/rooms/$roomId/requests',
    body: {if (message != null && message.isNotEmpty) 'message': message},
  );

  Future<RoomSession> join(String roomId, {bool anonymous = false}) async =>
      RoomSession.fromJson(
        Map<String, dynamic>.from(
          await _socket.request('room:join', {
                'roomId': roomId,
                'anonymous': anonymous,
              })
              as Map,
        ),
      );

  Future<void> leave(String roomId) =>
      _socket.request('room:leave', {'roomId': roomId});

  Future<void> kick(String roomId, int uid) =>
      _socket.request('room:kick', {'roomId': roomId, 'uid': uid});

  Future<void> setMic(String roomId, bool on) =>
      _socket.request('room:mic', {'roomId': roomId, 'on': on});

  Future<void> send(String roomId, String body) =>
      _socket.request('room:message', {'roomId': roomId, 'body': body});
}
