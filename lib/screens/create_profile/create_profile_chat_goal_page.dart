import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_primary_button.dart';
import 'package:veylo/core/widgets/app_selectable_tile.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/screens/create_profile/create_profile_nav.dart';
import 'package:veylo/screens/create_profile/create_profile_shell.dart';
import 'package:veylo/screens/create_profile/preparing_profiles_page.dart';

enum ProfileChatGoal {
  quickMatch,
  flirtyChat,
  moodMatch,
  lateNight,
  meetSomeoneNew,
}

/// Create Profile — 5/5 Chat goal.
class CreateProfileChatGoalPage extends StatefulWidget {
  const CreateProfileChatGoalPage({super.key});

  @override
  State<CreateProfileChatGoalPage> createState() =>
      _CreateProfileChatGoalPageState();
}

class _CreateProfileChatGoalPageState extends State<CreateProfileChatGoalPage> {
  ProfileChatGoal? _selected;

  void _finish() {
    Navigator.of(context).push(
      createProfileRoute(const PreparingProfilesPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final cp = t.createProfile;

    final options = <(ProfileChatGoal, String)>[
      (ProfileChatGoal.quickMatch, cp.chatGoalQuickMatch),
      (ProfileChatGoal.flirtyChat, cp.chatGoalFlirtyChat),
      (ProfileChatGoal.moodMatch, cp.chatGoalMoodMatch),
      (ProfileChatGoal.lateNight, cp.chatGoalLateNight),
      (ProfileChatGoal.meetSomeoneNew, cp.chatGoalMeetSomeoneNew),
    ];

    return CreateProfileShell(
      navTitle: cp.navTitle,
      step: 5,
      stepLabel: cp.stepChatGoal,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(cp.chatGoalTitle, style: AppTextStyles.createProfileHeading),
          const SizedBox(height: AppSpacing.sm),
          AppText(cp.chatGoalSubtitle, style: AppTextStyles.authSubtitle),
          const SizedBox(height: 20),
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
        label: cp.getStarted,
        onPressed: _selected == null ? null : _finish,
      ),
    );
  }
}
