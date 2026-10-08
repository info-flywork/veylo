import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/core/widgets/profile_tappable_avatar.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/screens/profile/profile_navigation.dart';

class _GroupMember {
  const _GroupMember({
    required this.name,
    required this.avatar,
    this.role,
    this.isYou = false,
  });

  final String name;
  final String avatar;
  final String? role;
  final bool isYou;
}

/// Grup sohbetinden açılan bilgi / ayarlar ekranı.
class GroupInfoPage extends StatefulWidget {
  const GroupInfoPage({
    super.key,
    required this.title,
    this.memberCount = 6,
  });

  final String title;
  final int memberCount;

  static Future<void> open(
    BuildContext context, {
    required String title,
    int memberCount = 6,
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => GroupInfoPage(
          title: title,
          memberCount: memberCount,
        ),
      ),
    );
  }

  @override
  State<GroupInfoPage> createState() => _GroupInfoPageState();
}

class _GroupInfoPageState extends State<GroupInfoPage> {
  bool _notifications = true;
  bool _private = true;

  static const _membersBg = Color(0xFFF4F4F9);
  static const _rowBorder = Color(0xFFE2E2E2);

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).discover.groupInfo;
    final top = MediaQuery.paddingOf(context).top;
    final bottom = MediaQuery.paddingOf(context).bottom;

    final members = [
      _GroupMember(
        name: t.you,
        avatar: AppAssets.fakePerson01,
        role: t.admin,
        isYou: true,
      ),
      const _GroupMember(
        name: 'Lyra',
        avatar: AppAssets.fakePerson02,
      ),
      const _GroupMember(
        name: 'Jessica',
        avatar: AppAssets.fakePerson05,
      ),
      const _GroupMember(
        name: 'Sona',
        avatar: AppAssets.fakePerson03,
      ),
      const _GroupMember(
        name: 'Clara',
        avatar: AppAssets.fakePerson06,
      ),
      const _GroupMember(
        name: 'Victoria',
        avatar: AppAssets.fakePerson07,
      ),
    ];

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
                    widget.title,
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
                    onChanged: (v) => setState(() => _notifications = v),
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
                    onChanged: (v) => setState(() => _private = v),
                  ),
                ),
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
                        t.membersCount(count: widget.memberCount.toString()),
                        style: AppTextStyles.groupInfoSection,
                      ),
                      const SizedBox(height: 10),
                      _MemberCard(
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
                      for (final member in members) ...[
                        const SizedBox(height: 8),
                        _MemberCard(
                          borderColor: _rowBorder,
                          child: GestureDetector(
                            onTap: () => openUserProfile(
                              context,
                              displayName: member.isYou ? null : member.name,
                              avatarUrl: member.avatar,
                              userId: member.isYou ? 'user_self' : null,
                            ),
                            behavior: HitTestBehavior.opaque,
                            child: Row(
                              children: [
                                ProfileTappableAvatar(
                                  avatarUrl: member.avatar,
                                  size: 40,
                                  displayName:
                                      member.isYou ? null : member.name,
                                  userId: member.isYou ? 'user_self' : null,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppText(
                                        member.name,
                                        style:
                                            AppTextStyles.groupInfoMemberName,
                                      ),
                                      if (member.role != null) ...[
                                        const SizedBox(height: 2),
                                        AppText(
                                          member.role!,
                                          style: AppTextStyles
                                              .groupInfoMemberRole,
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
                  onTap: () => Navigator.of(context).pop(),
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
          Expanded(
            child: AppText(label, style: AppTextStyles.groupInfoRow),
          ),
          trailing,
        ],
      ),
    );
  }
}

class _MemberCard extends StatelessWidget {
  const _MemberCard({
    required this.child,
    required this.borderColor,
  });

  final Widget child;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border(
          bottom: BorderSide(color: borderColor, width: 0.5),
        ),
      ),
      child: child,
    );
  }
}

class _GreenToggle extends StatelessWidget {
  const _GreenToggle({
    required this.value,
    required this.onChanged,
  });

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
