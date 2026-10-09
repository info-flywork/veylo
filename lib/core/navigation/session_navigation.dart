import 'package:flutter/material.dart';
import 'package:veylo/data/remote/session_store.dart';
import 'package:veylo/screens/create_profile/create_profile_draft.dart';
import 'package:veylo/screens/create_profile/create_profile_username_page.dart';
import 'package:veylo/screens/main/main_shell.dart';
import 'package:veylo/screens/onboarding/onboarding_flow_page.dart';

/// Oturum durumuna göre yığını temizleyip doğru ekrana geçer.
/// [usernameHint]: kayıt ekranında yazılan kullanıcı adı, profil oluşturmada hazır gelsin.
Future<void> goForSession(
  BuildContext context,
  SessionStatus status, {
  String? usernameHint,
}) {
  final Widget page = switch (status) {
    SessionStatus.signedOut => const OnboardingFlowPage(),
    SessionStatus.needsOnboarding => const CreateProfileUsernamePage(),
    SessionStatus.ready => const MainShell(),
  };
  if (status == SessionStatus.needsOnboarding) {
    CreateProfileDraft.instance.reset();
    if (usernameHint != null) {
      CreateProfileDraft.instance.username = usernameHint;
    }
  }

  return Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
    PageRouteBuilder<void>(
      pageBuilder: (_, _, _) => page,
      transitionsBuilder: (_, animation, _, child) =>
          FadeTransition(opacity: animation, child: child),
      transitionDuration: const Duration(milliseconds: 400),
    ),
    (_) => false,
  );
}
