import 'dart:async';

import 'package:flutter/material.dart';
import 'package:veylo/core/errors/error_messages.dart';
import 'package:veylo/core/navigation/session_navigation.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_primary_button.dart';
import 'package:veylo/core/widgets/app_suggestion_chip.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/core/widgets/app_text_field.dart';
import 'package:veylo/data/remote/session_store.dart';
import 'package:veylo/data/remote/user_repository.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/screens/create_profile/create_profile_draft.dart';
import 'package:veylo/screens/create_profile/create_profile_nav.dart';
import 'package:veylo/screens/create_profile/create_profile_photo_page.dart';
import 'package:veylo/screens/create_profile/create_profile_shell.dart';

enum _UsernameStatus { idle, invalid, taken, available }

/// Create Profile — 1/5 Username. Sonraki adım: profil fotoğrafı.
class CreateProfileUsernamePage extends StatefulWidget {
  const CreateProfileUsernamePage({super.key});

  @override
  State<CreateProfileUsernamePage> createState() =>
      _CreateProfileUsernamePageState();
}

class _CreateProfileUsernamePageState extends State<CreateProfileUsernamePage> {
  final _fullNameController = TextEditingController();
  final _usernameController = TextEditingController();

  final _draft = CreateProfileDraft.instance;

  _UsernameStatus _status = _UsernameStatus.idle;
  List<String> _suggestions = const [];
  Timer? _debounce;

  /// Yalnızca son yazılanın cevabı ekrana yansısın (eski istekler yarışmasın).
  int _checkSeq = 0;

  static final _validUsername = RegExp(r'^[a-z0-9._]{3,30}$');

  @override
  void initState() {
    super.initState();
    // Geri gelindiyse taslaktaki değerler.
    _fullNameController.text = _draft.fullName;
    if (_draft.username.isNotEmpty) {
      _usernameController.text = _draft.username;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _onUsernameChanged(_draft.username);
      });
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _fullNameController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  bool get _canContinue =>
      _fullNameController.text.trim().isNotEmpty &&
      _status == _UsernameStatus.available;

  void _onFullNameChanged(String _) => setState(() {});

  void _onUsernameChanged(String raw) {
    _debounce?.cancel();
    _checkSeq++;
    final cleaned = raw.trim().replaceFirst(RegExp(r'^@+'), '');

    if (cleaned.length < 3) {
      setState(() {
        _status = _UsernameStatus.idle;
        _suggestions = const [];
      });
      return;
    }

    setState(() {
      _status = _UsernameStatus.idle;
      _suggestions = const [];
    });

    final key = cleaned.toLowerCase();
    if (!_validUsername.hasMatch(key)) {
      setState(() => _status = _UsernameStatus.invalid);
      return;
    }
    _debounce = Timer(const Duration(milliseconds: 400), () => _check(key));
  }

  Future<void> _check(String key) async {
    final seq = ++_checkSeq;
    try {
      final result = await UserRepository.instance.usernameAvailability(key);
      if (!mounted || seq != _checkSeq) return;
      setState(() {
        _status = result.available
            ? _UsernameStatus.available
            : _UsernameStatus.taken;
        _suggestions = result.suggestions.take(3).map((s) => '@$s').toList();
      });
    } catch (e) {
      if (!mounted || seq != _checkSeq) return;
      showErrorSnackBar(context, e);
    }
  }

  void _continue() {
    _draft
      ..fullName = _fullNameController.text.trim()
      ..username = _usernameController.text
          .trim()
          .replaceFirst(RegExp(r'^@+'), '')
          .toLowerCase();
    Navigator.of(context).push(
      createProfileRoute(const CreateProfilePhotoPage()),
    );
  }

  /// İlk adımdan geri: oturumu kapat, karşılama ekranına dön.
  Future<void> _back() async {
    await SessionStore.instance.signOut();
    if (mounted) await goForSession(context, SessionStatus.signedOut);
  }

  void _applySuggestion(String chip) {
    final value = chip.replaceFirst(RegExp(r'^@+'), '');
    _usernameController.text = value;
    _usernameController.selection = TextSelection.collapsed(
      offset: _usernameController.text.length,
    );
    _onUsernameChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final cp = t.createProfile;

    return CreateProfileShell(
      navTitle: cp.navTitle,
      step: 1,
      stepLabel: cp.stepUsername,
      onBack: _back,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(cp.title, style: AppTextStyles.createProfileTitle),
          const SizedBox(height: AppSpacing.sm),
          // Figma 2 satır: "… — it" / "won't appear publicly."
          // Dar ekranda soft-wrap "it"i tek satıra düşürmesin diye Fixed 2 satır.
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  cp.subtitleLine1,
                  maxLines: 1,
                  softWrap: false,
                  style: AppTextStyles.authSubtitle,
                ),
              ),
              Text(
                cp.subtitleLine2,
                maxLines: 1,
                style: AppTextStyles.authSubtitle,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          AppTextField(
            label: cp.fullName,
            hint: cp.fullNameHint,
            controller: _fullNameController,
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.name],
            onChanged: _onFullNameChanged,
            labelGap: 4,
          ),
          const SizedBox(height: AppSpacing.fieldGap),
          AppTextField(
            label: cp.username,
            hint: cp.usernameHint,
            controller: _usernameController,
            prefixText: '@',
            hasError: _status == _UsernameStatus.taken ||
                _status == _UsernameStatus.invalid,
            textInputAction: TextInputAction.done,
            autofillHints: const [AutofillHints.username],
            onChanged: _onUsernameChanged,
            labelGap: 4,
          ),
          if (_status == _UsernameStatus.invalid) ...[
            const SizedBox(height: AppSpacing.sm),
            AppText(cp.usernameInvalid, style: AppTextStyles.fieldError),
          ],
          if (_status == _UsernameStatus.taken) ...[
            const SizedBox(height: AppSpacing.sm),
            AppText(cp.usernameTaken, style: AppTextStyles.fieldError),
            if (_suggestions.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.md),
              AppText(cp.mightWantToTry, style: AppTextStyles.suggestionHint),
              const SizedBox(height: 8),
              Wrap(
                spacing: 10,
                runSpacing: 8,
                children: [
                  for (final s in _suggestions)
                    AppSuggestionChip(
                      label: s,
                      onTap: () => _applySuggestion(s),
                    ),
                ],
              ),
            ],
          ],
          if (_status == _UsernameStatus.available) ...[
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                const Icon(
                  Icons.check,
                  size: 16,
                  color: AppColors.success,
                ),
                const SizedBox(width: AppSpacing.xs),
                AppText(
                  cp.usernameAvailable,
                  style: AppTextStyles.fieldSuccess,
                ),
              ],
            ),
          ],
        ],
      ),
      footer: AppPrimaryButton(
        label: t.common.continueAction,
        onPressed: _canContinue ? _continue : null,
      ),
    );
  }
}
