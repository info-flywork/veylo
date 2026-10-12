import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:veylo/app.dart';
import 'package:veylo/data/local/local_profile_store.dart';
import 'package:veylo/data/remote/push_service.dart';
import 'package:veylo/firebase_options.dart';
import 'package:veylo/i18n/strings.g.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Uygulama dili: İngilizce (cihaz dilinden bağımsız).
  await LocaleSettings.setLocale(AppLocale.en);
  await LocalProfileStore.instance.init();
  await PushService.instance.init();

  runApp(
    TranslationProvider(
      child: const VeyloApp(),
    ),
  );
}
