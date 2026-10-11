#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
if ! command -v flutter >/dev/null 2>&1; then
  echo 'Flutter no encontrado en PATH; instala el SDK antes de continuar.' >&2
  exit 1
fi
flutter create --platforms=android --project-name=mythos_recovery --org com.mythos --no-pub .
# El ejemplo generado por Flutter usa MyApp; Mythos tiene MythosApp.
# Eliminar solo el test demo reconocible, nunca una prueba personalizada.
if [[ -f test/widget_test.dart ]] && \
   grep -Eq 'pumpWidget\s*\(\s*(const\s+)?MyApp\s*\(' test/widget_test.dart && \
   grep -Eq 'Counter increments smoke test|This is a basic Flutter widget test' test/widget_test.dart; then
  echo 'Eliminando test demo de Flutter incompatible con Mythos...'
  rm test/widget_test.dart
fi
flutter pub get
flutter analyze
flutter test
printf 'Listo. Ejecuta flutter run con un emulador/dispositivo Android conectado.\n'
