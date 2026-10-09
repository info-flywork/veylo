import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:veylo/core/errors/error_messages.dart';
import 'package:veylo/core/navigation/session_navigation.dart';
import 'package:veylo/data/remote/session_store.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/screens/profile/change_email_sheet.dart';
import 'package:veylo/screens/profile/change_password_sheet.dart';
import 'package:veylo/screens/profile/delete_account_sheet.dart';
import 'package:veylo/screens/profile/delete_conversation_sheet.dart';
import 'package:veylo/screens/profile/faq_help_sheet.dart';
import 'package:veylo/screens/profile/legal_doc_sheet.dart';
import 'package:veylo/screens/profile/logout_sheet.dart';
import 'package:veylo/screens/profile/share_app_sheet.dart';

const _kContentWidth = 398.0;
const _kIconMuted = Color(0xFF7E8896);
const _kRowFill = Color(0x0D998FED); // #998FED @ 5%
const _kRowBorder = Color(0x3383A0B4); // #83A0B4 @ 20%

/// Settings — Figma Profile / Account Settings.
class AccountManagementPage extends StatefulWidget {
  const AccountManagementPage({super.key});

  static Future<void> open(BuildContext context) {
    return Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (_) => const AccountManagementPage(),
      ),
    );
  }

  @override
  State<AccountManagementPage> createState() => _AccountManagementPageState();
}

class _AccountManagementPageState extends State<AccountManagementPage> {
  String _email = SessionStore.instance.me?.email ?? '';
  bool _notificationsEnabled = true;

  Future<void> _openEmail() async {
    final result = await showChangeEmailSheet(
      context,
      initialEmail: _email,
    );
    if (result == null || !mounted) return;
    setState(() => _email = result);
  }

  Future<void> _openPassword() async {
    await showChangePasswordSheet(context);
  }

  Future<void> _toWelcome() async {
    if (!mounted) return;
    await goForSession(context, SessionStatus.signedOut);
  }

  Future<void> _openLogout() async {
    final ok = await showLogoutSheet(context);
    if (!ok) return;
    await SessionStore.instance.signOut();
    await _toWelcome();
  }

  Future<void> _openDelete() async {
    final reason = await showDeleteAccountSheet(context);
    if (reason == null) return;
    try {
      await SessionStore.instance.requestAccountDeletion(reason);
      await _toWelcome();
    } catch (e) {
      if (mounted) showErrorSnackBar(context, e);
    }
  }

  Future<void> _openDeleteConversations() async {
    final ok = await showDeleteConversationSheet(context);
    if (!ok || !mounted) return;
    // TODO: backend'de tüm sohbetleri sil.
    final msg = Translations.of(context).profile.conversationsDeleted;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _restorePurchases() async {
    // TODO: StoreKit / Play Billing restore.
    final msg = Translations.of(context).profile.restorePurchasesDone;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
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
          _SettingsHeader(
            eyebrow: t.eyebrow,
            title: t.title,
            saveLabel: t.save,
            onBack: () => Navigator.of(context).pop(),
            onSave: () => Navigator.of(context).pop(),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(hPad, 24, hPad, bottom + 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppText(t.settingsAbout, style: AppTextStyles.editProfileSection),
                  const SizedBox(height: 8),
                  _SettingsRow(
                    iconAsset: AppAssets.iconShareUp,
                    label: t.shareApp,
                    onTap: () => showShareAppSheet(context),
                  ),
                  const SizedBox(height: 8),
                  _SettingsRow(
                    iconAsset: AppAssets.iconOkeyHand,
                    label: t.rateApp,
                    onTap: () {
                      // TODO: store puanlama
                    },
                  ),
                  const SizedBox(height: 24),
                  AppText(
                    t.settingsAccount,
                    style: AppTextStyles.editProfileSection,
                  ),
                  const SizedBox(height: 8),
                  _SettingsRow(
                    iconAsset: AppAssets.iconNotificationBing,
                    label: t.notifications,
                    trailing: CupertinoSwitch(
                      value: _notificationsEnabled,
                      activeTrackColor: AppColors.toggleActive,
                      onChanged: (v) =>
                          setState(() => _notificationsEnabled = v),
                    ),
                  ),
                  const SizedBox(height: 8),
                  _SettingsRow(
                    iconAsset: AppAssets.iconPrivateLock,
                    label: t.password,
                    onTap: _openPassword,
                  ),
                  const SizedBox(height: 8),
                  _SettingsRow(
                    iconAsset: AppAssets.iconEmail,
                    label: t.email,
                    value: _email,
                    onTap: _openEmail,
                  ),
                  const SizedBox(height: 24),
                  AppText(
                    t.settingsSupport,
                    style: AppTextStyles.editProfileSection,
                  ),
                  const SizedBox(height: 8),
                  _SettingsRow(
                    label: t.deleteConversation,
                    onTap: _openDeleteConversations,
                  ),
                  const SizedBox(height: 8),
                  _SettingsRow(
                    label: t.faqHelp,
                    onTap: () => showFaqHelpSheet(context),
                  ),
                  const SizedBox(height: 8),
                  _SettingsRow(
                    label: t.restorePurchases,
                    onTap: _restorePurchases,
                  ),
                  const SizedBox(height: 8),
                  _SettingsRow(
                    label: t.termsOfService,
                    onTap: () => showTermsOfServiceSheet(context),
                  ),
                  const SizedBox(height: 8),
                  _SettingsRow(
                    label: t.privacyPolicy,
                    onTap: () => showPrivacyPolicySheet(context),
                  ),
                  const SizedBox(height: 28),
                  _TextAction(
                    label: t.logOut,
                    color: AppColors.logout,
                    onTap: _openLogout,
                  ),
                  const SizedBox(height: 16),
                  _TextAction(
                    label: t.deleteAccountAndData,
                    color: _kIconMuted,
                    onTap: _openDelete,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsHeader extends StatelessWidget {
  const _SettingsHeader({
    required this.eyebrow,
    required this.title,
    required this.saveLabel,
    required this.onBack,
    required this.onSave,
  });

  final String eyebrow;
  final String title;
  final String saveLabel;
  final VoidCallback onBack;
  final VoidCallback onSave;

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(eyebrow, style: AppTextStyles.profileEyebrow),
                const SizedBox(height: 2),
                AppText(
                  title,
                  style: AppTextStyles.profileTitle,
                  maxLines: 1,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          _SaveButton(label: saveLabel, onPressed: onSave),
        ],
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.selectionBorder,
      borderRadius: BorderRadius.circular(9999),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(9999),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_rounded,
                  size: 16,
                  color: AppColors.selectionBorder,
                ),
              ),
              const SizedBox(width: 10),
              AppText(label, style: AppTextStyles.editProfileSave),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  const _SettingsRow({
    required this.label,
    this.iconAsset,
    this.value,
    this.trailing,
    this.onTap,
  });

  final String label;
  final String? iconAsset;
  final String? value;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: trailing != null ? null : onTap,
        borderRadius: BorderRadius.circular(12),
        child: Ink(
          height: 50,
          decoration: BoxDecoration(
            color: _kRowFill,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kRowBorder),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              if (iconAsset != null) ...[
                SvgPicture.asset(
                  iconAsset!,
                  width: 24,
                  height: 24,
                  colorFilter: const ColorFilter.mode(
                    _kIconMuted,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 10),
              ],
              Expanded(
                child: AppText(
                  label,
                  style: AppTextStyles.editProfileField,
                  maxLines: 1,
                ),
              ),
              if (value != null) ...[
                const SizedBox(width: 8),
                Flexible(
                  child: AppText(
                    value!,
                    style: AppTextStyles.editProfileFieldValue,
                    maxLines: 1,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
              if (trailing != null) ...[
                const SizedBox(width: 8),
                trailing!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _TextAction extends StatelessWidget {
  const _TextAction({
    required this.label,
    required this.color,
    required this.onTap,
  });

  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          label,
          style: TextStyle(
            fontFamily: AppFonts.poppins,
            fontWeight: FontWeight.w500,
            fontSize: 16,
            height: 20 / 16,
            color: color,
          ),
        ),
      ),
    );
  }
}
