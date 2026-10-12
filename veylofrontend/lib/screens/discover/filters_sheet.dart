import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_interest_chip.dart';
import 'package:veylo/core/widgets/app_primary_button.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/models/discover/post.dart';

class _InterestItem {
  const _InterestItem(this.id, this.iconAsset);

  final String id;
  final String iconAsset;
}

/// Uygulanan filtreleri döner (kapatılırsa null). Açılışta mevcut filtreler seçili gelir.
Future<DiscoverFilters?> showFiltersSheet(
  BuildContext context, {
  DiscoverFilters initial = const DiscoverFilters(),
}) {
  return showModalBottomSheet<DiscoverFilters>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => FiltersSheet(initial: initial),
  );
}

/// Discover Filters — Figma bottom sheet.
class FiltersSheet extends StatefulWidget {
  const FiltersSheet({super.key, this.initial = const DiscoverFilters()});

  final DiscoverFilters initial;

  @override
  State<FiltersSheet> createState() => _FiltersSheetState();
}

class _FiltersSheetState extends State<FiltersSheet> {
  static const _items = <_InterestItem>[
    _InterestItem('music', AppAssets.interestMusic),
    _InterestItem('movies', AppAssets.interestMovies),
    _InterestItem('tvShows', AppAssets.interestTvShows),
    _InterestItem('reading', AppAssets.interestReading),
    _InterestItem('painting', AppAssets.interestPainting),
    _InterestItem('photography', AppAssets.interestPhotography),
    _InterestItem('theatre', AppAssets.interestTheatre),
    _InterestItem('fitness', AppAssets.interestFitness),
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

  RangeValues _age = const RangeValues(18, 35);
  double _distance = 25;
  late String _showMe = widget.initial.gender;
  late final Set<String> _interests = {...widget.initial.interests};
  late bool _activeNow = widget.initial.onlineOnly;

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

  void _toggleInterest(String id) {
    setState(() {
      if (_interests.contains(id)) {
        _interests.remove(id);
      } else {
        _interests.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final f = t.discover.filters;
    final bottom = MediaQuery.paddingOf(context).bottom;
    final maxHeight = MediaQuery.sizeOf(context).height * 0.92;

    final sliderTheme = SliderTheme.of(context).copyWith(
      trackHeight: 3,
      activeTrackColor: AppColors.black,
      inactiveTrackColor: AppColors.sliderTrackIdle,
      thumbColor: AppColors.white,
      overlayColor: AppColors.black.withValues(alpha: 0.06),
      thumbShape: const _FilterThumbShape(),
      rangeThumbShape: const _FilterRangeThumbShape(),
      overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
      rangeTrackShape: const RoundedRectRangeSliderTrackShape(),
      trackShape: const RoundedRectSliderTrackShape(),
    );

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxHeight),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 10, 16, 10 + bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.progressTrack,
                    borderRadius: BorderRadius.circular(AppBorders.radiusPill),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: AppText(f.title, style: AppTextStyles.filtersTitle),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    behavior: HitTestBehavior.opaque,
                    child: SvgPicture.asset(
                      AppAssets.iconClose,
                      width: 32,
                      height: 32,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Age Range — pad 10, gap 4
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: AppText(
                                    f.ageRange,
                                    style: AppTextStyles.filtersSectionLabel,
                                  ),
                                ),
                                AppText(
                                  f.ageRangeValue(
                                    min: _age.start.round().toString(),
                                    max: _age.end.round().toString(),
                                  ),
                                  style: AppTextStyles.filtersValue,
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            SliderTheme(
                              data: sliderTheme,
                              child: RangeSlider(
                                values: _age,
                                min: 18,
                                max: 60,
                                onChanged: (v) => setState(() => _age = v),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Distance
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: AppText(
                                    f.distance,
                                    style: AppTextStyles.filtersSectionLabel,
                                  ),
                                ),
                                AppText(
                                  f.distanceValue(km: _distance.round().toString()),
                                  style: AppTextStyles.filtersValue,
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            SliderTheme(
                              data: sliderTheme,
                              child: Slider(
                                value: _distance,
                                min: 1,
                                max: 100,
                                onChanged: (v) =>
                                    setState(() => _distance = v),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Show me
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            AppText(
                              f.showMe,
                              style: AppTextStyles.filtersSectionLabel,
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Expanded(
                                  child: _ShowMeChip(
                                    label: f.everyone,
                                    selected: _showMe == 'everyone',
                                    onTap: () =>
                                        setState(() => _showMe = 'everyone'),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: _ShowMeChip(
                                    label: f.women,
                                    selected: _showMe == 'women',
                                    onTap: () =>
                                        setState(() => _showMe = 'women'),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: _ShowMeChip(
                                    label: f.men,
                                    selected: _showMe == 'men',
                                    onTap: () =>
                                        setState(() => _showMe = 'men'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Interests
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: AppColors.filterDivider,
                              width: 0.5,
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            AppText(
                              f.interests,
                              style: AppTextStyles.filtersSectionLabel,
                            ),
                            const SizedBox(height: 4),
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: [
                                for (final item in _items)
                                  AppInterestChip(
                                    iconAsset: item.iconAsset,
                                    label: _labelFor(t, item.id),
                                    selected: _interests.contains(item.id),
                                    onTap: () => _toggleInterest(item.id),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Active now — Figma: fixed above Show Result (68 hug, pad 10, top border)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: AppColors.filterDivider,
                      width: 0.5,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            f.activeNow,
                            style: AppTextStyles.filtersSectionLabel,
                          ),
                          const SizedBox(height: 4),
                          AppText(
                            f.activeNowSubtitle,
                            style: AppTextStyles.filtersSubtitle,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Figma Frame 8913: 45.29 × 28
                    _FilterToggle(
                      value: _activeNow,
                      onChanged: (v) => setState(() => _activeNow = v),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              AppPrimaryButton(
                label: f.showResult,
                onPressed: () => Navigator.of(context).pop(
                  DiscoverFilters(
                    gender: _showMe,
                    interests: {..._interests},
                    onlineOnly: _activeNow,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Figma Active now switch — 45×28, purple on / grey off, white thumb.
class _FilterToggle extends StatelessWidget {
  const _FilterToggle({
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final ValueChanged<bool> onChanged;

  static const double _width = 45;
  static const double _height = 28;
  static const double _thumb = 22;
  static const double _pad = 3;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        width: _width,
        height: _height,
        padding: const EdgeInsets.all(_pad),
        decoration: BoxDecoration(
          color: value
              ? AppColors.selectionBorder
              : AppColors.sliderTrackIdle,
          borderRadius: BorderRadius.circular(_height / 2),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: _thumb,
            height: _thumb,
            decoration: const BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0x1A000000),
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ShowMeChip extends StatelessWidget {
  const _ShowMeChip({
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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: 52,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.inputFill,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected
                ? AppColors.selectionBorder
                : Colors.transparent,
            width: 1,
          ),
        ),
        child: AppText(
          label,
          style: selected
              ? AppTextStyles.filtersChipSelected
              : AppTextStyles.filtersChip,
          maxLines: 1,
        ),
      ),
    );
  }
}

/// Figma: 20×20 white thumb, 3px black border.
class _FilterThumbShape extends SliderComponentShape {
  const _FilterThumbShape();

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) =>
      const Size(20, 20);

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    _paintThumb(context.canvas, center);
  }
}

class _FilterRangeThumbShape extends RangeSliderThumbShape {
  const _FilterRangeThumbShape();

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) =>
      const Size(20, 20);

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool isDiscrete = false,
    bool isEnabled = false,
    bool isOnTop = false,
    TextDirection? textDirection,
    required SliderThemeData sliderTheme,
    Thumb? thumb,
    bool isPressed = false,
  }) {
    _paintThumb(context.canvas, center);
  }
}

void _paintThumb(Canvas canvas, Offset center) {
  const radius = 10.0;
  const stroke = 3.0;
  final fillR = radius - stroke / 2;
  canvas.drawCircle(
    center,
    fillR,
    Paint()..color = AppColors.white,
  );
  canvas.drawCircle(
    center,
    fillR,
    Paint()
      ..color = AppColors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke,
  );
}
