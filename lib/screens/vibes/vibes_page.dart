import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/core/widgets/profile_tappable_avatar.dart';
import 'package:veylo/data/local/local_profile_store.dart';
import 'package:veylo/data/mock/profile_mock_repository.dart';
import 'package:veylo/data/mock/vibes_mock_repository.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/models/vibes/vibe_post.dart';
import 'package:veylo/screens/vibes/vibe_share_sheet.dart';
import 'package:veylo/screens/vibes/vibe_talk_sheet.dart';
import 'package:veylo/screens/vibes/vibes_map_view.dart';

const _kSearchFill = Color(0x1A998FED);
const _kDivider = Color(0x1A000000);
const _kAvatar = 58.0;

/// Vibes — başlık, arama ve konuşma kartları.
class VibesPage extends StatefulWidget {
  const VibesPage({super.key, this.posts});

  final List<VibePost>? posts;

  @override
  State<VibesPage> createState() => _VibesPageState();
}

class _VibesPageState extends State<VibesPage> {
  final _searchCtrl = TextEditingController();
  late final List<VibePost> _posts;
  final Set<String> _likedIds = {};
  bool _mapOpen = false;

  @override
  void initState() {
    super.initState();
    _posts = widget.posts ?? VibesMockRepository.posts();
    _searchCtrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  List<VibePost> get _visible {
    final q = _searchCtrl.text.trim().toLowerCase();
    if (q.isEmpty) return _posts;
    return _posts
        .where(
          (p) =>
              p.name.toLowerCase().contains(q) ||
              p.body.toLowerCase().contains(q),
        )
        .toList();
  }

  Future<void> _shareVibe() async {
    final draft = await showVibeShareSheet(context);
    if (draft == null || !mounted) return;
    final self = LocalProfileStore.instance
        .apply(ProfileMockRepository.currentUser());
    final post = VibesMockRepository.addShared(
      body: draft.body,
      anonymous: draft.anonymous,
      displayName: self.displayName,
      avatarAsset: self.avatarUrl,
    );
    setState(() {
      _posts.insert(0, post);
      _mapOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final top = MediaQuery.paddingOf(context).top;
    final bottom = MediaQuery.paddingOf(context).bottom;
    final items = _visible;

    return Material(
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: top + 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _VibesHeader(
              mapOpen: _mapOpen,
              onToggleMap: () => setState(() => _mapOpen = !_mapOpen),
              onCreate: _shareVibe,
            ),
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _VibesSearchField(
              controller: _searchCtrl,
              hint: t.vibes.search,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: _mapOpen
                ? const VibesMapView()
                : ListView.builder(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 16 + bottom + 64),
                    itemCount: items.isEmpty ? 0 : items.length * 2 - 1,
                    itemBuilder: (context, index) {
                      if (index.isOdd) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Divider(
                            height: 1,
                            thickness: 1,
                            color: _kDivider,
                          ),
                        );
                      }
                      final post = items[index ~/ 2];
                      final liked = _likedIds.contains(post.id);
                      return _VibeCard(
                        post: post,
                        liked: liked,
                        sendLabel: t.vibes.sendMessage,
                        onLike: () => setState(() {
                          if (liked) {
                            _likedIds.remove(post.id);
                          } else {
                            _likedIds.add(post.id);
                          }
                        }),
                        onSend: () => showVibeTalkSheet(context, post),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _VibesHeader extends StatelessWidget {
  const _VibesHeader({
    required this.mapOpen,
    required this.onToggleMap,
    required this.onCreate,
  });

  final bool mapOpen;
  final VoidCallback onToggleMap;
  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppText(
            Translations.of(context).nav.vibes,
            style: AppTextStyles.discoverTitle,
          ),
        ),
        GestureDetector(
          onTap: onToggleMap,
          behavior: HitTestBehavior.opaque,
          child: SvgPicture.asset(
            mapOpen ? AppAssets.iconMoreOptions : AppAssets.iconVibes,
            width: 24,
            height: 24,
          ),
        ),
        const SizedBox(width: 16),
        SvgPicture.asset(
          AppAssets.iconConvert,
          width: 24,
          height: 24,
          colorFilter: const ColorFilter.mode(
            AppColors.textOnLight,
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(width: 16),
        GestureDetector(
          onTap: onCreate,
          behavior: HitTestBehavior.opaque,
          child: SvgPicture.asset(AppAssets.iconPlus, width: 24, height: 24),
        ),
      ],
    );
  }
}

class _VibesSearchField extends StatelessWidget {
  const _VibesSearchField({
    required this.controller,
    required this.hint,
  });

  final TextEditingController controller;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _kSearchFill,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            AppAssets.iconSearch,
            width: 20,
            height: 20,
            colorFilter: const ColorFilter.mode(
              Color(0x66000000),
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              style: AppTextStyles.vibesSearch.copyWith(
                color: AppColors.textOnLight,
              ),
              cursorColor: AppColors.brandPurple,
              decoration: InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                hintText: hint,
                hintStyle: AppTextStyles.vibesSearch,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _VibeCard extends StatelessWidget {
  const _VibeCard({
    required this.post,
    required this.liked,
    required this.sendLabel,
    required this.onLike,
    required this.onSend,
  });

  final VibePost post;
  final bool liked;
  final String sendLabel;
  final VoidCallback onLike;
  final VoidCallback onSend;

  static const _likedGreen = Color(0xFF33C658);

  @override
  Widget build(BuildContext context) {
    final likes = post.likeCount + (liked ? 1 : 0);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileTappableAvatar(
            avatarUrl: post.avatarAsset,
            size: _kAvatar,
            userId: post.id,
            displayName: post.name,
            enabled: !post.blurred,
            blurred: post.blurred,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: AppText(
                        post.name,
                        style: AppTextStyles.vibesName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    AppText(post.dateLabel, style: AppTextStyles.vibesDate),
                  ],
                ),
                AppText(post.body, style: AppTextStyles.vibesQuote),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: onLike,
                        behavior: HitTestBehavior.opaque,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              AppAssets.iconOkeyHand,
                              width: 24,
                              height: 24,
                              colorFilter: liked
                                  ? const ColorFilter.mode(
                                      _likedGreen,
                                      BlendMode.srcIn,
                                    )
                                  : null,
                            ),
                            const SizedBox(width: 6),
                            AppText(
                              '$likes',
                              style: liked
                                  ? AppTextStyles.vibesMeta.copyWith(
                                      color: _likedGreen,
                                    )
                                  : AppTextStyles.vibesMeta,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 18),
                      GestureDetector(
                        onTap: onSend,
                        behavior: HitTestBehavior.opaque,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              AppAssets.iconMessagesBalloon,
                              width: 24,
                              height: 24,
                            ),
                            const SizedBox(width: 6),
                            AppText(sendLabel, style: AppTextStyles.vibesMeta),
                          ],
                        ),
                      ),
                    ],
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

