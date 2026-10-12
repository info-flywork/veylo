import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_primary_button.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/data/remote/match_repository.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/screens/discover/finding_match_page.dart';

class _MoodOption {
  const _MoodOption({
    required this.id,
    required this.asset,
    required this.label,
  });

  final String id;
  final String asset;
  final String label;
}

class _LookingOption {
  const _LookingOption({
    required this.id,
    required this.emoji,
    required this.label,
  });

  final String id;
  final String emoji;
  final String label;
}

/// Discover → AI Match sekmesi.
class AiMatchTab extends StatefulWidget {
  const AiMatchTab({super.key});

  @override
  State<AiMatchTab> createState() => _AiMatchTabState();
}

class _AiMatchTabState extends State<AiMatchTab> {
  String _moodId = 'bored';
  String _lookingId = 'cultures';

  /// Gerçek çevrimiçi sayısı (yüklenene kadar null).
  int? _online;

  @override
  void initState() {
    super.initState();
    MatchRepository.instance
        .onlineCount()
        .then((n) {
          if (mounted) setState(() => _online = n);
        })
        .catchError((Object _) {});
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).discover.aiMatch;

    final moods = [
      _MoodOption(id: 'sad', asset: AppAssets.emotionSad, label: t.moodSad),
      _MoodOption(
        id: 'meltie',
        asset: AppAssets.emotionMeltie,
        label: t.moodMeltie,
      ),
      _MoodOption(
        id: 'bored',
        asset: AppAssets.emotionBored,
        label: t.moodBored,
      ),
      _MoodOption(
        id: 'crying',
        asset: AppAssets.emotionCrying,
        label: t.moodCrying,
      ),
      _MoodOption(
        id: 'smile',
        asset: AppAssets.emotionSmile,
        label: t.moodSmile,
      ),
    ];

    // Figma satırları: 1) friends+venting  2) flirty+fun+cultures  3) language
    final lookingRows = <List<_LookingOption>>[
      [
        _LookingOption(id: 'friends', emoji: '🤝', label: t.lookingNewFriends),
        _LookingOption(id: 'venting', emoji: '💬', label: t.lookingVenting),
      ],
      [
        _LookingOption(id: 'flirty', emoji: '💕', label: t.lookingFlirty),
        _LookingOption(id: 'fun', emoji: '😄', label: t.lookingFun),
        _LookingOption(id: 'cultures', emoji: '🌎', label: t.lookingCultures),
      ],
      [_LookingOption(id: 'language', emoji: '🗣️', label: t.lookingLanguage)],
    ];

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Figma Ellipse 2394 — #FFD2B4 @ 50%, 404, left -142
        const Positioned(
          left: -142 - _BlurOrb.pad,
          top: 20 - _BlurOrb.pad,
          child: _BlurOrb(size: 404, color: Color(0x80FFD2B4)),
        ),
        // Figma Ellipse 2393 — #7C6CD6 @ 50%, 404, left 182 (sağda kalsın)
        const Positioned(
          left: 182 - _BlurOrb.pad,
          top: 20 - _BlurOrb.pad,
          child: _BlurOrb(size: 404, color: Color(0x807C6CD6)),
        ),
        ListView(
          padding: const EdgeInsets.fromLTRB(0, 12, 0, 120),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    t.feelingTitle,
                    style: AppTextStyles.aiMatchFeelingTitle,
                  ),
                  const SizedBox(height: 7),
                  AppText(
                    t.feelingSubtitle,
                    style: AppTextStyles.aiMatchFeelingSubtitle,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              height: 136,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: moods.length,
                separatorBuilder: (_, _) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final mood = moods[index];
                  final selected = mood.id == _moodId;
                  return Align(
                    alignment: Alignment.center,
                    child: _MoodPill(
                      mood: mood,
                      selected: selected,
                      onTap: () => setState(() => _moodId = mood.id),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: AppText(
                t.lookingTitle,
                style: AppTextStyles.aiMatchLookingTitle,
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var r = 0; r < lookingRows.length; r++) ...[
                    if (r > 0) const SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        for (final option in lookingRows[r])
                          _LookingChip(
                            option: option,
                            selected: option.id == _lookingId,
                            onTap: () => setState(() => _lookingId = option.id),
                          ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      value: _online?.toString() ?? '–',
                      label: t.statActiveUsers,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _StatCard(
                      value: t.statMatchValue,
                      label: t.statMatchRate,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _StatCard(
                      value: t.statAvgValue,
                      label: t.statAvgTime,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: AppPrimaryButton(
                label: t.startSmartMatch,
                onPressed: () {
                  Navigator.of(context).push(
                    PageRouteBuilder<void>(
                      pageBuilder: (_, _, _) => FindingMatchPage(
                        mood: _moodId,
                        intent: _lookingId,
                        onlineCount: _online,
                      ),
                      transitionsBuilder: (_, animation, _, child) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                      transitionDuration: const Duration(milliseconds: 280),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _MoodPill extends StatelessWidget {
  const _MoodPill({
    required this.mood,
    required this.selected,
    required this.onTap,
  });

  final _MoodOption mood;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    // Unselected: 70×90, padding 20 — Selected: 102×136, padding 20, gap 10
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: selected ? 102 : 70,
        height: selected ? 136 : 90,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: selected ? 62 : 30,
              height: selected ? 59 : 30,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Image.asset(
                  mood.asset,
                  width: selected ? 62 : 40,
                  height: selected ? 59 : 41,
                ),
              ),
            ),
            if (selected) ...[
              const SizedBox(height: 10),
              AppText(
                mood.label,
                style: AppTextStyles.aiMatchMoodLabel,
                textAlign: TextAlign.center,
                maxLines: 1,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _LookingChip extends StatelessWidget {
  const _LookingChip({
    required this.option,
    required this.selected,
    required this.onTap,
  });

  final _LookingOption option;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected
                ? AppColors.selectionBorder
                : AppColors.black.withValues(alpha: 0.06),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(option.emoji, style: const TextStyle(fontSize: 18)),
            const SizedBox(width: 4),
            AppText(
              option.label,
              style: selected
                  ? AppTextStyles.aiMatchChipSelected
                  : AppTextStyles.aiMatchChip,
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(value, style: AppTextStyles.aiMatchStatValue),
          const SizedBox(height: 4),
          AppText(label, style: AppTextStyles.aiMatchStatLabel, maxLines: 1),
        ],
      ),
    );
  }
}

class _BlurOrb extends StatelessWidget {
  const _BlurOrb({required this.size, required this.color});

  final double size;
  final Color color;

  static const double _sigma = 75;
  static const double pad = _sigma * 2;

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: _sigma, sigmaY: _sigma),
      child: Padding(
        padding: const EdgeInsets.all(pad),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
      ),
    );
  }
}
