import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_primary_button.dart';
import 'package:veylo/core/widgets/app_selectable_tile.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/screens/create_profile/create_profile_interests_page.dart';
import 'package:veylo/screens/create_profile/create_profile_nav.dart';
import 'package:veylo/screens/create_profile/create_profile_shell.dart';

enum ProfileGender { female, male, nonBinary, preferNotToSay }

/// Create Profile — 3/5 Gender.
class CreateProfileGenderPage extends StatefulWidget {
  const CreateProfileGenderPage({super.key});

  @override
  State<CreateProfileGenderPage> createState() =>
      _CreateProfileGenderPageState();
}

class _CreateProfileGenderPageState extends State<CreateProfileGenderPage> {
  ProfileGender? _selected;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final cp = t.createProfile;

    final options = <(ProfileGender, String)>[
      (ProfileGender.female, cp.genderFemale),
      (ProfileGender.male, cp.genderMale),
      (ProfileGender.nonBinary, cp.genderNonBinary),
      (ProfileGender.preferNotToSay, cp.genderPreferNotToSay),
    ];

    return CreateProfileShell(
      navTitle: cp.navTitle,
      step: 3,
      stepLabel: cp.stepGender,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(cp.genderTitle, style: AppTextStyles.createProfileHeading),
          const SizedBox(height: AppSpacing.sm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  cp.genderSubtitleLine1,
                  maxLines: 1,
                  softWrap: false,
                  style: AppTextStyles.authSubtitle,
                ),
              ),
              Text(
                cp.genderSubtitleLine2,
                maxLines: 1,
                style: AppTextStyles.authSubtitle,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xxxl),
          for (var i = 0; i < options.length; i++) ...[
            if (i > 0) const SizedBox(height: 10),
            AppSelectableTile(
              label: options[i].$2,
              selected: _selected == options[i].$1,
              onTap: () => setState(() => _selected = options[i].$1),
            ),
          ],
        ],
      ),
      footer: AppPrimaryButton(
        label: t.common.continueAction,
        onPressed: _selected == null
            ? null
            : () {
                Navigator.of(context).push(
                  createProfileRoute(const CreateProfileInterestsPage()),
                );
              },
      ),
    );
  }
}
