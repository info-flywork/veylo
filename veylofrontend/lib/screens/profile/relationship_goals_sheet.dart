import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_edit_sheet.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';

enum RelationshipGoal {
  longTermOpenToShort,
  longTermRelationship,
  newFriends,
  shortTermFun,
  stillFiguringItOut,
}

const _kItemExtent = 36.0;
const _kVisibleItems = 5;

/// Relationship Goals — görünüm sabit liste; kaydırınca ortadaki seçilir.
Future<RelationshipGoal?> showRelationshipGoalsSheet(
  BuildContext context, {
  RelationshipGoal initial = RelationshipGoal.newFriends,
}) {
  return showAppEditSheet<RelationshipGoal>(
    context: context,
    builder: (_) => _RelationshipGoalsSheet(initial: initial),
  );
}

class _RelationshipGoalsSheet extends StatefulWidget {
  const _RelationshipGoalsSheet({required this.initial});

  final RelationshipGoal initial;

  @override
  State<_RelationshipGoalsSheet> createState() =>
      _RelationshipGoalsSheetState();
}

class _RelationshipGoalsSheetState extends State<_RelationshipGoalsSheet> {
  late final FixedExtentScrollController _controller;
  late RelationshipGoal _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initial;
    _controller = FixedExtentScrollController(
      initialItem: RelationshipGoal.values.indexOf(widget.initial),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _label(Translations t, RelationshipGoal g) {
    final p = t.profile;
    return switch (g) {
      RelationshipGoal.longTermOpenToShort => p.goalLongTermOpenToShort,
      RelationshipGoal.longTermRelationship => p.goalLongTermRelationship,
      RelationshipGoal.newFriends => p.goalNewFriends,
      RelationshipGoal.shortTermFun => p.goalShortTermFun,
      RelationshipGoal.stillFiguringItOut => p.goalStillFiguringItOut,
    };
  }

  /// Figma: uçlar idle 16px, ortadakiler idle 20px.
  double _idleFontSize(RelationshipGoal option) {
    return switch (option) {
      RelationshipGoal.longTermOpenToShort ||
      RelationshipGoal.stillFiguringItOut =>
        16,
      _ => 20,
    };
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return AppEditSheet(
      title: t.profile.relationshipGoals,
      saveLabel: t.profile.save,
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
          // Düz görünüm — 3D tekerlek ölçeklemesi yok.
          diameterRatio: 100,
          perspective: 0.0001,
          useMagnifier: false,
          physics: const FixedExtentScrollPhysics(),
          onSelectedItemChanged: (index) {
            setState(() => _selected = RelationshipGoal.values[index]);
          },
          childDelegate: ListWheelChildBuilderDelegate(
            childCount: RelationshipGoal.values.length,
            builder: (context, index) {
              final option = RelationshipGoal.values[index];
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
