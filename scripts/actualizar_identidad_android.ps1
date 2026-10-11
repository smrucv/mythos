# Actualiza los identificadores nativos existentes para Mythos sin recrear el proyecto.
# No desinstala aplicaciones ni modifica/elimina datos privados del emulador.
$ErrorActionPreference = 'Stop'
$root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$android = Join-Path $root 'android'
$appGradle = Join-Path $android 'app\build.gradle.kts'
$appGradleGroovy = Join-Path $android 'app\build.gradle'
$manifestFile = Join-Path $android 'app\src\main\AndroidManifest.xml'
$kotlinRoot = Join-Path $android 'app\src\main\kotlin'
$newPackage = 'com.mythos.mythos'

if (-not (Test-Path -LiteralPath $manifestFile)) {
    throw 'No existe la plataforma Android. Ejecuta primero flutter create --platforms=android --project-name=mythos --org com.mythos --no-pub .'
}
if (-not (Test-Path -LiteralPath $appGradle) -and -not (Test-Path -LiteralPath $appGradleGroovy)) {
    throw 'No se encontró el archivo Gradle de la aplicación Android.'
}
$backupRoot = Join-Path $root 'backup_identidad_android'
function Save-Backup([string] $file) {
    if (-not (Test-Path -LiteralPath $file)) { return }
    $relative = $file.Substring($android.Length).TrimStart('\', '/')
    $dest = Join-Path $backupRoot $relative
    if (-not (Test-Path -LiteralPath $dest)) {
        New-Item -ItemType Directory -Force -Path (Split-Path -Parent $dest) | Out-Null
        Copy-Item -LiteralPath $file -Destination $dest
    }
}

# Gradle Kotlin DSL o Groovy: reemplazar el identificador y namespace sin tocar otras opciones.
if (Test-Path -LiteralPath $appGradle) {
    $gradleFile = $appGradle
    $namespacePattern = '(?m)^(\s*namespace\s*=\s*)["''][^"'']+["'']'
    $applicationPattern = '(?m)^(\s*applicationId\s*=\s*)["''][^"'']+["'']'
    $namespaceNew = '$1"' + $newPackage + '"'
    $applicationNew = '$1"' + $newPackage + '"'
} else {
    $gradleFile = $appGradleGroovy
    $namespacePattern = '(?m)^(\s*namespace\s+)["''][^"'']+["'']'
    $applicationPattern = '(?m)^(\s*applicationId\s+)["''][^"'']+["'']'
    $namespaceNew = '$1"' + $newPackage + '"'
    $applicationNew = '$1"' + $newPackage + '"'
}
$gradle = Get-Content -LiteralPath $gradleFile -Raw -Encoding UTF8
if (-not [regex]::IsMatch($gradle, $namespacePattern) -or -not [regex]::IsMatch($gradle, $applicationPattern)) {
    throw 'No pude reconocer namespace/applicationId en Gradle. No modifiqué los archivos Android: revisa su contenido.'
}
$gradle = [regex]::Replace($gradle, $namespacePattern, $namespaceNew)
$gradle = [regex]::Replace($gradle, $applicationPattern, $applicationNew)
Save-Backup $gradleFile
[System.IO.File]::WriteAllText($gradleFile, $gradle, (New-Object System.Text.UTF8Encoding($false)))

# Manifiesto: nombre público y clase MainActivity intacta por nombre relativo.
Save-Backup $manifestFile
[xml]$manifest = Get-Content -LiteralPath $manifestFile -Raw -Encoding UTF8
$app = $manifest.SelectSingleNode('/manifest/application')
if ($null -eq $app) { throw 'No existe el nodo application en AndroidManifest.xml.' }
$app.SetAttribute('label', 'http://schemas.android.com/apk/res/android', 'Mythos')
$manifest.Save($manifestFile)

# Kotlin: mover MainActivity a la carpeta que corresponde al namespace definitivo.
$newActivity = Join-Path $kotlinRoot 'com\mythos\mythos\MainActivity.kt'
$found = @(Get-ChildItem -LiteralPath $kotlinRoot -Filter MainActivity.kt -File -Recurse -ErrorAction SilentlyContinue)
if ($found.Count -gt 1) {
    throw 'Hay varias clases MainActivity.kt: se requiere inspección manual antes de moverlas.'
}
if ($found.Count -eq 1) {
    $oldActivity = $found[0].FullName
    $activityText = Get-Content -LiteralPath $oldActivity -Raw -Encoding UTF8
    $activityText = [regex]::Replace($activityText, '(?m)^package\s+[A-Za-z0-9_.]+', 'package ' + $newPackage)
    Save-Backup $oldActivity
    New-Item -ItemType Directory -Force -Path (Split-Path -Parent $newActivity) | Out-Null
    [System.IO.File]::WriteAllText($newActivity, $activityText, (New-Object System.Text.UTF8Encoding($false)))
    if ($oldActivity -ne $newActivity) { Remove-Item -LiteralPath $oldActivity -Force }
} elseif (-not (Test-Path -LiteralPath $newActivity)) {
    throw 'No se encontró MainActivity.kt; revisa la estructura nativa antes de compilar.'
}

# El proyecto usa Mythos sin sufijos también en las referencias de Settings.
$settings = Join-Path $android 'settings.gradle.kts'
if (Test-Path -LiteralPath $settings) {
    $source = Get-Content -LiteralPath $settings -Raw -Encoding UTF8
    $changed = [regex]::Replace($source, '(?m)^(\s*rootProject\.name\s*=\s*)["''][^"'']+["'']', '$1"mythos"')
    if ($changed -ne $source) {
        Save-Backup $settings
        [System.IO.File]::WriteAllText($settings, $changed, (New-Object System.Text.UTF8Encoding($false)))
    }
}
Write-Host 'Nombre: Mythos'
Write-Host 'Package Flutter: mythos'
Write-Host 'Identificador Android: com.mythos.mythos'
Write-Host 'No se han desinstalado apps ni modificado datos privados.'
Write-Host 'Recompila desde la carpeta raiz: flutter clean; flutter pub get; flutter analyze; flutter test; flutter run -d emulator-5554'
