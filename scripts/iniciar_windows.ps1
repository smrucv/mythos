$ErrorActionPreference = 'Stop'
Set-Location (Resolve-Path (Join-Path $PSScriptRoot '..'))

if (-not (Get-Command flutter -ErrorAction SilentlyContinue)) {
    throw 'Flutter no aparece en PATH. Instala Flutter SDK y configura Android Studio antes de continuar.'
}

Write-Host '[1/4] Generando plataforma Android (sin sobrescribir fuentes existentes)...'
flutter create --platforms=android --project-name=mythos_recovery --org com.mythos --no-pub .
if ($LASTEXITCODE -ne 0) { throw 'flutter create fallo' }

Write-Host '[2/4] Resolviendo dependencias...'
flutter pub get
if ($LASTEXITCODE -ne 0) { throw 'flutter pub get fallo' }

Write-Host '[3/4] Analisis estatico...'
flutter analyze
if ($LASTEXITCODE -ne 0) { throw 'flutter analyze fallo' }

Write-Host '[4/4] Pruebas automaticas...'
flutter test
if ($LASTEXITCODE -ne 0) { throw 'flutter test fallo' }

Write-Host 'Proyecto preparado. En Android Studio: Open -> carpeta Mythos_Recovery_v1, seleccionar dispositivo y Run.'
Write-Host 'Alternativa consola: flutter run'
