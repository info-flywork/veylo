import 'package:flutter/material.dart';
import 'package:veylo/core/permissions/av_permissions.dart';
import 'package:veylo/i18n/strings.g.dart';

/// Ses kaydından önce mikrofon izni: ilk seferde sistem izni sorulur.
/// Daha önce reddedildiyse iOS bir daha sormaz; o zaman Ayarlar'a götüren uyarı çıkar.
Future<bool> ensureMicPermission(BuildContext context) async {
  if (await AvPermissions.microphone()) return true;
  if (!context.mounted) return false;
  final t = Translations.of(context).chats;
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(t.micNeeded),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: t.openSettings,
          onPressed: AvPermissions.openSettings,
        ),
      ),
    );
  return false;
}
