import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/errors/error_messages.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/core/widgets/profile_tappable_avatar.dart';
import 'package:veylo/data/remote/safety_repository.dart';
import 'package:veylo/i18n/strings.g.dart';

const _kContentWidth = 398.0;
const _kUnblockPurple = Color(0xFF7C6CD6);

/// Ayarlar → Engellenen Kullanıcılar: liste + engeli kaldır.
class BlockedUsersPage extends StatefulWidget {
  const BlockedUsersPage({super.key});

  static Future<void> open(BuildContext context) {
    return Navigator.of(context).push<void>(
      MaterialPageRoute<void>(builder: (_) => const BlockedUsersPage()),
    );
  }

  @override
  State<BlockedUsersPage> createState() => _BlockedUsersPageState();
}

class _BlockedUsersPageState extends State<BlockedUsersPage> {
  final _repo = SafetyRepository.instance;
  List<BlockedUserEntry> _items = const [];
  bool _loading = true;
  final Set<String> _busy = {};

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final all = await _repo.listBlocks();
      if (!mounted) return;
      setState(() {
        // Sadece engel (RESTRICT değil) ve kaldırılabilir id'si olanlar.
        _items = [
          for (final e in all)
            if (e.isBlock && (e.userId?.isNotEmpty ?? false)) e,
        ];
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _loading = false);
      showErrorSnackBar(context, e);
    }
  }

  Future<void> _unblock(BlockedUserEntry entry) async {
    final id = entry.userId;
    if (id == null || id.isEmpty || _busy.contains(id)) return;
    setState(() => _busy.add(id));
    try {
      await _repo.unblock(id);
      if (!mounted) return;
      final t = Translations.of(context).profile;
      final name = entry.anonymous
          ? t.blockedAnonymous
          : (entry.displayName?.trim().isNotEmpty == true
              ? entry.displayName!
              : (entry.username ?? t.blockedAnonymous));
      setState(() {
        _items = _items.where((e) => e.userId != id).toList();
        _busy.remove(id);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(t.unblockedDone(username: name)),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _busy.remove(id));
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

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: top),
          _Header(
            title: t.blockedUsers,
            onBack: () => Navigator.of(context).pop(),
          ),
          Expanded(
            child: _loading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.selectionBorder,
                    ),
                  )
                : _items.isEmpty
                    ? Padding(
                        padding:
                            EdgeInsets.fromLTRB(hPad, 48, hPad, bottom + 24),
                        child: Column(
                          children: [
                            AppText(
                              t.blockedUsersEmpty,
                              style: AppTextStyles.profileTitle.copyWith(
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            AppText(
                              t.blockedUsersEmptyHint,
                              style: const TextStyle(
                                fontFamily: AppFonts.poppins,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Color(0xA6000000),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    : RefreshIndicator(
                        color: AppColors.selectionBorder,
                        onRefresh: _load,
                        child: ListView.separated(
                          padding: EdgeInsets.fromLTRB(
                            hPad,
                            16,
                            hPad,
                            bottom + 24,
                          ),
                          itemCount: _items.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final entry = _items[index];
                            final id = entry.userId ?? '';
                            return _BlockedRow(
                              entry: entry,
                              anonymousLabel: t.blockedAnonymous,
                              unblockLabel: t.unblock,
                              busy: _busy.contains(id),
                              onUnblock: () => _unblock(entry),
                            );
                          },
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.title, required this.onBack});

  final String title;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 10, 16, 10),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(
          bottom: BorderSide(color: Color(0x26000000), width: 1),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
            icon: SvgPicture.asset(
              AppAssets.backButton,
              width: 24,
              height: 24,
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: AppText(
              title,
              style: AppTextStyles.profileTitle.copyWith(
                fontSize: 22,
                height: 28 / 22,
              ),
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _BlockedRow extends StatelessWidget {
  const _BlockedRow({
    required this.entry,
    required this.anonymousLabel,
    required this.unblockLabel,
    required this.busy,
    required this.onUnblock,
  });

  final BlockedUserEntry entry;
  final String anonymousLabel;
  final String unblockLabel;
  final bool busy;
  final VoidCallback onUnblock;

  @override
  Widget build(BuildContext context) {
    final name = entry.anonymous
        ? anonymousLabel
        : (entry.displayName?.trim().isNotEmpty == true
            ? entry.displayName!
            : (entry.username ?? anonymousLabel));
    final handle = entry.anonymous || (entry.username?.isEmpty ?? true)
        ? null
        : '@${entry.username}';

    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
        color: const Color(0x0D998FED),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0x3383A0B4)),
      ),
      child: Row(
        children: [
          ProfileTappableAvatar(
            avatarUrl: entry.anonymous ? '' : (entry.avatarUrl ?? ''),
            size: 48,
            userId: entry.anonymous ? null : entry.userId,
            displayName: name,
            enabled: !entry.anonymous,
            blurred: entry.anonymous,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  name,
                  style: const TextStyle(
                    fontFamily: AppFonts.poppins,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 1,
                ),
                if (handle != null) ...[
                  const SizedBox(height: 2),
                  AppText(
                    handle,
                    style: const TextStyle(
                      fontFamily: AppFonts.poppins,
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      color: Color(0xA6000000),
                    ),
                    maxLines: 1,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 8),
          TextButton(
            onPressed: busy ? null : onUnblock,
            style: TextButton.styleFrom(
              foregroundColor: _kUnblockPurple,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            child: busy
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: _kUnblockPurple,
                    ),
                  )
                : AppText(
                    unblockLabel,
                    style: const TextStyle(
                      fontFamily: AppFonts.poppins,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: _kUnblockPurple,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
