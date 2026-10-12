/// Rooms > All Groups kartı (`GET /groups`).
class GroupSummary {
  const GroupSummary({
    required this.id,
    required this.title,
    required this.isPrivate,
    required this.memberCount,
    required this.activeCount,
    required this.avatars,
    this.isMember = false,
    this.requested = false,
  });

  final String id;
  final String title;
  final bool isPrivate;
  final int memberCount;

  /// Şu an bağlı üye sayısı.
  final int activeCount;
  final List<String> avatars;
  final bool isMember;

  /// Gizli gruba gönderilmiş, bekleyen katılma isteğim var.
  final bool requested;

  factory GroupSummary.fromJson(Map<String, dynamic> j) => GroupSummary(
    id: j['id'] as String,
    title: j['title'] as String? ?? '',
    isPrivate: j['isPrivate'] as bool? ?? false,
    memberCount: (j['memberCount'] as num?)?.toInt() ?? 0,
    activeCount: (j['activeCount'] as num?)?.toInt() ?? 0,
    avatars: (j['avatars'] as List? ?? const []).cast<String>(),
    isMember: j['isMember'] as bool? ?? false,
    requested: j['requested'] as bool? ?? false,
  );

  GroupSummary copyWith({bool? requested, bool? isMember, int? memberCount}) =>
      GroupSummary(
        id: id,
        title: title,
        isPrivate: isPrivate,
        memberCount: memberCount ?? this.memberCount,
        activeCount: activeCount,
        avatars: avatars,
        isMember: isMember ?? this.isMember,
        requested: requested ?? this.requested,
      );
}

/// Grup üyesi. Anonim üyede [userId] null, ad maskeli, foto bulanık.
class GroupMember {
  const GroupMember({
    required this.memberId,
    required this.displayName,
    this.userId,
    this.username,
    this.avatarUrl,
    this.blurred = false,
    this.role = 'MEMBER',
    this.isYou = false,
    this.isAi = false,
  });

  /// Yönetici işlemleri için gruba özel id.
  final String memberId;
  final String? userId;
  final String? username;
  final String displayName;
  final String? avatarUrl;
  final bool blurred;

  /// OWNER | ADMIN | MEMBER
  final String role;
  final bool isYou;

  /// Veylo'nun AI karakteri ("AI" rozeti).
  final bool isAi;

  bool get isAdmin => role == 'OWNER' || role == 'ADMIN';

  factory GroupMember.fromJson(Map<String, dynamic> j) => GroupMember(
    memberId: j['memberId'] as String? ?? '',
    userId: j['id'] as String?,
    username: j['username'] as String?,
    displayName: j['displayName'] as String? ?? '',
    avatarUrl: j['avatarUrl'] as String?,
    blurred: j['avatarBlurred'] as bool? ?? false,
    role: j['role'] as String? ?? 'MEMBER',
    isYou: j['isYou'] as bool? ?? false,
    isAi: j['isAi'] as bool? ?? false,
  );
}

/// Grup bilgi ekranı (`GET /groups/:id`).
class GroupInfo {
  const GroupInfo({
    required this.id,
    required this.title,
    required this.isPrivate,
    required this.memberCount,
    required this.myRole,
    required this.muted,
    required this.pendingRequests,
    required this.members,
  });

  final String id;
  final String title;
  final bool isPrivate;
  final int memberCount;
  final String myRole;
  final bool muted;
  final int pendingRequests;
  final List<GroupMember> members;

  bool get amAdmin => myRole == 'OWNER' || myRole == 'ADMIN';
  bool get amOwner => myRole == 'OWNER';

  factory GroupInfo.fromJson(Map<String, dynamic> j) => GroupInfo(
    id: j['id'] as String,
    title: j['title'] as String? ?? '',
    isPrivate: j['isPrivate'] as bool? ?? false,
    memberCount: (j['memberCount'] as num?)?.toInt() ?? 0,
    myRole: j['myRole'] as String? ?? 'MEMBER',
    muted: j['muted'] as bool? ?? false,
    pendingRequests: (j['pendingRequests'] as num?)?.toInt() ?? 0,
    members: [
      for (final m in (j['members'] as List? ?? const []).cast<Map>())
        GroupMember.fromJson(Map<String, dynamic>.from(m)),
    ],
  );
}

/// Gizli gruba katılma isteği (yönetici görür).
class GroupJoinRequest {
  const GroupJoinRequest({required this.id, required this.user, this.message});

  final String id;
  final GroupMember user;
  final String? message;

  factory GroupJoinRequest.fromJson(Map<String, dynamic> j) => GroupJoinRequest(
    id: j['id'] as String,
    message: j['message'] as String?,
    user: GroupMember.fromJson(
      Map<String, dynamic>.from(j['user'] as Map? ?? const {}),
    ),
  );
}
