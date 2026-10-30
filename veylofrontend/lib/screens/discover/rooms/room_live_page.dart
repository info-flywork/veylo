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
import 'package:veylo/data/remote/api_client.dart';
import 'package:veylo/data/remote/room_repository.dart';
import 'package:veylo/data/remote/room_store.dart';
import 'package:veylo/data/remote/socket_service.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/models/room/live_room.dart';
import 'package:veylo/screens/chat/widgets/chat_note_card.dart';

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
    if (!_left) {
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

  Future<void> _leave() async {
    if (_left && _canLeave) return;
    _left = true;
    _repo.leave(widget.roomId).ignore();
    await _agora.leave();
    if (!mounted) return;
    setState(() => _canLeave = true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) Navigator.of(context).pop();
    });
  }

  void _onKicked() {
    if (!mounted || _left) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(Translations.of(context).discover.liveRoom.removed),
      ),
    );
    _leave();
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
    if (!mounted || _left) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(Translations.of(context).discover.liveRoom.roomEnded),
      ),
    );
    _leave();
  }

  /// Sahibim: gizli odama katılma isteği.
  void _onRequest(Map<String, dynamic> e) {
    final requestId = e['requestId'] as String?;
    if (!mounted || !_isHost || requestId == null) return;
    final t = Translations.of(context).discover.liveRoom;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 8),
        content: Text(t.wantsToJoin(name: e['name'] as String? ?? '')),
        action: SnackBarAction(
          label: t.approve,
          onPressed: () => ApiClient.instance
              .post(
                '/rooms/${widget.roomId}/requests/$requestId',
                body: {'approve': true},
              )
              .ignore(),
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
        if (!didPop) _leave();
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Column(
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
                          onTap: _leave,
                          behavior: HitTestBehavior.opaque,
                          child: const Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 18,
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
                              return _ChatBubble(
                                message: _messages[index],
                                notice: _notice(_messages[index]),
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

class _ChatBubble extends StatelessWidget {
  const _ChatBubble({required this.message, this.notice});

  final RoomChatLine message;
  final String? notice;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipOval(
          child: message.sender.blurred
              ? ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                  child: ChatAvatarImage(
                    url: message.sender.avatarUrl,
                    size: 30,
                  ),
                )
              : ChatAvatarImage(url: message.sender.avatarUrl, size: 30),
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.brandPurpleMuted.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text.rich(
              TextSpan(
                children: [
                  if (notice == null)
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
          ),
        ),
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
    required this.micOn,
    required this.onMic,
  });

  final String hint;
  final TextEditingController controller;
  final ValueChanged<String> onSubmit;
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
          SvgPicture.asset(AppAssets.iconSticker, width: 28, height: 28),
          const SizedBox(width: 8),
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
