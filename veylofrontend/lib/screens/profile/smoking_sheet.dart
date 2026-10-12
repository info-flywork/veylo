import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_edit_sheet.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';

enum SmokingPreference {
  nonSmoker,
  socialSmoker,
  smoker,
  tryingToQuit,
  smokerWhenDrinking,
  preferNotToSay,
}

const _kItemExtent = 36.0;
/// Ortada 1 + üstte 3 + altta 2 (Drinking ile aynı).
const _kVisibleItems = 6;

/// Smoking — Drinking ile aynı düz liste; varsayılan Trying to quit.
Future<SmokingPreference?> showSmokingSheet(
  BuildContext context, {
  SmokingPreference initial = SmokingPreference.tryingToQuit,
}) {
  return showAppEditSheet<SmokingPreference>(
    context: context,
    builder: (_) => _SmokingSheet(initial: initial),
  );
}

class _SmokingSheet extends StatefulWidget {
  const _SmokingSheet({required this.initial});

  final SmokingPreference initial;

  @override
  State<_SmokingSheet> createState() => _SmokingSheetState();
}

class _SmokingSheetState extends State<_SmokingSheet> {
  late final FixedExtentScrollController _controller;
  late SmokingPreference _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initial;
    final index = SmokingPreference.values.indexOf(widget.initial);
    _controller = FixedExtentScrollController(initialItem: index);
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

  String _label(Translations t, SmokingPreference p) {
    final profile = t.profile;
    return switch (p) {
      SmokingPreference.nonSmoker => profile.smokingNonSmoker,
      SmokingPreference.socialSmoker => profile.smokingSocialSmoker,
      SmokingPreference.smoker => profile.smokingSmoker,
      SmokingPreference.tryingToQuit => profile.smokingTryingToQuit,
      SmokingPreference.smokerWhenDrinking => profile.smokingWhenDrinking,
      SmokingPreference.preferNotToSay => profile.smokingPreferNotToSay,
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
    final selectedIndex = SmokingPreference.values.indexOf(_selected);

    return AppEditSheet(
      title: t.profile.smoking,
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
          clipBehavior: Clip.none,
          physics: const FixedExtentScrollPhysics(),
          onSelectedItemChanged: (index) {
            setState(() => _selected = SmokingPreference.values[index]);
          },
          childDelegate: ListWheelChildBuilderDelegate(
            childCount: SmokingPreference.values.length,
            builder: (context, index) {
              final option = SmokingPreference.values[index];
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
