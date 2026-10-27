import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/core/widgets/ai_badge.dart';
import 'package:veylo/data/remote/discover_store.dart';
import 'package:veylo/models/discover/post.dart';
import 'package:veylo/screens/chat/widgets/chat_note_card.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/screens/discover/ai_match_tab.dart';
import 'package:veylo/screens/discover/discover_post_page.dart';
import 'package:veylo/screens/discover/filters_sheet.dart';
import 'package:veylo/screens/discover/highlight_sheet.dart';
import 'package:veylo/screens/discover/rooms/create_room_or_group_sheet.dart';
import 'package:veylo/screens/discover/rooms/rooms_tab.dart';
import 'package:veylo/screens/discover/story_camera_page.dart';

/// Discover — header, tabs, search+filter, 3 kolon grid.
class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  final _store = DiscoverStore.instance;
  final _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    _store.addListener(_onStore);
    _scroll.addListener(_onScroll);
    if (!_store.loaded || _store.posts.isEmpty) _store.refresh();
  }

  @override
  void dispose() {
    _store.removeListener(_onStore);
    _scroll.removeListener(_onScroll);
    _scroll.dispose();
    super.dispose();
  }

  void _onStore() {
    if (mounted) setState(() {});
  }

  void _onScroll() => _maybeLoadMore();

  bool _maybeLoadMore([ScrollMetrics? metrics]) {
    if (metrics != null) {
      if (metrics.extentAfter < 900) _store.loadMore();
      return false;
    }
    if (!_scroll.hasClients) return false;
    if (_scroll.position.extentAfter < 900) _store.loadMore();
    return false;
  }

  Future<void> _openFilters() async {
    final f = await showFiltersSheet(context, initial: _store.filters);
    if (f != null) _store.applyFilters(f);
  }

  int _tabIndex = 1; // Discover

  void _onHeaderPlusTap() {
    switch (_tabIndex) {
      case 0:
        showCreateRoomOrGroupSheet(context);
      case 1:
        Navigator.of(context).push<void>(
          MaterialPageRoute<void>(builder: (_) => const StoryCameraPage()),
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
                              onChanged: _store.search,
                              style: AppTextStyles.discoverSearchHint.copyWith(
                                color: AppColors.textOnLight,
                              ),
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
                    onTap: _openFilters,
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
              child: RefreshIndicator(
                onRefresh: _store.refresh,
                color: AppColors.brandPurple,
                child: NotificationListener<ScrollNotification>(
                  onNotification: (n) {
                    if (n.metrics.axis == Axis.vertical) _maybeLoadMore(n.metrics);
                    return false;
                  },
                  child: GridView.builder(
                    controller: _scroll,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 110),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 2,
                          crossAxisSpacing: 2,
                          childAspectRatio: 142 / 175,
                        ),
                    itemCount: _store.posts.length,
                    itemBuilder: (_, index) {
                      final post = _store.posts[index];
                      return GestureDetector(
                        onTap: () => DiscoverPostPage.openPost(
                          context,
                          post,
                          index: index,
                          liveFeed: true,
                        ),
                        child: _DiscoverCard(post: post),
                      );
                    },
                  ),
                ),
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
  const _DiscoverCard({required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.white,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Image.network(
              post.thumbUrl,
              fit: BoxFit.cover,
              alignment: Alignment.center,
              filterQuality: FilterQuality.high,
              errorBuilder: (_, _, _) =>
                  const ColoredBox(color: AppColors.inputFill),
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
                    child: ChatAvatarImage(
                      url: post.authorAvatarUrl ?? '',
                      size: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Flexible(
                  child: AppText(
                    post.handle,
                    style: AppTextStyles.discoverCardUsername,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (post.authorIsAi) const AiBadge(compact: true),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
