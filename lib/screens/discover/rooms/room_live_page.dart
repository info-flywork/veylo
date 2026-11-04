import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/errors/error_messages.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/ai_badge.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/data/remote/agora_service.dart';
import 'package:veylo/data/remote/room_pip_store.dart';
import 'package:veylo/data/remote/room_repository.dart';
import 'package:veylo/data/remote/room_store.dart';
import 'package:veylo/data/remote/socket_service.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/models/room/live_room.dart';
import 'package:veylo/screens/chat/chat_sticker.dart';
import 'package:veylo/screens/chat/widgets/chat_note_card.dart';
import 'package:veylo/screens/discover/discover_page.dart';
import 'package:veylo/screens/discover/rooms/room_close_confirm_sheet.dart';
import 'package:veylo/screens/discover/story_editor/story_sticker_sheet.dart';

/// Odaya girince açılan canlı oda ekranı (katılımcılar + mikrofon + sohbet).
class RoomLivePage extends StatefulWidget {
  const RoomLivePage({
    super.key,
    required this.roomId,
    required this.roomTitle,
    this.anonymous = false,
  });

  final String roomId;
  final String roomTitle;

  /// Katılımcı olarak "Hide Your Account" (sahibin tercihi oda açılırken verilir).
  final bool anonymous;

  static Future<void> open(
    BuildContext context, {
    required String roomId,
    required String roomTitle,
    bool anonymous = false,
  }) async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => RoomLivePage(
          roomId: roomId,
          roomTitle: roomTitle,
          anonymous: anonymous,
        ),
      ),
    );
    RoomStore.instance.refresh();
  }

  @override
  State<RoomLivePage> createState() => _RoomLivePageState();
}

class _RoomLivePageState extends State<RoomLivePage> {
  final _repo = RoomRepository.instance;
  final _agora = AgoraService.instance;
  final _socket = SocketService.instance;
  final _input = TextEditingController();
  final _scroll = ScrollController();
  final List<StreamSubscription<Map<String, dynamic>>> _subs = [];

  String _title = '';
  bool _isHost = false;
  RoomParticipant? _me;
  List<RoomParticipant> _people = const [];
  List<RoomChatLine> _messages = const [];
  bool _joined = false;
  bool _left = false;
  bool _canLeave = false;
  /// Küçültülüyor: dispose odayı terk etmez.
  bool _minimizing = false;
  /// Kapatılıyor / oda bitti: ended ekranı + rooms listesine dönüş.
  bool _closing = false;
  bool _showEnded = false;

  /// Sahip: gizli odaya bekleyen katılma istekleri.
  List<RoomJoinRequest> _requests = const [];

  /// Yanıtlanan (ya da yok sayılan) mikrofon istekleri: butonlar gizlenir.
  final _handledNotices = <String>{};

  @override
  void initState() {
    super.initState();
    _title = widget.roomTitle;
    bool mine(Map<String, dynamic> e) => e['roomId'] == widget.roomId;
    _subs.addAll([
      _socket.on('room:participant_joined').where(mine).listen((e) {
        _upsert(_participant(e['participant']));
      }),
      _socket.on('room:participant_updated').where(mine).listen((e) {
        _upsert(_participant(e['participant']));
      }),
      _socket.on('room:participant_left').where(mine).listen((e) {
        final uid = (e['uid'] as num).toInt();
        setState(() => _people = [..._people.where((p) => p.uid != uid)]);
      }),
      _socket.on('room:message').where(mine).listen((e) {
        _addMessage(
          RoomChatLine.fromJson(Map<String, dynamic>.from(e['message'] as Map)),
        );
      }),
      _socket.on('room:ended').where(mine).listen((_) => _onEnded()),
      _socket.on('room:kicked').where(mine).listen((_) => _onKicked()),
      _socket.on('room:request').where(mine).listen(_onRequest),
    ]);
    // Bağlantı koptuysa geri gelince odaya yeniden katıl (sunucu kaldığı yerden devam eder).
    _socket.reconnects.addListener(_rejoin);
    _join();
  }

  @override
  void dispose() {
    for (final s in _subs) {
      s.cancel();
    }
    _socket.reconnects.removeListener(_rejoin);
    _input.dispose();
    _scroll.dispose();
    if (!_left && !_minimizing) {
      _repo.leave(widget.roomId).ignore();
      _agora.leave();
    }
    super.dispose();
  }

  RoomParticipant _participant(Object? json) =>
      RoomParticipant.fromJson(Map<String, dynamic>.from(json as Map));

  Future<void> _join() async {
    try {
      final s = await _repo.join(widget.roomId, anonymous: widget.anonymous);
      if (!mounted) return;
      setState(() {
        _title = s.title;
        _isHost = s.isHost;
        _me = s.me;
        _people = s.participants;
        _messages = [
          for (final m in s.messages)
            if (m.toUid == null || m.toUid == s.me.uid) m,
        ];
        _joined = true;
      });
      _scrollToEnd();
      if (s.isHost) _loadRequests();
      await _agora.join(s.rtc, micOn: s.me.micOn);
    } catch (e) {
      if (!mounted) return;
      showErrorSnackBar(context, e);
      _leave();
    }
  }

  void _rejoin() {
    if (_joined && !_left) _join();
  }

  void _upsert(RoomParticipant p) {
    if (!mounted) return;
    setState(() {
      final i = _people.indexWhere((x) => x.uid == p.uid);
      _people = i == -1
          ? [..._people, p]
          : [for (final x in _people) x.uid == p.uid ? p : x];
      if (p.uid == _me?.uid) {
        final wasOn = _me?.micOn ?? false;
        _me = p;
        if (wasOn && !p.micOn) _agora.setMic(false);
      }
    });
  }

  void _addMessage(RoomChatLine m) {
    final mine = _me?.uid;
    if (m.toUid != null && m.toUid != mine) return;
    if (!mounted || _messages.any((x) => x.id == m.id)) return;
    setState(() => _messages = [..._messages, m]);
    _scrollToEnd();
  }

  void _scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.animateTo(
          _scroll.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _send(String text) async {
    final body = text.trim();
    if (body.isEmpty) return;
    _input.clear();
    try {
      await _repo.send(widget.roomId, body);
    } catch (e) {
      if (mounted) showErrorSnackBar(context, e);
    }
  }

  Future<void> _sendSticker() async {
    final asset = await showStoryStickerSheet(context, dark: false);
    if (asset == null || !mounted) return;
    await _send(ChatSticker.encode(asset));
  }

  Future<void> _loadRequests() async {
    try {
      final list = await _repo.requests(widget.roomId);
      if (mounted) setState(() => _requests = list);
    } catch (_) {
      // Herkese açık odada istek listesi boş; hata sessizce yok sayılır.
    }
  }

  /// Sahip: katılma isteğini onayla / reddet.
  Future<void> _decide(String requestId, bool approve) async {
    try {
      final rest = await _repo.decideRequest(
        widget.roomId,
        requestId,
        approve: approve,
      );
      if (mounted) setState(() => _requests = rest);
    } catch (e) {
      if (mounted) showErrorSnackBar(context, e);
    }
  }

  Future<void> _openRequests() async {
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _RoomRequestsSheet(
        load: () => _repo.requests(widget.roomId),
        decide: (id, approve) =>
            _repo.decideRequest(widget.roomId, id, approve: approve),
        onChanged: (list) {
          if (mounted) setState(() => _requests = list);
        },
      ),
    );
  }

  /// Sahip: kilitli mikrofon isteğine izin ver (kilidi aç) ya da yok say.
  Future<void> _answerMic(RoomChatLine m, bool allow) async {
    setState(() => _handledNotices.add(m.id));
    if (!allow) return;
    try {
      await _repo.setMicLock(widget.roomId, m.sender.uid, locked: false);
    } catch (e) {
      if (!mounted) return;
      setState(() => _handledNotices.remove(m.id));
      showErrorSnackBar(context, e);
    }
  }

  Future<void> _toggleMic() async {
    final me = _me;
    if (me == null) return;
    final on = !me.micOn;
    if (on && me.micLocked) {
      try {
        await _repo.setMic(widget.roomId, true);
      } catch (e) {
        if (mounted) showErrorSnackBar(context, e);
      }
      return;
    }
    if (on && !await _agora.requestMic()) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(Translations.of(context).call.micDenied)),
        );
      }
      return;
    }
    await _agora.setMic(on);
    try {
      await _repo.setMic(widget.roomId, on);
    } catch (e) {
      await _agora.setMic(!on);
      if (mounted) showErrorSnackBar(context, e);
    }
  }

  /// Odada kal, ekranı küçült (YouTube PiP).
  void _minimize() {
    if (_left || _minimizing || _closing) return;
    RoomPipStore.instance.show(
      roomId: widget.roomId,
      title: _title,
      isHost: _isHost,
      anonymous: widget.anonymous,
      participants: _people,
    );
    _minimizing = true;
    _canLeave = true;
    if (mounted) Navigator.of(context).pop();
  }

  Future<void> _leave({bool toRooms = false}) async {
    if (_left && _canLeave) return;
    _left = true;
    RoomPipStore.instance.hideBubble();
    _repo.leave(widget.roomId).ignore();
    await _agora.leave();
    if (!mounted) return;
    setState(() => _canLeave = true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (toRooms) {
        Navigator.of(context).popUntil((r) => r.isFirst);
        DiscoverShell.showRooms();
        RoomStore.instance.refresh();
      } else {
        Navigator.of(context).pop();
      }
    });
  }

  /// Çarpı: emin misin → (sahipse room ended + herkesi at) → rooms listesi.
  Future<void> _confirmClose() async {
    if (_left || _closing || _minimizing) return;
    final ok = await showRoomCloseConfirmSheet(context, isHost: _isHost);
    if (!ok || !mounted) return;
    if (_isHost) {
      await _endRoomForEveryone();
    } else {
      await _leave(toRooms: true);
    }
  }

  /// Sahip kapatır: önce ended ekranı, sonra herkesi at, rooms listesine dön.
  Future<void> _endRoomForEveryone() async {
    if (_closing || _left) return;
    _closing = true;
    if (mounted) setState(() => _showEnded = true);
    await Future<void>.delayed(const Duration(milliseconds: 1400));
    if (!mounted) return;
    _left = true;
    RoomPipStore.instance.hideBubble();
    try {
      await _repo.end(widget.roomId);
    } catch (_) {}
    await _agora.leave();
    if (!mounted) return;
    setState(() => _canLeave = true);
    Navigator.of(context).popUntil((r) => r.isFirst);
    DiscoverShell.showRooms();
    RoomStore.instance.refresh();
  }

  Future<void> _showEndedThenExit() async {
    if (_closing || _left) return;
    _closing = true;
    if (mounted) setState(() => _showEnded = true);
    await Future<void>.delayed(const Duration(milliseconds: 1400));
    if (!mounted) return;
    _left = true;
    RoomPipStore.instance.hideBubble();
    await _agora.leave();
    if (!mounted) return;
    setState(() => _canLeave = true);
    Navigator.of(context).popUntil((r) => r.isFirst);
    DiscoverShell.showRooms();
    RoomStore.instance.refresh();
  }

  void _onKicked() {
    if (!mounted || _left || _closing) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(Translations.of(context).discover.liveRoom.removed),
      ),
    );
    _leave(toRooms: true);
  }

  /// Üç nokta: profil isteği. Adminse yanında çıkarma ve mikrofon kilidi.
  Future<void> _memberMenu(RoomParticipant member) async {
    final t = Translations.of(context).discover.liveRoom;
    final admin = _isHost && !member.isHost;
    final action = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: AppText(t.seeProfile, style: AppTextStyles.groupInfoRow),
              onTap: () => Navigator.of(context).pop('profile'),
            ),
            if (admin) ...[
              ListTile(
                title: AppText(
                  member.micLocked ? t.unmuteMic : t.muteMic,
                  style: AppTextStyles.groupInfoRow,
                ),
                onTap: () => Navigator.of(context).pop('mic'),
              ),
              ListTile(
                title: AppText(t.remove, style: AppTextStyles.groupInfoLeave),
                onTap: () => Navigator.of(context).pop('kick'),
              ),
            ],
          ],
        ),
      ),
    );
    if (action == null || !mounted) return;
    try {
      switch (action) {
        case 'profile':
          await _repo.requestProfile(widget.roomId, member.uid);
        case 'mic':
          await _repo.setMicLock(
            widget.roomId,
            member.uid,
            locked: !member.micLocked,
          );
        case 'kick':
          await _repo.kick(widget.roomId, member.uid);
      }
    } catch (e) {
      if (mounted) showErrorSnackBar(context, e);
    }
  }

  String? _notice(RoomChatLine message) {
    final t = Translations.of(context).discover.liveRoom;
    final name = message.sender.displayName;
    return switch (message.kind) {
      'profile_request' => t.wantsToSeeYou(name: name, room: _title),
      'mic_request' => t.wantsMic(name: name),
      _ => null,
    };
  }

  void _onEnded() {
    if (!mounted || _left || _closing) return;
    _showEndedThenExit();
  }

  /// Sahibim: gizli odama katılma isteği. Kaçırılırsa başlıktaki rozetten açılır.
  void _onRequest(Map<String, dynamic> e) {
    final requestId = e['requestId'] as String?;
    if (!mounted || !_isHost || requestId == null) return;
    _loadRequests();
    final t = Translations.of(context).discover.liveRoom;
    final messenger = ScaffoldMessenger.of(context);
    messenger.showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 8),
        content: Row(
          children: [
            Expanded(
              child: Text(t.wantsToJoin(name: e['name'] as String? ?? '')),
            ),
            TextButton(
              onPressed: () {
                messenger.hideCurrentSnackBar();
                _decide(requestId, false);
              },
              child: Text(t.reject),
            ),
          ],
        ),
        action: SnackBarAction(
          label: t.approve,
          onPressed: () => _decide(requestId, true),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).discover.liveRoom;
    final top = MediaQuery.paddingOf(context).top;
    final bottom = MediaQuery.paddingOf(context).bottom;
    final host = _people.where((p) => p.isHost).firstOrNull;
    final members = _people.where((p) => !p.isHost).toList();

    final quickReplies = [t.quickReplyHey, t.quickReplyTopic, t.quickReplyNew];

    return PopScope(
      canPop: _canLeave,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _minimize();
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
            ColoredBox(
              color: AppColors.white,
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, top + 8, 16, 16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: _minimize,
                          behavior: HitTestBehavior.opaque,
                          child: const Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 22,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                        Expanded(
                          child: AppText(
                            _title,
                            style: AppTextStyles.liveRoomTitle,
                          ),
                        ),
                        if (_isHost && _requests.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: GestureDetector(
                              onTap: _openRequests,
                              behavior: HitTestBehavior.opaque,
                              child: Badge(
                                label: Text('${_requests.length}'),
                                backgroundColor: AppColors.selectionBorder,
                                child: const Icon(
                                  Icons.person_add_alt_1_rounded,
                                  size: 24,
                                  color: AppColors.black,
                                ),
                              ),
                            ),
                          ),
                        GestureDetector(
                          onTap: _confirmClose,
                          behavior: HitTestBehavior.opaque,
                          child: SvgPicture.asset(
                            AppAssets.iconCloseButton,
                            width: 32,
                            height: 32,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ValueListenableBuilder<Set<int>>(
                      valueListenable: _agora.speaking,
                      builder: (context, speaking, _) => _AdminAvatar(
                        avatar: host?.avatarUrl ?? '',
                        blurred: host?.blurred ?? false,
                        speaking: host != null && speaking.contains(host.uid),
                        size: 72,
                        micOn: host?.micOn ?? false,
                        onMic: _isHost ? _toggleMic : null,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: host?.displayName ?? '',
                                  style: AppTextStyles.liveRoomMemberName,
                                ),
                                TextSpan(
                                  text: ' ${t.adminSuffix}',
                                  style: AppTextStyles.liveRoomAdminSuffix,
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        if (host?.isAi ?? false) const AiBadge(compact: true),
                        if (host != null && host.uid != _me?.uid)
                          _MoreDots(onTap: () => _memberMenu(host)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 1,
              color: AppColors.black.withValues(alpha: 0.10),
            ),
            Expanded(
              child: ColoredBox(
                color: AppColors.white,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Peach left + purple right — centers meet mid-screen (~50/50)
                    const Positioned(
                      left: -142 - _BlurOrb.pad,
                      top: 20 - _BlurOrb.pad,
                      child: _BlurOrb(size: 404, color: Color(0x80FFD2B4)),
                    ),
                    const Positioned(
                      right: -142 - _BlurOrb.pad,
                      top: 20 - _BlurOrb.pad,
                      child: _BlurOrb(size: 404, color: Color(0x807C6CD6)),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              const columns = 4;
                              const spacing = 4.0;
                              final tileWidth =
                                  (constraints.maxWidth -
                                      spacing * (columns - 1)) /
                                  columns;
                              return ValueListenableBuilder<Set<int>>(
                                valueListenable: _agora.speaking,
                                builder: (context, speaking, _) => Wrap(
                                  alignment: WrapAlignment.center,
                                  spacing: spacing,
                                  runSpacing: 12,
                                  children: [
                                    for (final member in members)
                                      SizedBox(
                                        width: tileWidth,
                                        child: _MemberTile(
                                          member: member,
                                          speaking: speaking.contains(
                                            member.uid,
                                          ),
                                          onMic: member.uid == _me?.uid
                                              ? _toggleMic
                                              : null,
                                          onMenu: member.uid == _me?.uid
                                              ? null
                                              : () => _memberMenu(member),
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: ListView.separated(
                            controller: _scroll,
                            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                            itemCount: _messages.length,
                            separatorBuilder: (_, _) =>
                                const SizedBox(height: 10),
                            itemBuilder: (context, index) {
                              final m = _messages[index];
                              final askMic =
                                  _isHost &&
                                  m.kind == 'mic_request' &&
                                  !_handledNotices.contains(m.id);
                              return _ChatBubble(
                                message: m,
                                // Kendi yazdığım (sahip olsam da) sağda durur.
                                mine: m.kind == null &&
                                    m.sender.uid == _me?.uid,
                                notice: _notice(m),
                                actions: askMic
                                    ? (
                                        allow: t.approve,
                                        deny: t.reject,
                                        onAllow: () => _answerMic(m, true),
                                        onDeny: () => _answerMic(m, false),
                                      )
                                    : null,
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: quickReplies.length,
                            separatorBuilder: (_, _) =>
                                const SizedBox(width: 8),
                            itemBuilder: (context, index) {
                              return _QuickReplyChip(
                                label: quickReplies[index],
                                onTap: () => _send(quickReplies[index]),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                            16,
                            10,
                            16,
                            bottom > 0 ? bottom : 8,
                          ),
                          child: _MessageInput(
                            hint: t.messageHint,
                            controller: _input,
                            onSubmit: _send,
                            onSticker: _sendSticker,
                            micOn: _me?.micOn ?? false,
                            onMic: _toggleMic,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
            ),
            if (_showEnded)
              Positioned.fill(
                child: ColoredBox(
                  color: AppColors.black.withValues(alpha: 0.55),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: AppText(
                        t.roomEnded,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: AppFonts.poppins,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _BlurOrb extends StatelessWidget {
  const _BlurOrb({required this.size, required this.color});

  final double size;
  final Color color;

  /// Figma layer blur 150 ≈ Flutter sigma ~75
  static const double _sigma = 75;

  /// Extra space so blur isn't clipped; must be subtracted from Positioned offsets
  static const double pad = _sigma * 2;

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: _sigma, sigmaY: _sigma),
      child: Padding(
        padding: const EdgeInsets.all(pad),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
      ),
    );
  }
}

class _AdminAvatar extends StatelessWidget {
  const _AdminAvatar({
    required this.avatar,
    required this.size,
    this.blurred = false,
    this.speaking = false,
    this.micOn = false,
    this.onMic,
  });

  final String avatar;
  final double size;
  final bool blurred;
  final bool speaking;
  final bool micOn;
  final VoidCallback? onMic;

  @override
  Widget build(BuildContext context) {
    Widget photo = ChatAvatarImage(url: avatar, size: size);
    if (blurred) {
      photo = ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: photo,
      );
    }
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.selectionBorder,
                width: speaking ? 3 : 2,
              ),
            ),
            child: ClipOval(child: photo),
          ),
          if (onMic != null)
            Positioned(
              right: 0,
              bottom: 0,
              child: _ProfileMicButton(on: micOn, onTap: onMic!),
            ),
        ],
      ),
    );
  }
}

class _MemberTile extends StatelessWidget {
  const _MemberTile({
    required this.member,
    this.speaking = false,
    this.onMic,
    this.onMenu,
  });

  final RoomParticipant member;
  final bool speaking;
  final VoidCallback? onMic;
  final VoidCallback? onMenu;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 68,
          height: 68,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              if (speaking)
                Container(
                  width: 68,
                  height: 68,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.selectionBorder,
                      width: 2,
                    ),
                  ),
                ),
              ClipOval(
                child: SizedBox(
                  width: 68,
                  height: 68,
                  child: member.blurred
                      ? ImageFiltered(
                          imageFilter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                          child: ChatAvatarImage(
                            url: member.avatarUrl,
                            size: 68,
                          ),
                        )
                      : ChatAvatarImage(url: member.avatarUrl, size: 68),
                ),
              ),
              if (!member.micOn && onMic == null) ...[
                Container(
                  width: 68,
                  height: 68,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white.withValues(alpha: 0.28),
                  ),
                ),
                SvgPicture.asset(
                  AppAssets.iconMicrophoneOff,
                  width: 24,
                  height: 24,
                ),
              ],
              if (onMic != null)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: _ProfileMicButton(on: member.micOn, onTap: onMic!),
                ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: AppText(
                member.displayName,
                style: AppTextStyles.liveRoomMemberName,
                textAlign: TextAlign.center,
                maxLines: 1,
              ),
            ),
            if (member.isAi) const AiBadge(compact: true),
          ],
        ),
        if (onMenu != null) _MoreDots(onTap: onMenu!),
      ],
    );
  }
}

class _ProfileMicButton extends StatelessWidget {
  const _ProfileMicButton({required this.on, required this.onTap});

  final bool on;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: on ? AppColors.selectionBorder : AppColors.white,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.white, width: 2),
        ),
        alignment: Alignment.center,
        child: SvgPicture.asset(
          on ? AppAssets.iconMicrophone : AppAssets.iconMicrophoneOff,
          width: 16,
          height: 16,
          colorFilter: ColorFilter.mode(
            on ? AppColors.white : AppColors.black,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}

class _MoreDots extends StatelessWidget {
  const _MoreDots({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: const Padding(
        padding: EdgeInsets.only(left: 2, top: 2),
        child: Icon(Icons.more_horiz, size: 18, color: Color(0x73000000)),
      ),
    );
  }
}

typedef _NoticeActions = ({
  String allow,
  String deny,
  VoidCallback onAllow,
  VoidCallback onDeny,
});

class _ChatBubble extends StatelessWidget {
  const _ChatBubble({
    required this.message,
    this.mine = false,
    this.notice,
    this.actions,
  });

  final RoomChatLine message;
  final bool mine;
  final String? notice;

  /// Mikrofon isteği (sahip): izin ver / reddet.
  final _NoticeActions? actions;

  @override
  Widget build(BuildContext context) {
    final sticker = notice == null ? ChatSticker.assetOf(message.body) : null;
    final avatar = ClipOval(
          child: message.sender.blurred
              ? ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                  child: ChatAvatarImage(
                    url: message.sender.avatarUrl,
                    size: 30,
                  ),
                )
              : ChatAvatarImage(url: message.sender.avatarUrl, size: 30),
    );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: mine ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!mine) ...[avatar, const SizedBox(width: 10)],
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.brandPurpleMuted.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: sticker != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (!mine) ...[
                        AppText(
                          message.sender.displayName,
                          style: AppTextStyles.liveRoomChatName,
                        ),
                        const SizedBox(height: 4),
                      ],
                      ChatStickerImage(asset: sticker),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            if (notice == null && !mine)
                              TextSpan(
                                text: '${message.sender.displayName}: ',
                                style: AppTextStyles.liveRoomChatName,
                              ),
                            TextSpan(
                              text: notice ?? message.body,
                              style: AppTextStyles.liveRoomChatBody,
                            ),
                          ],
                        ),
                      ),
                      if (actions != null) ...[
                        const SizedBox(height: 8),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _QuickReplyChip(
                              label: actions!.deny,
                              onTap: actions!.onDeny,
                            ),
                            const SizedBox(width: 8),
                            _QuickReplyChip(
                              label: actions!.allow,
                              onTap: actions!.onAllow,
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
          ),
        ),
        if (mine) ...[const SizedBox(width: 10), avatar],
      ],
    );
  }
}

class _QuickReplyChip extends StatelessWidget {
  const _QuickReplyChip({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: _chip(),
    );
  }

  Widget _chip() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.brandPurpleMuted.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(9999),
      ),
      child: AppText(label, style: AppTextStyles.liveRoomQuickReply),
    );
  }
}

class _MessageInput extends StatelessWidget {
  const _MessageInput({
    required this.hint,
    required this.controller,
    required this.onSubmit,
    required this.onSticker,
    required this.micOn,
    required this.onMic,
  });

  final String hint;
  final TextEditingController controller;
  final ValueChanged<String> onSubmit;
  final VoidCallback onSticker;
  final bool micOn;
  final VoidCallback onMic;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.sheetMuted,
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              onSubmitted: onSubmit,
              textInputAction: TextInputAction.send,
              maxLength: 300,
              buildCounter:
                  (
                    _, {
                    required currentLength,
                    required isFocused,
                    maxLength,
                  }) => null,
              style: AppTextStyles.liveRoomMessageHint,
              cursorColor: AppColors.selectionBorder,
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: hint,
                hintStyle: AppTextStyles.liveRoomMessageHint,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onSticker,
            behavior: HitTestBehavior.opaque,
            child: SvgPicture.asset(
              AppAssets.iconSticker,
              width: 28,
              height: 28,
            ),
          ),
          const SizedBox(width: 8),
          // Yazı varken gönder (sohbet kutusundaki gönder butonuyla aynı).
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: controller,
            builder: (context, value, _) {
              if (value.text.trim().isEmpty) return const SizedBox.shrink();
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: () => onSubmit(controller.text),
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.selectionBorder,
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.send_rounded,
                      size: 15,
                      color: AppColors.white,
                    ),
                  ),
                ),
              );
            },
          ),
          // Mikrofonum: kapalıyken soluk.
          GestureDetector(
            onTap: onMic,
            behavior: HitTestBehavior.opaque,
            child: Opacity(
              opacity: micOn ? 1 : 0.4,
              child: SvgPicture.asset(
                AppAssets.iconMicrophone,
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

/// Sahip: bekleyen katılma istekleri (onayla / reddet).
class _RoomRequestsSheet extends StatefulWidget {
  const _RoomRequestsSheet({
    required this.load,
    required this.decide,
    required this.onChanged,
  });

  final Future<List<RoomJoinRequest>> Function() load;
  final Future<List<RoomJoinRequest>> Function(String id, bool approve) decide;
  final ValueChanged<List<RoomJoinRequest>> onChanged;

  @override
  State<_RoomRequestsSheet> createState() => _RoomRequestsSheetState();
}

class _RoomRequestsSheetState extends State<_RoomRequestsSheet> {
  List<RoomJoinRequest>? _items;
  final _busy = <String>{};

  @override
  void initState() {
    super.initState();
    widget
        .load()
        .then((list) {
          if (!mounted) return;
          setState(() => _items = list);
          widget.onChanged(list);
        })
        .catchError((Object e) {
          if (!mounted) return;
          setState(() => _items = const []);
          showErrorSnackBar(context, e);
        });
  }

  Future<void> _decide(RoomJoinRequest r, bool approve) async {
    if (_busy.contains(r.id)) return;
    setState(() => _busy.add(r.id));
    try {
      final rest = await widget.decide(r.id, approve);
      if (!mounted) return;
      setState(() => _items = rest);
      widget.onChanged(rest);
    } catch (e) {
      if (mounted) showErrorSnackBar(context, e);
    } finally {
      if (mounted) setState(() => _busy.remove(r.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).discover.liveRoom;
    final items = _items;
    final maxHeight = MediaQuery.sizeOf(context).height * 0.6;

    return SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.progressTrack,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              AppText(t.pendingRequests, style: AppTextStyles.filtersTitle),
              const SizedBox(height: 8),
              if (items == null)
                const Padding(
                  padding: EdgeInsets.all(24),
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (items.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: AppText(
                    t.noRequests,
                    style: AppTextStyles.groupInfoRow,
                    textAlign: TextAlign.center,
                  ),
                )
              else
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (final r in items)
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: ClipOval(
                            child: r.user.blurred
                                ? ImageFiltered(
                                    imageFilter: ImageFilter.blur(
                                      sigmaX: 3,
                                      sigmaY: 3,
                                    ),
                                    child: ChatAvatarImage(
                                      url: r.user.avatarUrl,
                                      size: 40,
                                    ),
                                  )
                                : ChatAvatarImage(
                                    url: r.user.avatarUrl,
                                    size: 40,
                                  ),
                          ),
                          title: AppText(
                            r.user.displayName,
                            style: AppTextStyles.groupInfoRow,
                            maxLines: 1,
                          ),
                          subtitle: (r.message?.isNotEmpty ?? false)
                              ? AppText(
                                  r.message!,
                                  style: AppTextStyles.liveRoomChatBody,
                                  maxLines: 2,
                                )
                              : null,
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _QuickReplyChip(
                                label: t.reject,
                                onTap: () => _decide(r, false),
                              ),
                              const SizedBox(width: 8),
                              _QuickReplyChip(
                                label: t.approve,
                                onTap: () => _decide(r, true),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
