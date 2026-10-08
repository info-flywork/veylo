import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_edit_sheet.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';

enum ZodiacSign {
  aries('♈', 'Aries'),
  taurus('♉', 'Taurus'),
  gemini('♊', 'Gemini'),
  cancer('♋', 'Cancer'),
  leo('♌', 'Leo'),
  virgo('♍', 'Virgo'),
  libra('♎', 'Libra'),
  scorpio('♏', 'Scorpio'),
  sagittarius('♐', 'Sagittarius'),
  capricorn('♑', 'Capricorn'),
  aquarius('♒', 'Aquarius'),
  pisces('♓', 'Pisces');

  const ZodiacSign(this.symbol, this.label);

  final String symbol;
  final String label;
}

const _kItemExtent = 36.0;
const _kVisibleItems = 5;
const _kBadgeSize = 28.0;

/// Zodiac — Education ile aynı düz liste + yazı CSS; ortada seçili, üstünde önceki burç.
Future<ZodiacSign?> showZodiacSheet(
  BuildContext context, {
  ZodiacSign initial = ZodiacSign.gemini,
}) {
  return showAppEditSheet<ZodiacSign>(
    context: context,
    builder: (_) => _ZodiacSheet(initial: initial),
  );
}

class _ZodiacSheet extends StatefulWidget {
  const _ZodiacSheet({required this.initial});

  final ZodiacSign initial;

  @override
  State<_ZodiacSheet> createState() => _ZodiacSheetState();
}

class _ZodiacSheetState extends State<_ZodiacSheet> {
  late final FixedExtentScrollController _controller;
  late ZodiacSign _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initial;
    _controller = FixedExtentScrollController(
      initialItem: ZodiacSign.values.indexOf(widget.initial),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Education ile aynı: seçili 24 / komşu 20 / uç 16; idle #000@25%.
  double _fontSize({required bool selected, required int distance}) {
    if (selected) return 24;
    if (distance == 1) return 20;
    return 16;
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).profile;
    final selectedIndex = ZodiacSign.values.indexOf(_selected);

    return AppEditSheet(
      title: t.zodiac,
      saveLabel: t.save,
      onSave: () => Navigator.of(context).pop(_selected),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 12),
          SizedBox(
            height: _kItemExtent * _kVisibleItems,
            child: ListWheelScrollView.useDelegate(
              controller: _controller,
              itemExtent: _kItemExtent,
              diameterRatio: 100,
              perspective: 0.0001,
              useMagnifier: false,
              physics: const FixedExtentScrollPhysics(),
              onSelectedItemChanged: (index) {
                setState(() => _selected = ZodiacSign.values[index]);
              },
              childDelegate: ListWheelChildBuilderDelegate(
                childCount: ZodiacSign.values.length,
                builder: (context, index) {
                  final sign = ZodiacSign.values[index];
                  final selected = sign == _selected;
                  final distance = (index - selectedIndex).abs();
                  return GestureDetector(
                    onTap: () {
                      _controller.animateToItem(
                        index,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeOut,
                      );
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _ZodiacBadge(symbol: sign.symbol),
                          const SizedBox(width: 10),
                          AppText(
                            sign.label,
                            style: TextStyle(
                              fontFamily: AppFonts.poppins,
                              fontWeight: FontWeight.w500,
                              fontSize: _fontSize(
                                selected: selected,
                                distance: distance,
                              ),
                              height: 1,
                              color: selected
                                  ? AppColors.black
                                  : const Color(0x40000000),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Figma: mor rounded kare + beyaz burç sembolü.
class _ZodiacBadge extends StatelessWidget {
  const _ZodiacBadge({required this.symbol});

  final String symbol;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _kBadgeSize,
      height: _kBadgeSize,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.linkGradientStart,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        symbol,
        style: const TextStyle(
          fontSize: 15,
          height: 1,
          color: AppColors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
