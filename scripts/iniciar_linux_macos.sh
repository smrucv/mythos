#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
if ! command -v flutter >/dev/null 2>&1; then
  echo 'Flutter no encontrado en PATH; instala el SDK antes de continuar.' >&2
  exit 1
fi
flutter create --platforms=android --project-name=mythos_recovery --org com.mythos --no-pub .
flutter pub get
flutter analyze
flutter test
printf 'Listo. Ejecuta flutter run con un emulador/dispositivo Android conectado.\n'
