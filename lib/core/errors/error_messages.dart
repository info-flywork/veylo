import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:veylo/data/remote/api_client.dart';
import 'package:veylo/i18n/strings.g.dart';

/// Hata → kullanıcıya gösterilecek metin.
String errorMessage(BuildContext context, Object error) {
  final e = Translations.of(context).errors;
  if (error is ApiException) {
    if (error.isNetwork) return e.network;
    return switch (error.code) {
      'ACCOUNT_SUSPENDED' => e.accountSuspended,
      'USER_NOT_REGISTERED' ||
      'INVALID_TOKEN' ||
      'MISSING_TOKEN' => e.sessionExpired,
      'INSUFFICIENT_TOKENS' => e.insufficientTokens,
      'REQUEST_NOT_ACCEPTED' => e.requestNotAccepted,
      'REQUEST_PENDING_LIMIT' => e.requestPendingLimit,
      'BLOCKED' => e.blocked,
      'PEER_UNAVAILABLE' => e.peerUnavailable,
      'INVALID_CREDENTIALS' => e.wrongCredentials,
      'TOO_MANY_ATTEMPTS' => e.tooManyAttempts,
      'UNSUPPORTED_IMAGE' => e.unsupportedImage,
      'FILE_TOO_LARGE' => e.fileTooLarge,
      _ => e.generic,
    };
  }
  if (error is FirebaseAuthException) {
    return switch (error.code) {
      'invalid-credential' ||
      'wrong-password' ||
      'user-not-found' ||
      'invalid-login-credentials' => e.wrongCredentials,
      'email-already-in-use' => e.emailInUse,
      'weak-password' => e.weakPassword,
      'invalid-email' => e.invalidEmail,
      'too-many-requests' => e.tooManyAttempts,
      'user-disabled' => e.accountSuspended,
      'network-request-failed' => e.network,
      _ => e.generic,
    };
  }
  return e.generic;
}

void showErrorSnackBar(BuildContext context, Object error) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(errorMessage(context, error)),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
