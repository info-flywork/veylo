import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/core/widgets/profile_tappable_avatar.dart';
import 'package:veylo/core/errors/error_messages.dart';
import 'package:veylo/data/remote/vibe_repository.dart';
import 'package:veylo/data/remote/vibe_store.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/models/vibes/vibe_post.dart';
import 'package:veylo/screens/chat/report_reason_sheet.dart';
import 'package:veylo/screens/vibes/vibe_share_sheet.dart';
import 'package:veylo/screens/vibes/vibe_talk_sheet.dart';
import 'package:veylo/screens/vibes/vibes_map_view.dart';

const _kSearchFill = Color(0x1A998FED);
const _kDivider = Color(0x1A000000);
const _kAvatar = 58.0;

/// Vibes — başlık, arama ve konuşma kartları.
class VibesPage extends StatefulWidget {
  const VibesPage({super.key});

  @override
  State<VibesPage> createState() => _VibesPageState();
}

class _VibesPageState extends State<VibesPage> {
  final _searchCtrl = TextEditingController();
  final _store = VibeStore.instance;
  bool _mapOpen = false;

  /// Başlıktaki sıralama butonu: en yeni (sunucu sırası) / en çok beğenilen.
  bool _popular = false;

  @override
  void initState() {
    super.initState();
    _searchCtrl.addListener(() => setState(() {}));
    _store.addListener(_onStore);
    if (!_store.loaded) _store.refresh();
  }

  @override
  void dispose() {
    _store.removeListener(_onStore);
    _searchCtrl.dispose();
    super.dispose();
  }

  void _onStore() {
    if (mounted) setState(() {});
  }

  List<VibePost> get _visible {
    final q = _searchCtrl.text.trim().toLowerCase();
    final posts = _store.posts;
    final filtered = q.isEmpty
        ? posts
        : posts
              .where(
                (p) =>
                    p.name.toLowerCase().contains(q) ||
                    p.body.toLowerCase().contains(q),
              )
              .toList();
    if (!_popular) return filtered;
    return List.of(filtered)
      ..sort((a, b) => b.likeCount.compareTo(a.likeCount));
  }

  void _toggleSort() {
    setState(() => _popular = !_popular);
    final t = Translations.of(context).vibes;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(_popular ? t.sortPopular : t.sortNewest),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 1),
        ),
      );
  }

  /// Uzun basma: kendi vibe'ım → silme onayı, başkasının → şikayet.
  void _onPostLongPress(VibePost post) {
    if (post.isMine) {
      _confirmDelete(post);
      return;
    }
    showReportReasonSheet(
      context,
      onSubmit: (reason) =>
          VibeRepository.instance.report(post.id, reason: reason),
    );
  }

  Future<void> _shareVibe() async {
    final draft = await showVibeShareSheet(context);
    if (draft == null || !mounted) return;
    try {
      await _store.share(body: draft.body, anonymous: draft.anonymous);
      if (mounted) setState(() => _mapOpen = false);
    } catch (e) {
      if (mounted) showErrorSnackBar(context, e);
    }
  }

  /// Kendi vibe'ına uzun basınca silme onayı.
  Future<void> _confirmDelete(VibePost post) async {
    final t = Translations.of(context).vibes;
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(t.deleteTitle),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(t.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(t.delete),
          ),
        ],
      ),
    );
    if (ok != true || !mounted) return;
    try {
      await _store.delete(post);
    } catch (e) {
      if (mounted) showErrorSnackBar(context, e);
    }
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
              popular: _popular,
              onToggleMap: () => setState(() => _mapOpen = !_mapOpen),
              onToggleSort: _toggleSort,
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
            child: !_store.loaded && _store.loading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.brandPurple,
                    ),
                  )
                : !_store.loaded && _store.error != null
                ? _VibesError(
                    text: t.vibes.loadFailed,
                    retryLabel: t.common.retry,
                    onRetry: _store.refresh,
                  )
                : _mapOpen
                ? VibesMapView(
                    posts: items,
                    onLongPress: _onPostLongPress,
                    onDelete: _confirmDelete,
                  )
                : _store.loaded && _store.posts.isEmpty
                ? _VibesEmpty(text: t.vibes.empty, onRefresh: _store.refresh)
                : items.isEmpty
                ? _VibesEmpty(text: t.vibes.noResults, onRefresh: _store.refresh)
                : RefreshIndicator(
                    onRefresh: _store.refresh,
                    color: AppColors.brandPurple,
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (n) {
                        if (n.metrics.extentAfter < 400) _store.loadMore();
                        return false;
                      },
                      child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.fromLTRB(
                          16,
                          0,
                          16,
                          16 + bottom + 64,
                        ),
                        itemCount: items.isEmpty ? 0 : items.length * 2 - 1,
                        // Sayfanın context'i: liste yenilense de sheet akışı yarıda kalmaz.
                        itemBuilder: (_, index) {
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
                          return GestureDetector(
                            onLongPress: () => _onPostLongPress(post),
                            child: _VibeCard(
                              post: post,
                              liked: post.likedByMe,
                              sendLabel: t.vibes.sendMessage,
                              onLike: () => _store.toggleLike(post),
                              // Kendi vibe'ına mesaj gönderilmez.
                              onSend: post.isMine
                                  ? () {}
                                  : () => showVibeTalkSheet(context, post),
                            ),
                          );
                        },
                      ),
                    ),
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
    required this.popular,
    required this.onToggleMap,
    required this.onToggleSort,
    required this.onCreate,
  });

  final bool mapOpen;
  final bool popular;
  final VoidCallback onToggleMap;
  final VoidCallback onToggleSort;
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
        GestureDetector(
          onTap: onToggleSort,
          behavior: HitTestBehavior.opaque,
          child: SvgPicture.asset(
            AppAssets.iconConvert,
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              popular ? AppColors.brandPurple : AppColors.textOnLight,
              BlendMode.srcIn,
            ),
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
  const _VibesSearchField({required this.controller, required this.hint});

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
    final likes = post.likeCount;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileTappableAvatar(
            avatarUrl: post.avatarAsset,
            size: _kAvatar,
            userId: post.authorId,
            username: post.username,
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
                      child: Row(
                        children: [
                          Flexible(
                            child: AppText(
                              post.name,
                              style: AppTextStyles.vibesName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
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
                      if (!post.isMine) ...[
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

class _VibesEmpty extends StatelessWidget {
  const _VibesEmpty({required this.text, required this.onRefresh});

  final String text;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: AppColors.brandPurple,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(32, 120, 32, 0),
        children: [
          AppText(
            text,
            style: AppTextStyles.vibesDate,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _VibesError extends StatelessWidget {
  const _VibesError({
    required this.text,
    required this.retryLabel,
    required this.onRetry,
  });

  final String text;
  final String retryLabel;
  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 120, 32, 0),
      child: Column(
        children: [
          AppText(
            text,
            style: AppTextStyles.vibesDate,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: onRetry,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: AppText(retryLabel, style: AppTextStyles.chatsRequestLink),
            ),
          ),
        ],
      ),
    );
  }
}
