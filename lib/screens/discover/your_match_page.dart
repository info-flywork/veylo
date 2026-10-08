import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_primary_button.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/screens/discover/rooms/group_chat_page.dart';

const _kContentWidth = 398.0;
const _kCardRadius = 20.0;
const _kActionSize = 52.0;

class _MatchProfile {
  const _MatchProfile({
    required this.imageAsset,
    required this.name,
    required this.age,
    required this.vibePercent,
  });

  final String imageAsset;
  final String name;
  final int age;
  final int vibePercent;
}

const _kMatches = [
  _MatchProfile(
    imageAsset: AppAssets.fakePerson03,
    name: 'Victoria',
    age: 22,
    vibePercent: 92,
  ),
  _MatchProfile(
    imageAsset: AppAssets.fakePerson01,
    name: 'Emma',
    age: 24,
    vibePercent: 88,
  ),
  _MatchProfile(
    imageAsset: AppAssets.fakePerson05,
    name: 'Sophia',
    age: 21,
    vibePercent: 85,
  ),
  _MatchProfile(
    imageAsset: AppAssets.fakePerson07,
    name: 'Luna',
    age: 23,
    vibePercent: 90,
  ),
];

/// AI Match sonucu — Your Match ekranı.
class YourMatchPage extends StatefulWidget {
  const YourMatchPage({super.key});

  @override
  State<YourMatchPage> createState() => _YourMatchPageState();
}

class _YourMatchPageState extends State<YourMatchPage> {
  late final PageController _pageController;
  bool _showSwipeHint = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToNextMatch() {
    final page = _pageController.page?.round() ?? 0;
    if (page < _kMatches.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeOutCubic,
      );
    }
  }

  void _startChatting() {
    final page = _pageController.hasClients
        ? (_pageController.page?.round() ?? 0)
        : 0;
    final match = _kMatches[page.clamp(0, _kMatches.length - 1)];
    GroupChatPage.open(
      context,
      title: match.name,
      memberCount: 1,
      avatars: [match.imageAsset],
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).discover.aiMatch;
    final media = MediaQuery.of(context);
    final screenW = media.size.width;
    final topInset = media.padding.top;
    final bottomInset = media.padding.bottom;
    final hPad = math.max(16.0, (screenW - _kContentWidth) / 2);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: EdgeInsets.fromLTRB(hPad, topInset + 12, hPad, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(t.yourMatchTitle, style: AppTextStyles.yourMatchTitle),
            const SizedBox(height: 6),
            AppText(
              t.yourMatchSubtitle,
              style: AppTextStyles.yourMatchSubtitle,
            ),
            const SizedBox(height: 28),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _kMatches.length,
                itemBuilder: (context, index) {
                  final match = _kMatches[index];
                  return _MatchCard(
                    imageAsset: match.imageAsset,
                    vibeLabel: t.vibeMatch(percent: match.vibePercent),
                    nameAge: t.matchNameAge(name: match.name, age: match.age),
                    bio: t.matchBio,
                    showSwipeHint: _showSwipeHint,
                    swipePreviousLabel: t.swipePrevious,
                    swipeNextLabel: t.swipeNext,
                    swipeFingerLabel: t.swipeFinger,
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 13, 0, 13 + bottomInset),
              child: Row(
                children: [
                  _CircleAction(
                    background: AppColors.textPrimary.withValues(alpha: 0.10),
                    onTap: () => setState(() => _showSwipeHint = false),
                    child: SvgPicture.asset(
                      AppAssets.iconClose,
                      width: 32,
                      height: 32,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppPrimaryButton(
                      label: t.startChatting,
                      leading: SvgPicture.asset(
                        AppAssets.iconYourMatchChatting,
                        width: 24,
                        height: 24,
                      ),
                      onPressed: _startChatting,
                    ),
                  ),
                  const SizedBox(width: 12),
                  _CircleAction(
                    background: const Color(0x1AEC1C24),
                    onTap: _goToNextMatch,
                    child: SvgPicture.asset(
                      AppAssets.iconHeart,
                      width: 26,
                      height: 24,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFFC23041),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MatchCard extends StatelessWidget {
  const _MatchCard({
    required this.imageAsset,
    required this.vibeLabel,
    required this.nameAge,
    required this.bio,
    required this.showSwipeHint,
    required this.swipePreviousLabel,
    required this.swipeNextLabel,
    required this.swipeFingerLabel,
  });

  final String imageAsset;
  final String vibeLabel;
  final String nameAge;
  final String bio;
  final bool showSwipeHint;
  final String swipePreviousLabel;
  final String swipeNextLabel;
  final String swipeFingerLabel;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(_kCardRadius),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            imageAsset,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
            filterQuality: FilterQuality.high,
          ),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x00000000),
                  Color(0x66000000),
                  Color(0xCC1A0B3A),
                ],
                stops: [0.35, 0.65, 1],
              ),
            ),
          ),
          if (showSwipeHint)
            Center(
              child: _SwipeHintOverlay(
                previousLabel: swipePreviousLabel,
                nextLabel: swipeNextLabel,
                fingerLabel: swipeFingerLabel,
              ),
            ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF008F24).withValues(alpha: 0.20),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: AppText(vibeLabel, style: AppTextStyles.yourMatchVibe),
                ),
                const SizedBox(height: 10),
                AppText(nameAge, style: AppTextStyles.yourMatchName),
                const SizedBox(height: 6),
                AppText(bio, style: AppTextStyles.yourMatchBio),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SwipeHintOverlay extends StatelessWidget {
  const _SwipeHintOverlay({
    required this.previousLabel,
    required this.nextLabel,
    required this.fingerLabel,
  });

  final String previousLabel;
  final String nextLabel;
  final String fingerLabel;

  /// Figma: parmak 59×65, ok 56×21 — yan sütun "Previous" için biraz geniş.
  static const _fingerW = 59.0;
  static const _fingerH = 65.0;
  static const _arrowW = 56.0;
  static const _arrowH = 21.0;
  static const _sideColW = 72.0;
  static const _colGap = 12.0;

  static const _sideLabelStyle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w700,
    fontSize: 16,
    height: 1,
    color: AppColors.white,
    shadows: [
      Shadow(
        color: Color(0x80000000),
        blurRadius: 8,
        offset: Offset(0, 2),
      ),
    ],
  );

  static const _fingerLabelStyle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 20,
    height: 1,
    color: AppColors.white,
    shadows: [
      Shadow(
        color: Color(0x80000000),
        blurRadius: 8,
        offset: Offset(0, 2),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: _sideColW,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: _fingerH,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: SvgPicture.asset(
                    AppAssets.iconYourMatchPrevious,
                    width: _arrowW,
                    height: _arrowH,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                previousLabel,
                style: _sideLabelStyle,
                textAlign: TextAlign.center,
                maxLines: 1,
              ),
            ],
          ),
        ),
        const SizedBox(width: _colGap),
        Transform.translate(
          offset: const Offset(0, 18),
          child: SizedBox(
            width: _fingerW + 40,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  AppAssets.iconYourMatchSwiperFinger,
                  width: _fingerW,
                  height: _fingerH,
                ),
                const SizedBox(height: 8),
                Text(
                  fingerLabel,
                  style: _fingerLabelStyle,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: _colGap),
        SizedBox(
          width: _sideColW,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: _fingerH,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SvgPicture.asset(
                    AppAssets.iconYourMatchNext,
                    width: _arrowW,
                    height: _arrowH,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                nextLabel,
                style: _sideLabelStyle,
                textAlign: TextAlign.center,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CircleAction extends StatelessWidget {
  const _CircleAction({
    required this.background,
    required this.onTap,
    required this.child,
  });

  final Color background;
  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: background,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: _kActionSize,
          height: _kActionSize,
          child: Center(child: child),
        ),
      ),
    );
  }
}
