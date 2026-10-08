import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_bottom_nav.dart';
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
