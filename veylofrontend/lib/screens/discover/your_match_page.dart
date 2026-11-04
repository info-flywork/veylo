import 'dart:async';
import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_primary_button.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/core/errors/error_messages.dart';
import 'package:veylo/data/remote/chat_repository.dart';
import 'package:veylo/data/remote/chat_store.dart';
import 'package:veylo/data/remote/match_repository.dart';
import 'package:veylo/data/remote/user_repository.dart';
import 'package:veylo/screens/chat/anonymous_chat_page.dart';
import 'package:veylo/i18n/strings.g.dart';

const _kContentWidth = 398.0;
const _kCardRadius = 20.0;
const _kActionSize = 52.0;
const _kHintDuration = Duration(seconds: 3);

class _MatchProfile {
  const _MatchProfile({
    required this.imageAsset,
    required this.name,
    required this.age,
    required this.vibePercent,
    required this.userId,
    this.bio,
  });

  final String imageAsset;
  final String name;

  /// 0: bilinmiyor (profilde doğum tarihi yok) → sadece ad gösterilir.
  final int age;
  final int vibePercent;
  final String? bio;
  final String userId;
}

/// AI Match sonucu — Your Match ekranı.
class YourMatchPage extends StatefulWidget {
  const YourMatchPage({super.key, required this.matches});

  /// Sunucudan gelen eşleşmeler.
  final List<MatchCandidate> matches;

  @override
  State<YourMatchPage> createState() => _YourMatchPageState();
}

class _YourMatchPageState extends State<YourMatchPage> {
  late final PageController _pageController;
  final _cardLink = LayerLink();
  Timer? _hintTimer;
  late bool _showSwipeHint = _cards.isNotEmpty;
  bool _opening = false;
  bool _liking = false;

  /// Kalp ile takip edilen eşleşmeler (aynı karta tekrar istek atılmaz).
  final _liked = <String>{};

  late final List<_MatchProfile> _cards = [
    for (final m in widget.matches)
      _MatchProfile(
        imageAsset: (m.avatarUrl?.isNotEmpty ?? false)
            ? m.avatarUrl!
            : AppAssets.strangerAvatar,
        name: m.displayName,
        age: m.age ?? 0,
        vibePercent: m.vibePercent,
        bio: m.bio,
        userId: m.userId,
      ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    // Kaydırma ipucu birkaç saniye görünür, sonra kendiliğinden kaybolur.
    if (_showSwipeHint) _hintTimer = Timer(_kHintDuration, _hideHint);
  }

  @override
  void dispose() {
    _hintTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _hideHint() {
    _hintTimer?.cancel();
    if (mounted && _showSwipeHint) setState(() => _showSwipeHint = false);
  }

  int get _currentPage => _pageController.hasClients
      ? (_pageController.page?.round() ?? 0).clamp(0, _cards.length - 1)
      : 0;

  void _snack(String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(text), behavior: SnackBarBehavior.floating),
      );
  }

  /// Kalp: eşleşmeyi takip eder (ilgi bildirir), sonra sıradaki karta geçer.
  Future<void> _likeCurrent() async {
    if (_cards.isEmpty || _liking) return;
    final t = Translations.of(context).discover.aiMatch;
    final page = _currentPage;
    final match = _cards[page];
    if (!_liked.contains(match.userId)) {
      setState(() => _liking = true);
      try {
        await UserRepository.instance.follow(match.userId);
        _liked.add(match.userId);
        if (!mounted) return;
        _snack(t.likeSent(name: match.name));
      } catch (e) {
        if (mounted) showErrorSnackBar(context, e);
        return;
      } finally {
        if (mounted) setState(() => _liking = false);
      }
    }
    if (!mounted) return;
    if (page < _cards.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeOutCubic,
      );
    } else {
      _snack(t.lastMatch);
    }
  }

  Future<void> _startChatting() async {
    if (_cards.isEmpty) return;
    final userId = _cards[_currentPage].userId;
    // Anonim sohbet isteği.
    if (_opening) return;
    setState(() => _opening = true);
    try {
      final thread = await ChatRepository.instance.createAnonymous(userId);
      ChatStore.instance.replace(thread);
      if (mounted) await AnonymousChatPage.open(context, thread);
    } catch (e) {
      if (mounted) showErrorSnackBar(context, e);
    } finally {
      if (mounted) setState(() => _opening = false);
    }
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
      body: Stack(
        children: [
          Padding(
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
                  child: _cards.isEmpty
                      ? Center(
                          child: AppText(
                            t.noMatch,
                            style: AppTextStyles.yourMatchSubtitle,
                            textAlign: TextAlign.center,
                          ),
                        )
                      : CompositedTransformTarget(
                          link: _cardLink,
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: _cards.length,
                            itemBuilder: (context, index) {
                              final match = _cards[index];
                              return _MatchCard(
                                imageAsset: match.imageAsset,
                                vibeLabel: t.vibeMatch(
                                  percent: match.vibePercent,
                                ),
                                nameAge: match.age > 0
                                    ? t.matchNameAge(
                                        name: match.name,
                                        age: match.age,
                                      )
                                    : match.name,
                                bio: match.bio ?? '',
                              );
                            },
                          ),
                        ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 13, 0, 13 + bottomInset),
                  child: Row(
                    children: [
                      _CircleAction(
                        background: AppColors.black.withValues(alpha: 0.10),
                        onTap: () => Navigator.of(context).maybePop(),
                        child: SvgPicture.asset(
                          AppAssets.iconYourMatchClose,
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
                        onTap: _likeCurrent,
                        child: SvgPicture.asset(
                          AppAssets.iconYourMatchHeart,
                          width: 32,
                          height: 32,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Figma: ilk açılışta ekran kararır, ipucu kartın ortasında görünür.
          // Dokununca ya da birkaç saniye sonra kaybolur.
          Positioned.fill(
            child: IgnorePointer(
              ignoring: !_showSwipeHint,
              child: AnimatedOpacity(
                opacity: _showSwipeHint ? 1 : 0,
                duration: const Duration(milliseconds: 350),
                child: Listener(
                  behavior: HitTestBehavior.opaque,
                  onPointerDown: (_) => _hideHint(),
                  child: Stack(
                    children: [
                      const Positioned.fill(
                        child: ColoredBox(color: Color(0x99000000)),
                      ),
                      CompositedTransformFollower(
                        link: _cardLink,
                        showWhenUnlinked: false,
                        targetAnchor: Alignment.center,
                        followerAnchor: Alignment.center,
                        child: _SwipeHintOverlay(
                          previousLabel: t.swipePrevious,
                          nextLabel: t.swipeNext,
                          fingerLabel: t.swipeFinger,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
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
  });

  final String imageAsset;
  final String vibeLabel;
  final String nameAge;
  final String bio;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(_kCardRadius),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (imageAsset.startsWith('assets/'))
            Image.asset(
              imageAsset,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
              filterQuality: FilterQuality.high,
            )
          else
            Image(
              image: CachedNetworkImageProvider(imageAsset),
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
              filterQuality: FilterQuality.high,
              errorBuilder: (_, _, _) =>
                  const ColoredBox(color: AppColors.inputFill),
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
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 1,
    color: AppColors.white,
    shadows: [
      Shadow(color: Color(0x80000000), blurRadius: 8, offset: Offset(0, 2)),
    ],
  );

  static const _fingerLabelStyle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w400,
    fontSize: 20,
    height: 1,
    color: AppColors.white,
    shadows: [
      Shadow(color: Color(0x80000000), blurRadius: 8, offset: Offset(0, 2)),
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
