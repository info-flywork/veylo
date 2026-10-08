import 'package:flutter/material.dart';
import 'package:veylo/i18n/strings.g.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(t.app.name),
        actions: [
          PopupMenuButton<AppLocale>(
            tooltip: t.common.language,
            icon: const Icon(Icons.language),
            onSelected: (locale) => LocaleSettings.setLocale(locale),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: AppLocale.tr,
                child: Text(t.languages.tr),
              ),
              PopupMenuItem(
                value: AppLocale.en,
                child: Text(t.languages.en),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                t.app.tagline,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                t.home.subtitle,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                t.home.body,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
