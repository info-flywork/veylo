import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_edit_sheet.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';

enum ProfileGender {
  female,
  male,
  preferNotToSay,
}

/// Gender seçenek listesi ile [AppEditSheet].
Future<ProfileGender?> showGenderSheet(
  BuildContext context, {
  ProfileGender initial = ProfileGender.male,
}) {
  return showAppEditSheet<ProfileGender>(
    context: context,
    builder: (_) => _GenderSheet(initial: initial),
  );
}

class _GenderSheet extends StatefulWidget {
  const _GenderSheet({required this.initial});

  final ProfileGender initial;

  @override
  State<_GenderSheet> createState() => _GenderSheetState();
}

class _GenderSheetState extends State<_GenderSheet> {
  late ProfileGender _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initial;
  }

  String _label(Translations t, ProfileGender g) {
    final p = t.profile;
    return switch (g) {
      ProfileGender.female => p.genderFemale,
      ProfileGender.male => p.genderMale,
      ProfileGender.preferNotToSay => p.genderPreferNotToSay,
    };
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return AppEditSheet(
      title: t.profile.gender,
      saveLabel: t.profile.save,
      onSave: () => Navigator.of(context).pop(_selected),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final (i, option) in ProfileGender.values.indexed) ...[
              if (i > 0) const SizedBox(height: 16),
              GestureDetector(
                onTap: () => setState(() => _selected = option),
                behavior: HitTestBehavior.opaque,
                child: SizedBox(
                  height: 30,
                  width: double.infinity,
                  child: Center(
                    child: AppText(
                      _label(t, option),
                      style: option == _selected
                          ? AppTextStyles.editSheetOptionSelected
                          : AppTextStyles.editSheetOptionIdle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
