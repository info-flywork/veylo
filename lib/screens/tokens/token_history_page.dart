import 'package:flutter/material.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/errors/error_messages.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_back_button.dart';
import 'package:veylo/data/remote/token_repository.dart';
import 'package:veylo/i18n/strings.g.dart';

const _purple = Color(0xFF7D37FD);
const _cardBg = Color(0xFFF6F2FF);
const _minus = Color(0xFFE5242A);
const _plus = Color(0xFF13A57A);

/// Token hareketleri (Boost > History).
class TokenHistoryPage extends StatefulWidget {
  const TokenHistoryPage({super.key});

  static Future<void> open(BuildContext context) => Navigator.of(context).push(
    MaterialPageRoute<void>(builder: (_) => const TokenHistoryPage()),
  );

  @override
  State<TokenHistoryPage> createState() => _TokenHistoryPageState();
}

class _TokenHistoryPageState extends State<TokenHistoryPage> {
  final _repo = TokenRepository.instance;
  final _scroll = ScrollController();

  List<TokenHistoryItem>? _items;
  String? _cursor;
  bool _loadingMore = false;

  @override
  void initState() {
    super.initState();
    _load();
    _scroll.addListener(() {
      if (_scroll.position.pixels > _scroll.position.maxScrollExtent - 300) _more();
    });
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    try {
      final page = await _repo.history();
      if (!mounted) return;
      setState(() {
        _items = page.items;
        _cursor = page.nextCursor;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _items ??= const []);
      showErrorSnackBar(context, e);
    }
  }

  Future<void> _more() async {
    final cursor = _cursor;
    if (cursor == null || _loadingMore) return;
    _loadingMore = true;
    try {
      final page = await _repo.history(cursor: cursor);
      if (!mounted) return;
      setState(() {
        _items = [...?_items, ...page.items];
        _cursor = page.nextCursor;
      });
    } catch (_) {
      // Bir sonraki kaydırmada tekrar denenir.
    } finally {
      _loadingMore = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).tokens;
    final top = MediaQuery.paddingOf(context).top;
    final items = _items;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: top + 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const AppBackButton(),
                Text(
                  t.history,
                  style: const TextStyle(
                    fontFamily: AppFonts.poppins,
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    height: 36 / 32,
                    letterSpacing: 32 * -0.02,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: items == null
                ? const Center(child: CircularProgressIndicator())
                : items.isEmpty
                ? Center(
                    child: Text(
                      t.historyEmpty,
                      style: TextStyle(
                        fontFamily: AppFonts.poppins,
                        fontSize: 15,
                        color: AppColors.black.withValues(alpha: 0.5),
                      ),
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: _load,
                    child: ListView.separated(
                      controller: _scroll,
                      padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                      itemCount: items.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 12),
                      itemBuilder: (context, i) => _HistoryCard(item: items[i], t: t),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  const _HistoryCard({required this.item, required this.t});

  final TokenHistoryItem item;
  final Translations$tokens$tr t;

  /// Sol taraf: başlık ve (varsa) alt satır.
  (String title, String? subtitle, bool clock) _describe() {
    final m = item.meta;
    switch (item.reason) {
      case 'PROFILE_BOOST':
        final title = switch (m['option']) {
          '30m' => t.duration30m,
          '1h' => t.duration1h,
          _ => t.duration2h,
        };
        final v = m['visibility'];
        return (title, v == null ? null : t.visibility(n: '$v'), true);
      case 'DAILY_CHECKIN':
        final day = m['day'];
        return (t.reasonCheckin, day == null ? null : t.day(n: '$day'), false);
      case 'PURCHASE':
        return (t.reasonPurchase, null, false);
      case 'WELCOME_BONUS':
        return (t.reasonWelcome, null, false);
      case 'CALL_GENDER_FILTER':
        return (t.reasonGenderFilter, null, false);
      case 'VIDEO_CALL':
        return (t.reasonVideoCall, null, false);
      case 'ROOM_CREATE':
        return (t.reasonRoomCreate, null, false);
      case 'BORDER_PURCHASE':
        return (t.reasonBorder, null, false);
      case 'POST_BOOST':
        return (t.reasonPostBoost, null, false);
      case 'REFUND':
        return (t.reasonRefund, null, false);
      default:
        return (t.reasonAdjust, null, false);
    }
  }

  String _date(DateTime d) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${two(d.day)}.${two(d.month)}.${d.year} ${two(d.hour)}:${two(d.minute)}';
  }

  @override
  Widget build(BuildContext context) {
    final (title, subtitle, clock) = _describe();
    final positive = item.delta >= 0;
    final grey = AppColors.black.withValues(alpha: 0.5);

    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (clock) ...[
                      const Icon(Icons.access_time_rounded, size: 22, color: AppColors.black),
                      const SizedBox(width: 6),
                    ],
                    Flexible(
                      child: Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: AppFonts.poppins,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 20 * -0.02,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                if (subtitle != null)
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontFamily: AppFonts.poppins,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: _purple,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(AppAssets.iconTokens, width: 28, height: 28),
                  const SizedBox(width: 6),
                  Text(
                    positive ? '+${item.delta}' : '${item.delta}',
                    style: TextStyle(
                      fontFamily: AppFonts.poppins,
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      color: positive ? _plus : _minus,
                    ),
                  ),
                ],
              ),
              Text(
                t.balanceLine(count: '${item.balanceAfter}'),
                style: TextStyle(fontFamily: AppFonts.poppins, fontSize: 14, color: grey),
              ),
              const SizedBox(height: 2),
              Text(
                _date(item.createdAt),
                style: TextStyle(fontFamily: AppFonts.poppins, fontSize: 13, color: grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
