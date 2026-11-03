import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_back_button.dart';
import 'package:veylo/core/widgets/app_bottom_nav.dart';
import 'package:veylo/core/errors/error_messages.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/data/remote/session_store.dart';
import 'package:veylo/data/remote/user_repository.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/core/widgets/profile_tappable_avatar.dart';
import 'package:veylo/models/profile/follow_user.dart';
import 'package:veylo/screens/profile/follow_sort_sheet.dart';

const _kContentWidth = 398.0;
const _kAvatarSize = 58.0;
const _kBadgeSize = 40.0;
const _kSearchHeight = 44.0;
const _kSortSize = 44.0;
const _kListGap = 12.0;
const _kUnfollowBtnW = 89.0;
const _kUnfollowBtnH = 36.0;
const _kUnfollowHPad = 16.0; // yazı ile buton kenarı arası
const _kUnfollowEdge = 10.0; // buton ile satır kenarı arası
const _kUnfollowPurple = Color(0xFF7C6CD6);
/// #998FED @ 10% on white — opak tek renk (üst üste binince koyulaşmasın).
const _kSwipeRowBg = Color(0xFFF4F3FD);

enum FollowTab { following, followers }

/// Figma Follow — Takip / Takipçi listesi, arama, sıralama, swipe Unfollow.
class FollowPage extends StatefulWidget {
  const FollowPage({
    super.key,
    this.initialTab = FollowTab.followers,
    this.userId,
  });

  final FollowTab initialTab;

  /// Kimin listesi; null = giriş yapan kullanıcı.
  final String? userId;

  static Future<void> open(
    BuildContext context, {
    FollowTab initialTab = FollowTab.followers,
    String? userId,
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => FollowPage(initialTab: initialTab, userId: userId),
      ),
    );
  }

  @override
  State<FollowPage> createState() => _FollowPageState();
}

class _FollowPageState extends State<FollowPage> {
  late FollowTab _tab;
  late final TextEditingController _searchCtrl;
  String? _openSwipeId;
  FollowSortFilter _sortFilter = FollowSortFilter.recent;
  final Set<String> _removedIds = {};
  final Set<String> _hiddenBadgeIds = {};
  final _repo = UserRepository.instance;
  final _scroll = ScrollController();

  /// Sekme başına sayfalı liste (cursor ile; arama sunucuda).
  final Map<FollowTab, List<FollowUser>> _lists = {
    for (final tab in FollowTab.values) tab: const [],
  };
  final Map<FollowTab, String?> _cursors = {};
  final Map<FollowTab, bool> _hasMore = {
    for (final tab in FollowTab.values) tab: true,
  };
  final Set<FollowTab> _loading = {};
  final Set<FollowTab> _loaded = {};

  /// Son istek hata verdi: kendiliğinden tekrar denenmez (kaydırınca dener).
  final Set<FollowTab> _failed = {};

  /// Arama değişince eski istek cevapları yok sayılır.
  int _generation = 0;
  Timer? _searchDebounce;

  String? get _userId => widget.userId ?? SessionStore.instance.me?.id;

  /// Kendi listem: kaydırınca takibi bırak / takipçiden çıkar.
  bool get _mine {
    final me = SessionStore.instance.me?.id;
    return me != null && _userId == me;
  }

  @override
  void initState() {
    super.initState();
    _tab = widget.initialTab;
    _searchCtrl = TextEditingController();
    _scroll.addListener(_onScroll);
    for (final tab in FollowTab.values) {
      _loadPage(tab);
    }
  }

  /// Sonraki sayfayı getirir (liste sonuna gelince / filtre az sonuç verince).
  Future<void> _loadPage(FollowTab tab) async {
    final id = _userId;
    if (id == null || _loading.contains(tab) || _hasMore[tab] != true) return;
    final generation = _generation;
    setState(() => _loading.add(tab));
    try {
      final page = await _repo.follows(
        id,
        tab == FollowTab.following ? 'following' : 'followers',
        cursor: _cursors[tab],
        query: _searchCtrl.text,
      );
      if (!mounted || generation != _generation) return;
      setState(() {
        _lists[tab] = [..._lists[tab]!, ...page.items];
        _cursors[tab] = page.nextCursor;
        _hasMore[tab] = page.nextCursor != null;
        _loaded.add(tab);
        _failed.remove(tab);
      });
    } catch (e) {
      if (!mounted || generation != _generation) return;
      // Hata sonrası otomatik tekrar denenmesin; kaydırınca yeniden dener.
      setState(() {
        _loaded.add(tab);
        _failed.add(tab);
      });
      showErrorSnackBar(context, e);
    } finally {
      if (mounted && generation == _generation) {
        setState(() => _loading.remove(tab));
      }
    }
  }

  void _onScroll() {
    if (!_scroll.hasClients) return;
    final pos = _scroll.position;
    if (pos.pixels >= pos.maxScrollExtent - 300) _loadPage(_tab);
  }

  /// Arama sunucuda yapılır: yazmayı bitirince listeler baştan yüklenir.
  void _onSearchChanged(String _) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 350), () {
      if (!mounted) return;
      _generation++;
      setState(() {
        for (final tab in FollowTab.values) {
          _lists[tab] = const [];
          _cursors[tab] = null;
          _hasMore[tab] = true;
        }
        _loading.clear();
        _loaded.clear();
        _failed.clear();
        _openSwipeId = null;
      });
      for (final tab in FollowTab.values) {
        _loadPage(tab);
      }
    });
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _scroll.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  List<FollowUser> get _source {
    final base = _lists[_tab]!;
    return base.where((u) => !_removedIds.contains(u.id)).toList();
  }

  List<FollowUser> get _filtered {
    var list = _source;

    switch (_sortFilter) {
      case FollowSortFilter.recent:
        list = [...list]..sort((a, b) {
            final aAt = a.followedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
            final bAt = b.followedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
            return bAt.compareTo(aAt);
          });
      case FollowSortFilter.notFollowingMeBack:
        list = list.where((u) => u.iFollow && !u.followsMe).toList();
      case FollowSortFilter.notFollowedByMe:
        list = list.where((u) => u.followsMe && !u.iFollow).toList();
    }
    return list;
  }

  Future<void> _openSortSheet() async {
    final result = await showFollowSortSheet(
      context,
      initial: _sortFilter,
    );
    if (result == null || !mounted) return;
    setState(() {
      _sortFilter = result;
      _openSwipeId = null;
    });
  }

  /// Takip ettiklerim: takibi bırak. Takipçilerim: takipçiden çıkar.
  Future<void> _unfollow(String id) async {
    if (!_mine) return;
    final followingTab = _tab == FollowTab.following;
    setState(() {
      _removedIds.add(id);
      _hiddenBadgeIds.add(id);
      if (_openSwipeId == id) _openSwipeId = null;
    });
    try {
      await (followingTab ? _repo.unfollow(id) : _repo.removeFollower(id));
      SessionStore.instance.refreshMe().catchError((_) {});
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _removedIds.remove(id);
        _hiddenBadgeIds.remove(id);
      });
      showErrorSnackBar(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).profile;
    final top = MediaQuery.viewPaddingOf(context).top;
    final bottom = MediaQuery.viewPaddingOf(context).bottom;
    final screenW = MediaQuery.sizeOf(context).width;
    final hPad = ((screenW - _kContentWidth) / 2).clamp(16.0, 40.0);
    final users = _filtered;
    final loadingTab = _loading.contains(_tab);
    // Filtre az sonuç verdiyse (liste kaydırılamaz) sonraki sayfaları kendiliğinden getir.
    if (users.length < 15 &&
        _hasMore[_tab] == true &&
        _loaded.contains(_tab) &&
        !_failed.contains(_tab) &&
        !loadingTab) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _loadPage(_tab);
      });
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      extendBody: true,
      bottomNavigationBar: AppBottomNav(
        current: AppShell.current,
        onChanged: AppShell.select,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: top),
          Padding(
            padding: EdgeInsets.fromLTRB(hPad, 8, hPad, 0),
            child: Row(
              children: [
                const AppBackButton(),
                const SizedBox(width: 4),
                Flexible(
                  child: AppText(
                    t.followPageTitle,
                    style: AppTextStyles.followPageTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: hPad),
            child: Row(
              children: [
                Expanded(
                  child: _SearchField(
                    controller: _searchCtrl,
                    hint: t.followSearch,
                    onChanged: _onSearchChanged,
                  ),
                ),
                const SizedBox(width: 10),
                _SortButton(onTap: _openSortSheet),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: hPad),
            child: _FollowTabs(
              followingLabel: t.followTabFollowing,
              followersLabel: t.followTabFollowers,
              selected: _tab,
              onChanged: (tab) => setState(() {
                _tab = tab;
                _openSwipeId = null;
              }),
            ),
          ),
          Expanded(
            child: users.isEmpty && (loadingTab || !_loaded.contains(_tab))
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.selectionBorder,
                    ),
                  )
                : users.isEmpty
                ? Center(
                    child: AppText(
                      _sortFilter == FollowSortFilter.recent &&
                              _searchCtrl.text.trim().isEmpty
                          ? t.followEmpty
                          : t.followSortEmpty,
                      style: AppTextStyles.followListName.copyWith(
                        color: const Color(0xA6000000),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView.separated(
                    controller: _scroll,
                    padding: EdgeInsets.fromLTRB(hPad, 12, hPad, bottom + 120),
                    itemCount: users.length + (loadingTab ? 1 : 0),
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: _kListGap),
                    itemBuilder: (context, index) {
                      if (index >= users.length) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: CircularProgressIndicator(
                              color: AppColors.selectionBorder,
                            ),
                          ),
                        );
                      }
                      final user = users[index];
                      return _FollowRow(
                        key: ValueKey(user.id),
                        user: user,
                        unfollowLabel: t.unfollow,
                        isOpen: _openSwipeId == user.id,
                        showBadge: !_hiddenBadgeIds.contains(user.id),
                        onOpenChanged: (open) {
                          // Başkasının listesinde kaydırma işlemi yok.
                          if (!_mine) return;
                          setState(
                            () => _openSwipeId = open ? user.id : null,
                          );
                        },
                        onUnfollow: () => _unfollow(user.id),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({
    required this.controller,
    required this.hint,
    required this.onChanged,
  });

  final TextEditingController controller;
  final String hint;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _kSearchHeight,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.suggestionChipFill, // #998FED @ 10%
        borderRadius: BorderRadius.circular(99999),
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
              onChanged: onChanged,
              style: AppTextStyles.followSearchInput,
              cursorColor: AppColors.selectionBorder,
              decoration: InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                hintText: hint,
                hintStyle: AppTextStyles.followSearchHint,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SortButton extends StatelessWidget {
  const _SortButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: _kSortSize,
        height: _kSortSize,
        decoration: const BoxDecoration(
          color: AppColors.suggestionChipFill,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: SvgPicture.asset(
          AppAssets.iconArrangement,
          width: 24,
          height: 24,
          colorFilter: const ColorFilter.mode(
            AppColors.textOnLight,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}

class _FollowTabs extends StatelessWidget {
  const _FollowTabs({
    required this.followingLabel,
    required this.followersLabel,
    required this.selected,
    required this.onChanged,
  });

  final String followingLabel;
  final String followersLabel;
  final FollowTab selected;
  final ValueChanged<FollowTab> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 59,
      child: Row(
        children: [
          Expanded(
            child: _TabItem(
              label: followingLabel,
              active: selected == FollowTab.following,
              onTap: () => onChanged(FollowTab.following),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _TabItem(
              label: followersLabel,
              active: selected == FollowTab.followers,
              onTap: () => onChanged(FollowTab.followers),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem({
    required this.label,
    required this.active,
    required this.onTap,
  });

  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 39,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: active
                  ? AppColors.selectionBorder
                  : const Color(0x1A000000),
              width: 1,
            ),
          ),
        ),
        child: AppText(
          label,
          style: active
              ? AppTextStyles.followTabActive
              : AppTextStyles.followTabInactive,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

/// Sola kaydır → Unfollow; basınca satır anında kaybolur.
class _FollowRow extends StatefulWidget {
  const _FollowRow({
    super.key,
    required this.user,
    required this.unfollowLabel,
    required this.isOpen,
    required this.showBadge,
    required this.onOpenChanged,
    required this.onUnfollow,
  });

  final FollowUser user;
  final String unfollowLabel;
  final bool isOpen;
  final bool showBadge;
  final ValueChanged<bool> onOpenChanged;
  final VoidCallback onUnfollow;

  @override
  State<_FollowRow> createState() => _FollowRowState();
}

class _FollowRowState extends State<_FollowRow>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  String? get _badgeAsset => switch (widget.user.badge) {
        FollowBadge.goldenDiamond => AppAssets.iconGoldenDiamond,
        FollowBadge.crown => AppAssets.iconCrown,
        null => null,
      };

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      value: widget.isOpen ? 1 : 0,
    );
  }

  @override
  void didUpdateWidget(covariant _FollowRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isOpen != oldWidget.isOpen) {
      if (widget.isOpen) {
        _ctrl.forward();
      } else {
        _ctrl.reverse();
      }
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  /// Buton genişliği yazıya göre (TR "Takibi Bırak" 89'a sığmıyordu), en az Figma'daki 89.
  double get _btnWidth {
    final painter = TextPainter(
      text: TextSpan(text: widget.unfollowLabel, style: AppTextStyles.followUnfollow),
      textDirection: TextDirection.ltr,
      textScaler: MediaQuery.textScalerOf(context),
      maxLines: 1,
    )..layout();
    final w = painter.width + _kUnfollowHPad * 2;
    painter.dispose();
    return w < _kUnfollowBtnW ? _kUnfollowBtnW : w;
  }

  /// Kaydırınca açılan alan: kenar boşluğu + buton + içerikle arası.
  double get _reveal => _kUnfollowEdge + _btnWidth + _kUnfollowEdge;

  void _onDragUpdate(DragUpdateDetails d) {
    final delta = -d.primaryDelta! / _reveal;
    _ctrl.value = (_ctrl.value + delta).clamp(0.0, 1.0);
  }

  void _onDragEnd(DragEndDetails d) {
    final velocity = d.primaryVelocity ?? 0;
    final open = velocity < -300
        ? true
        : velocity > 300
            ? false
            : _ctrl.value > 0.4;
    if (open) {
      _ctrl.forward();
      widget.onOpenChanged(true);
    } else {
      _ctrl.reverse();
      widget.onOpenChanged(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            height: 78,
            child: AnimatedBuilder(
              animation: _ctrl,
              builder: (context, _) {
                final offset = -_ctrl.value * _reveal;
                final openProgress = _ctrl.value;
                final open = openProgress > 0.02;
                // Rozet: swipe açıkken veya unfollow sonrası gizle
                final badgeVisible = widget.showBadge &&
                    _badgeAsset != null &&
                    openProgress < 0.15;
                return Stack(
                  children: [
                    // Tek zemin — kapalı: beyaz, açık: lavanta
                    Positioned.fill(
                      child: ColoredBox(
                        color: open ? _kSwipeRowBg : AppColors.white,
                      ),
                    ),
                    // Unfollow (sağda)
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: _kUnfollowEdge),
                          child: Opacity(
                            opacity: openProgress.clamp(0.0, 1.0),
                            child: GestureDetector(
                              onTap: openProgress > 0.5
                                  ? widget.onUnfollow
                                  : null,
                              child: Container(
                                width: _btnWidth,
                                height: _kUnfollowBtnH,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: _kUnfollowPurple,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: AppText(
                                  widget.unfollowLabel,
                                  style: AppTextStyles.followUnfollow,
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Kaydırılan içerik — şeffaf (zemin tek kalsın)
                    Transform.translate(
                      offset: Offset(offset, 0),
                      child: GestureDetector(
                        onHorizontalDragUpdate: _onDragUpdate,
                        onHorizontalDragEnd: _onDragEnd,
                        onTap: () {
                          if (_ctrl.value > 0.05) {
                            _ctrl.reverse();
                            widget.onOpenChanged(false);
                          }
                        },
                        child: Container(
                          height: 78,
                          padding: const EdgeInsets.all(10),
                          color: Colors.transparent,
                          child: Row(
                            children: [
                              ProfileTappableAvatar(
                                avatarUrl: widget.user.avatarUrl,
                                size: _kAvatarSize,
                                userId: widget.user.id,
                                displayName: widget.user.displayName,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: AppText(
                                        widget.user.displayName,
                                        style: AppTextStyles.followListName,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (badgeVisible) ...[
                                const SizedBox(width: 10),
                                Image.asset(
                                  _badgeAsset!,
                                  width: _kBadgeSize,
                                  height: _kBadgeSize,
                                  fit: BoxFit.contain,
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        const Divider(
          height: 1,
          thickness: 1,
          color: Color(0x1A000000), // #000 @ 10%
        ),
      ],
    );
  }
}
