import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_primary_button.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';

enum VibeComposeMode { share, reply }

/// Share sheet sonucu — listeye fake vibe eklemek için.
class VibeShareDraft {
  const VibeShareDraft({required this.body, required this.anonymous});

  final String body;
  final bool anonymous;
}

/// Vibe Paylaş — yeni vibe yaz; gönderilince draft döner.
Future<VibeShareDraft?> showVibeShareSheet(BuildContext context) {
  return showModalBottomSheet<VibeShareDraft>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    useSafeArea: false,
    builder: (context) => const _VibeComposeSheet(mode: VibeComposeMode.share),
  );
}

/// Vibe'a Cevap Ver — gönderilen metni döner (iptalde null).
Future<String?> showVibeReplySheet(BuildContext context) {
  return showModalBottomSheet<String>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    useSafeArea: false,
    builder: (context) => const _VibeComposeSheet(mode: VibeComposeMode.reply),
  );
}

class _VibeComposeSheet extends StatefulWidget {
  const _VibeComposeSheet({required this.mode});

  final VibeComposeMode mode;

  @override
  State<_VibeComposeSheet> createState() => _VibeComposeSheetState();
}

class _VibeComposeSheetState extends State<_VibeComposeSheet> {
  final _controller = TextEditingController();
  bool _anonymous = true;

  static const _titleStyle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w600,
    fontSize: 24,
    height: 36 / 24,
    letterSpacing: -0.48,
    color: Color(0xFF000000),
  );

  static const _hintStyle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 20 / 16,
    letterSpacing: 0,
    color: Color(0xFF7E8896),
  );

  static const _countStyle = TextStyle(
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 0,
    color: Color(0xFF7E8896),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSend() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    if (widget.mode == VibeComposeMode.reply) {
      Navigator.of(context).pop(text);
      return;
    }
    Navigator.of(context).pop(
      VibeShareDraft(body: text, anonymous: _anonymous),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final bottom = MediaQuery.viewPaddingOf(context).bottom;
    final keyboard = MediaQuery.viewInsetsOf(context).bottom;
    final title = widget.mode == VibeComposeMode.reply
        ? t.vibes.replyTitle
        : t.vibes.shareTitle;
    final canSend = _controller.text.trim().isNotEmpty;

    return Padding(
      padding: EdgeInsets.only(bottom: keyboard),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 36,
              child: Row(
                children: [
                  Expanded(
                    child: AppText(title, style: _titleStyle),
                  ),
                  _SheetCloseButton(onTap: () => Navigator.of(context).pop()),
                ],
              ),
            ),
            const SizedBox(height: 12),
            _ShareField(
              controller: _controller,
              hint: t.vibes.shareHint,
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppAssets.iconPrivateLock,
                      width: 24,
                      height: 24,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFF7E8896),
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: AppText(
                        t.vibes.shareAnonymous,
                        style: _hintStyle,
                      ),
                    ),
                    Switch.adaptive(
                      value: _anonymous,
                      activeTrackColor: const Color(0xFF34C759),
                      onChanged: (value) => setState(() => _anonymous = value),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            AppPrimaryButton(
              label: t.vibes.sendMessage,
              onPressed: canSend ? _onSend : null,
            ),
          ],
        ),
      ),
    );
  }
}

class _ShareField extends StatelessWidget {
  const _ShareField({
    required this.controller,
    required this.hint,
    required this.onChanged,
  });

  final TextEditingController controller;
  final String hint;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0x0D998FED),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0x3383A0B4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              maxLength: 160,
              maxLines: null,
              expands: true,
              buildCounter:
                  (_, {required currentLength, required isFocused, maxLength}) =>
                      null,
              style: _VibeComposeSheetState._hintStyle.copyWith(
                color: const Color(0xFF000000),
              ),
              cursorColor: AppColors.brandPurple,
              decoration: InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                hintText: hint,
                hintStyle: _VibeComposeSheetState._hintStyle,
              ),
            ),
          ),
          AppText(
            '${controller.text.length}/160',
            style: _VibeComposeSheetState._countStyle,
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }
}

class _SheetCloseButton extends StatelessWidget {
  const _SheetCloseButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SvgPicture.asset(
        AppAssets.iconClose,
        width: 26.67,
        height: 26.67,
      ),
    );
  }
}
