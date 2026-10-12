import 'package:flutter/material.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/errors/error_messages.dart';
import 'package:veylo/core/widgets/ai_badge.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/core/widgets/profile_tappable_avatar.dart';
import 'package:veylo/data/remote/post_repository.dart';
import 'package:veylo/data/remote/session_store.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/models/discover/post.dart';
import 'package:veylo/screens/chat/widgets/chat_note_card.dart';

class _CommentItem {
  const _CommentItem({
    required this.avatar,
    required this.username,
    required this.minutesAgo,
    required this.body,
    this.source,
  });

  final String avatar;
  final String username;
  final int minutesAgo;
  final String body;

  /// Sunucudaki yorum (örnek modunda null).
  final PostComment? source;

  factory _CommentItem.from(PostComment c) => _CommentItem(
    avatar: (c.authorAvatarUrl?.isNotEmpty ?? false)
        ? c.authorAvatarUrl!
        : AppAssets.strangerAvatar,
    username: c.authorUsername ?? c.authorName,
    minutesAgo: DateTime.now().difference(c.createdAt).inMinutes,
    body: c.body,
    source: c,
  );
}

/// [postId] verilirse gönderinin gerçek yorumları; verilmezse örnek yorumlar.
/// [postIsMine]: gönderi benimse her yorumu silebilirim.
Future<void> showCommentsSheet(
  BuildContext context, {
  String? postId,
  bool postIsMine = false,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => CommentsSheet(postId: postId, postIsMine: postIsMine),
  );
}

/// Post comments bottom sheet — Figma Comments (430×418).
class CommentsSheet extends StatefulWidget {
  const CommentsSheet({super.key, this.postId, this.postIsMine = false});

  final String? postId;
  final bool postIsMine;

  @override
  State<CommentsSheet> createState() => _CommentsSheetState();
}

class _CommentsSheetState extends State<CommentsSheet> {
  static const _samples = <_CommentItem>[
    _CommentItem(
      avatar: AppAssets.fakePerson06,
      username: 'sam_black',
      minutesAgo: 19 * 60,
      body: '🔥🔥🔥🔥🔥🔥',
    ),
    _CommentItem(
      avatar: AppAssets.fakePerson08,
      username: 'lara.wtson',
      minutesAgo: 21 * 60,
      body: 'Omg this is soooo coooool tho! 😄❤️',
    ),
  ];

  final _repo = PostRepository.instance;
  List<_CommentItem> _comments = const [];
  bool _sending = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
    final id = widget.postId;
    if (id == null) {
      _comments = _samples;
      return;
    }
    _repo
        .comments(id)
        .then((list) {
          if (mounted) {
            setState(
              () => _comments = [for (final c in list) _CommentItem.from(c)],
            );
          }
        })
        .catchError((Object e) {
          if (mounted) showErrorSnackBar(context, e);
        });
  }

  Future<void> _send() async {
    final id = widget.postId;
    final text = _controller.text.trim();
    if (id == null || text.isEmpty || _sending) return;
    setState(() => _sending = true);
    try {
      final c = await _repo.addComment(id, text);
      _controller.clear();
      if (mounted) {
        setState(() => _comments = [..._comments, _CommentItem.from(c)]);
      }
    } catch (e) {
      if (mounted) showErrorSnackBar(context, e);
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  /// Kendi yorumum ya da gönderi benimse: uzun basınca sil.
  Future<void> _confirmDelete(_CommentItem item) async {
    final c = item.source;
    if (c == null || !(c.isMine || widget.postIsMine)) return;
    final tr = Translations.of(context);
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(tr.discover.post.deleteCommentTitle),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(tr.vibes.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(tr.vibes.delete),
          ),
        ],
      ),
    );
    if (ok != true) return;
    try {
      await _repo.deleteComment(c.id);
      if (mounted) {
        setState(
          () =>
              _comments = _comments.where((x) => x.source?.id != c.id).toList(),
        );
      }
    } catch (e) {
      if (mounted) showErrorSnackBar(context, e);
    }
  }

  String _ago(Translations tr, int minutes) {
    final t = tr.discover.post;
    if (minutes < 60) {
      return t.minutesAgo(minutes: (minutes < 1 ? 1 : minutes).toString());
    }
    if (minutes < 24 * 60) return t.hoursAgo(hours: (minutes ~/ 60).toString());
    return t.daysAgo(days: (minutes ~/ (24 * 60)).toString());
  }

  static const _reactions = <String>['🔥', '❤️', '✨', '😄', '👋', '😍', '💋'];

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
                  itemBuilder: (_, index) {
                    final c = _comments[index];
                    return GestureDetector(
                      onLongPress: () => _confirmDelete(c),
                      behavior: HitTestBehavior.opaque,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProfileTappableAvatar(
                            avatarUrl: c.avatar,
                            size: 30,
                            userId: c.source?.authorId,
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
                                    Flexible(
                                      child: AppText(
                                        c.username,
                                        style: AppTextStyles.commentUsername,
                                        maxLines: 1,
                                      ),
                                    ),
                                    if (c.source?.authorIsAi ?? false)
                                      const AiBadge(compact: true),
                                    const SizedBox(width: 4),
                                    AppText(
                                      _ago(
                                        Translations.of(context),
                                        c.minutesAgo,
                                      ),
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
                      ),
                    );
                  },
                ),
              ),
              // Footer — top border #000@10%, pad 10, gap 10
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Color(0x1A000000), width: 0.5),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (final emoji in _reactions)
                          // Dar ekranda taşmasın: gerekirse küçülür.
                          Flexible(
                            child: GestureDetector(
                              onTap: () => _appendEmoji(emoji),
                              behavior: HitTestBehavior.opaque,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  emoji,
                                  style: const TextStyle(fontSize: 28),
                                ),
                              ),
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
                            child: ChatAvatarImage(
                              url: SessionStore.instance.me?.avatarUrl ?? '',
                              size: 36,
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
                              textInputAction: TextInputAction.send,
                              onSubmitted: (_) => _send(),
                              style: AppTextStyles.commentBody,
                              cursorColor: AppColors.selectionBorder,
                              decoration: InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                                hintText: t.addComment,
                                hintStyle: AppTextStyles.commentInputHint,
                                // Yazı varken gönder (sohbetteki düğmeyle aynı).
                                suffixIconConstraints: const BoxConstraints(),
                                suffixIcon:
                                    widget.postId != null &&
                                        _controller.text.trim().isNotEmpty
                                    ? GestureDetector(
                                        onTap: _send,
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.selectionBorder,
                                          ),
                                          alignment: Alignment.center,
                                          child: const Icon(
                                            Icons.send_rounded,
                                            size: 16,
                                            color: AppColors.white,
                                          ),
                                        ),
                                      )
                                    : null,
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
