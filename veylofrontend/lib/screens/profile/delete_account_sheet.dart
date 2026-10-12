import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/i18n/strings.g.dart';

const _createRequestRed = Color(0xFFEC1C24);

/// Hesap silme talebi bottom sheet'i (zovi delete_account_sheet karşılığı).
/// Sebep string döner (boş olabilir); iptalde `null`.
Future<String?> showDeleteAccountSheet(BuildContext context) async {
  final reason = await showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => const DeleteAccountSheet(),
  );
  if (reason == null || !context.mounted) return null;

  // Sebep sheet kapansın, sonra onay sheet açılsın (üst üste binmesin).
  final confirmed = await showDeleteAccountConfirmSheet(context);
  if (!confirmed) return null;
  return reason;
}

class DeleteAccountSheet extends StatefulWidget {
  const DeleteAccountSheet({super.key});

  @override
  State<DeleteAccountSheet> createState() => _DeleteAccountSheetState();
}

class _DeleteAccountSheetState extends State<DeleteAccountSheet> {
  var _step = 0;
  final _reasonController = TextEditingController();

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  void _onCreateRequest() {
    if (_step == 0) {
      setState(() => _step = 1);
      return;
    }
    Navigator.of(context).pop(_reasonController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    final tr = LocaleSettings.currentLocale == AppLocale.tr;

    final title =
        tr ? 'Hesap silme talebi gönder' : 'Submit an account deletion request';
    final subtitle = tr
        ? 'Hesabını silmek istediğinden emin misin?'
        : 'Are you sure you want to delete your account?';
    final reasonTitle = tr
        ? 'Gitmeni istemiyoruz ama seni anlıyoruz.'
        : "We don't want you to leave, but we understand.";
    final reasonSubtitleBefore = tr
        ? ''
        : 'Would you tell us why you want to leave so we can improve the ';
    final reasonSubtitleAfter = tr
        ? ' deneyimini iyileştirmemiz için bize neden ayrılmak istediğini söyler misin?'
        : ' experience?';
    final reasonLabel = tr
        ? 'Hesabını neden silmek istiyorsun'
        : 'Why do you want to delete your account';
    final reasonHint = tr ? 'Mesajınızı yazın' : 'Type your message';
    final cancel = tr ? 'İptal' : 'Cancel';
    final createRequest = tr ? 'Talep Oluştur' : 'Create a Request';

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
          child: AnimatedSize(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 46,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.sheetHandle,
                    borderRadius: BorderRadius.circular(9999),
                  ),
                ),
                const SizedBox(height: 24),
                if (_step == 0) ...[
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: AppFonts.poppins,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      height: 1,
                      letterSpacing: -0.4,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: AppFonts.poppins,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 20 / 16,
                      letterSpacing: -0.32,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ] else ...[
                  Text(
                    reasonTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: AppFonts.poppins,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      height: 1,
                      letterSpacing: 18 * -0.02,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text.rich(
                    TextSpan(
                      style: const TextStyle(
                        fontFamily: AppFonts.poppins,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 18 / 14,
                        letterSpacing: 14 * -0.02,
                        color: AppColors.textSecondary,
                      ),
                      children: [
                        if (tr) ...[
                          const TextSpan(
                            text: 'Veylo',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          TextSpan(text: reasonSubtitleAfter),
                        ] else ...[
                          TextSpan(text: reasonSubtitleBefore),
                          const TextSpan(
                            text: 'Veylo',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          TextSpan(text: reasonSubtitleAfter),
                        ],
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      reasonLabel,
                      style: const TextStyle(
                        fontFamily: AppFonts.poppins,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        height: 1,
                        letterSpacing: 14 * -0.02,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _reasonController,
                    maxLines: 3,
                    minLines: 2,
                    style: const TextStyle(
                      fontFamily: AppFonts.poppins,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1,
                      letterSpacing: 14 * -0.02,
                      color: AppColors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: reasonHint,
                      hintStyle: const TextStyle(
                        fontFamily: AppFonts.poppins,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 1,
                        letterSpacing: 14 * -0.02,
                        color: AppColors.textSecondary,
                      ),
                      contentPadding: const EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0x1A000000)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0x1A000000)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: AppColors.brandPurple),
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 24),
                _SheetButton(
                  label: cancel,
                  background: AppColors.editSheetButton,
                  onTap: () => Navigator.of(context).pop(),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: _onCreateRequest,
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Text(
                      createRequest,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: AppFonts.poppins,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        height: 20 / 16,
                        color: _createRequestRed,
                      ),
                    ),
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

class _SheetButton extends StatelessWidget {
  const _SheetButton({
    required this.label,
    required this.background,
    required this.onTap,
  });

  final String label;
  final Color background;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(9999),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontFamily: AppFonts.poppins,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            height: 20 / 16,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}

/// Create a Request sonrası son onay sheet'i.
Future<bool> showDeleteAccountConfirmSheet(BuildContext context) async {
  final result = await showModalBottomSheet<bool>(
    context: context,
    backgroundColor: AppColors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => const DeleteAccountConfirmSheet(),
  );
  return result ?? false;
}

class DeleteAccountConfirmSheet extends StatelessWidget {
  const DeleteAccountConfirmSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.paddingOf(context).bottom;
    final tr = LocaleSettings.currentLocale == AppLocale.tr;

    final title = tr
        ? 'Hesap silme talebini göndermek istediğinden emin misin?'
        : 'Are you sure you want to submit a deletion request?';
    final subtitle = tr
        ? 'Onaylarsan hesap silme talebin oluşturulacak'
        : 'If you confirm, your account deletion request will be submitted';
    final delete = tr ? 'Sil' : 'Delete';

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 10, 16, 10 + bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 46,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.sheetHandle,
              borderRadius: BorderRadius.circular(9999),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: AppFonts.poppins,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              height: 28 / 20,
              letterSpacing: 20 * -0.02,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: AppFonts.poppins,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              height: 20 / 16,
              letterSpacing: 16 * -0.02,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          _SheetButton(
            label: delete,
            background: AppColors.editSheetButton,
            onTap: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );
  }
}
