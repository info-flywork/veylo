import 'package:flutter/material.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/core/widgets/profile_tappable_avatar.dart';
import 'package:veylo/i18n/strings.g.dart';

class _CommentItem {
  const _CommentItem({
    required this.avatar,
    required this.username,
    required this.hoursAgo,
    required this.body,
  });

  final String avatar;
  final String username;
  final int hoursAgo;
  final String body;
}

Future<void> showCommentsSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => const CommentsSheet(),
  );
}

/// Post comments bottom sheet — Figma Comments (430×418).
class CommentsSheet extends StatefulWidget {
  const CommentsSheet({super.key});

  @override
  State<CommentsSheet> createState() => _CommentsSheetState();
}

class _CommentsSheetState extends State<CommentsSheet> {
  static const _comments = <_CommentItem>[
    _CommentItem(
      avatar: AppAssets.fakePerson06,
      username: 'sam_black',
      hoursAgo: 19,
      body: '🔥🔥🔥🔥🔥🔥',
    ),
    _CommentItem(
      avatar: AppAssets.fakePerson08,
      username: 'lara.wtson',
      hoursAgo: 21,
      body: 'Omg this is soooo coooool tho! 😄❤️',
    ),
  ];

  static const _reactions = <String>[
    '🔥',
    '❤️',
    '✨',
    '😄',
    '👋',
    '😍',
    '💋',
  ];

  final _controller = TextEditingController();
  final _focus = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  void _appendEmoji(String emoji) {
    final text = _controller.text;
    final sel = _controller.selection;
    final start = sel.isValid ? sel.start : text.length;
    final end = sel.isValid ? sel.end : text.length;
    final next = text.replaceRange(start, end, emoji);
    _controller.value = TextEditingValue(
      text: next,
      selection: TextSelection.collapsed(offset: start + emoji.length),
    );
    _focus.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).discover.post;
    final bottom = MediaQuery.paddingOf(context).bottom;
    final keyboard = MediaQuery.viewInsetsOf(context).bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: keyboard),
      child: SizedBox(
        height: 418 + bottom,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 10, 16, 10 + bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.progressTrack,
                    borderRadius: BorderRadius.circular(AppBorders.radiusPill),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Title — Poppins SemiBold 16, pad 10
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: AppText(
                  t.commentsTitle,
                  style: AppTextStyles.commentsTitle,
                ),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: _comments.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final c = _comments[index];
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProfileTappableAvatar(
                          avatarUrl: c.avatar,
                          size: 30,
                          displayName: c.username,
                          username: c.username,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  AppText(
                                    c.username,
                                    style: AppTextStyles.commentUsername,
                                  ),
                                  const SizedBox(width: 4),
                                  AppText(
                                    t.hoursAgo(hours: c.hoursAgo.toString()),
                                    style: AppTextStyles.commentTime,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 0),
                              AppText(
                                c.body,
                                style: AppTextStyles.commentBody,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              // Footer — top border #000@10%, pad 10, gap 10
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Color(0x1A000000),
                      width: 0.5,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (final emoji in _reactions)
                          GestureDetector(
                            onTap: () => _appendEmoji(emoji),
                            behavior: HitTestBehavior.opaque,
                            child: Text(
                              emoji,
                              style: const TextStyle(fontSize: 28),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.selectionBorder,
                              width: 2,
                            ),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              AppAssets.fakePerson06,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            height: 50,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: AppColors.suggestionChipFill,
                              borderRadius: BorderRadius.circular(99999),
                            ),
                            child: TextField(
                              controller: _controller,
                              focusNode: _focus,
                              style: AppTextStyles.commentBody,
                              cursorColor: AppColors.selectionBorder,
                              decoration: InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                                hintText: t.addComment,
                                hintStyle: AppTextStyles.commentInputHint,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
