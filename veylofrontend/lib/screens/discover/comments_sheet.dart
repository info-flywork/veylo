import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  _CommentItem({
    required this.avatar,
    required this.username,
    required this.minutesAgo,
    required this.body,
    this.source,
    this.likeCount = 0,
    this.liked = false,
    this.replies = const [],
    this.hiddenReplyCount = 0,
    this.expanded = false,
  });

  final String avatar;
  final String username;
  final int minutesAgo;
  final String body;

  /// Sunucudaki yorum (örnek modunda null).
  final PostComment? source;
  int likeCount;
  bool liked;
  List<_CommentItem> replies;
  int hiddenReplyCount;
  bool expanded;

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
  static List<_CommentItem> get _samples => [
    _CommentItem(
      avatar: AppAssets.fakePerson06,
      username: 'sam_black',
      minutesAgo: 19 * 60,
      body: '🔥🔥🔥🔥🔥🔥',
      likeCount: 10000,
      replies: [
        _CommentItem(
          avatar: AppAssets.fakePerson08,
          username: 'lara.wtson',
          minutesAgo: 19 * 60,
          body: '💚',
          likeCount: 2000,
        ),
      ],
      hiddenReplyCount: 15,
    ),
  ];

  final _repo = PostRepository.instance;
  List<_CommentItem> _comments = const [];
  bool _sending = false;
  _CommentItem? _replyTo;

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

  String _replyTag(_CommentItem item) => '@${item.username} ';

  String _stripReplyTag(String text, _CommentItem? item) {
    if (item == null) return text;
    final tag = _replyTag(item);
    if (text.startsWith(tag)) return text.substring(tag.length);
    final bare = '@${item.username}';
    if (text.startsWith(bare)) {
      return text.substring(bare.length).trimLeft();
    }
    return text;
  }

  Future<void> _send() async {
    final raw = _controller.text.trim();
    if (raw.isEmpty || _sending) return;

    final replyTo = _replyTo;
    final contentOnly = _stripReplyTag(raw, replyTo).trim();
    // Sadece @etiket varsa gönderme.
    if (contentOnly.isEmpty) return;

    final id = widget.postId;
    // Input’taki metin zaten @kullanıcı + yorumu içerir.
    final body = raw;

    final thread = replyTo == null ? null : _threadRootFor(replyTo);

    // Örnek / önizleme: yerel listeye ekle.
    if (id == null) {
      final me = SessionStore.instance.me;
      final item = _CommentItem(
        avatar: me?.avatarUrl?.isNotEmpty == true
            ? me!.avatarUrl!
            : AppAssets.fakePerson01,
        username: me?.username ?? me?.displayName ?? 'you',
        minutesAgo: 0,
        body: body,
      );
      setState(() {
        if (thread != null) {
          thread.replies = [...thread.replies, item];
          thread.expanded = true;
        } else {
          _comments = [..._comments, item];
        }
        _replyTo = null;
        _controller.clear();
      });
      return;
    }

    setState(() => _sending = true);
    try {
      final c = await _repo.addComment(id, body);
      _controller.clear();
      if (mounted) {
        setState(() {
          final item = _CommentItem.from(c);
          if (thread != null) {
            thread.replies = [...thread.replies, item];
            thread.expanded = true;
          } else {
            _comments = [..._comments, item];
          }
          _replyTo = null;
        });
      }
    } catch (e) {
      if (mounted) showErrorSnackBar(context, e);
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  /// Yanıta yanıtta da thread köküne ekle; etiket `_replyTo` kişisine kalır.
  _CommentItem _threadRootFor(_CommentItem target) {
    for (final c in _comments) {
      if (identical(c, target)) return c;
      if (c.replies.any((r) => identical(r, target))) return c;
    }
    return target;
  }

  void _startReply(_CommentItem item) {
    final rest = _stripReplyTag(_controller.text, _replyTo);
    final next = '${_replyTag(item)}$rest';
    setState(() {
      _replyTo = item;
      _controller.value = TextEditingValue(
        text: next,
        selection: TextSelection.collapsed(offset: next.length),
      );
    });
    _focus.requestFocus();
  }

  bool get _canSend {
    final raw = _controller.text.trim();
    if (raw.isEmpty) return false;
    return _stripReplyTag(raw, _replyTo).trim().isNotEmpty;
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
        setState(() {
          _comments = _comments.where((x) => x.source?.id != c.id).toList();
          for (final parent in _comments) {
            parent.replies =
                parent.replies.where((x) => x.source?.id != c.id).toList();
          }
        });
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

  String _formatCount(int n) {
    if (n >= 1000000) {
      final v = n / 1000000;
      final s = v >= 10 ? '${v.round()}' : v.toStringAsFixed(1);
      return '${s.replaceAll(RegExp(r'\.0$'), '')}M';
    }
    if (n >= 1000) {
      final v = n / 1000;
      final s = v >= 10 ? '${v.round()}' : v.toStringAsFixed(1);
      return '${s.replaceAll(RegExp(r'\.0$'), '')}k';
    }
    return '$n';
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
                  separatorBuilder: (_, _) => const SizedBox(height: 16),
                  itemBuilder: (_, index) {
                    final c = _comments[index];
                    final tr = Translations.of(context);
                    return _CommentThread(
                      item: c,
                      formatAgo: (m) => _ago(tr, m),
                      formatCount: _formatCount,
                      replyLabel: t.reply,
                      viewOtherReplies: t.viewOtherReplies,
                      onReply: _startReply,
                      onLongPress: _confirmDelete,
                      onToggleLike: (item) => setState(() {
                        item.liked = !item.liked;
                        item.likeCount += item.liked ? 1 : -1;
                        if (item.likeCount < 0) item.likeCount = 0;
                      }),
                      onExpand: () => setState(() => c.expanded = true),
                    );
                  },
                ),
              ),
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
                                suffixIconConstraints: const BoxConstraints(),
                                suffixIcon: _canSend
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

class _CommentThread extends StatelessWidget {
  const _CommentThread({
    required this.item,
    required this.formatAgo,
    required this.formatCount,
    required this.replyLabel,
    required this.viewOtherReplies,
    required this.onReply,
    required this.onLongPress,
    required this.onToggleLike,
    required this.onExpand,
  });

  final _CommentItem item;
  final String Function(int) formatAgo;
  final String Function(int) formatCount;
  final String replyLabel;
  final String Function({required Object count}) viewOtherReplies;
  final ValueChanged<_CommentItem> onReply;
  final ValueChanged<_CommentItem> onLongPress;
  final ValueChanged<_CommentItem> onToggleLike;
  final VoidCallback onExpand;

  @override
  Widget build(BuildContext context) {
    final visibleReplies = item.expanded
        ? item.replies
        : item.replies.take(1).toList();
    final showViewMore = !item.expanded && item.hiddenReplyCount > 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _CommentRow(
          item: item,
          ago: formatAgo(item.minutesAgo),
          formatCount: formatCount,
          replyLabel: replyLabel,
          onReply: () => onReply(item),
          onLongPress: () => onLongPress(item),
          onToggleLike: () => onToggleLike(item),
        ),
        if (showViewMore) ...[
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: GestureDetector(
              onTap: onExpand,
              behavior: HitTestBehavior.opaque,
              child: Row(
                children: [
                  Container(
                    width: 24,
                    height: 1,
                    color: AppColors.navInactive.withValues(alpha: 0.45),
                  ),
                  const SizedBox(width: 8),
                  AppText(
                    viewOtherReplies(count: item.hiddenReplyCount),
                    style: AppTextStyles.commentReplyAction,
                  ),
                ],
              ),
            ),
          ),
        ],
        for (final reply in visibleReplies) ...[
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: _CommentRow(
              item: reply,
              ago: formatAgo(reply.minutesAgo),
              formatCount: formatCount,
              replyLabel: replyLabel,
              onReply: () => onReply(reply),
              onLongPress: () => onLongPress(reply),
              onToggleLike: () => onToggleLike(reply),
            ),
          ),
        ],
      ],
    );
  }
}

class _CommentRow extends StatelessWidget {
  const _CommentRow({
    required this.item,
    required this.ago,
    required this.formatCount,
    required this.replyLabel,
    required this.onReply,
    required this.onLongPress,
    required this.onToggleLike,
  });

  final _CommentItem item;
  final String ago;
  final String Function(int) formatCount;
  final String replyLabel;
  final VoidCallback onReply;
  final VoidCallback onLongPress;
  final VoidCallback onToggleLike;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      behavior: HitTestBehavior.opaque,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileTappableAvatar(
            avatarUrl: item.avatar,
            size: 30,
            userId: item.source?.authorId,
            displayName: item.username,
            username: item.username,
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
                        item.username,
                        style: AppTextStyles.commentUsername,
                        maxLines: 1,
                      ),
                    ),
                    if (item.source?.authorIsAi ?? false)
                      const AiBadge(compact: true),
                    const SizedBox(width: 4),
                    AppText(ago, style: AppTextStyles.commentTime),
                  ],
                ),
                AppText(item.body, style: AppTextStyles.commentBody),
                const SizedBox(height: 4),
                GestureDetector(
                  onTap: onReply,
                  behavior: HitTestBehavior.opaque,
                  child: AppText(
                    replyLabel,
                    style: AppTextStyles.commentReplyAction,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onToggleLike,
            behavior: HitTestBehavior.opaque,
            child: Column(
              children: [
                SvgPicture.asset(
                  item.liked ? AppAssets.iconHeartFilled : AppAssets.iconHeart,
                  width: 18,
                  height: 18,
                  colorFilter: ColorFilter.mode(
                    item.liked
                        ? AppColors.selectionBorder
                        : AppColors.navInactive,
                    BlendMode.srcIn,
                  ),
                ),
                if (item.likeCount > 0) ...[
                  const SizedBox(height: 2),
                  AppText(
                    formatCount(item.likeCount),
                    style: AppTextStyles.commentLikeCount,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
