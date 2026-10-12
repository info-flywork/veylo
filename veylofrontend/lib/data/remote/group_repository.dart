import 'package:veylo/data/remote/api_client.dart';
import 'package:veylo/models/chat/chat_thread.dart';
import 'package:veylo/models/group/group_models.dart';

/// Kişi seçicide gösterilen kullanıcı.
typedef PersonSummary = ({
  String id,
  String name,
  String? username,
  String? avatarUrl,
});

/// Grup uç noktaları (`/groups`). Mesajlaşma `/conversations` üzerinden yapılır.
class GroupRepository {
  GroupRepository._();

  static final GroupRepository instance = GroupRepository._();

  final _api = ApiClient.instance;

  Future<List<GroupSummary>> discover({String? query}) async {
    final res = await _api.get('/groups', query: {'q': ?query}) as Map;
    return [
      for (final j in (res['items'] as List).cast<Map>())
        GroupSummary.fromJson(Map<String, dynamic>.from(j)),
    ];
  }

  Future<ChatThread> create({
    required String title,
    required bool anonymous,
  }) async => _thread(
    await _api.post('/groups', body: {'title': title, 'anonymous': anonymous}),
  );

  Future<GroupInfo> info(String id) async => GroupInfo.fromJson(
    Map<String, dynamic>.from(await _api.get('/groups/$id') as Map),
  );

  Future<GroupInfo> setPrivate(String id, bool isPrivate) async =>
      GroupInfo.fromJson(
        Map<String, dynamic>.from(
          await _api.patch('/groups/$id', body: {'isPrivate': isPrivate})
              as Map,
        ),
      );

  Future<ChatThread> join(String id) async =>
      _thread(await _api.post('/groups/$id/join', body: const {}));

  Future<void> requestJoin(String id, {String? message}) => _api.post(
    '/groups/$id/requests',
    body: {if (message != null && message.isNotEmpty) 'message': message},
  );

  Future<List<GroupJoinRequest>> requests(String id) async =>
      _requests(await _api.get('/groups/$id/requests'));

  Future<List<GroupJoinRequest>> decide(
    String id,
    String requestId, {
    required bool approve,
  }) async => _requests(
    await _api.post(
      '/groups/$id/requests/$requestId',
      body: {'approve': approve},
    ),
  );

  Future<GroupInfo> addMembers(String id, List<String> userIds) async =>
      GroupInfo.fromJson(
        Map<String, dynamic>.from(
          await _api.post('/groups/$id/members', body: {'userIds': userIds})
              as Map,
        ),
      );

  Future<GroupInfo> removeMember(String id, String memberId) async =>
      GroupInfo.fromJson(
        Map<String, dynamic>.from(
          await _api.delete('/groups/$id/members/$memberId') as Map,
        ),
      );

  Future<GroupInfo> setRole(String id, String memberId, String role) async =>
      GroupInfo.fromJson(
        Map<String, dynamic>.from(
          await _api.patch(
                '/groups/$id/members/$memberId',
                body: {'role': role},
              )
              as Map,
        ),
      );

  Future<void> leave(String id) => _api.delete('/groups/$id/members/me');

  /// Kişi ekle listesi: takip ettiklerim.
  Future<List<PersonSummary>> following(String myUserId) async {
    final res =
        await _api.get('/users/$myUserId/following', query: {'limit': '50'})
            as Map;
    return [
      for (final j in (res['items'] as List).cast<Map>())
        (
          id: j['id'] as String,
          name: (j['displayName'] ?? j['username'] ?? '') as String,
          username: j['username'] as String?,
          avatarUrl: j['avatarUrl'] as String?,
        ),
    ];
  }

  ChatThread _thread(dynamic res) =>
      ChatThread.fromApi(Map<String, dynamic>.from(res as Map));

  List<GroupJoinRequest> _requests(dynamic res) => [
    for (final j in ((res as Map)['items'] as List).cast<Map>())
      GroupJoinRequest.fromJson(Map<String, dynamic>.from(j)),
  ];
}
