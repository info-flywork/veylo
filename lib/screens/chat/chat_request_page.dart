import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veylo/core/assets/app_assets.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_back_button.dart';
import 'package:veylo/core/widgets/app_text.dart';
import 'package:veylo/i18n/strings.g.dart';

/// Chats → Request — mesaj isteği yoksa empty state.
class ChatRequestPage extends StatelessWidget {
  const ChatRequestPage({super.key, this.requests = const []});

  /// İleride gerçek istek listesi; boşsa empty state.
  final List<Object> requests;

  static Future<void> open(BuildContext context) {
    return Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (_) => const ChatRequestPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).chats;
    final top = MediaQuery.paddingOf(context).top;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: top + 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                const AppBackButton(),
                AppText(t.request, style: AppTextStyles.requestNavTitle),
              ],
            ),
          ),
          Expanded(
            child: requests.isEmpty
                ? const _RequestEmptyState()
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

class _RequestEmptyState extends StatelessWidget {
  const _RequestEmptyState();

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).chats;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              AppAssets.iconStorySend,
              width: 98,
              height: 98,
              colorFilter: const ColorFilter.mode(
                AppColors.black,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 10),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 398),
              child: AppText(
                t.emptyRequestTitle,
                style: AppTextStyles.requestEmptyTitle,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 398),
              child: AppText(
                t.emptyRequestSubtitle,
                style: AppTextStyles.requestEmptySubtitle,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
