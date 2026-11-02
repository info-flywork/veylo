import 'dart:io';

import 'package:flutter/material.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/state/discover_highlight.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/screens/discover/post_stats_sheet.dart';

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
