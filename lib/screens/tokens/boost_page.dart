import 'dart:async';

import 'package:flutter/material.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/errors/error_messages.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_back_button.dart';
import 'package:veylo/core/widgets/app_primary_button.dart';
import 'package:veylo/data/remote/session_store.dart';
import 'package:veylo/data/remote/socket_service.dart';
import 'package:veylo/data/remote/token_repository.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/screens/tokens/token_history_page.dart';
import 'package:veylo/screens/tokens/token_packs_sheet.dart';

const _purple = Color(0xFF7D37FD);
const _tileBg = Color(0xFFF1EAFF);
const _cardBg = Color(0xFFF4EFFF);
const _pillBg = Color(0xFFE9DEFF);

/// Boost: bakiye, günlük ödül, profil öne çıkarma ve token geçmişi.
class BoostPage extends StatefulWidget {
  const BoostPage({super.key});

  static Future<void> open(BuildContext context) => Navigator.of(context).push(
    MaterialPageRoute<void>(builder: (_) => const BoostPage()),
  );

  @override
  State<BoostPage> createState() => _BoostPageState();
}

class _BoostPageState extends State<BoostPage> {
  final _repo = TokenRepository.instance;
  StreamSubscription<Map<String, dynamic>>? _tokens;

  BoostStatus? _status;
  String _selected = '1h';
  bool _busy = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
    // Başka yerden (satın alma, arama) bakiye değişirse güncel kalsın.
    _tokens = SocketService.instance.on('tokens:updated').listen((_) => _load());
  }

  @override
  void dispose() {
    _tokens?.cancel();
    super.dispose();
  }

  Future<void> _load() async {
    try {
      final s = await _repo.status();
      if (!mounted) return;
      SessionStore.instance.updateTokenBalance(s.balance);
      setState(() {
        _status = s;
        _error = null;
      });
    } catch (e) {
      if (!mounted || _status != null) return;
      setState(() => _error = errorMessage(context, e));
    }
  }

  Future<void> _run(Future<BoostStatus> Function() action, {String? done}) async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      final s = await action();
      if (!mounted) return;
      SessionStore.instance.updateTokenBalance(s.balance);
      setState(() => _status = s);
      if (done != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(done), behavior: SnackBarBehavior.floating),
        );
      }
    } catch (e) {
      if (!mounted) return;
      if (!await handleInsufficientTokens(context, e)) {
        if (mounted) showErrorSnackBar(context, e);
      } else {
        _load();
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _getMore() async {
    if (await showTokenPacksSheet(context, products: _status?.products)) _load();
  }

  String _durationLabel(Translations$tokens$tr t, BoostOption o) => switch (o.id) {
    '30m' => t.duration30m,
    '1h' => t.duration1h,
    _ => t.duration2h,
  };

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).tokens;
    final top = MediaQuery.paddingOf(context).top;
    final bottom = MediaQuery.paddingOf(context).bottom;
    final s = _status;
    final selected = s?.options.where((o) => o.id == _selected).firstOrNull;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          // Figma: üstte şeftali → mor yumuşak geçiş.
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 640,
            child: Image(
              image: AssetImage(AppAssets.callStrangerBg),
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: top + 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    const AppBackButton(),
                    Expanded(
                      child: Text(
                        t.boostTitle,
                        style: const TextStyle(
                          fontFamily: AppFonts.poppins,
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                          height: 36 / 32,
                          letterSpacing: 32 * -0.02,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                    _HistoryPill(
                      label: t.history,
                      onTap: () => TokenHistoryPage.open(context),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: s == null
                    ? Center(
                        child: _error == null
                            ? const CircularProgressIndicator()
                            : Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 32),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      _error!,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontFamily: AppFonts.poppins,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        height: 22 / 15,
                                        color: AppColors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    TextButton(
                                      onPressed: () {
                                        setState(() => _error = null);
                                        _load();
                                      },
                                      child: Text(Translations.of(context).common.retry),
                                    ),
                                  ],
                                ),
                              ),
                      )
                    : RefreshIndicator(
                        onRefresh: _load,
                        child: ListView(
                          padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                          children: [
                            _BalanceHero(
                              balance: s.balance,
                              t: t,
                              onGetMore: _getMore,
                            ),
                            const SizedBox(height: 24),
                            _CheckinCard(
                              status: s,
                              t: t,
                              busy: _busy,
                              onCollect: () => _run(_repo.checkin),
                            ),
                            const SizedBox(height: 20),
                            for (final o in s.options) ...[
                              _BoostOptionCard(
                                title: _durationLabel(t, o),
                                subtitle: t.visibility(n: o.visibility.toString()),
                                cost: o.cost,
                                selected: o.id == _selected,
                                onTap: () => setState(() => _selected = o.id),
                              ),
                              const SizedBox(height: 12),
                            ],
                            if (s.boostUntil != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  t.boostActive(
                                    time: TimeOfDay.fromDateTime(s.boostUntil!).format(context),
                                  ),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontFamily: AppFonts.poppins,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: _purple,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
              ),
              if (s != null)
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 8, 16, bottom > 0 ? bottom : 16),
                  child: AppPrimaryButton(
                    label: t.boostFor(count: (selected?.cost ?? 0).toString()),
                    onPressed: selected == null || _busy
                        ? null
                        : () => _run(() => _repo.boost(selected.id), done: t.boostDone),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HistoryPill extends StatelessWidget {
  const _HistoryPill({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFEDEDED),
      borderRadius: BorderRadius.circular(9999),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(9999),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: AppFonts.poppins,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 18 / 14,
              letterSpacing: 14 * -0.02,
              color: AppColors.black,
            ),
          ),
        ),
      ),
    );
  }
}

class _BalanceHero extends StatelessWidget {
  const _BalanceHero({required this.balance, required this.t, required this.onGetMore});

  final int balance;
  final Translations$tokens$tr t;
  final VoidCallback onGetMore;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(AppAssets.iconTokens, width: 150, height: 150, filterQuality: FilterQuality.high),
        Text(
          t.yourBalance,
          style: TextStyle(
            fontFamily: AppFonts.poppins,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.black.withValues(alpha: 0.55),
          ),
        ),
        Text(
          t.balanceTokens(count: balance.toString()),
          style: const TextStyle(
            fontFamily: AppFonts.poppins,
            fontSize: 30,
            fontWeight: FontWeight.w600,
            height: 1.2,
            letterSpacing: 30 * -0.02,
            color: _purple,
          ),
        ),
        const SizedBox(height: 10),
        Material(
          color: _purple.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(9999),
          child: InkWell(
            onTap: onGetMore,
            borderRadius: BorderRadius.circular(9999),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    t.getMore,
                    style: const TextStyle(
                      fontFamily: AppFonts.poppins,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: _purple,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: _purple, width: 1.5),
                    ),
                    child: const Icon(Icons.chevron_right_rounded, size: 16, color: _purple),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CheckinCard extends StatelessWidget {
  const _CheckinCard({
    required this.status,
    required this.t,
    required this.busy,
    required this.onCollect,
  });

  final BoostStatus status;
  final Translations$tokens$tr t;
  final bool busy;
  final VoidCallback onCollect;

  @override
  Widget build(BuildContext context) {
    final maxReward = status.rewards.isEmpty
        ? 0
        : status.rewards.reduce((a, b) => a > b ? a : b);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            t.checkinTitle,
            style: const TextStyle(
              fontFamily: AppFonts.poppins,
              fontSize: 26,
              fontWeight: FontWeight.w600,
              height: 1.2,
              letterSpacing: 26 * -0.02,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            t.checkinSubtitle(max: maxReward.toString()),
            style: TextStyle(
              fontFamily: AppFonts.poppins,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              height: 20 / 16,
              letterSpacing: 16 * -0.02,
              color: AppColors.black.withValues(alpha: 0.65),
            ),
          ),
          const SizedBox(height: 18),
          _DaysRow(
            rewards: status.rewards,
            current: status.checkinDay,
            dayLabel: (n) => t.day(n: n.toString()),
          ),
          const SizedBox(height: 18),
          AppPrimaryButton(
            label: status.checkinCanCollect
                ? t.collectDay(n: status.checkinDay.toString())
                : t.collectedToday(
                    n: (status.checkinDay % status.rewards.length + 1).toString(),
                  ),
            onPressed: status.checkinCanCollect && !busy ? onCollect : null,
          ),
        ],
      ),
    );
  }
}

class _DaysRow extends StatelessWidget {
  const _DaysRow({required this.rewards, required this.current, required this.dayLabel});

  final List<int> rewards;
  final int current;
  final String Function(int) dayLabel;

  @override
  Widget build(BuildContext context) {
    const tileH = 70.0;
    return Column(
      children: [
        Row(
          children: [
            for (var i = 0; i < rewards.length; i++)
              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    dayLabel(i + 1),
                    style: TextStyle(
                      fontFamily: AppFonts.poppins,
                      fontSize: 13,
                      fontWeight: i + 1 == current ? FontWeight.w600 : FontWeight.w400,
                      color: i + 1 == current
                          ? AppColors.black
                          : AppColors.black.withValues(alpha: 0.45),
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: tileH,
          child: Stack(
            children: [
              // Günleri birleştiren mor çizgi.
              Positioned(
                left: 0,
                right: 0,
                top: tileH / 2 - 2,
                child: Container(height: 4, color: _purple),
              ),
              Row(
                children: [
                  for (var i = 0; i < rewards.length; i++)
                    Expanded(
                      child: Center(
                        child: Container(
                          width: 44,
                          height: tileH,
                          decoration: BoxDecoration(
                            color: _tileBg,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: i + 1 == current ? _purple : AppColors.white,
                              width: i + 1 == current ? 1.5 : 2,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(AppAssets.iconTokens, width: 28, height: 28),
                              const SizedBox(height: 4),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  '+${rewards[i]}',
                                  style: const TextStyle(
                                    fontFamily: AppFonts.poppins,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: _purple,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _BoostOptionCard extends StatelessWidget {
  const _BoostOptionCard({
    required this.title,
    required this.subtitle,
    required this.cost,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final int cost;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.fromLTRB(14, 12, 12, 12),
        decoration: BoxDecoration(
          color: _cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? _purple : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.access_time_rounded, size: 24, color: AppColors.black),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: AppFonts.poppins,
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 22 * -0.02,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontFamily: AppFonts.poppins,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: _purple,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _pillBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(AppAssets.iconTokens, width: 34, height: 34),
                  const SizedBox(width: 6),
                  Text(
                    '$cost',
                    style: const TextStyle(
                      fontFamily: AppFonts.poppins,
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: _purple,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
