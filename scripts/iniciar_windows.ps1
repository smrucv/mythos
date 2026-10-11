$ErrorActionPreference = 'Stop'
Set-Location (Resolve-Path (Join-Path $PSScriptRoot '..'))

if (-not (Get-Command flutter -ErrorAction SilentlyContinue)) {
    throw 'Flutter no aparece en PATH. Instala Flutter SDK y configura Android Studio antes de continuar.'
}

Write-Host '[1/5] Verificando plataforma Android...'
if (-not (Test-Path 'android/app/src/main/AndroidManifest.xml')) {
    flutter create --platforms=android --project-name=mythos_recovery --org com.mythos --no-pub .
    if ($LASTEXITCODE -ne 0) { throw 'flutter create fallo' }
} else {
    Write-Host 'Android ya esta creado; se conservaran sus archivos existentes.'
}

# En proyectos reconstruidos, 'flutter create' puede agregar la prueba demo
# test/widget_test.dart. Esa prueba referencia MyApp y NO corresponde a MythosApp.
# Quitarla solo si contiene la invocacion de la plantilla, sin tocar pruebas propias.
$testDemo = Join-Path (Get-Location) 'test/widget_test.dart'
if (Test-Path -LiteralPath $testDemo) {
    $contenido = Get-Content -LiteralPath $testDemo -Raw
    if ($contenido -match 'pumpWidget\s*\(\s*(?:const\s+)?MyApp\s*\(' -and
        $contenido -match 'Counter increments smoke test|This is a basic Flutter widget test') {
        Write-Host 'Eliminando test demo generado por Flutter (MyApp no existe en Mythos)...'
        Remove-Item -LiteralPath $testDemo
    }
}

Write-Host '[2/5] Aplicando branding nativo...'
& (Join-Path $PSScriptRoot 'aplicar_branding_android.ps1')

Write-Host '[3/5] Resolviendo dependencias...'
flutter pub get
if ($LASTEXITCODE -ne 0) { throw 'flutter pub get fallo' }

Write-Host '[4/5] Analisis estatico...'
flutter analyze
if ($LASTEXITCODE -ne 0) { throw 'flutter analyze fallo' }

Write-Host '[5/5] Pruebas automaticas...'
flutter test
if ($LASTEXITCODE -ne 0) { throw 'flutter test fallo' }

Write-Host 'Proyecto preparado. En Android Studio: Open -> carpeta Mythos_Recovery_v1, seleccionar dispositivo y Run.'
Write-Host 'Alternativa consola: flutter run'
