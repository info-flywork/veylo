import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/errors/error_messages.dart';
import 'package:veylo/core/widgets/ai_badge.dart';
import 'package:veylo/data/remote/safety_repository.dart';
import 'package:veylo/data/remote/user_repository.dart';
import 'package:veylo/core/state/discover_highlight.dart';
import 'package:veylo/data/remote/post_repository.dart';
import 'package:veylo/models/discover/post.dart';
import 'package:veylo/screens/discover/discover_post_page.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_back_button.dart';
import 'package:veylo/core/widgets/app_primary_button.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/data/local/local_profile_store.dart';
import 'package:veylo/data/remote/session_store.dart';
import 'package:veylo/data/mock/profile_mock_repository.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/models/profile/profile_border.dart';
import 'package:veylo/models/profile/profile_user.dart';
import 'package:veylo/screens/profile/follow_page.dart';
import 'package:veylo/screens/profile/profile_actions_sheet.dart';
import 'package:veylo/screens/profile/share_profile_sheet.dart';
import 'package:veylo/screens/profile/widgets/profile_framed_avatar.dart';

const _kAvatarSize = 88.0;
const _kContentWidth = 398.0;
const _kPostHeight = 200.0;
const _kPostRadius = 12.0;
const _kPostGap = 10.0;

enum _ProfileMediaTab { posts, video, saved }

/// Profil / Settings — kendi profilinde Edit + Stand Out; başkasında Follow.
class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
    this.user,
    this.onTokensTap,
    this.onShareTap,
    this.onSettingsTap,
    this.onEditProfileTap,
    this.onStandOutTap,
    this.onFollowTap,
  });

  final ProfileUser? user;
  final VoidCallback? onTokensTap;
  final VoidCallback? onShareTap;
  final VoidCallback? onSettingsTap;
  final VoidCallback? onEditProfileTap;
  final VoidCallback? onStandOutTap;
  final VoidCallback? onFollowTap;

  /// Başka kullanıcının profilini açar.
  static Future<void> open(
    BuildContext context, {
    required ProfileUser user,
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ProfilePage(user: user),
      ),
    );
  }

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  _ProfileMediaTab _tab = _ProfileMediaTab.video;
  bool _following = false;

  /// Başka kullanıcının sunucudan yüklenen profili.
  ProfileUser? _remote;
  bool _followBusy = false;

  /// Gerçek gönderiler (null: örnek/mock profil).
  List<Post>? _posts;
  List<Post>? _saved;

  /// Profil sahibinin backend id'si (mock profilde null).
  String? get _ownerId {
    final user = widget.user;
    if (user == null || user.isSelf) return SessionStore.instance.me?.id;
    return SafetyRepository.isRealUser(user.id) ? user.id : null;
  }

  bool get _isSelfProfile => widget.user == null || widget.user!.isSelf;

  @override
  void initState() {
    super.initState();
    final user = widget.user;
    if (user == null || user.isSelf) {
      // Kendi profilim: sayılar (takip/takipçi) güncel olsun.
      SessionStore.instance.refreshMe().catchError((_) {});
      // Yeni paylaşım yapınca gönderilerim yenilensin.
      DiscoverHighlight.instance.imagePath.addListener(_loadMedia);
    } else if (SafetyRepository.isRealUser(user.id)) {
      _loadRemote(user.id);
    }
    _loadMedia();
  }

  @override
  void dispose() {
    DiscoverHighlight.instance.imagePath.removeListener(_loadMedia);
    super.dispose();
  }

  Future<void> _loadMedia() async {
    final id = _ownerId;
    if (id == null) return;
    final repo = PostRepository.instance;
    try {
      final posts = await repo.byUser(id);
      final saved = _isSelfProfile ? await repo.saved() : null;
      if (!mounted) return;
      setState(() {
        _posts = posts.items;
        _saved = saved?.items ?? const [];
      });
    } catch (_) {}
  }

  /// Seçili sekmenin gerçek gönderileri (video şimdilik yok).
  List<Post>? get _tabPosts {
    final posts = _posts;
    if (posts == null) return null;
    return switch (_tab) {
      _ProfileMediaTab.posts => posts,
      _ProfileMediaTab.video => const [],
      _ProfileMediaTab.saved => _isSelfProfile ? (_saved ?? const []) : const [],
    };
  }

  Future<void> _loadRemote(String id) async {
    try {
      final p = await UserRepository.instance.profile(id);
      if (!mounted) return;
      setState(() {
        _remote = p;
        _following = p.iFollow;
      });
    } catch (e) {
      if (mounted) showErrorSnackBar(context, e);
    }
  }

  /// Takip et / bırak: ekranda hemen değişir, hata olursa geri alınır.
  Future<void> _toggleFollow() async {
    final remote = _remote;
    if (remote == null) {
      // Örnek (backend'de olmayan) profil: yalnızca görünüm.
      setState(() => _following = !_following);
      widget.onFollowTap?.call();
      return;
    }
    if (_followBusy) return;
    final follow = !_following;
    setState(() {
      _followBusy = true;
      _following = follow;
      _remote = remote.copyWith(
        iFollow: follow,
        followerCount: remote.followerCount + (follow ? 1 : -1),
      );
    });
    try {
      final repo = UserRepository.instance;
      await (follow ? repo.follow(remote.id) : repo.unfollow(remote.id));
      SessionStore.instance.refreshMe().catchError((_) {});
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _following = !follow;
        _remote = remote;
      });
      showErrorSnackBar(context, e);
    } finally {
      if (mounted) setState(() => _followBusy = false);
    }
    widget.onFollowTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).profile;
    final screenW = MediaQuery.sizeOf(context).width;
    final hPad = ((screenW - _kContentWidth) / 2).clamp(16.0, 40.0);
    final media = ProfileMockRepository.mediaFor(_tab.name);

    return ListenableBuilder(
      listenable: Listenable.merge([
        LocalProfileStore.instance,
        SessionStore.instance,
      ]),
      builder: (context, _) {
        final base =
            _remote ?? widget.user ?? ProfileMockRepository.currentUser();
        final profile = base.isSelf
            ? LocalProfileStore.instance.apply(base)
            : base;
        final isSelf = profile.isSelf;

        return Material(
      color: AppColors.white,
      child: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(hPad, 8, hPad, 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _ProfileHeader(
                showBack: !isSelf,
                eyebrow: isSelf ? t.eyebrow : null,
                title: isSelf ? t.title : t.eyebrow,
                tokenBalance: isSelf ? profile.tokenBalance : null,
                onTokensTap: isSelf ? widget.onTokensTap : null,
                onShareTap: isSelf
                    ? widget.onShareTap
                    : () => showShareProfileSheet(
                          context,
                          username: profile.username ?? profile.displayName,
                        ),
                onSettingsTap: isSelf
                    ? widget.onSettingsTap
                    : () => showProfileActionsSheet(context, user: profile),
              ),
              const SizedBox(height: 20),
              _ProfileSummary(
                profile: profile,
                likeLabel: t.statLike,
                followLabel: t.statFollow,
                followerLabel: t.statFollower,
                showUsername: !isSelf,
                onFollowTap: () => FollowPage.open(
                  context,
                  initialTab: FollowTab.following,
                  userId: isSelf ? null : _remote?.id,
                ),
                onFollowerTap: () => FollowPage.open(
                  context,
                  initialTab: FollowTab.followers,
                  userId: isSelf ? null : _remote?.id,
                ),
              ),
              const SizedBox(height: 18),
              AppText(profile.bio, style: AppTextStyles.profileBio),
              const SizedBox(height: 18),
              if (isSelf) ...[
                _EditProfileButton(
                  label: t.editProfile,
                  onPressed: widget.onEditProfileTap,
                ),
                const SizedBox(height: 18),
                _StandOutBanner(
                  title: t.promoTitle,
                  subtitle: t.promoSubtitle,
                  ctaLabel: t.standOut,
                  onPressed: widget.onStandOutTap,
                ),
                const SizedBox(height: 18),
              ] else ...[
                AppPrimaryButton(
                  label: _following ? t.following : t.follow,
                  onPressed: _toggleFollow,
                ),
                const SizedBox(height: 18),
              ],
              _ProfileMediaTabs(
                postsLabel: t.tabPosts,
                videoLabel: t.tabVideo,
                savedLabel: t.tabSaved,
                selected: _tab,
                onChanged: (tab) => setState(() => _tab = tab),
              ),
              const SizedBox(height: 6),
              if (_tabPosts case final posts?)
                _ProfilePostGrid(
                  posts: posts,
                  onTap: (p) => DiscoverPostPage.openPost(context, p),
                )
              else
                _ProfileMediaGrid(assets: media),
            ],
          ),
        ),
      ),
        );
      },
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({
    this.showBack = false,
    this.eyebrow,
    required this.title,
    this.tokenBalance,
    this.onTokensTap,
    this.onShareTap,
    this.onSettingsTap,
  });

  final bool showBack;
  final String? eyebrow;
  final String title;
  final int? tokenBalance;
  final VoidCallback? onTokensTap;
  final VoidCallback? onShareTap;
  final VoidCallback? onSettingsTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (showBack) const AppBackButton(),
        Expanded(
          child: Transform.translate(
            // Geri ok ile "Profile" arası ~10px daha sıkı
            offset: Offset(showBack ? -10 : 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (eyebrow != null) ...[
                  AppText(eyebrow!, style: AppTextStyles.profileEyebrow),
                  const SizedBox(height: 2),
                ],
                AppText(title, style: AppTextStyles.profileTitle),
              ],
            ),
          ),
        ),
        if (tokenBalance != null) ...[
          _TokenPill(
            count: tokenBalance!,
            onTap: onTokensTap,
          ),
          const SizedBox(width: 8),
        ],
        _HeaderIconButton(
          asset: AppAssets.iconCircleOff,
          onTap: onShareTap,
        ),
        const SizedBox(width: 4),
        _HeaderIconButton(
          asset: AppAssets.iconSettings,
          onTap: onSettingsTap,
        ),
      ],
    );
  }
}

class _TokenPill extends StatelessWidget {
  const _TokenPill({required this.count, this.onTap});

  final int count;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0x337B2FFF),
      borderRadius: BorderRadius.circular(9999),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(9999),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SizedBox(
            height: 36,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  AppAssets.iconTokens,
                  width: 32,
                  height: 32,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 4),
                AppText(
                  '$count',
                  style: AppTextStyles.profileTokenCount,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  const _HeaderIconButton({required this.asset, this.onTap});

  final String asset;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 36,
        height: 36,
        child: Center(
          child: SvgPicture.asset(
            asset,
            width: 32,
            height: 32,
            colorFilter: const ColorFilter.mode(
              AppColors.black,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileSummary extends StatelessWidget {
  const _ProfileSummary({
    required this.profile,
    required this.likeLabel,
    required this.followLabel,
    required this.followerLabel,
    this.showUsername = false,
    this.onFollowTap,
    this.onFollowerTap,
  });

  final ProfileUser profile;
  final String likeLabel;
  final String followLabel;
  final String followerLabel;
  final bool showUsername;
  final VoidCallback? onFollowTap;
  final VoidCallback? onFollowerTap;

  @override
  Widget build(BuildContext context) {
    final handle = profile.username;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileFramedAvatar(
          avatarUrl: profile.avatarUrl,
          size: _kAvatarSize,
          borderAsset: ProfileBorder.assetFor(profile.borderId),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: AppText(
                      profile.displayName,
                      style: AppTextStyles.profileName,
                    ),
                  ),
                  if (profile.isAi) const AiBadge(),
                ],
              ),
              if (showUsername && handle != null && handle.isNotEmpty) ...[
                const SizedBox(height: 4),
                AppText('@$handle', style: AppTextStyles.profileUsername),
              ],
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      label: likeLabel,
                      value: '${profile.likeCount}',
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _StatCard(
                      label: followLabel,
                      value: '${profile.followCount}',
                      onTap: onFollowTap,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _StatCard(
                      label: followerLabel,
                      value: '${profile.followerCount}',
                      onTap: onFollowerTap,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    this.onTap,
  });

  final String label;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0x05000000), // #000 @ 2%
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(
              label,
              style: AppTextStyles.profileStatLabel,
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            AppText(
              value,
              style: AppTextStyles.profileStatValue,
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _EditProfileButton extends StatelessWidget {
  const _EditProfileButton({required this.label, this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.textPrimary,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(999),
        child: SizedBox(
          height: 40,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppAssets.iconEditProfile,
                width: 24,
                height: 24,
                colorFilter: const ColorFilter.mode(
                  AppColors.white,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 10),
              AppText(label, style: AppTextStyles.profileEditButton),
            ],
          ),
        ),
      ),
    );
  }
}

/// Figma Stand Out kartı — linear #7B2FFF→#430F9D, 2px glow border, rocket + CTA.
class _StandOutBanner extends StatelessWidget {
  const _StandOutBanner({
    required this.title,
    required this.subtitle,
    required this.ctaLabel,
    this.onPressed,
  });

  final String title;
  final String subtitle;
  final String ctaLabel;
  final VoidCallback? onPressed;

  static const _cardRadius = 18.0;
  static const _borderWidth = 2.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_cardRadius),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF7B2FFF),
            Color(0xFF8E99FF),
          ],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x40000000),
            offset: Offset(0, 2),
            blurRadius: 4,
            spreadRadius: -2,
          ),
        ],
      ),
      padding: const EdgeInsets.all(_borderWidth),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_cardRadius - _borderWidth),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF7B2FFF),
              Color(0xFF430F9D),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  AppAssets.iconRocket,
                  width: 62,
                  height: 62,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(title, style: AppTextStyles.profilePromoTitle),
                      const SizedBox(height: 4),
                      AppText(
                        subtitle,
                        style: AppTextStyles.profilePromoSubtitle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            _StandOutCta(
              label: ctaLabel,
              onPressed: onPressed,
            ),
          ],
        ),
      ),
    );
  }
}

/// Figma Frame 8916 + 2147227506 — dış #976FEA→#5E35B4 (3px), iç #7D37FD→#9073F2.
class _StandOutCta extends StatelessWidget {
  const _StandOutCta({
    required this.label,
    this.onPressed,
  });

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        height: AppSizes.primaryButtonHeight,
        width: double.infinity,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppBorders.buttonOuterRadius),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.brandPurpleSoft,
                AppColors.brandPurpleDeep,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.25),
                offset: const Offset(0, 2),
                blurRadius: 4,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(3),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppBorders.buttonRadius),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.brandPurple,
                    AppColors.brandPurpleLight,
                  ],
                ),
                border: Border.all(
                  width: AppBorders.buttonBorderWidth,
                  color: AppColors.white.withValues(alpha: 0.33),
                ),
              ),
              child: Center(
                child: AppText(label, style: AppTextStyles.profileStandOut),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileMediaTabs extends StatelessWidget {
  const _ProfileMediaTabs({
    required this.postsLabel,
    required this.videoLabel,
    required this.savedLabel,
    required this.selected,
    required this.onChanged,
  });

  final String postsLabel;
  final String videoLabel;
  final String savedLabel;
  final _ProfileMediaTab selected;
  final ValueChanged<_ProfileMediaTab> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ProfileTab(
            label: postsLabel,
            selected: selected == _ProfileMediaTab.posts,
            onTap: () => onChanged(_ProfileMediaTab.posts),
          ),
        ),
        Expanded(
          child: _ProfileTab(
            label: videoLabel,
            selected: selected == _ProfileMediaTab.video,
            onTap: () => onChanged(_ProfileMediaTab.video),
          ),
        ),
        Expanded(
          child: _ProfileTab(
            label: savedLabel,
            selected: selected == _ProfileMediaTab.saved,
            onTap: () => onChanged(_ProfileMediaTab.saved),
          ),
        ),
      ],
    );
  }
}

class _ProfileTab extends StatelessWidget {
  const _ProfileTab({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        height: 39,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AppText(
              label,
              style: selected
                  ? AppTextStyles.profileTabActive
                  : AppTextStyles.profileTabIdle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Container(
              height: 1,
              width: double.infinity,
              color: selected
                  ? AppColors.selectionBorder
                  : AppColors.borderLight,
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileMediaGrid extends StatelessWidget {
  const _ProfileMediaGrid({required this.assets});

  final List<String> assets;

  @override
  Widget build(BuildContext context) {
    final items = assets.take(3).toList();
    while (items.length < 3) {
      items.add(AppAssets.fakePerson01);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < items.length; i++) ...[
            if (i > 0) const SizedBox(width: _kPostGap),
            Expanded(
              child: _ProfilePostTile(asset: items[i]),
            ),
          ],
        ],
      ),
    );
  }
}

/// Gerçek gönderiler: 3'lü satırlar, boş yer sahte görselle doldurulmaz.
class _ProfilePostGrid extends StatelessWidget {
  const _ProfilePostGrid({required this.posts, required this.onTap});

  final List<Post> posts;
  final ValueChanged<Post> onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          for (var row = 0; row * 3 < posts.length; row++) ...[
            if (row > 0) const SizedBox(height: _kPostGap),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < 3; i++) ...[
                  if (i > 0) const SizedBox(width: _kPostGap),
                  Expanded(
                    child: row * 3 + i < posts.length
                        ? GestureDetector(
                            onTap: () => onTap(posts[row * 3 + i]),
                            child: SizedBox(
                              height: _kPostHeight,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  _kPostRadius,
                                ),
                                child: Image.network(
                                  posts[row * 3 + i].thumbUrl,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: _kPostHeight,
                                  errorBuilder: (_, _, _) => const ColoredBox(
                                    color: AppColors.inputFill,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(height: _kPostHeight),
                  ),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _ProfilePostTile extends StatelessWidget {
  const _ProfilePostTile({required this.asset});

  final String asset;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _kPostHeight,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(_kPostRadius),
        child: Image.asset(
          asset,
          fit: BoxFit.cover,
          width: double.infinity,
          height: _kPostHeight,
        ),
      ),
    );
  }
}
