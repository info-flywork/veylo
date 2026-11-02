import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/screens/chat/chat_sticker_pack.dart';

/// Çıkartma seçici (hikâye editörü koyu, canlı oda açık); seçilen asset yolunu döner.
Future<String?> showStoryStickerSheet(
  BuildContext context, {
  bool dark = true,
}) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    backgroundColor: dark ? const Color(0xFF1C1C1E) : AppColors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => _StoryStickerSheet(dark: dark),
  );
}

class _StoryStickerSheet extends StatelessWidget {
  const _StoryStickerSheet({required this.dark});

  final bool dark;

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.paddingOf(context).bottom;
    final height = MediaQuery.sizeOf(context).height * 0.5;
    final stickers = [for (final list in chatStickerPack.values) ...list];

    return SizedBox(
      height: height + bottom,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 10, 16, bottom),
        child: Column(
          children: [
            Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: dark
                    ? AppColors.white.withValues(alpha: 0.25)
                    : AppColors.progressTrack,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.only(bottom: 16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: stickers.length,
                itemBuilder: (context, index) {
                  final asset = stickers[index];
                  return GestureDetector(
                    onTap: () => Navigator.of(context).pop(asset),
                    behavior: HitTestBehavior.opaque,
                    child: Image.asset(asset, fit: BoxFit.contain),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
