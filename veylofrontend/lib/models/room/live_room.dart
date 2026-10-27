/// Odadaki kişinin herkese görünen hali. Anonimde [userId] yok, ad maskeli, foto bulanık.
class RoomParticipant {
  const RoomParticipant({
    required this.uid,
    required this.userId,
    required this.displayName,
    required this.avatarUrl,
    required this.blurred,
    required this.isAi,
    required this.micOn,
    required this.isHost,
  });

  factory RoomParticipant.fromJson(Map<String, dynamic> j) => RoomParticipant(
    uid: (j['uid'] as num).toInt(),
    userId: j['userId'] as String?,
    displayName: j['displayName'] as String? ?? '',
    avatarUrl: j['avatarUrl'] as String? ?? '',
    blurred: j['blurred'] == true,
    isAi: j['isAi'] == true,
    micOn: j['micOn'] == true,
    isHost: j['isHost'] == true,
  );

  /// Agora kanalındaki uid (konuşan göstergesi).
  final int uid;
  final String? userId;
  final String displayName;
  final String avatarUrl;
  final bool blurred;
  final bool isAi;
  final bool micOn;
  final bool isHost;
}

class RoomChatLine {
  const RoomChatLine({
    required this.id,
    required this.sender,
    required this.body,
  });

  factory RoomChatLine.fromJson(Map<String, dynamic> j) => RoomChatLine(
    id: j['id'] as String,
    sender: RoomParticipant.fromJson(
      Map<String, dynamic>.from(j['sender'] as Map),
    ),
    body: j['body'] as String? ?? '',
  );

  final String id;
  final RoomParticipant sender;
  final String body;
}

/// `GET /rooms` satırı.
class LiveRoomSummary {
  const LiveRoomSummary({
    required this.id,
    required this.title,
    required this.isPrivate,
    required this.host,
    required this.participantCount,
    required this.avatars,
    required this.isHost,
    required this.hasAccess,
    required this.requested,
  });

  factory LiveRoomSummary.fromJson(Map<String, dynamic> j) => LiveRoomSummary(
    id: j['id'] as String,
    title: j['title'] as String? ?? '',
    isPrivate: j['isPrivate'] == true,
    host: RoomParticipant.fromJson(Map<String, dynamic>.from(j['host'] as Map)),
    participantCount: (j['participantCount'] as num?)?.toInt() ?? 0,
    avatars: (j['avatars'] as List? ?? const []).cast<String>(),
    isHost: j['isHost'] == true,
    hasAccess: j['hasAccess'] == true,
    requested: j['requested'] == true,
  );

  final String id;
  final String title;
  final bool isPrivate;
  final RoomParticipant host;
  final int participantCount;
  final List<String> avatars;
  final bool isHost;
  final bool hasAccess;
  final bool requested;

  LiveRoomSummary copyWith({bool? requested}) => LiveRoomSummary(
    id: id,
    title: title,
    isPrivate: isPrivate,
    host: host,
    participantCount: participantCount,
    avatars: avatars,
    isHost: isHost,
    hasAccess: hasAccess,
    requested: requested ?? this.requested,
  );
}
