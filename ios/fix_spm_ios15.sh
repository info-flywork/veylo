#!/bin/sh
# Flutter SPM Package.swift varsayılanı 13.0; Firebase 15+ ister.
# prepare sonrası Archive/build öncesi çağrılır.
set -e
PKG="${SRCROOT}/Flutter/ephemeral/Packages/FlutterGeneratedPluginSwiftPackage/Package.swift"
if [ -f "$PKG" ]; then
  /usr/bin/sed -i '' 's/\.iOS("13.0")/.iOS("15.0")/g' "$PKG"
fi
