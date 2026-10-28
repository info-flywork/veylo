import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/errors/error_messages.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';

/// Anonim sohbet — Connection Progress bottom sheet.
Future<void> showConnectionProgressSheet(
  BuildContext context, {
  required int progress,
  Future<void> Function(String milestone)? onRequest,
}) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: AppColors.white,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => ConnectionProgressSheet(
      progress: progress,
      onRequest: onRequest,
    ),
  );
}

class ConnectionProgressSheet extends StatefulWidget {
  const ConnectionProgressSheet({
    super.key,
    required this.progress,
    this.onRequest,
  });

  final int progress;
  final Future<void> Function(String milestone)? onRequest;

  @override
  State<ConnectionProgressSheet> createState() => _ConnectionProgressSheetState();
}

class _ConnectionProgressSheetState extends State<ConnectionProgressSheet> {
  final Set<String> _sent = {};
  String? _busy;

  Future<void> _request(String id) async {
    final send = widget.onRequest;
    if (send == null || _busy != null || _sent.contains(id)) return;
    setState(() => _busy = id);
    try {
      await send(id);
      if (mounted) setState(() => _sent.add(id));
    } catch (e) {
      if (mounted) showErrorSnackBar(context, e);
    } finally {
      if (mounted) setState(() => _busy = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).chats;
    final bottom = MediaQuery.viewPaddingOf(context).bottom;
    final milestones = [
      (
        id: 'initial',
        title: t.milestoneInitial,
        hintUnlocked: t.milestoneInitialHint,
        hintLocked: t.milestoneInitialLocked,
        at: 25,
      ),
      (
        id: 'photo',
        title: t.milestonePhoto,
        hintUnlocked: t.milestonePhotoHint,
        hintLocked: t.milestonePhotoHint,
        at: 70,
      ),
      (
        id: 'full',
        title: t.milestoneFull,
        hintUnlocked: t.milestoneFullHint,
        hintLocked: t.milestoneFullHint,
        at: 100,
      ),
    ];

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 36,
            child: Stack(
              alignment: Alignment.center,
              children: [
                AppText(
                  t.connectionProgressTitle,
                  style: const TextStyle(
                    fontFamily: AppFonts.poppins,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    height: 1,
                    letterSpacing: 20 * -0.02,
                    color: AppColors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    behavior: HitTestBehavior.opaque,
                    child: SizedBox(
                      width: 36,
                      height: 36,
                      child: Center(
                        child: SvgPicture.asset(
                          AppAssets.iconClose,
                          width: 28,
                          height: 28,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          for (var i = 0; i < milestones.length; i++) ...[
            if (i > 0)
              const Divider(height: 1, thickness: 1, color: Color(0xFFE8E8E8)),
            _MilestoneRow(
              title: milestones[i].title,
              subtitle: widget.progress >= milestones[i].at
                  ? milestones[i].hintUnlocked
                  : milestones[i].hintLocked,
              unlocked: widget.progress >= milestones[i].at,
              requestLabel: _sent.contains(milestones[i].id) ? 'Sent' : 'Request',
              busy: _busy == milestones[i].id,
              onRequest: widget.onRequest == null || _sent.contains(milestones[i].id)
                  ? null
                  : () => _request(milestones[i].id),
            ),
          ],
        ],
      ),
    );
  }
}

class _MilestoneRow extends StatelessWidget {
  const _MilestoneRow({
    required this.title,
    required this.subtitle,
    required this.unlocked,
    required this.requestLabel,
    required this.busy,
    this.onRequest,
  });

  final String title;
  final String subtitle;
  final bool unlocked;
  final String requestLabel;
  final bool busy;
  final VoidCallback? onRequest;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: unlocked
                  ? AppColors.selectionBorder
                  : const Color(0xFFD9D9D9),
            ),
            alignment: Alignment.center,
            child: unlocked
                ? const Icon(Icons.check_rounded, size: 14, color: AppColors.white)
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  title,
                  style: const TextStyle(
                    fontFamily: AppFonts.poppins,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    height: 18 / 16,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 2),
                AppText(
                  subtitle,
                  style: const TextStyle(
                    fontFamily: AppFonts.poppins,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    height: 20 / 14,
                    color: Color(0xA6000000),
                  ),
                ),
              ],
            ),
          ),
          if (onRequest != null || requestLabel == 'Sent')
            GestureDetector(
              onTap: busy ? null : onRequest,
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: AppText(
                  busy ? '...' : requestLabel,
                  style: const TextStyle(
                    fontFamily: AppFonts.poppins,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    height: 1,
                    color: AppColors.selectionBorder,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
