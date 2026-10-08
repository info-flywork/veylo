import 'package:flutter/material.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_interest_chip.dart';
import 'package:veylo/core/widgets/app_primary_button.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/screens/create_profile/create_profile_chat_goal_page.dart';
import 'package:veylo/screens/create_profile/create_profile_nav.dart';
import 'package:veylo/screens/create_profile/create_profile_shell.dart';

class _InterestItem {
  const _InterestItem(this.id, this.iconAsset);

  final String id;
  final String iconAsset;
}

/// Create Profile — 4/5 Interests. En az 5 seçim.
class CreateProfileInterestsPage extends StatefulWidget {
  const CreateProfileInterestsPage({super.key});

  @override
  State<CreateProfileInterestsPage> createState() =>
      _CreateProfileInterestsPageState();
}

class _CreateProfileInterestsPageState
    extends State<CreateProfileInterestsPage> {
  static const _minCount = 5;

  static const _items = <_InterestItem>[
    _InterestItem('music', AppAssets.interestMusic),
    _InterestItem('movies', AppAssets.interestMovies),
    _InterestItem('tvShows', AppAssets.interestTvShows),
    _InterestItem('reading', AppAssets.interestReading),
    _InterestItem('painting', AppAssets.interestPainting),
    _InterestItem('photography', AppAssets.interestPhotography),
    _InterestItem('theatre', AppAssets.interestTheatre),
    _InterestItem('fitness', AppAssets.interestFitness),
    _InterestItem('swimming', AppAssets.interestSwimming),
    _InterestItem('football', AppAssets.interestFootball),
    _InterestItem('basketball', AppAssets.interestBasketball),
    _InterestItem('coffee', AppAssets.interestCoffee),
    _InterestItem('travel', AppAssets.interestTravel),
    _InterestItem('camping', AppAssets.interestCamping),
    _InterestItem('meditation', AppAssets.interestMeditation),
    _InterestItem('videoGames', AppAssets.interestVideoGames),
    _InterestItem('boardGames', AppAssets.interestBoardGames),
    _InterestItem('standUp', AppAssets.interestStandUp),
    _InterestItem('tech', AppAssets.interestTech),
    _InterestItem('coding', AppAssets.interestCoding),
    _InterestItem('ai', AppAssets.interestAi),
    _InterestItem('podcast', AppAssets.interestPodcast),
  ];

  final Set<String> _selected = {};

  String _labelFor(Translations t, String id) {
    final i = t.createProfile.interests;
    return switch (id) {
      'music' => i.music,
      'movies' => i.movies,
      'tvShows' => i.tvShows,
      'reading' => i.reading,
      'painting' => i.painting,
      'photography' => i.photography,
      'theatre' => i.theatre,
      'fitness' => i.fitness,
      'swimming' => i.swimming,
      'football' => i.football,
      'basketball' => i.basketball,
      'coffee' => i.coffee,
      'travel' => i.travel,
      'camping' => i.camping,
      'meditation' => i.meditation,
      'videoGames' => i.videoGames,
      'boardGames' => i.boardGames,
      'standUp' => i.standUp,
      'tech' => i.tech,
      'coding' => i.coding,
      'ai' => i.ai,
      'podcast' => i.podcast,
      _ => id,
    };
  }

  void _toggle(String id) {
    setState(() {
      if (_selected.contains(id)) {
        _selected.remove(id);
      } else {
        _selected.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final cp = t.createProfile;
    final canContinue = _selected.length >= _minCount;

    return CreateProfileShell(
      navTitle: cp.navTitle,
      step: 4,
      stepLabel: cp.stepInterests,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: AppText(
              cp.interestsTitle,
              style: AppTextStyles.createProfileHeading,
              maxLines: 1,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          AppText(cp.interestsSubtitle, style: AppTextStyles.authSubtitle),
          const SizedBox(height: AppSpacing.xxxl),
          Wrap(
            spacing: 8,
            runSpacing: 10,
            children: [
              for (final item in _items)
                AppInterestChip(
                  iconAsset: item.iconAsset,
                  label: _labelFor(t, item.id),
                  selected: _selected.contains(item.id),
                  onTap: () => _toggle(item.id),
                ),
            ],
          ),
        ],
      ),
      footer: AppPrimaryButton(
        label: t.common.continueAction,
        onPressed: canContinue
            ? () {
                Navigator.of(context).push(
                  createProfileRoute(const CreateProfileChatGoalPage()),
                );
              }
            : null,
      ),
    );
  }
}
