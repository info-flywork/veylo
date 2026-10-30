import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/errors/error_messages.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/data/remote/api_client.dart';
import 'package:veylo/data/remote/session_store.dart';
import 'package:veylo/data/remote/token_repository.dart';
import 'package:veylo/i18n/strings.g.dart';

/// Mağaza fiyatları RevenueCat bağlanınca oradan gelecek; şimdilik gösterim için.
const _displayPrices = {
  'veylo.tokens.100': r'$6.99',
  'veylo.tokens.400': r'$19.99',
  'veylo.tokens.1000': r'$39.99',
};

const _fallbackProducts = [
  TokenProduct(id: 'veylo.tokens.100', tokens: 100),
  TokenProduct(id: 'veylo.tokens.400', tokens: 400),
  TokenProduct(id: 'veylo.tokens.1000', tokens: 1000),
];

/// Token paketleri. Satın alınca bakiye hemen güncellenir. Satın alındıysa true döner.
/// [notEnough]: bakiye yetmediği için açıldı (başlık buna göre değişir).
Future<bool> showTokenPacksSheet(
  BuildContext context, {
  List<TokenProduct>? products,
  bool notEnough = false,
}) async {
  final bought = await showModalBottomSheet<bool>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => _TokenPacksSheet(
      products: products ?? _fallbackProducts,
      notEnough: notEnough,
    ),
  );
  return bought ?? false;
}

/// Hata "yetersiz token" ise paketleri açar ve true döner; değilse false.
Future<bool> handleInsufficientTokens(BuildContext context, Object error) async {
  if (error is! ApiException || error.code != 'INSUFFICIENT_TOKENS') {
    return false;
  }
  await showTokenPacksSheet(context, notEnough: true);
  return true;
}

class _TokenPacksSheet extends StatefulWidget {
  const _TokenPacksSheet({required this.products, required this.notEnough});

  final List<TokenProduct> products;
  final bool notEnough;

  @override
  State<_TokenPacksSheet> createState() => _TokenPacksSheetState();
}

class _TokenPacksSheetState extends State<_TokenPacksSheet> {
  static const _sheetBg = Color(0xFFF6F6FB);
  static const _rowBg = Color(0x0D998FED);

  String? _buying;

  Future<void> _buy(TokenProduct p) async {
    if (_buying != null) return;
    setState(() => _buying = p.id);
    final t = Translations.of(context).tokens;
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    try {
      final balance = await TokenRepository.instance.purchase(p.id);
      SessionStore.instance.updateTokenBalance(balance);
      navigator.pop(true);
      messenger.showSnackBar(
        SnackBar(
          content: Text(t.purchaseDone(count: p.tokens.toString())),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _buying = null);
      showErrorSnackBar(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).tokens;
    final bottom = MediaQuery.paddingOf(context).bottom;
    final balance = SessionStore.instance.me?.tokenBalance ?? 0;

    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 50),
          width: double.infinity,
          decoration: const BoxDecoration(
            color: _sheetBg,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: EdgeInsets.fromLTRB(16, 66, 16, 16 + bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText(
                widget.notEnough ? t.notEnoughTitle : t.packsTitle,
                style: AppTextStyles.filtersTitle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              AppText(
                widget.notEnough ? t.notEnoughSubtitle : t.packsSubtitle,
                style: AppTextStyles.privateRoomSubtitle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              AppText(
                t.balanceLine(count: balance.toString()),
                style: AppTextStyles.privateRoomRowLabel,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              for (final p in widget.products) ...[
                _PackRow(
                  label: t.packTokens(count: p.tokens.toString()),
                  price: _displayPrices[p.id] ?? t.buy,
                  background: _rowBg,
                  busy: _buying == p.id,
                  onTap: () => _buy(p),
                ),
                const SizedBox(height: 10),
              ],
            ],
          ),
        ),
        Positioned(
          top: 58,
          right: 16,
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            behavior: HitTestBehavior.opaque,
            child: SvgPicture.asset(AppAssets.iconClose, width: 32, height: 32),
          ),
        ),
        Positioned(
          top: 0,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: 0.08),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Image.asset(AppAssets.iconTokens, width: 72, height: 72),
          ),
        ),
      ],
    );
  }
}

class _PackRow extends StatelessWidget {
  const _PackRow({
    required this.label,
    required this.price,
    required this.background,
    required this.busy,
    required this.onTap,
  });

  final String label;
  final String price;
  final Color background;
  final bool busy;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: busy ? null : onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Image.asset(AppAssets.iconTokens, width: 36, height: 36),
            const SizedBox(width: 8),
            Expanded(
              child: AppText(
                label,
                style: AppTextStyles.privateRoomTokenAmount,
                maxLines: 1,
              ),
            ),
            Container(
              height: 36,
              constraints: const BoxConstraints(minWidth: 84),
              padding: const EdgeInsets.symmetric(horizontal: 14),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9999),
                gradient: const LinearGradient(
                  colors: [Color(0xFF7B2FFF), Color(0xFF998FED)],
                ),
              ),
              child: busy
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.white,
                      ),
                    )
                  : Text(
                      price,
                      style: const TextStyle(
                        fontFamily: AppFonts.poppins,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
