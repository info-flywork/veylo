import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_edit_sheet.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/screens/profile/widgets/picker_clear_action.dart';

enum EducationLevel {
  highSchool,
  associates,
  bachelors,
  masters,
  phd,
}

const _kItemExtent = 36.0;
const _kVisibleItems = 5;

/// Education — Relationship Goals ile aynı: düz liste görünümü, kaydırınca seçim.
/// Sonuç: [PickedValue.value] null ise kullanıcı değeri temizledi.
Future<PickedValue<EducationLevel>?> showEducationSheet(
  BuildContext context, {
  EducationLevel initial = EducationLevel.bachelors,
}) {
  return showAppEditSheet<PickedValue<EducationLevel>>(
    context: context,
    builder: (_) => _EducationSheet(initial: initial),
  );
}

class _EducationSheet extends StatefulWidget {
  const _EducationSheet({required this.initial});

  final EducationLevel initial;

  @override
  State<_EducationSheet> createState() => _EducationSheetState();
}

class _EducationSheetState extends State<_EducationSheet> {
  late final FixedExtentScrollController _controller;
  late EducationLevel _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initial;
    _controller = FixedExtentScrollController(
      initialItem: EducationLevel.values.indexOf(widget.initial),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _label(Translations t, EducationLevel level) {
    final p = t.profile;
    return switch (level) {
      EducationLevel.highSchool => p.educationHighSchool,
      EducationLevel.associates => p.educationAssociates,
      EducationLevel.bachelors => p.educationBachelors,
      EducationLevel.masters => p.educationMasters,
      EducationLevel.phd => p.educationPhd,
    };
  }

  /// İlk ve son 16px, ortadakiler 20px (idle).
  double _idleFontSize(EducationLevel option) {
    return switch (option) {
      EducationLevel.highSchool || EducationLevel.phd => 16,
      _ => 20,
    };
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return AppEditSheet(
      title: t.profile.education,
      saveLabel: t.profile.save,
      onSave: () => Navigator.of(context).pop(PickedValue(_selected)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
                setState(() => _selected = EducationLevel.values[index]);
              },
              childDelegate: ListWheelChildBuilderDelegate(
                childCount: EducationLevel.values.length,
                builder: (context, index) {
                  final option = EducationLevel.values[index];
                  final selected = option == _selected;
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
                          fontSize: selected ? 24 : _idleFontSize(option),
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
        ],
      ),
    );
  }
}
