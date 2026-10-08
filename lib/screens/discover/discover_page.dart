import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/screens/discover/ai_match_tab.dart';
import 'package:veylo/screens/discover/discover_post_page.dart';
import 'package:veylo/screens/discover/filters_sheet.dart';
import 'package:veylo/screens/discover/highlight_sheet.dart';
import 'package:veylo/screens/discover/rooms/create_room_or_group_sheet.dart';
import 'package:veylo/screens/discover/rooms/rooms_tab.dart';
import 'package:veylo/screens/discover/story_camera_page.dart';

class _DiscoverProfile {
  const _DiscoverProfile({
    required this.image,
    required this.avatar,
    required this.username,
  });

  final String image;
  final String avatar;
  final String username;
}

/// Discover — header, tabs, search+filter, 3 kolon grid.
class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  static const _profiles = <_DiscoverProfile>[
    _DiscoverProfile(
      image: AppAssets.fakePerson01,
      avatar: AppAssets.fakePerson01,
      username: 'natalie_pnk',
    ),
    _DiscoverProfile(
      image: AppAssets.fakePerson02,
      avatar: AppAssets.fakePerson02,
      username: 'christian.samuel',
    ),
    _DiscoverProfile(
      image: AppAssets.fakePerson03,
      avatar: AppAssets.fakePerson03,
      username: 'adnan___adn',
    ),
    _DiscoverProfile(
      image: AppAssets.fakePerson04,
      avatar: AppAssets.fakePerson04,
      username: 'sophievargas',
    ),
    _DiscoverProfile(
      image: AppAssets.fakePerson05,
      avatar: AppAssets.fakePerson05,
      username: 'clara.clr',
    ),
    _DiscoverProfile(
      image: AppAssets.fakePerson06,
      avatar: AppAssets.fakePerson06,
      username: 'sam_black',
    ),
    _DiscoverProfile(
      image: AppAssets.fakePerson07,
      avatar: AppAssets.fakePerson07,
      username: 'kyrie.lee',
    ),
    _DiscoverProfile(
      image: AppAssets.fakePerson08,
      avatar: AppAssets.fakePerson08,
      username: 'lara.wtson',
    ),
    _DiscoverProfile(
      image: AppAssets.fakePerson02,
      avatar: AppAssets.fakePerson02,
      username: 'samuel_',
    ),
  ];

  int _tabIndex = 1; // Discover

  void _onHeaderPlusTap() {
    switch (_tabIndex) {
      case 0:
        showCreateRoomOrGroupSheet(context);
      case 1:
        Navigator.of(context).push<void>(
          MaterialPageRoute<void>(
            builder: (_) => const StoryCameraPage(),
          ),
        );
      case 2:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).discover;
    final top = MediaQuery.paddingOf(context).top;

    return Material(
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: top + 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: AppText(t.title, style: AppTextStyles.discoverTitle),
                ),
                if (_tabIndex != 2)
                  GestureDetector(
                    onTap: _onHeaderPlusTap,
                    behavior: HitTestBehavior.opaque,
                    child: SizedBox(
                      width: 44,
                      height: 44,
                      child: Center(
                        child: SvgPicture.asset(
                          AppAssets.iconPlus,
                          colorFilter: const ColorFilter.mode(
                            AppColors.textOnLight,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          _DiscoverTabs(
            selectedIndex: _tabIndex,
            labels: [t.tabRooms, t.tabDiscover, t.tabAiMatch],
            onChanged: (i) => setState(() => _tabIndex = i),
          ),
          if (_tabIndex == 1) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 44,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: AppColors.inputFill,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AppAssets.iconSearch,
                            width: 20,
                            height: 20,
                            colorFilter: const ColorFilter.mode(
                              AppColors.searchPlaceholder,
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              style: AppTextStyles.discoverSearchHint
                                  .copyWith(color: AppColors.textOnLight),
                              cursorColor: AppColors.selectionBorder,
                              decoration: InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                                hintText: t.searchHint,
                                hintStyle: AppTextStyles.discoverSearchHint,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () => showFiltersSheet(context),
                    behavior: HitTestBehavior.opaque,
                    child: SizedBox(
                      width: 44,
                      height: 44,
                      child: Center(
                        child: SvgPicture.asset(
                          AppAssets.iconFilter,
                          width: 24,
                          height: 24,
                          colorFilter: const ColorFilter.mode(
                            AppColors.textOnLight,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const DiscoverSharedSuccessBanner(),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.only(bottom: 110),
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                  childAspectRatio: 142 / 175,
                ),
                itemCount: _profiles.length,
                itemBuilder: (context, index) {
                  final profile = _profiles[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => DiscoverPostPage(
                            avatar: profile.avatar,
                            username: profile.username,
                          ),
                        ),
                      );
                    },
                    child: _DiscoverCard(profile: profile),
                  );
                },
              ),
            ),
          ] else if (_tabIndex == 0) ...[
            const Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 110),
                child: RoomsTab(),
              ),
            ),
          ] else ...[
            const Expanded(child: AiMatchTab()),
          ],
        ],
      ),
    );
  }
}

class _DiscoverTabs extends StatelessWidget {
  const _DiscoverTabs({
    required this.selectedIndex,
    required this.labels,
    required this.onChanged,
  });

  final int selectedIndex;
  final List<String> labels;
  final ValueChanged<int> onChanged;

  /// Figma: Fill × Hug 44, padding 10, bottom border 1px #7B2FFF (active).
  static const _tabHeight = 44.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < labels.length; i++)
          Expanded(
            child: GestureDetector(
              onTap: () => onChanged(i),
              behavior: HitTestBehavior.opaque,
              child: Container(
                height: _tabHeight,
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: i == selectedIndex
                          ? AppColors.selectionBorder
                          : AppColors.borderLight,
                      width: 1,
                    ),
                  ),
                ),
                child: AppText(
                  labels[i],
                  style: i == selectedIndex
                      ? AppTextStyles.discoverTabActive
                      : AppTextStyles.discoverTabIdle,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _DiscoverCard extends StatelessWidget {
  const _DiscoverCard({required this.profile});

  final _DiscoverProfile profile;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.white,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Image.asset(
              profile.image,
              fit: BoxFit.cover,
              alignment: Alignment.center,
              filterQuality: FilterQuality.high,
            ),
          ),
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    Color(0x99000000),
                  ],
                  stops: [0, 0.55, 1],
                ),
              ),
            ),
          ),
          Positioned(
            left: 6,
            right: 6,
            bottom: 8,
            child: Row(
              children: [
                Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.white, width: 1),
                  ),
                  child: ClipOval(
                    child: Image.asset(profile.avatar, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: AppText(
                    profile.username,
                    style: AppTextStyles.discoverCardUsername,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
