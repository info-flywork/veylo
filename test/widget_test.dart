import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veylo/i18n/strings.g.dart';
import 'package:veylo/screens/auth/login_page.dart';
import 'package:veylo/screens/auth/register_page.dart';
import 'package:veylo/screens/onboarding/onboarding_flow_page.dart';

void main() {
  setUp(() async {
    await LocaleSettings.setLocale(AppLocale.tr);
  });

  testWidgets('Login ekranı auth metinlerini gösterir', (tester) async {
    await tester.pumpWidget(
      TranslationProvider(
        child: const MaterialApp(home: LoginPage()),
      ),
    );
    await tester.pump();

    expect(find.text('Tekrar hoş geldin'), findsOneWidget);
    expect(find.text('Giriş yap'), findsOneWidget);
    expect(find.text('Şifremi unuttum?'), findsOneWidget);
    // Apple ile giriş sadece iOS'ta gösterilir (test ortamı iOS değil).
    expect(find.text('Apple ile devam et'), findsNothing);
    expect(find.text('Google ile devam et'), findsOneWidget);
  });

  testWidgets('Register ekranı auth metinlerini gösterir', (tester) async {
    await tester.pumpWidget(
      TranslationProvider(
        child: const MaterialApp(home: RegisterPage()),
      ),
    );
    await tester.pump();

    expect(find.text('Hesabını oluştur'), findsOneWidget);
    expect(find.text('Kayıt ol'), findsOneWidget);
    expect(find.text('Kullanıcı adı'), findsOneWidget);
    expect(find.text('E-posta'), findsOneWidget);
  });
  testWidgets('Onboarding sayfa 1 ve 2 metinlerini gösterir', (tester) async {
    await tester.pumpWidget(
      TranslationProvider(
        child: const MaterialApp(home: OnboardingFlowPage()),
      ),
    );
    await tester.pump();

    expect(find.text('Atla'), findsOneWidget);
    expect(find.text('Kendin ol. Anonim kal.'), findsOneWidget);

    await tester.drag(find.byType(PageView), const Offset(-400, 0));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.text('Yaz. Konuş. Vibes’i hisset.'), findsOneWidget);
  });
}
