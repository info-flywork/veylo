import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/i18n/strings.g.dart';

const _kItemFill = Color(0x0D998FED); // #998FED @ 5%
const _kItemBorder = Color(0x3383A0B4); // #83A0B4 @ 20%

/// SSS / F.A.Q & Help bottom sheet.
Future<void> showFaqHelpSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const FaqHelpSheet(),
  );
}

class FaqHelpSheet extends StatefulWidget {
  const FaqHelpSheet({super.key});

  @override
  State<FaqHelpSheet> createState() => _FaqHelpSheetState();
}

class _FaqHelpSheetState extends State<FaqHelpSheet> {
  int? _expandedIndex = 0;

  List<({String q, String a})> _items(Translations$faq$tr f) => [
    (q: f.q1, a: f.a1),
    (q: f.q2, a: f.a2),
    (q: f.q3, a: f.a3),
    (q: f.q4, a: f.a4),
    (q: f.q5, a: f.a5),
    (q: f.q6, a: f.a6),
    (q: f.q7, a: f.a7),
    (q: f.q8, a: f.a8),
    (q: f.q9, a: f.a9),
    (q: f.q10, a: f.a10),
    (q: f.q11, a: f.a11),
    (q: f.q12, a: f.a12),
    (q: f.q13, a: f.a13),
    (q: f.q14, a: f.a14),
  ];

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).profile;
    final bottom = MediaQuery.viewPaddingOf(context).bottom;
    final items = _items(Translations.of(context).faq);
    final sheetHeight = MediaQuery.sizeOf(context).height * 0.90;

    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: sheetHeight,
        width: double.infinity,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Padding(
          padding: EdgeInsets.fromLTRB(16, 10, 16, 10 + bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 46,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.sheetHandle,
                    borderRadius: BorderRadius.circular(9999),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                t.faqHelp,
                style: const TextStyle(
                  fontFamily: AppFonts.poppins,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  height: 1,
                  letterSpacing: 20 * -0.02,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: items.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    final expanded = _expandedIndex == index;
                    return _FaqItem(
                      question: item.q,
                      answer: item.a,
                      expanded: expanded,
                      onTap: () {
                        setState(() {
                          _expandedIndex = expanded ? null : index;
                        });
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          ),
        ),
      ),
    );
  }
}

class _FaqItem extends StatelessWidget {
  const _FaqItem({
    required this.question,
    required this.answer,
    required this.expanded,
    required this.onTap,
  });

  final String question;
  final String answer;
  final bool expanded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: _kItemFill,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _kItemBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 30,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      question,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: AppFonts.poppins,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 20 / 16,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                  Icon(
                    expanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    size: 22,
                    color: AppColors.black,
                  ),
                ],
              ),
            ),
            if (expanded) ...[
              const SizedBox(height: 10),
              Text(
                answer,
                style: const TextStyle(
                  fontFamily: AppFonts.poppins,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 20 / 14,
                  color: Color(0xA6000000),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
