import 'dart:async';

import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_bottom_nav.dart';
import 'package:veylo/data/remote/chat_repository.dart';
import 'package:veylo/data/remote/chat_store.dart';
import 'package:veylo/data/remote/group_store.dart';
import 'package:veylo/data/remote/note_store.dart';
import 'package:veylo/data/remote/push_service.dart';
import 'package:veylo/data/remote/room_store.dart';
import 'package:veylo/data/remote/socket_service.dart';
import 'package:veylo/data/remote/vibe_store.dart';
import 'package:veylo/screens/discover/rooms/room_approved_sheet.dart';
import 'package:veylo/data/remote/discover_store.dart';
import 'package:veylo/data/remote/session_store.dart';
import 'package:veylo/screens/call/call_stranger_page.dart';
import 'package:veylo/screens/chat/chat_request_page.dart';
import 'package:veylo/screens/chat/chats_page.dart';
import 'package:veylo/screens/discover/discover_page.dart';
import 'package:veylo/screens/profile/account_management_page.dart';
import 'package:veylo/screens/profile/edit_profile_page.dart';
import 'package:veylo/screens/profile/profile_page.dart';
import 'package:veylo/screens/tokens/boost_page.dart';
import 'package:veylo/screens/vibes/vibes_page.dart';

/// Ana shell: Discover + bottom nav.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  AppNavTab _tab = AppNavTab.discover;
  StreamSubscription<String>? _pushTaps;
  StreamSubscription<String>? _callPush;
  StreamSubscription<Map<String, dynamic>>? _groupApproved;
  StreamSubscription<Map<String, dynamic>>? _roomApproved;
  StreamSubscription<Map<String, dynamic>>? _callIncoming;
  String? _incomingCallId;

  @override
  void initState() {
    super.initState();
    // Giriş yapılmış: socket bağlantısı, sohbet listesi ve bildirimler.
    if (SessionStore.instance.me != null) {
      ChatStore.instance.start();
      PushService.instance.start();
    }
    _pushTaps = PushService.instance.taps.listen(_openConversation);
    _callPush = PushService.instance.callInvites.listen(_openIncomingCall);
    // Gizli gruba katılma isteğim onaylandı.
    _groupApproved = SocketService.instance.on('group:approved').listen((e) {
      final id = e['conversationId'] as String?;
      if (id == null || !mounted) return;
      GroupStore.instance.markJoined(id);
      showRoomApprovedSheet(
        context,
        roomTitle: e['title'] as String? ?? '',
        isGroup: true,
        conversationId: id,
      );
    });
    // Gizli canlı odaya katılma isteğim onaylandı.
    _callIncoming = SocketService.instance.on('call:incoming').listen((e) {
      _openIncomingCall(e['inviteId'] as String?);
    });
    _roomApproved = SocketService.instance.on('room:approved').listen((e) {
      final id = e['roomId'] as String?;
      if (id == null || !mounted) return;
      RoomStore.instance.refresh();
      showRoomApprovedSheet(
        context,
        roomTitle: e['title'] as String? ?? '',
        roomId: id,
      );
    });
    AppShell.bind(
      current: () => _tab,
      select: (tab) {
        if (!mounted) return;
        Navigator.of(context).popUntil((route) => route.isFirst);
        _onNavChanged(tab);
      },
    );
    final pending = PushService.instance.takePendingTap();
    final pendingCall = PushService.instance.takePendingCall();
    if (pending != null || pendingCall != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (pendingCall != null) _openIncomingCall(pendingCall);
        if (pending != null) _openConversation(pending);
      });
    }
  }

  @override
  void dispose() {
    AppShell.unbind();
    _pushTaps?.cancel();
    _callPush?.cancel();
    _groupApproved?.cancel();
    _roomApproved?.cancel();
    _callIncoming?.cancel();
    super.dispose();
  }

  void _openIncomingCall(String? inviteId) {
    if (inviteId == null || inviteId.isEmpty || !mounted || _incomingCallId == inviteId) {
      return;
    }
    _incomingCallId = inviteId;
    CallStrangerPage.openIncoming(context, {'inviteId': inviteId}).whenComplete(() {
      if (_incomingCallId == inviteId) _incomingCallId = null;
    });
  }

  /// Bildirime dokunuldu: Chats sekmesine geç ve sohbeti aç.
  Future<void> _openConversation(String id) async {
    if (!mounted) return;
    Navigator.of(context).popUntil((r) => r.isFirst);
    setState(() => _tab = AppNavTab.chat);
    try {
      final thread =
          ChatStore.instance.byId(id) ??
          await ChatRepository.instance.get(id);
      if (mounted) ChatsPage.openThread(context, thread);
    } catch (_) {
      // Sohbet silinmiş/erişim yok: Chats listesinde kalınır.
    }
  }

  void _onNavChanged(AppNavTab tab) {
    if (tab == AppNavTab.call) {
      CallStrangerPage.open(context);
      return;
    }
    // Vibes 24 saatlik: sekmeye her gelişte taze akış.
    if (tab == AppNavTab.vibes && _tab != tab) VibeStore.instance.refresh();
    if (tab == AppNavTab.discover && _tab != tab) {
      GroupStore.instance.refresh();
      RoomStore.instance.refresh();
      DiscoverStore.instance.refresh();
    }
    if (tab == AppNavTab.chat && _tab != tab) {
      NoteStore.instance.refresh();
      ChatStore.instance.refresh();
    }
    // Profil: takip/takipçi sayıları ve token bakiyesi güncel olsun.
    if (tab == AppNavTab.profile && _tab != tab) {
      SessionStore.instance.refreshMe().catchError((_) {});
    }
    setState(() => _tab = tab);
  }

  int get _stackIndex {
    // Call sekmesi push ile açılır; IndexedStack’te yok.
    if (_tab.index > AppNavTab.call.index) return _tab.index - 1;
    return _tab.index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      extendBody: true,
      body: IndexedStack(
        index: _stackIndex,
        children: [
          const DiscoverPage(),
          ChatsPage(
            onRequestTap: () => ChatRequestPage.open(context),
          ),
          const VibesPage(),
          ProfilePage(
            onEditProfileTap: () => EditProfilePage.open(context),
            onSettingsTap: () => AccountManagementPage.open(context),
            onTokensTap: () => BoostPage.open(context),
            onStandOutTap: () => BoostPage.open(context),
          ),
        ],
      ),
      bottomNavigationBar: AppBottomNav(
        current: _tab,
        onChanged: _onNavChanged,
      ),
    );
  }
}
