import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/data/local/language_store.dart';
import 'package:veylo/data/local/local_profile_store.dart';
import 'package:veylo/data/remote/session_store.dart';
import 'package:veylo/firebase_options.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/screens/discover/rooms/create_room_or_group_sheet.dart';
import 'package:veylo/screens/main/main_shell.dart';

/// Oda kurma sheet’ini açar (mümkünse oturumla).
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await LocaleSettings.setLocaleRaw(await LanguageStore.instance.current());
  await LocalProfileStore.instance.init();

  var status = await SessionStore.instance.restore();
  if (status != SessionStatus.ready && kDebugMode) {
    try {
      status = await SessionStore.instance.signInAsDev('tester1');
      debugPrint('dev login status=$status');
    } catch (e) {
      debugPrint('dev login failed: $e');
    }
  }
  debugPrint('session status=$status me=${SessionStore.instance.me?.username}');

  runApp(TranslationProvider(
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: _CreateRoomEntry(loggedIn: status == SessionStatus.ready),
    ),
  ));
}

class _CreateRoomEntry extends StatefulWidget {
  const _CreateRoomEntry({required this.loggedIn});

  final bool loggedIn;

  @override
  State<_CreateRoomEntry> createState() => _CreateRoomEntryState();
}

class _CreateRoomEntryState extends State<_CreateRoomEntry> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      await showCreateRoomOrGroupSheet(context);
      if (!mounted) return;
      if (widget.loggedIn) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute<void>(builder: (_) => const MainShell()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.white,
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
