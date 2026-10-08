import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/models/chat/chat_note.dart';

const _kNoteCardWidth = 110.0;
const _kNoteCardHeight = 142.0;
const _kNoteAvatarSize = 68.0;
const _kAddBadgeSize = 24.0;

class ChatNoteCard extends StatelessWidget {
  const ChatNoteCard({
    super.key,
    required this.note,
    this.onTap,
  });

  final ChatNote note;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: _kNoteCardWidth,
        height: _kNoteCardHeight,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E2E2)),
        ),
        child: Column(
          children: [
            SizedBox(
              width: _kNoteAvatarSize,
              height: _kNoteAvatarSize,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipOval(
                    child: ChatAvatarImage(
                      url: note.avatarUrl,
                      size: _kNoteAvatarSize,
                    ),
                  ),
                  if (note.showAddBadge)
                    Positioned(
                      right: -2,
                      bottom: -2,
                      child: Container(
                        width: _kAddBadgeSize,
                        height: _kAddBadgeSize,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.textPrimary,
                        ),
                        child: const Icon(
                          Icons.add,
                          size: 16,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    note.displayName,
                    style: AppTextStyles.chatsNoteName,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  AppText(
                    note.statusText,
                    style: AppTextStyles.chatsNoteStatus,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatAvatarImage extends StatelessWidget {
  const ChatAvatarImage({
    super.key,
    required this.url,
    required this.size,
    this.fit = BoxFit.cover,
  });
  final String url;
  final double size;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    if (url.startsWith('assets/')) {
      return Image.asset(
        url,
        width: size,
        height: size,
        fit: fit,
      );
    }
    return Image.network(
      url,
      width: size,
      height: size,
      fit: fit,
      errorBuilder: (_, _, _) => ColoredBox(
        color: AppColors.inputFill,
        child: Icon(Icons.person, size: size * 0.5),
      ),
    );
  }
}
