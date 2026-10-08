import 'dart:async';

import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_primary_button.dart';
import 'package:veylo/core/widgets/app_suggestion_chip.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/core/widgets/app_text_field.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/screens/create_profile/create_profile_nav.dart';
import 'package:veylo/screens/create_profile/create_profile_photo_page.dart';
import 'package:veylo/screens/create_profile/create_profile_shell.dart';

enum _UsernameStatus { idle, taken, available }

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

  _UsernameStatus _status = _UsernameStatus.idle;
  List<String> _suggestions = const [];
  Timer? _debounce;

  /// Backend yokken mock: bu kullanıcı adları dolu sayılır.
  static const _taken = {'jhondoe', 'samlee123', 'admin', 'veylo', 'sena'};

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

    _debounce = Timer(const Duration(milliseconds: 400), () {
      if (!mounted) return;
      final key = cleaned.toLowerCase();
      if (_taken.contains(key)) {
        setState(() {
          _status = _UsernameStatus.taken;
          _suggestions = _buildSuggestions(key);
        });
      } else {
        setState(() {
          _status = _UsernameStatus.available;
          _suggestions = const [];
        });
      }
    });
  }

  List<String> _buildSuggestions(String base) {
    final candidates = <String>[
      '${base}1',
      '${base}12',
      if (base.length > 2) '${base.substring(2)}${base.substring(0, 2)}1',
    ];
    return candidates
        .where((s) => !_taken.contains(s))
        .take(3)
        .map((s) => '@$s')
        .toList();
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
            hasError: _status == _UsernameStatus.taken,
            textInputAction: TextInputAction.done,
            autofillHints: const [AutofillHints.username],
            onChanged: _onUsernameChanged,
            labelGap: 4,
          ),
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
        onPressed: _canContinue
            ? () {
                Navigator.of(context).push(
                  createProfileRoute(const CreateProfilePhotoPage()),
                );
              }
            : null,
      ),
    );
  }
}
