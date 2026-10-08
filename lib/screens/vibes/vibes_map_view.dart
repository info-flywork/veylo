import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/core/widgets/avatar_ripple.dart';
import 'package:veylo/data/local/local_profile_store.dart';
import 'package:veylo/data/mock/profile_mock_repository.dart';
import 'package:veylo/data/mock/vibes_mock_repository.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/models/vibes/vibe_post.dart';
import 'package:veylo/screens/chat/widgets/chat_note_card.dart';
import 'package:veylo/screens/vibes/vibe_talk_sheet.dart';

class _BubbleSpec {
  const _BubbleSpec(this.size, this.asset, this.blurred);

  final double size;
  final String asset;
  final bool blurred;
}

class _PlacedBubble {
  const _PlacedBubble(this.cx, this.cy, this.spec, this.postIndex);

  final double cx;
  final double cy;
  final _BubbleSpec spec;
  final int postIndex;
}

/// Büyükten küçüğe — yerleşince boşluk kalır, üst üste binmez.
const _specs = <_BubbleSpec>[
  _BubbleSpec(96, AppAssets.fakePerson01, false),
  _BubbleSpec(88, AppAssets.fakePerson05, false),
  _BubbleSpec(84, AppAssets.fakePerson07, false),
  _BubbleSpec(80, AppAssets.fakePerson03, false),
  _BubbleSpec(76, AppAssets.fakePerson02, true),
  _BubbleSpec(72, AppAssets.fakePerson01, false),
  _BubbleSpec(70, AppAssets.fakePerson06, true),
  _BubbleSpec(66, AppAssets.fakePerson08, true),
  _BubbleSpec(64, AppAssets.fakePerson04, false),
  _BubbleSpec(62, AppAssets.fakePerson05, false),
  _BubbleSpec(58, AppAssets.fakePerson07, true),
  _BubbleSpec(56, AppAssets.fakePerson01, false),
  _BubbleSpec(54, AppAssets.fakePerson02, true),
  _BubbleSpec(52, AppAssets.fakePerson06, true),
  _BubbleSpec(50, AppAssets.fakePerson08, true),
  _BubbleSpec(48, AppAssets.fakePerson04, true),
  _BubbleSpec(74, AppAssets.fakePerson03, false),
  _BubbleSpec(68, AppAssets.fakePerson05, true),
  _BubbleSpec(60, AppAssets.fakePerson01, false),
  _BubbleSpec(46, AppAssets.fakePerson07, true),
  _BubbleSpec(90, AppAssets.fakePerson02, false),
  _BubbleSpec(82, AppAssets.fakePerson04, true),
  _BubbleSpec(78, AppAssets.fakePerson06, false),
  _BubbleSpec(74, AppAssets.fakePerson08, true),
  _BubbleSpec(72, AppAssets.fakePerson03, false),
  _BubbleSpec(70, AppAssets.fakePerson01, true),
  _BubbleSpec(68, AppAssets.fakePerson07, false),
  _BubbleSpec(66, AppAssets.fakePerson05, true),
  _BubbleSpec(64, AppAssets.fakePerson02, true),
  _BubbleSpec(62, AppAssets.fakePerson08, false),
  _BubbleSpec(60, AppAssets.fakePerson04, true),
  _BubbleSpec(58, AppAssets.fakePerson06, true),
  _BubbleSpec(56, AppAssets.fakePerson03, false),
  _BubbleSpec(54, AppAssets.fakePerson01, true),
  _BubbleSpec(52, AppAssets.fakePerson07, true),
  _BubbleSpec(50, AppAssets.fakePerson05, true),
  _BubbleSpec(50, AppAssets.fakePerson02, true),
  _BubbleSpec(48, AppAssets.fakePerson08, true),
  _BubbleSpec(46, AppAssets.fakePerson04, true),
  _BubbleSpec(44, AppAssets.fakePerson06, true),
];

const _kGap = 4.0;
const _kMapShift = 48.0;
const _kSelfAvatar = 80.0;
/// Sadece avatar gövdesi için boşluk — dalgalar diğer balonların üstüne binebilir.
const _kSelfClearRadius = _kSelfAvatar * 0.62;

/// Orta halkayı dolduran ekstra balonlar (kenar + rastgele paket yetmeyince).
const _centerSpecs = <_BubbleSpec>[
  _BubbleSpec(70, AppAssets.fakePerson05, false),
  _BubbleSpec(64, AppAssets.fakePerson01, false),
  _BubbleSpec(58, AppAssets.fakePerson07, true),
  _BubbleSpec(62, AppAssets.fakePerson03, false),
  _BubbleSpec(54, AppAssets.fakePerson02, true),
  _BubbleSpec(60, AppAssets.fakePerson08, false),
  _BubbleSpec(52, AppAssets.fakePerson04, true),
  _BubbleSpec(56, AppAssets.fakePerson06, true),
  _BubbleSpec(48, AppAssets.fakePerson01, true),
  _BubbleSpec(50, AppAssets.fakePerson05, false),
  _BubbleSpec(46, AppAssets.fakePerson07, true),
  _BubbleSpec(54, AppAssets.fakePerson03, true),
];

List<_PlacedBubble> _pack(double width, double height) {
  final random = math.Random(7);
  final placed = <_PlacedBubble>[];
  final selfCx = width / 2;
  final selfCy = height * 0.48;

  bool hitsSelf(double cx, double cy, double radius) {
    final dx = cx - selfCx;
    final dy = cy - selfCy;
    final min = radius + _kSelfClearRadius + _kGap;
    return dx * dx + dy * dy < min * min;
  }

  bool overlapsAny(double cx, double cy, double radius) {
    return placed.any((other) {
      final dx = other.cx - cx;
      final dy = other.cy - cy;
      final min = radius + other.spec.size / 2 + _kGap;
      return dx * dx + dy * dy < min * min;
    });
  }

  bool tryPlace(_BubbleSpec spec, double cx, double cy, int postIndex) {
    final radius = spec.size / 2;
    if (cx < radius - 8 ||
        cy < radius - 8 ||
        cx > width - radius + 8 ||
        cy > height - radius + 8) {
      return false;
    }
    if (hitsSelf(cx, cy, radius) || overlapsAny(cx, cy, radius)) return false;
    placed.add(_PlacedBubble(cx, cy, spec, postIndex));
    return true;
  }

  // Ekranın kenarlarından taşan, yarısı kesik balonlar (figma gibi).
  const edgeSpecs = <_BubbleSpec>[
    _BubbleSpec(84, AppAssets.fakePerson06, true),
    _BubbleSpec(74, AppAssets.fakePerson03, false),
    _BubbleSpec(90, AppAssets.fakePerson04, true),
    _BubbleSpec(92, AppAssets.fakePerson02, true),
  ];
  if (width > 140 && height > 160) {
    tryPlace(edgeSpecs[0], edgeSpecs[0].size * 0.10, height * 0.09,
        _specs.length);
    tryPlace(edgeSpecs[1], edgeSpecs[1].size * 0.06, height * 0.52,
        _specs.length + 1);
    tryPlace(edgeSpecs[2], edgeSpecs[2].size * 0.14, height * 0.90,
        _specs.length + 2);
    tryPlace(edgeSpecs[3], width - edgeSpecs[3].size * 0.14, height * 0.86,
        _specs.length + 3);
  }

  // Orta halka — boş Atlantik bölgesini doldur (self etrafında 2 ring).
  var centerIdx = 0;
  for (var ring = 0; ring < 2; ring++) {
    final ringR = _kSelfAvatar * (0.95 + ring * 0.55);
    final count = ring == 0 ? 6 : 8;
    for (var k = 0; k < count && centerIdx < _centerSpecs.length; k++) {
      final spec = _centerSpecs[centerIdx];
      final angle = -math.pi / 2 + (k / count) * math.pi * 2 + ring * 0.18;
      final cx = selfCx + math.cos(angle) * ringR;
      final cy = selfCy + math.sin(angle) * ringR * 0.92;
      if (tryPlace(
        spec,
        cx,
        cy,
        _specs.length + 10 + centerIdx,
      )) {
        centerIdx++;
      }
    }
  }

  // Kalan merkez boşluklarına küçük balon sıkıştır.
  for (var i = 0; i < 10; i++) {
    final spec = _centerSpecs[i % _centerSpecs.length];
    for (var attempt = 0; attempt < 100; attempt++) {
      // Merkez elips: x %25–75, y %28–68
      final cx = width * (0.25 + random.nextDouble() * 0.50);
      final cy = height * (0.28 + random.nextDouble() * 0.40);
      if (tryPlace(spec, cx, cy, _specs.length + 40 + i)) break;
    }
  }

  final bands = List<int>.generate(_specs.length, (i) => i)..shuffle(random);

  for (var i = 0; i < _specs.length; i++) {
    final spec = _specs[i];
    final radius = spec.size / 2;
    const edge = 4.0;
    if (width <= spec.size + edge * 2 || height <= spec.size + edge * 2) {
      continue;
    }
    final band = bands[i];
    final bandH = height / _specs.length;
    final yCenter = (band + 0.5) * bandH;
    final yMin = math.max(radius + edge, yCenter - bandH);
    final yMax = math.min(height - radius - edge, yCenter + bandH);

    // İlk denemelerde merkeze yakın x tercih et.
    for (var attempt = 0; attempt < 180; attempt++) {
      final preferCenter = attempt < 90;
      final cx = preferCenter
          ? width * (0.22 + random.nextDouble() * 0.56)
          : radius +
              edge +
              random.nextDouble() * (width - spec.size - edge * 2);
      final cy = yMin + random.nextDouble() * math.max(1, yMax - yMin);
      if (tryPlace(spec, cx, cy, i)) break;
    }
  }
  return placed;
}

/// Siyah zemin saydam, mor kıtalar soluk lavanta kalsın.
const _kMapColor = ColorFilter.matrix(<double>[
  1, 0, 0, 0, 0,
  0, 1, 0, 0, 0,
  0, 0, 1, 0, 0,
  1, 1, 1, 0, 0,
]);

/// Vibes haritası — balona basınca önizleme kartı açılır.
class VibesMapView extends StatefulWidget {
  const VibesMapView({super.key});

  @override
  State<VibesMapView> createState() => _VibesMapViewState();
}

class _VibesMapViewState extends State<VibesMapView> {
  int? _selected;
  final Set<String> _likedIds = {};

  @override
  Widget build(BuildContext context) {
    final safeBottom = MediaQuery.paddingOf(context).bottom;
    final posts = VibesMockRepository.posts();

    return LayoutBuilder(
      builder: (context, constraints) {
        final mapW = constraints.maxWidth;
        final mapH = constraints.maxHeight;
        final bottomGap = safeBottom + 12;
        final usableH = (mapH - _kMapShift - bottomGap).clamp(0.0, mapH);
        final bubbles = _pack(mapW, usableH)
            .map(
              (b) => _PlacedBubble(
                b.cx,
                b.cy + _kMapShift,
                b.spec,
                b.postIndex,
              ),
            )
            .toList();
        final _PlacedBubble? selected = _selected == null
            ? null
            : bubbles.where((b) => b.postIndex == _selected).firstOrNull;

        final self = LocalProfileStore.instance
            .apply(ProfileMockRepository.currentUser());
        final selfCx = mapW / 2;
        final selfCy = _kMapShift + usableH * 0.48;
        // Dalgalar taşsın diye clip yok; harita katmanı kendi alanında kalır.
        return Stack(
          clipBehavior: Clip.none,
          children: [
            const Positioned.fill(child: ColoredBox(color: Color(0xFFFFFFFF))),
            Positioned(
              top: _kMapShift,
              left: 0,
              right: 0,
              bottom: -_kMapShift,
              child: GestureDetector(
                onTap: () => setState(() => _selected = null),
                child: ClipRect(
                  child: Opacity(
                    opacity: 0.22,
                    child: ColorFiltered(
                      colorFilter: _kMapColor,
                      child: Image.asset(
                        AppAssets.vibesMap,
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            for (final bubble in bubbles)
              Positioned(
                left: bubble.cx - bubble.spec.size / 2,
                top: bubble.cy - bubble.spec.size / 2,
                width: bubble.spec.size,
                height: bubble.spec.size,
                child: GestureDetector(
                  onTap: () => setState(() {
                    _selected = _selected == bubble.postIndex
                        ? null
                        : bubble.postIndex;
                  }),
                  child: _PersonBubble(spec: bubble.spec),
                ),
              ),
            // Figma: merkez kullanıcı + lavanta radar dalgaları
            Positioned(
              left: selfCx - _kSelfAvatar / 2,
              top: selfCy - _kSelfAvatar / 2,
              width: _kSelfAvatar,
              height: _kSelfAvatar,
              child: AvatarRipple(
                size: _kSelfAvatar,
                ringCount: 4,
                maxScale: 2.85,
                peakOpacity: 0.14,
                color: const Color(0xFF998FED),
                child: ClipOval(
                  child: ChatAvatarImage(
                    url: self.avatarUrl,
                    size: _kSelfAvatar,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            if (selected != null)
              Positioned(
                left: _cardLeft(selected, mapW),
                top: _cardTop(selected, mapH - bottomGap),
                width: _cardWidth(mapW),
                child: Builder(
                  builder: (context) {
                    final post = posts[selected.postIndex % posts.length];
                    final liked = _likedIds.contains(post.id);
                    return _VibePreviewCard(
                      post: post,
                      liked: liked,
                      sendLabel: Translations.of(context).vibes.sendMessage,
                      onLike: () => setState(() {
                        if (liked) {
                          _likedIds.remove(post.id);
                        } else {
                          _likedIds.add(post.id);
                        }
                      }),
                      onSend: () => showVibeTalkSheet(context, post),
                    );
                  },
                ),
              ),
          ],
        );
      },
    );
  }

  double _cardWidth(double mapW) => math.min(379, mapW - 32);

  double _cardLeft(_PlacedBubble bubble, double mapW) {
    final width = _cardWidth(mapW);
    final left = bubble.cx - width / 2;
    return left.clamp(16.0, math.max(16.0, mapW - 16 - width));
  }

  double _cardTop(_PlacedBubble bubble, double usableH) {
    const cardH = 108.0;
    const gap = 8.0;
    // Öncelik: balonun hemen altı; sığmazsa üstüne düş.
    final below = bubble.cy + bubble.spec.size / 2 + gap;
    if (below + cardH <= usableH) return below;
    final above = bubble.cy - bubble.spec.size / 2 - gap - cardH;
    if (above >= 8) return above;
    return math.max(8.0, usableH - cardH);
  }
}

class _VibePreviewCard extends StatelessWidget {
  const _VibePreviewCard({
    required this.post,
    required this.liked,
    required this.sendLabel,
    required this.onLike,
    required this.onSend,
  });

  final VibePost post;
  final bool liked;
  final String sendLabel;
  final VoidCallback onLike;
  final VoidCallback onSend;

  static const _likedGreen = Color(0xFF33C658);

  static const _dateStyle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    height: 16 / 12,
    letterSpacing: 0,
    color: Color(0xA6000000),
  );

  @override
  Widget build(BuildContext context) {
    final likes = post.likeCount + (liked ? 1 : 0);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x40000000),
            offset: Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: AppText(
                    post.name,
                    style: AppTextStyles.vibesName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 10),
                AppText(post.dateLabel, style: _dateStyle),
              ],
            ),
            AppText(post.body, style: AppTextStyles.vibesQuote),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: onLike,
                    behavior: HitTestBehavior.opaque,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          AppAssets.iconOkeyHand,
                          width: 24,
                          height: 24,
                          colorFilter: liked
                              ? const ColorFilter.mode(
                                  _likedGreen,
                                  BlendMode.srcIn,
                                )
                              : null,
                        ),
                        const SizedBox(width: 4),
                        AppText(
                          '$likes',
                          style: liked
                              ? AppTextStyles.vibesMeta.copyWith(
                                  color: _likedGreen,
                                )
                              : AppTextStyles.vibesMeta,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 18),
                  GestureDetector(
                    onTap: onSend,
                    behavior: HitTestBehavior.opaque,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          AppAssets.iconMessagesBalloon,
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(width: 4),
                        AppText(sendLabel, style: AppTextStyles.vibesMeta),
                      ],
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

class _PersonBubble extends StatelessWidget {
  const _PersonBubble({required this.spec});

  final _BubbleSpec spec;

  @override
  Widget build(BuildContext context) {
    final image = Image.asset(
      spec.asset,
      width: spec.size,
      height: spec.size,
      fit: BoxFit.cover, // daire tam dolsun (yuvarlak kalsın)
      alignment: const Alignment(0, -0.55), // üstten kırp -> kafalar kesilmesin
    );

    return ClipOval(
      child: SizedBox(
        width: spec.size,
        height: spec.size,
        child: spec.blurred
            ? ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Transform.scale(scale: 1.35, child: image),
              )
            : image,
      ),
    );
  }
}
