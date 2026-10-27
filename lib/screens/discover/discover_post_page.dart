import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/errors/error_messages.dart';
import 'package:veylo/core/widgets/ai_badge.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/data/remote/discover_store.dart';
import 'package:veylo/data/remote/post_repository.dart';
import 'package:veylo/data/remote/user_repository.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/models/discover/post.dart';
import 'package:veylo/screens/chat/widgets/chat_note_card.dart';
import 'package:veylo/screens/discover/comments_sheet.dart';
import 'package:veylo/screens/profile/profile_navigation.dart';

/// Discover grid’den açılan full-screen post.
class DiscoverPostPage extends StatefulWidget {
  const DiscoverPostPage({
    super.key,
    required this.avatar,
    required this.username,
    this.caption,
    this.imageFilePath,
    this.post,
    this.feed,
    this.initialIndex = 0,
    this.liveFeed = false,
  });

  final String avatar;
  final String username;
  final String? caption;
  final String? imageFilePath;

  /// Sunucudaki gönderi (verilmezse yerel önizleme).
  final Post? post;

  /// Discover akışı: aşağı kaydırınca sıradaki gönderi.
  final bool liveFeed;

  /// Profil gibi sabit bir liste. Verilmezse tek gönderi.
  final List<Post>? feed;

  final int initialIndex;

  static Future<void> openPost(
    BuildContext context,
    Post post, {
    List<Post>? feed,
    int? index,
    bool liveFeed = false,
  }) {
    final source = liveFeed ? DiscoverStore.instance.posts : (feed ?? [post]);
    final i = index ?? source.indexWhere((p) => p.id == post.id);
    return Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => DiscoverPostPage(
          avatar: post.authorAvatarUrl ?? '',
          username: post.handle,
          caption: post.caption,
          post: post,
          feed: liveFeed ? null : source,
          initialIndex: i < 0 ? 0 : i,
          liveFeed: liveFeed,
        ),
      ),
    );
  }

  @override
  State<DiscoverPostPage> createState() => _DiscoverPostPageState();
}

class _DiscoverPostPageState extends State<DiscoverPostPage> {
  final _store = DiscoverStore.instance;
  PageController? _pages;

  List<Post> get _posts {
    if (widget.liveFeed) return _store.posts;
    return widget.feed ?? (widget.post == null ? const [] : [widget.post!]);
  }

  @override
  void initState() {
    super.initState();
    if (_posts.isEmpty) return;
    final last = _posts.length - 1;
    final initial = widget.initialIndex.clamp(0, last);
    _pages = PageController(initialPage: initial);
    if (widget.liveFeed) {
      _store.addListener(_onStore);
      if (initial >= last - 3) _store.loadMore();
    }
  }

  void _onStore() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    if (widget.liveFeed) _store.removeListener(_onStore);
    _pages?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.paddingOf(context).top;
    final posts = _posts;
    final pages = _pages;

    final Widget body = posts.isEmpty || pages == null
        ? _FeedPostSlide(
            avatar: widget.avatar,
            username: widget.username,
            caption: widget.caption,
            imageFilePath: widget.imageFilePath,
          )
        : PageView.builder(
            controller: pages,
            scrollDirection: Axis.vertical,
            itemCount: posts.length,
            onPageChanged: (i) {
              if (widget.liveFeed && i >= posts.length - 4) _store.loadMore();
            },
            itemBuilder: (_, i) => _FeedPostSlide(post: posts[i]),
          );

    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          body,
          Positioned(
            top: top + 8,
            left: 8,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              behavior: HitTestBehavior.opaque,
              child: const SizedBox(
                width: 44,
                height: 44,
                child: Center(
                  child: _CloseMark(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CloseMark extends StatelessWidget {
  const _CloseMark();

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AppAssets.iconCloseWithoutBorder,
      width: 32,
      height: 32,
    );
  }
}

class _FeedPostSlide extends StatefulWidget {
  const _FeedPostSlide({
    this.post,
    this.avatar = '',
    this.username = '',
    this.caption,
    this.imageFilePath,
  });

  final Post? post;
  final String avatar;
  final String username;
  final String? caption;
  final String? imageFilePath;

  @override
  State<_FeedPostSlide> createState() => _FeedPostSlideState();
}

class _FeedPostSlideState extends State<_FeedPostSlide> {
  bool _following = false;
  bool _liked = false;
  bool _saved = false;
  late Post? _post = widget.post;
  final _repo = PostRepository.instance;

  @override
  void initState() {
    super.initState();
    final post = _post;
    if (post == null) return;
    _liked = post.likedByMe;
    _saved = post.savedByMe;
    // Görüntülenme sayılır; tam detayla takip durumu gelir.
    _repo.view(post.id).catchError((_) {});
    _repo
        .get(post.id)
        .then((p) {
          if (!mounted) return;
          setState(() {
            _post = p;
            _following = p.iFollowAuthor ?? false;
            _liked = p.likedByMe;
            _saved = p.savedByMe;
          });
        })
        .catchError((Object e) {
          if (mounted) showErrorSnackBar(context, e);
        });
  }

  void _apply(Post p) {
    if (!mounted) return;
    setState(() => _post = p);
    DiscoverStore.instance.replace(p);
  }

  Future<void> _toggleLike() async {
    final post = _post;
    setState(() => _liked = !_liked);
    if (post == null) return;
    try {
      _apply(await _repo.setLiked(post.id, _liked));
    } catch (e) {
      if (!mounted) return;
      setState(() => _liked = !_liked);
      showErrorSnackBar(context, e);
    }
  }

  Future<void> _toggleSave() async {
    final post = _post;
    setState(() => _saved = !_saved);
    if (post == null) return;
    try {
      _apply(await _repo.setSaved(post.id, _saved));
    } catch (e) {
      if (!mounted) return;
      setState(() => _saved = !_saved);
      showErrorSnackBar(context, e);
    }
  }

  Future<void> _toggleFollow() async {
    final post = _post;
    setState(() => _following = !_following);
    if (post == null) return;
    try {
      final users = UserRepository.instance;
      await (_following
          ? users.follow(post.authorId)
          : users.unfollow(post.authorId));
    } catch (e) {
      if (!mounted) return;
      setState(() => _following = !_following);
      showErrorSnackBar(context, e);
    }
  }

  void _openComments() => showCommentsSheet(
    context,
    postId: _post?.id,
    postIsMine: _post?.isMine ?? false,
  );

  void _openAuthor() {
    final post = _post;
    if (post == null) return;
    openUserProfile(
      context,
      userId: post.authorId,
      displayName: post.authorName,
      avatarUrl: post.authorAvatarUrl,
      username: post.authorUsername,
    );
  }

  Widget _background() {
    final post = _post;
    if (post != null) {
      return Image.network(
        post.mediaUrl,
        fit: BoxFit.cover,
        alignment: Alignment.center,
        filterQuality: FilterQuality.high,
        errorBuilder: (_, _, _) => const ColoredBox(color: AppColors.black),
      );
    }
    final path = widget.imageFilePath;
    if (path != null && File(path).existsSync()) {
      return Image.file(
        File(path),
        fit: BoxFit.cover,
        alignment: Alignment.center,
        filterQuality: FilterQuality.high,
      );
    }
    return Image.asset(
      AppAssets.postDetail,
      fit: BoxFit.cover,
      alignment: Alignment.center,
      filterQuality: FilterQuality.high,
    );
  }

  Widget _avatarImage() {
    final post = _post;
    if (post != null) {
      return ChatAvatarImage(url: post.authorAvatarUrl ?? '', size: 36);
    }
    final path = widget.avatar;
    if (File(path).existsSync()) {
      return Image.file(File(path), fit: BoxFit.cover);
    }
    return Image.asset(path, fit: BoxFit.cover);
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).discover.post;
    final bottom = MediaQuery.paddingOf(context).bottom;
    final post = _post;
    final caption = post != null
        ? (post.caption ?? '')
        : (widget.caption ?? t.sampleCaption);
    final showFollow = post == null || !post.isMine;

    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          _background(),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.transparent,
                  Color(0x99000000),
                  Color(0xE6000000),
                ],
                stops: [0, 0.45, 0.72, 1],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 10 + bottom),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: _openAuthor,
                              behavior: HitTestBehavior.opaque,
                              child: Row(
                                children: [
                                  Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: AppColors.white,
                                        width: 1,
                                      ),
                                    ),
                                    child: ClipOval(child: _avatarImage()),
                                  ),
                                  const SizedBox(width: 8),
                                  Flexible(
                                    child: AppText(
                                      post?.handle ?? widget.username,
                                      style: AppTextStyles.postUsername,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  if (post?.authorIsAi ?? false)
                                    const AiBadge(),
                                ],
                              ),
                            ),
                            if (showFollow) ...[
                              const SizedBox(height: 10),
                              GestureDetector(
                                onTap: _toggleFollow,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.black.withValues(
                                      alpha: 0.4,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        _following
                                            ? Icons.person
                                            : Icons.person_add_alt_1,
                                        size: 18,
                                        color: AppColors.white,
                                      ),
                                      const SizedBox(width: 10),
                                      AppText(
                                        _following ? t.following : t.follow,
                                        style: AppTextStyles.postFollow,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                            if (caption.isNotEmpty) ...[
                              const SizedBox(height: 10),
                              AppText(
                                caption,
                                style: AppTextStyles.postCaption,
                                maxLines: 3,
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _ActionIcon(
                            asset: AppAssets.iconSave,
                            size: 32,
                            active: _saved,
                            onTap: _toggleSave,
                          ),
                          const SizedBox(height: 16),
                          GestureDetector(
                            onTap: _openComments,
                            behavior: HitTestBehavior.opaque,
                            child: SvgPicture.asset(
                              AppAssets.iconComment,
                              width: 32,
                              height: 32,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: _openComments,
                          child: Container(
                            height: 50,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: AppColors.black.withValues(alpha: 0.4),
                              borderRadius: BorderRadius.circular(99999),
                            ),
                            child: AppText(
                              t.addComment,
                              style: AppTextStyles.postCommentHint,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: _toggleLike,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.black.withValues(alpha: 0.4),
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: SvgPicture.asset(
                            AppAssets.iconHeart,
                            width: 28,
                            height: 28,
                            colorFilter: ColorFilter.mode(
                              _liked
                                  ? AppColors.selectionBorder
                                  : AppColors.white,
                              BlendMode.srcIn,
                            ),
                          ),
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
    );
  }
}

class _ActionIcon extends StatelessWidget {
  const _ActionIcon({
    required this.asset,
    required this.size,
    required this.onTap,
    this.active = false,
  });

  final String asset;
  final double size;
  final VoidCallback onTap;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 38,
        height: size,
        child: Center(
          child: SvgPicture.asset(
            asset,
            width: size,
            height: size,
            colorFilter: active
                ? const ColorFilter.mode(
                    AppColors.selectionBorder,
                    BlendMode.srcIn,
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
