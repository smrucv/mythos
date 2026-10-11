$ErrorActionPreference = 'Stop'
$projectRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$androidMain = Join-Path $projectRoot 'android\app\src\main'
$androidRes  = Join-Path $androidMain 'res'
$assetRes    = Join-Path $projectRoot 'branding\android\res'

if (-not (Test-Path (Join-Path $androidMain 'AndroidManifest.xml'))) {
    throw 'No existe la plataforma Android. Ejecuta primero flutter create --platforms=android --project-name=mythos_recovery --org com.mythos --no-pub .'
}

function Backup-Once([string] $path) {
    # Los respaldos quedan FUERA de res/: AAPT no acepta extensiones desconocidas.
    $relative = $path.Substring($androidMain.Length).TrimStart('\', '/')
    $backup = Join-Path (Join-Path $projectRoot 'android\.mythos_brand_backups') $relative
    if ((Test-Path -LiteralPath $path) -and -not (Test-Path -LiteralPath $backup)) {
        New-Item -ItemType Directory -Force -Path (Split-Path -Parent $backup) | Out-Null
        Copy-Item -LiteralPath $path -Destination $backup
    }
}

# Icono de Chiguire Grove para el arranque nativo e icono de libro para el lanzador.
$assets = @(
    'drawable-nodpi\chiguire_grove_splash_icon.png',
    'mipmap-mdpi\ic_launcher.png',
    'mipmap-hdpi\ic_launcher.png',
    'mipmap-xhdpi\ic_launcher.png',
    'mipmap-xxhdpi\ic_launcher.png',
    'mipmap-xxxhdpi\ic_launcher.png'
)
foreach ($asset in $assets) {
    $source = Join-Path $assetRes $asset
    $destination = Join-Path $androidRes $asset
    New-Item -ItemType Directory -Force -Path (Split-Path -Parent $destination) | Out-Null
    Backup-Once $destination
    Copy-Item -LiteralPath $source -Destination $destination -Force
}

# Color identico al fondo inicial de la animacion original.
$colors = Join-Path $androidRes 'values\mythos_brand_colors.xml'
New-Item -ItemType Directory -Force -Path (Split-Path -Parent $colors) | Out-Null
Set-Content -LiteralPath $colors -Encoding UTF8 -Value @'
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <color name="grove_cream">#F5F2EA</color>
</resources>
'@

# Android 11 e inferiores: pantalla de fondo crema con isotipo de Chiguire Grove.
$launchBackground = @'
<?xml version="1.0" encoding="utf-8"?>
<layer-list xmlns:android="http://schemas.android.com/apk/res/android">
    <item android:drawable="@color/grove_cream" />
    <item>
        <bitmap android:gravity="center" android:src="@drawable/chiguire_grove_splash_icon" />
    </item>
</layer-list>
'@
foreach ($dir in @('drawable', 'drawable-v21')) {
    $target = Join-Path (Join-Path $androidRes $dir) 'launch_background.xml'
    New-Item -ItemType Directory -Force -Path (Split-Path -Parent $target) | Out-Null
    Backup-Once $target
    Set-Content -LiteralPath $target -Encoding UTF8 -Value $launchBackground
}

function Update-LaunchTheme([string] $path, [string] $parentTheme, [bool] $android12) {
    New-Item -ItemType Directory -Force -Path (Split-Path -Parent $path) | Out-Null
    Backup-Once $path
    if (Test-Path -LiteralPath $path) {
        [xml]$doc = Get-Content -LiteralPath $path -Raw -Encoding UTF8
    } else {
        [xml]$doc = '<resources></resources>'
    }
    $root = $doc.DocumentElement
    $theme = $doc.SelectSingleNode('/resources/style[@name="LaunchTheme"]')
    if ($null -eq $theme) {
        $theme = $doc.CreateElement('style')
        $theme.SetAttribute('name', 'LaunchTheme')
        $theme.SetAttribute('parent', $parentTheme)
        [void]$root.AppendChild($theme)
    }
    $items = @{
        'android:windowBackground' = '@drawable/launch_background'
    }
    if ($android12) {
        $items['android:windowSplashScreenBackground'] = '@color/grove_cream'
        $items['android:windowSplashScreenAnimatedIcon'] = '@drawable/chiguire_grove_splash_icon'
    }
    foreach ($name in $items.Keys) {
        $existing = $null
        foreach ($node in $theme.ChildNodes) {
            if ($node.NodeType -eq 'Element' -and $node.Name -eq 'item' -and $node.GetAttribute('name') -eq $name) {
                $existing = $node
                break
            }
        }
        if ($null -eq $existing) {
            $existing = $doc.CreateElement('item')
            $existing.SetAttribute('name', $name)
            [void]$theme.AppendChild($existing)
        }
        $existing.InnerText = $items[$name]
    }
    $doc.Save($path)
}

Update-LaunchTheme (Join-Path $androidRes 'values\styles.xml') '@android:style/Theme.Light.NoTitleBar' $false
Update-LaunchTheme (Join-Path $androidRes 'values-night\styles.xml') '@android:style/Theme.Black.NoTitleBar' $false
Update-LaunchTheme (Join-Path $androidRes 'values-v31\styles.xml') '@android:style/Theme.Light.NoTitleBar' $true
Update-LaunchTheme (Join-Path $androidRes 'values-night-v31\styles.xml') '@android:style/Theme.Black.NoTitleBar' $true

# El nombre visible pasa a Mythos; NO se modifica el applicationId ni los datos guardados.
$manifestPath = Join-Path $androidMain 'AndroidManifest.xml'
Backup-Once $manifestPath
[xml]$manifest = Get-Content -LiteralPath $manifestPath -Raw -Encoding UTF8
$app = $manifest.SelectSingleNode('/manifest/application')
if ($null -eq $app) { throw 'AndroidManifest.xml no tiene nodo application.' }
$app.SetAttribute('label', 'http://schemas.android.com/apk/res/android', 'Mythos')
$manifest.Save($manifestPath)

Write-Host 'Branding Android aplicado: sin logo de Flutter; Chiguire Grove nativo e icono de libro para Mythos.'
Write-Host 'Recompila con flutter run -d emulator-5554. Hot reload NO actualiza los recursos nativos.'
