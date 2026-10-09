import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_screen_title.dart';
import 'package:veylo/core/errors/error_messages.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/data/mock/chat_mock_repository.dart';
import 'package:veylo/data/remote/chat_repository.dart';
import 'package:veylo/data/remote/chat_store.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/models/chat/chat_note.dart';
import 'package:veylo/models/chat/chat_thread.dart';
import 'package:veylo/models/profile/profile_user.dart';
import 'package:veylo/screens/chat/anonymous_chat_page.dart';
import 'package:veylo/screens/chat/direct_chat_page.dart';
import 'package:veylo/screens/chat/widgets/chat_note_card.dart';
import 'package:veylo/screens/chat/widgets/chat_thread_tile.dart';
import 'package:veylo/screens/discover/rooms/group_chat_page.dart';
import 'package:veylo/screens/profile/block_user_sheet.dart';
import 'package:veylo/screens/profile/profile_navigation.dart';

const _kSearchFill = Color(0x1A998FED);

/// Ana sohbet listesi — [ChatStore] üzerinden canlı (socket) güncellenir.
class ChatsPage extends StatefulWidget {
  const ChatsPage({
    super.key,
    this.notes,
    this.threads,
    this.onSearchTap,
    this.onRequestTap,
    this.onOpenThread,
    this.onPinThread,
    this.onBlockThread,
    this.onDeleteThread,
  });

  final List<ChatNote>? notes;
  final List<ChatThread>? threads;
  final VoidCallback? onSearchTap;
  final VoidCallback? onRequestTap;
  final void Function(BuildContext context, ChatThread thread)? onOpenThread;
  final void Function(ChatThread thread)? onPinThread;
  final void Function(ChatThread thread)? onBlockThread;
  final void Function(ChatThread thread)? onDeleteThread;

  /// Bildirime dokunulunca da aynı ekran açılır.
  static void openThread(BuildContext context, ChatThread thread) =>
      _ChatsPageState.openThread(context, thread);

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  String? _openThreadId;
  late List<ChatThread> _threadItems;
  final _searchCtrl = TextEditingController();
  final _searchFocus = FocusNode();
  bool _searchOpen = false;

  @override
  void initState() {
    super.initState();
    _reloadThreads();
    _searchCtrl.addListener(() => setState(() {}));
    ChatStore.instance.addListener(_onStoreChanged);
  }

  void _onStoreChanged() {
    if (widget.threads == null && mounted) setState(_reloadThreads);
  }

  @override
  void dispose() {
    ChatStore.instance.removeListener(_onStoreChanged);
    _searchCtrl.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ChatsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.threads != oldWidget.threads) {
      _reloadThreads();
    }
  }

  /// Hot reload’da IndexedStack state’i eski ChatThread nesnelerini tutmasın.
  @override
  void reassemble() {
    super.reassemble();
    if (widget.threads == null) {
      setState(_reloadThreads);
    }
  }

  void _reloadThreads() {
    _threadItems = List.of(widget.threads ?? ChatStore.instance.inbox);
  }

  void _toggleSearch() {
    setState(() {
      _searchOpen = !_searchOpen;
      if (!_searchOpen) {
        _searchCtrl.clear();
        _searchFocus.unfocus();
      }
    });
    widget.onSearchTap?.call();
    if (_searchOpen) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _searchFocus.requestFocus();
      });
    }
  }

  List<ChatThread> get _visibleThreads {
    final q = _searchCtrl.text.trim().toLowerCase();
    if (q.isEmpty) return _threadItems;
    return _threadItems.where((t) {
      final title = (t.isAnonymous ? (t.maskedName ?? t.title) : t.title)
          .toLowerCase();
      return title.contains(q) ||
          t.lastMessagePreview.toLowerCase().contains(q) ||
          (t.peerUsername?.toLowerCase().contains(q) ?? false);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).chats;
    final top = MediaQuery.paddingOf(context).top;
    final noteItems = widget.notes ?? ChatMockRepository.notes();
    final threads = _visibleThreads;

    return Material(
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: top + 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AppScreenTitle(
              title: t.title,
              onSearchTap: _toggleSearch,
            ),
          ),
          if (_searchOpen) ...[
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _ChatsSearchField(
                controller: _searchCtrl,
                focusNode: _searchFocus,
                hint: t.search,
              ),
            ),
          ],
          const SizedBox(height: 16),
          SizedBox(
            height: 142,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: noteItems.length,
              separatorBuilder: (_, _) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final note = noteItems[index];
                return ChatNoteCard(
                  note: note,
                  onTap: () => openUserProfile(
                    context,
                    userId: note.userId,
                    displayName: note.displayName,
                    avatarUrl: note.avatarUrl,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: AppText(
                    t.messagesSection,
                    style: AppTextStyles.chatsSectionTitle,
                  ),
                ),
                GestureDetector(
                  onTap: widget.onRequestTap,
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 4,
                    ),
                    child: AppText(
                      t.request,
                      style: AppTextStyles.chatsRequestLink,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 110),
              itemCount: threads.length,
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final thread = threads[index];
                return ChatThreadTile(
                  key: ValueKey(thread.id),
                  thread: thread,
                  isOpen: _openThreadId == thread.id,
                  onOpenChanged: (open) {
                    final id = thread.id;
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (!mounted) return;
                      setState(() {
                        _openThreadId = open ? id : null;
                      });
                    });
                  },
                  onPin: () => widget.onPinThread != null
                      ? widget.onPinThread!(thread)
                      : _togglePin(thread),
                  onBlock: () => widget.onBlockThread != null
                      ? widget.onBlockThread!(thread)
                      : _block(context, thread),
                  onDelete: () {
                    if (widget.onDeleteThread != null) {
                      widget.onDeleteThread!(thread);
                    } else {
                      _delete(thread);
                    }
                    setState(() {
                      _threadItems.removeWhere((e) => e.id == thread.id);
                      if (_openThreadId == thread.id) _openThreadId = null;
                    });
                  },
                  onTap: () {
                    if (widget.onOpenThread != null) {
                      widget.onOpenThread!(context, thread);
                      return;
                    }
                    openThread(context, thread);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _togglePin(ChatThread thread) async {
    if (thread.isLocalOnly) return;
    try {
      await ChatRepository.instance.setPinned(thread.id, !thread.pinned);
      await ChatStore.instance.refresh();
    } catch (e) {
      if (mounted) showErrorSnackBar(context, e);
    }
  }

  /// Sadece benim için siler; yeni mesaj gelirse sohbet tekrar görünür.
  Future<void> _delete(ChatThread thread) async {
    if (thread.isLocalOnly) return;
    ChatStore.instance.remove(thread.id);
    try {
      await ChatRepository.instance.deleteForMe(thread.id);
    } catch (e) {
      if (mounted) showErrorSnackBar(context, e);
      await ChatStore.instance.refresh();
    }
  }

  /// Sohbet üzerinden engelleme (anonimde kullanıcı id'si bilinmez).
  void _block(BuildContext context, ChatThread thread) {
    showBlockUserSheet(
      context,
      user: ProfileUser(
        id: thread.peerUserId ?? '',
        displayName: thread.maskedName ?? thread.title,
        username: thread.peerUsername,
        avatarUrl: thread.avatarUrl,
        bio: '',
        likeCount: 0,
        followCount: 0,
        followerCount: 0,
      ),
      conversationId: thread.isLocalOnly ? null : thread.id,
      onDone: () => ChatStore.instance.remove(thread.id),
    );
  }

  /// Sohbeti türüne göre doğru ekranda açar.
  static void openThread(BuildContext context, ChatThread thread) {
    if (thread.isAnonymous) {
      AnonymousChatPage.open(context, thread);
      return;
    }
    if (thread.isGroup) {
      GroupChatPage.open(
        context,
        title: thread.title,
        memberCount: thread.memberCount,
        avatars: thread.groupAvatarUrls,
      );
      return;
    }
    DirectChatPage.open(context, thread);
  }
}

class _ChatsSearchField extends StatelessWidget {
  const _ChatsSearchField({
    required this.controller,
    required this.focusNode,
    required this.hint,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
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
              focusNode: focusNode,
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
