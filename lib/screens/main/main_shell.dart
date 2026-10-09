import 'dart:async';

import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_bottom_nav.dart';
import 'package:veylo/data/remote/chat_repository.dart';
import 'package:veylo/data/remote/chat_store.dart';
import 'package:veylo/data/remote/push_service.dart';
import 'package:veylo/data/remote/session_store.dart';
import 'package:veylo/screens/call/call_stranger_page.dart';
import 'package:veylo/screens/chat/chat_request_page.dart';
import 'package:veylo/screens/chat/chats_page.dart';
import 'package:veylo/screens/discover/discover_page.dart';
import 'package:veylo/screens/profile/account_management_page.dart';
import 'package:veylo/screens/profile/edit_profile_page.dart';
import 'package:veylo/screens/profile/profile_page.dart';
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

  @override
  void initState() {
    super.initState();
    // Giriş yapılmış: socket bağlantısı, sohbet listesi ve bildirimler.
    if (SessionStore.instance.me != null) {
      ChatStore.instance.start();
      PushService.instance.start();
    }
    _pushTaps = PushService.instance.taps.listen(_openConversation);
    final pending = PushService.instance.takePendingTap();
    if (pending != null) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => _openConversation(pending),
      );
    }
  }

  @override
  void dispose() {
    _pushTaps?.cancel();
    super.dispose();
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
