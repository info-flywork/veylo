import 'dart:io';

import 'package:flutter/material.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/errors/error_messages.dart';
import 'package:veylo/core/state/discover_highlight.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/data/remote/discover_store.dart';
import 'package:veylo/data/remote/post_repository.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/models/discover/post.dart';
import 'package:veylo/screens/discover/discover_post_page.dart';
import 'package:veylo/screens/discover/post_stats_sheet.dart';

/// Discover’da paylaşım sonrası görünen rocket highlight.
/// Figma: search altında cream strip (thumbnail + mesaj + Öne Çıkar).
class DiscoverSharedSuccessBanner extends StatelessWidget {
  const DiscoverSharedSuccessBanner({super.key});

  Post? _postInFeed(String? id) {
    if (id == null) return null;
    for (final p in DiscoverStore.instance.posts) {
      if (p.id == id) return p;
    }
    return null;
  }

  Future<void> _openSharedPost(BuildContext context, String path) async {
    final id = DiscoverHighlight.instance.postId;
    var post = _postInFeed(id);
    if (post == null && id != null) {
      try {
        post = await PostRepository.instance.get(id);
      } catch (e) {
        if (context.mounted) showErrorSnackBar(context, e);
        return;
      }
    }
    if (!context.mounted) return;
    if (post != null) {
      await DiscoverPostPage.openPost(context, post, liveFeed: true);
      return;
    }
    await Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (_) => DiscoverPostPage(
          avatar: '',
          username: '',
          imageFilePath: path,
        ),
      ),
    );
  }

  Future<void> _boost(BuildContext context, String path) async {
    // Keşfet üst sıralama — profil/Vibes boost sayfasına gitmez.
    await showPostStatsSheet(
      context,
      imagePath: path,
      postId: DiscoverHighlight.instance.postId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).discover.highlight;

    return ValueListenableBuilder<String?>(
      valueListenable: DiscoverHighlight.instance.imagePath,
      builder: (context, path, _) {
        if (path == null) return const SizedBox.shrink();

        return Material(
          color: AppColors.sharedSuccessStrip,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: SizedBox(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => _openSharedPost(context, path),
                      child: Row(
                        children: [
                          ClipOval(
                            child: Image.file(
                              File(path),
                              width: 42,
                              height: 42,
                              fit: BoxFit.cover,
                              errorBuilder: (_, _, _) => const SizedBox(
                                width: 42,
                                height: 42,
                                child: ColoredBox(color: AppColors.inputFill),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                t.sharedSuccess,
                                maxLines: 1,
                                softWrap: false,
                                style: AppTextStyles.sharedSuccessMessage,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  InkWell(
                    onTap: () => _boost(context, path),
                    borderRadius: BorderRadius.circular(8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          AppAssets.iconHighlight,
                          width: 39,
                          height: 39,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          t.boost,
                          style: AppTextStyles.sharedSuccessBoost,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
