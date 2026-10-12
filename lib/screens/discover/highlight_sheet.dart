import 'dart:io';

import 'package:flutter/material.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/state/discover_highlight.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/screens/discover/comments_sheet.dart';
import 'package:veylo/screens/discover/discover_post_page.dart';
import 'package:veylo/screens/discover/post_stats_sheet.dart';

Future<void> showHighlightSheet(
  BuildContext context, {
  required String imagePath,
}) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: AppColors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => _HighlightSheet(imagePath: imagePath),
  );
}

class _HighlightSheet extends StatelessWidget {
  const _HighlightSheet({required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).discover.highlight;
    final bottom = MediaQuery.paddingOf(context).bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 10, 16, 20 + bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.progressTrack,
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          const SizedBox(height: 16),
          AppText(t.title, style: AppTextStyles.filtersTitle),
          const SizedBox(height: 16),
          _Row(
            icon: Icons.visibility_outlined,
            label: t.view,
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => DiscoverPostPage(
                    avatar: imagePath,
                    username: 'you',
                    imageFilePath: imagePath,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 8),
          _Row(
            iconWidget: Image.asset(
              AppAssets.iconAiCommentary,
              width: 28,
              height: 28,
            ),
            label: t.aiComments,
            onTap: () {
              Navigator.pop(context);
              showCommentsSheet(context);
            },
          ),
          const SizedBox(height: 8),
          _Row(
            icon: Icons.front_hand_outlined,
            label: t.remove,
            destructive: true,
            onTap: () {
              DiscoverHighlight.instance.clear();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({
    required this.label,
    required this.onTap,
    this.icon,
    this.iconWidget,
    this.destructive = false,
  });

  final IconData? icon;
  final Widget? iconWidget;
  final String label;
  final VoidCallback onTap;
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    final color = destructive ? AppColors.error : AppColors.textOnLight;
    return Material(
      color: AppColors.sheetMuted,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          child: Row(
            children: [
              SizedBox(
                width: 28,
                height: 28,
                child: iconWidget ??
                    Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontFamily: AppFonts.poppins,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Discover’da paylaşım sonrası görünen rocket highlight.
/// Figma: search altında cream strip (thumbnail + mesaj + Öne Çıkar).
class DiscoverSharedSuccessBanner extends StatelessWidget {
  const DiscoverSharedSuccessBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).discover.highlight;

    return ValueListenableBuilder<String?>(
      valueListenable: DiscoverHighlight.instance.imagePath,
      builder: (context, path, _) {
        if (path == null) return const SizedBox.shrink();

        return Material(
          color: AppColors.sharedSuccessStrip,
          child: InkWell(
            onTap: () => showPostStatsSheet(
              context,
              imagePath: path,
              postId: DiscoverHighlight.instance.postId,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: SizedBox(
                height: 50,
                child: Row(
                  children: [
                    ClipOval(
                      child: Image.file(
                        File(path),
                        width: 42,
                        height: 42,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => Image.asset(
                          AppAssets.fakePerson01,
                          width: 42,
                          height: 42,
                          fit: BoxFit.cover,
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
                    const SizedBox(width: 12),
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
            ),
          ),
        );
      },
    );
  }
}
