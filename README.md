# Veylo

| Klasör | İçerik |
|---|---|
| [`veylobackend/`](veylobackend) | Node.js (TypeScript, Express 5, Socket.IO, Prisma/MariaDB) API — kurulum: `veylobackend/README.md` |
| [`veylofrontend/`](veylofrontend) | Flutter mobil uygulama (iOS / Android) |
| [`legal_site/`](legal_site) | fly-work.com/veylo/{about,privacy-policy,terms,cookies,csae}/ |

## Yasal sayfalar

Eggbrella / Arrow Shift şablonu; Veylo paleti; TR/EN; çerez yok.

```bash
python3 legal_site/build.py
```

Uygulama linkleri: `AppConfig.privacyPolicyUrl` / `termsOfServiceUrl`.

Gizli dosyalar repoda yoktur: `veylobackend/.env`, `firebase-service-account.json`,
`veylofrontend/ios/Runner/GoogleService-Info.plist`, `veylofrontend/android/app/google-services.json`,
`veylofrontend/lib/firebase_options.dart` (`flutterfire configure` ile üretilir).
