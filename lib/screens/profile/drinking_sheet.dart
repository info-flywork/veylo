import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_edit_sheet.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';

enum DrinkingPreference {
  never,
  specialOccasions,
  socially,
  frequently,
  sober,
  preferNotToSay,
}

const _kItemExtent = 36.0;
/// Ortada 1 + üstte 3 + altta 2 (tam 6 satır — altta ekstra boşluk yok).
const _kVisibleItems = 6;

/// Drinking — Pets ile aynı düz liste; varsayılan Frequently.
Future<DrinkingPreference?> showDrinkingSheet(
  BuildContext context, {
  DrinkingPreference initial = DrinkingPreference.frequently,
}) {
  return showAppEditSheet<DrinkingPreference>(
    context: context,
    builder: (_) => _DrinkingSheet(initial: initial),
  );
}

class _DrinkingSheet extends StatefulWidget {
  const _DrinkingSheet({required this.initial});

  final DrinkingPreference initial;

  @override
  State<_DrinkingSheet> createState() => _DrinkingSheetState();
}

class _DrinkingSheetState extends State<_DrinkingSheet> {
  late final FixedExtentScrollController _controller;
  late DrinkingPreference _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initial;
    final index = DrinkingPreference.values.indexOf(widget.initial);
    _controller = FixedExtentScrollController(initialItem: index);
    // Hot reload / ilk açılışta ortada kalsın.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_controller.hasClients) return;
      _controller.jumpToItem(index);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _label(Translations t, DrinkingPreference p) {
    final profile = t.profile;
    return switch (p) {
      DrinkingPreference.never => profile.drinkingNever,
      DrinkingPreference.specialOccasions => profile.drinkingSpecialOccasions,
      DrinkingPreference.socially => profile.drinkingSocially,
      DrinkingPreference.frequently => profile.drinkingFrequently,
      DrinkingPreference.sober => profile.drinkingSober,
      DrinkingPreference.preferNotToSay => profile.drinkingPreferNotToSay,
    };
  }

  /// Seçili 24 / komşu 20 / orta 16 / en uç 14; idle #000@25%.
  double _fontSize({required bool selected, required int distance}) {
    if (selected) return 24;
    if (distance >= 3) return 14;
    if (distance == 2) return 16;
    return 20;
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final selectedIndex = DrinkingPreference.values.indexOf(_selected);

    return AppEditSheet(
      title: t.profile.drinking,
      saveLabel: t.profile.save,
      onSave: () => Navigator.of(context).pop(_selected),
      afterChildGap: 15,
      child: SizedBox(
        height: _kItemExtent * _kVisibleItems,
        child: ListWheelScrollView.useDelegate(
          controller: _controller,
          itemExtent: _kItemExtent,
          diameterRatio: 100,
          perspective: 0.0001,
          useMagnifier: false,
          // Never üstte biraz taşabilir; altta Prefer not to say–buton boşluğu şişmesin.
          clipBehavior: Clip.none,
          physics: const FixedExtentScrollPhysics(),
          onSelectedItemChanged: (index) {
            setState(() => _selected = DrinkingPreference.values[index]);
          },
          childDelegate: ListWheelChildBuilderDelegate(
            childCount: DrinkingPreference.values.length,
            builder: (context, index) {
              final option = DrinkingPreference.values[index];
              final selected = option == _selected;
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
                  child: AppText(
                    _label(t, option),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
