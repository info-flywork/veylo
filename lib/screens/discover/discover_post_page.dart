import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/screens/discover/comments_sheet.dart';

/// Discover grid’den açılan full-screen post.
class DiscoverPostPage extends StatefulWidget {
  const DiscoverPostPage({
    super.key,
    required this.avatar,
    required this.username,
    this.caption,
    this.imageFilePath,
  });

  final String avatar;
  final String username;
  final String? caption;
  final String? imageFilePath;

  @override
  State<DiscoverPostPage> createState() => _DiscoverPostPageState();
}

class _DiscoverPostPageState extends State<DiscoverPostPage> {
  bool _following = false;
  bool _liked = false;
  bool _saved = false;

  Widget _background() {
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
    final top = MediaQuery.paddingOf(context).top;
    final caption = widget.caption ?? t.sampleCaption;

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
            top: top + 8,
            left: 8,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              behavior: HitTestBehavior.opaque,
              child: SizedBox(
                width: 44,
                height: 44,
                child: Center(
                  child: SvgPicture.asset(
                    AppAssets.iconCloseWithoutBorder,
                    width: 32,
                    height: 32,
                  ),
                ),
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
                            Row(
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
                                    widget.username,
                                    style: AppTextStyles.postUsername,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () =>
                                  setState(() => _following = !_following),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.black.withValues(alpha: 0.4),
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
                            const SizedBox(height: 10),
                            AppText(
                              caption,
                              style: AppTextStyles.postCaption,
                              maxLines: 3,
                            ),
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
                            onTap: () => setState(() => _saved = !_saved),
                          ),
                          const SizedBox(height: 16),
                          GestureDetector(
                            onTap: () => showCommentsSheet(context),
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
                          onTap: () => showCommentsSheet(context),
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
                        onTap: () => setState(() => _liked = !_liked),
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
