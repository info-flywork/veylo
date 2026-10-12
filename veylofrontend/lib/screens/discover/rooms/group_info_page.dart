import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/errors/error_messages.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_primary_button.dart';
import 'package:veylo/core/widgets/ai_badge.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/core/widgets/profile_tappable_avatar.dart';
import 'package:veylo/data/remote/chat_repository.dart';
import 'package:veylo/data/remote/chat_store.dart';
import 'package:veylo/data/remote/group_repository.dart';
import 'package:veylo/data/remote/session_store.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/models/group/group_models.dart';
import 'package:veylo/screens/profile/profile_navigation.dart';

class _GroupMember {
  const _GroupMember({
    required this.name,
    required this.avatar,
    this.role,
    this.isYou = false,
    this.source,
  });

  final String name;
  final String avatar;
  final String? role;
  final bool isYou;

  /// Gerçek grupta üye (demo modunda null).
  final GroupMember? source;
}

/// Grup sohbetinden açılan bilgi / ayarlar ekranı.
/// [conversationId] verilirse gerçek grup; yoksa örnek verilerle gösterilir.
/// Gruptan ayrılınca `true` döner.
class GroupInfoPage extends StatefulWidget {
  const GroupInfoPage({
    super.key,
    required this.title,
    this.memberCount = 6,
    this.conversationId,
  });

  final String title;
  final int memberCount;
  final String? conversationId;

  static Future<bool?> open(
    BuildContext context, {
    required String title,
    int memberCount = 6,
    String? conversationId,
  }) {
    return Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(
        builder: (_) => GroupInfoPage(
          title: title,
          memberCount: memberCount,
          conversationId: conversationId,
        ),
      ),
    );
  }

  @override
  State<GroupInfoPage> createState() => _GroupInfoPageState();
}

class _GroupInfoPageState extends State<GroupInfoPage> {
  final _repo = GroupRepository.instance;
  bool _notifications = true;
  bool _private = true;
  GroupInfo? _info;
  List<GroupJoinRequest> _requests = const [];

  static const _membersBg = Color(0xFFF4F4F9);
  static const _rowBorder = Color(0xFFE2E2E2);

  String? get _id => widget.conversationId;

  @override
  void initState() {
    super.initState();
    if (_id != null) _load();
  }

  Future<void> _load() async {
    try {
      final info = await _repo.info(_id!);
      final requests = info.amAdmin && info.pendingRequests > 0
          ? await _repo.requests(_id!)
          : const <GroupJoinRequest>[];
      if (!mounted) return;
      setState(() => _apply(info, requests));
    } catch (e) {
      if (mounted) showErrorSnackBar(context, e);
    }
  }

  void _apply(GroupInfo info, [List<GroupJoinRequest>? requests]) {
    _info = info;
    _notifications = !info.muted;
    _private = info.isPrivate;
    if (requests != null) _requests = requests;
  }

  Future<void> _run(Future<void> Function() action) async {
    try {
      await action();
    } catch (e) {
      if (mounted) showErrorSnackBar(context, e);
    }
  }

  Future<void> _setNotifications(bool on) async {
    final id = _id;
    if (id == null) return setState(() => _notifications = on);
    setState(() => _notifications = on);
    await _run(() => ChatRepository.instance.setMuted(id, !on));
  }

  Future<void> _setPrivate(bool on) async {
    final id = _id;
    if (id == null) return setState(() => _private = on);
    if (!(_info?.amAdmin ?? false)) return;
    setState(() => _private = on);
    await _run(() async {
      final info = await _repo.setPrivate(id, on);
      if (mounted) setState(() => _apply(info));
    });
  }

  Future<void> _decide(GroupJoinRequest r, bool approve) async {
    await _run(() async {
      final rest = await _repo.decide(_id!, r.id, approve: approve);
      final info = await _repo.info(_id!);
      if (mounted) setState(() => _apply(info, rest));
    });
  }

  Future<void> _addPeople() async {
    final info = _info;
    final me = SessionStore.instance.me;
    if (info == null || me == null || !info.amAdmin) return;
    final existing = {for (final m in info.members) m.userId};
    final picked = await showModalBottomSheet<List<String>>(
      context: context,
      backgroundColor: AppColors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _AddPeopleSheet(
        load: () => _repo.following(me.id),
        exclude: existing,
      ),
    );
    if (picked == null || picked.isEmpty) return;
    await _run(() async {
      final updated = await _repo.addMembers(_id!, picked);
      if (mounted) setState(() => _apply(updated));
    });
  }

  /// Yönetici: üyeye uzun basınca yönetici yap / çıkar.
  Future<void> _memberActions(GroupMember m) async {
    final info = _info;
    if (info == null || !info.amAdmin || m.isYou || m.role == 'OWNER') return;
    if (m.role == 'ADMIN' && !info.amOwner) return;
    final t = Translations.of(context).discover.groupInfo;
    final action = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (info.amOwner)
              ListTile(
                title: AppText(
                  m.role == 'ADMIN' ? t.removeAdmin : t.makeAdmin,
                  style: AppTextStyles.groupInfoRow,
                ),
                onTap: () => Navigator.of(context).pop('role'),
              ),
            ListTile(
              title: AppText(t.remove, style: AppTextStyles.groupInfoLeave),
              onTap: () => Navigator.of(context).pop('remove'),
            ),
          ],
        ),
      ),
    );
    if (action == null) return;
    await _run(() async {
      final updated = action == 'role'
          ? await _repo.setRole(
              _id!,
              m.memberId,
              m.role == 'ADMIN' ? 'MEMBER' : 'ADMIN',
            )
          : await _repo.removeMember(_id!, m.memberId);
      if (mounted) setState(() => _apply(updated));
    });
  }

  Future<void> _leave() async {
    final id = _id;
    if (id == null) return Navigator.of(context).pop();
    final t = Translations.of(context).discover.groupInfo;
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(t.leaveConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(t.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(t.leave),
          ),
        ],
      ),
    );
    if (ok != true || !mounted) return;
    await _run(() async {
      await _repo.leave(id);
      ChatStore.instance.remove(id);
      if (mounted) Navigator.of(context).pop(true);
    });
  }

  List<_GroupMember> _members(Translations tr) {
    final t = tr.discover.groupInfo;
    final info = _info;
    if (info != null) {
      return [
        for (final m in info.members)
          _GroupMember(
            name: m.isYou ? t.you : m.displayName,
            avatar: (m.avatarUrl?.isNotEmpty ?? false)
                ? m.avatarUrl!
                : AppAssets.strangerAvatar,
            role: m.isAdmin ? t.admin : null,
            isYou: m.isYou,
            source: m,
          ),
      ];
    }
    return [
      _GroupMember(
        name: t.you,
        avatar: AppAssets.fakePerson01,
        role: t.admin,
        isYou: true,
      ),
      const _GroupMember(name: 'Lyra', avatar: AppAssets.fakePerson02),
      const _GroupMember(name: 'Jessica', avatar: AppAssets.fakePerson05),
      const _GroupMember(name: 'Sona', avatar: AppAssets.fakePerson03),
      const _GroupMember(name: 'Clara', avatar: AppAssets.fakePerson06),
      const _GroupMember(name: 'Victoria', avatar: AppAssets.fakePerson07),
    ];
  }

  void _openMember(_GroupMember member) {
    final m = member.source;
    if (m == null) {
      openUserProfile(
        context,
        displayName: member.isYou ? null : member.name,
        avatarUrl: member.avatar,
        userId: member.isYou ? 'user_self' : null,
      );
      return;
    }
    // Anonim üyenin profili açılmaz.
    if (m.userId == null) return;
    openUserProfile(
      context,
      userId: m.userId,
      username: m.username,
      displayName: m.displayName,
      avatarUrl: member.avatar,
    );
  }

  @override
  Widget build(BuildContext context) {
    final tr = Translations.of(context);
    final t = tr.discover.groupInfo;
    final top = MediaQuery.paddingOf(context).top;
    final bottom = MediaQuery.paddingOf(context).bottom;
    final info = _info;
    final title = info?.title ?? widget.title;
    final memberCount = info?.memberCount ?? widget.memberCount;
    final canAdd = _id == null || (info?.amAdmin ?? false);
    final members = _members(tr);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(8, top + 8, 16, 8),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 20,
                    color: AppColors.black,
                  ),
                ),
                Expanded(
                  child: AppText(
                    title,
                    style: AppTextStyles.groupInfoTitle,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.fromLTRB(16, 10, 16, 24 + bottom),
              children: [
                AppText(t.media, style: AppTextStyles.groupInfoSection),
                const SizedBox(height: 8),
                _SettingsRow(
                  icon: AppAssets.iconGallery,
                  label: t.gallery,
                  trailing: const Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 20),
                AppText(t.settings, style: AppTextStyles.groupInfoSection),
                const SizedBox(height: 8),
                _SettingsRow(
                  icon: AppAssets.iconNotificationBing,
                  label: t.notifications,
                  trailing: _GreenToggle(
                    value: _notifications,
                    onChanged: _setNotifications,
                  ),
                ),
                _SettingsRow(
                  icon: AppAssets.iconBlock,
                  label: t.blocked,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppText('0', style: AppTextStyles.groupInfoRow),
                      const Icon(
                        Icons.chevron_right_rounded,
                        color: AppColors.black,
                      ),
                    ],
                  ),
                ),
                _SettingsRow(
                  icon: AppAssets.iconPrivateLock,
                  label: t.private,
                  trailing: _GreenToggle(
                    value: _private,
                    onChanged: _setPrivate,
                  ),
                ),
                if (_requests.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _membersBg,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AppText(
                          '${t.requests} (${_requests.length})',
                          style: AppTextStyles.groupInfoSection,
                        ),
                        for (final r in _requests) ...[
                          const SizedBox(height: 8),
                          _MemberCard(
                            borderColor: _rowBorder,
                            child: _RequestRow(
                              request: r,
                              approveLabel: t.approve,
                              rejectLabel: t.reject,
                              onApprove: () => _decide(r, true),
                              onReject: () => _decide(r, false),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _membersBg,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AppText(
                        t.membersCount(count: memberCount.toString()),
                        style: AppTextStyles.groupInfoSection,
                      ),
                      if (canAdd) ...[
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: _addPeople,
                          behavior: HitTestBehavior.opaque,
                          child: _MemberCard(
                            borderColor: _rowBorder,
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  AppAssets.iconAddPeople,
                                  width: 40,
                                  height: 40,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: AppText(
                                    t.addPeople,
                                    style: AppTextStyles.groupInfoAddPeople,
                                  ),
                                ),
                                const Icon(
                                  Icons.chevron_right_rounded,
                                  color: AppColors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                      for (final member in members) ...[
                        const SizedBox(height: 8),
                        _MemberCard(
                          borderColor: _rowBorder,
                          child: GestureDetector(
                            onTap: () => _openMember(member),
                            onLongPress: member.source == null
                                ? null
                                : () => _memberActions(member.source!),
                            behavior: HitTestBehavior.opaque,
                            child: Row(
                              children: [
                                ProfileTappableAvatar(
                                  avatarUrl: member.avatar,
                                  size: 40,
                                  displayName: member.isYou
                                      ? null
                                      : member.name,
                                  userId: member.source != null
                                      ? member.source!.userId
                                      : (member.isYou ? 'user_self' : null),
                                  enabled:
                                      member.source == null ||
                                      member.source!.userId != null,
                                  blurred: member.source?.blurred ?? false,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Flexible(
                                            child: AppText(
                                              member.name,
                                              style: AppTextStyles
                                                  .groupInfoMemberName,
                                            ),
                                          ),
                                          if (member.source?.isAi ?? false)
                                            const AiBadge(compact: true),
                                        ],
                                      ),
                                      if (member.role != null) ...[
                                        const SizedBox(height: 2),
                                        AppText(
                                          member.role!,
                                          style:
                                              AppTextStyles.groupInfoMemberRole,
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                                if (!member.isYou)
                                  const Icon(
                                    Icons.chevron_right_rounded,
                                    color: AppColors.black,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: _leave,
                  behavior: HitTestBehavior.opaque,
                  child: AppText(
                    t.leaveGroup,
                    style: AppTextStyles.groupInfoLeave,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Katılma isteği satırı: üye kartı düzeninde, Onayla / Reddet.
class _RequestRow extends StatelessWidget {
  const _RequestRow({
    required this.request,
    required this.approveLabel,
    required this.rejectLabel,
    required this.onApprove,
    required this.onReject,
  });

  final GroupJoinRequest request;
  final String approveLabel;
  final String rejectLabel;
  final VoidCallback onApprove;
  final VoidCallback onReject;

  @override
  Widget build(BuildContext context) {
    final u = request.user;
    final message = request.message?.trim() ?? '';
    return Row(
      children: [
        ProfileTappableAvatar(
          avatarUrl: (u.avatarUrl?.isNotEmpty ?? false)
              ? u.avatarUrl!
              : AppAssets.strangerAvatar,
          size: 40,
          userId: u.userId,
          username: u.username,
          displayName: u.displayName,
          enabled: u.userId != null,
          blurred: u.blurred,
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
                      u.displayName,
                      style: AppTextStyles.groupInfoMemberName,
                    ),
                  ),
                  if (u.isAi) const AiBadge(compact: true),
                ],
              ),
              if (message.isNotEmpty) ...[
                const SizedBox(height: 2),
                AppText(
                  message,
                  style: AppTextStyles.groupInfoMemberRole,
                  maxLines: 2,
                ),
              ],
            ],
          ),
        ),
        const SizedBox(width: 8),
        _PillButton(label: rejectLabel, filled: false, onTap: onReject),
        const SizedBox(width: 6),
        _PillButton(label: approveLabel, filled: true, onTap: onApprove),
      ],
    );
  }
}

class _PillButton extends StatelessWidget {
  const _PillButton({
    required this.label,
    required this.filled,
    required this.onTap,
  });

  final String label;
  final bool filled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 32,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: filled ? AppColors.selectionBorder : AppColors.white,
          borderRadius: BorderRadius.circular(9999),
          border: filled
              ? null
              : Border.all(color: AppColors.selectionBorder, width: 1),
        ),
        alignment: Alignment.center,
        child: AppText(
          label,
          style: AppTextStyles.allRoomAction.copyWith(
            color: filled ? AppColors.white : AppColors.selectionBorder,
          ),
        ),
      ),
    );
  }
}

/// Kişi ekle: takip ettiklerim arasından seçim.
class _AddPeopleSheet extends StatefulWidget {
  const _AddPeopleSheet({required this.load, required this.exclude});

  final Future<List<PersonSummary>> Function() load;
  final Set<String?> exclude;

  @override
  State<_AddPeopleSheet> createState() => _AddPeopleSheetState();
}

class _AddPeopleSheetState extends State<_AddPeopleSheet> {
  List<PersonSummary>? _people;
  final _selected = <String>{};

  @override
  void initState() {
    super.initState();
    widget
        .load()
        .then((all) {
          if (!mounted) return;
          setState(
            () => _people = [
              for (final p in all)
                if (!widget.exclude.contains(p.id)) p,
            ],
          );
        })
        .catchError((Object e) {
          if (!mounted) return;
          setState(() => _people = const []);
          showErrorSnackBar(context, e);
        });
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).discover.groupInfo;
    final bottom = MediaQuery.paddingOf(context).bottom;
    final people = _people;

    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.7,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 24, 16, 10 + bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppText(
              t.addPeople,
              style: AppTextStyles.filtersTitle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: people == null
                  ? const Center(child: CircularProgressIndicator())
                  : people.isEmpty
                  ? Center(
                      child: AppText(
                        t.addPeopleEmpty,
                        style: AppTextStyles.groupInfoMemberRole,
                        textAlign: TextAlign.center,
                      ),
                    )
                  : ListView.separated(
                      itemCount: people.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 8),
                      itemBuilder: (context, i) {
                        final p = people[i];
                        final on = _selected.contains(p.id);
                        return GestureDetector(
                          onTap: () => setState(
                            () => on
                                ? _selected.remove(p.id)
                                : _selected.add(p.id),
                          ),
                          behavior: HitTestBehavior.opaque,
                          child: _MemberCard(
                            borderColor: const Color(0xFFE2E2E2),
                            child: Row(
                              children: [
                                ProfileTappableAvatar(
                                  avatarUrl: (p.avatarUrl?.isNotEmpty ?? false)
                                      ? p.avatarUrl!
                                      : AppAssets.strangerAvatar,
                                  size: 40,
                                  enabled: false,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: AppText(
                                    p.name,
                                    style: AppTextStyles.groupInfoMemberName,
                                  ),
                                ),
                                Icon(
                                  on
                                      ? Icons.check_circle_rounded
                                      : Icons.circle_outlined,
                                  color: on
                                      ? AppColors.selectionBorder
                                      : const Color(0xFFBDBDBD),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 12),
            AppPrimaryButton(
              label: t.add,
              onPressed: _selected.isEmpty
                  ? null
                  : () => Navigator.of(context).pop(_selected.toList()),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  const _SettingsRow({
    required this.icon,
    required this.label,
    required this.trailing,
  });

  final String icon;
  final String label;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          SvgPicture.asset(icon, width: 26, height: 26),
          const SizedBox(width: 10),
          Expanded(child: AppText(label, style: AppTextStyles.groupInfoRow)),
          trailing,
        ],
      ),
    );
  }
}

class _MemberCard extends StatelessWidget {
  const _MemberCard({required this.child, required this.borderColor});

  final Widget child;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border(bottom: BorderSide(color: borderColor, width: 0.5)),
      ),
      child: child,
    );
  }
}

class _GreenToggle extends StatelessWidget {
  const _GreenToggle({required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  static const double _width = 45.29;
  static const double _height = 28;
  static const double _thumb = 23.06;
  static const double _pad = 2.47;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: _width,
        height: _height,
        child: value
            ? SvgPicture.asset(
                AppAssets.iconNotifications,
                width: _width,
                height: _height,
                fit: BoxFit.contain,
              )
            : Container(
                width: _width,
                height: _height,
                padding: const EdgeInsets.all(_pad),
                decoration: BoxDecoration(
                  color: AppColors.sliderTrackIdle,
                  borderRadius: BorderRadius.circular(_height / 2),
                ),
                alignment: Alignment.centerLeft,
                child: Container(
                  width: _thumb,
                  height: _thumb,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withValues(alpha: 0.05),
                        blurRadius: 2.5,
                        offset: const Offset(0, 1.6),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
