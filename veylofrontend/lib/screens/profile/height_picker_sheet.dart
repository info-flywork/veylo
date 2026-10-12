import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';

const _kMinCm = 140;
const _kMaxCm = 220;
const _kDefaultCm = 177;
const _kItemExtent = 44.0;
const _kBtnColor = Color(0xFF1A1714);

/// Height tekerlek picker — seçilen cm değerini döner.
Future<int?> showHeightPickerSheet(
  BuildContext context, {
  int? initialCm,
}) {
  return showModalBottomSheet<int>(
    context: context,
    backgroundColor: AppColors.white,
    isScrollControlled: true,
    useSafeArea: false,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => HeightPickerSheet(initialCm: initialCm ?? _kDefaultCm),
  );
}

class HeightPickerSheet extends StatefulWidget {
  const HeightPickerSheet({super.key, required this.initialCm});

  final int initialCm;

  @override
  State<HeightPickerSheet> createState() => _HeightPickerSheetState();
}

class _HeightPickerSheetState extends State<HeightPickerSheet> {
  late final FixedExtentScrollController _controller;
  late int _selectedCm;

  static final _values =
      List<int>.generate(_kMaxCm - _kMinCm + 1, (i) => _kMinCm + i);

  @override
  void initState() {
    super.initState();
    _selectedCm = widget.initialCm.clamp(_kMinCm, _kMaxCm);
    _controller = FixedExtentScrollController(
      initialItem: _selectedCm - _kMinCm,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).profile;
    final bottom = MediaQuery.viewPaddingOf(context).bottom;

    // SafeArea + viewPadding birlikte çift boşluk yaratıyordu; sadece bir kez ekle.
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 10, 16, 16 + bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
            const SizedBox(height: 16),
            AppText(
              t.height,
              style: const TextStyle(
                fontFamily: AppFonts.poppins,
                fontWeight: FontWeight.w600,
                fontSize: 20,
                height: 1,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: _kItemExtent * 5,
              child: ListWheelScrollView.useDelegate(
                controller: _controller,
                itemExtent: _kItemExtent,
                diameterRatio: 1.8,
                perspective: 0.002,
                physics: const FixedExtentScrollPhysics(),
                onSelectedItemChanged: (index) {
                  setState(() => _selectedCm = _values[index]);
                },
                childDelegate: ListWheelChildBuilderDelegate(
                  childCount: _values.length,
                  builder: (context, index) {
                    final cm = _values[index];
                    final selected = cm == _selectedCm;
                    return Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppText(
                            t.heightCm(value: cm),
                            style: TextStyle(
                              fontFamily: AppFonts.poppins,
                              fontWeight: FontWeight.w500,
                              fontSize: selected ? 24 : 20,
                              height: 1,
                              color: selected
                                  ? AppColors.textPrimary
                                  : const Color(0x40000000),
                            ),
                          ),
                          if (selected) ...[
                            const SizedBox(width: 8),
                            SvgPicture.asset(
                              AppAssets.iconEpArrowLeft,
                              width: 16,
                              height: 16,
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: Material(
                color: _kBtnColor,
                borderRadius: BorderRadius.circular(999),
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(_selectedCm),
                  borderRadius: BorderRadius.circular(999),
                  child: Center(
                    child: AppText(
                      t.save,
                      style: const TextStyle(
                        fontFamily: AppFonts.poppins,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        height: 1,
                        letterSpacing: 16 * -0.02,
                        color: AppColors.white,
                      ),
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
