$ErrorActionPreference = 'Stop'
$projectRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$androidRes = Join-Path $projectRoot 'android\app\src\main\res'
if (-not (Test-Path $androidRes)) { throw 'No existe la plataforma Android del proyecto.' }
# Este script solo neutraliza la ventana inicial. No cambia launcher, manifiesto ni identidad.
$resources = @{
    'values/launch_colors.xml' = '<?xml version="1.0" encoding="utf-8"?>
<resources>
    <!-- Superficie de espera sin marca, igual al primer frame Flutter. -->
    <color name="launch_background_color">#F5F2EA</color>
</resources>
'
    'drawable/launch_no_icon.xml' = '<?xml version="1.0" encoding="utf-8"?>
<!-- Neutraliza el icono automatico de Android 12+, sin presentar una marca. -->
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="1dp" android:height="1dp"
    android:viewportWidth="1" android:viewportHeight="1">
    <path android:fillColor="#00000000" android:pathData="M0,0 L1,0 L1,1 L0,1 Z" />
</vector>
'
    'drawable/launch_background.xml' = '<?xml version="1.0" encoding="utf-8"?>
<layer-list xmlns:android="http://schemas.android.com/apk/res/android">
    <item android:drawable="@color/launch_background_color" />
</layer-list>
'
    'drawable-v21/launch_background.xml' = '<?xml version="1.0" encoding="utf-8"?>
<layer-list xmlns:android="http://schemas.android.com/apk/res/android">
    <item android:drawable="@color/launch_background_color" />
</layer-list>
'
    'values/styles.xml' = '<?xml version="1.0" encoding="utf-8"?>
<resources>
    <!-- Sin presentacion nativa: la identidad empieza en la animacion Flutter. -->
    <style name="LaunchTheme" parent="@android:style/Theme.Light.NoTitleBar">
        <item name="android:windowBackground">@color/launch_background_color</item>
    </style>
    <style name="NormalTheme" parent="@android:style/Theme.Light.NoTitleBar">
        <item name="android:windowBackground">@color/launch_background_color</item>
    </style>
</resources>
'
    'values-v31/styles.xml' = '<?xml version="1.0" encoding="utf-8"?>
<resources>
    <!-- Sin presentacion nativa: la identidad empieza en la animacion Flutter. -->
    <style name="LaunchTheme" parent="@android:style/Theme.Light.NoTitleBar">
        <item name="android:windowBackground">@color/launch_background_color</item>
        <item name="android:windowSplashScreenBackground">@color/launch_background_color</item>
        <item name="android:windowSplashScreenAnimatedIcon">@drawable/launch_no_icon</item>
    </style>
</resources>
'
    'values-night/styles.xml' = '<?xml version="1.0" encoding="utf-8"?>
<resources>
    <!-- Sin presentacion nativa: la identidad empieza en la animacion Flutter. -->
    <style name="LaunchTheme" parent="@android:style/Theme.Black.NoTitleBar">
        <item name="android:windowBackground">@color/launch_background_color</item>
    </style>
    <style name="NormalTheme" parent="@android:style/Theme.Black.NoTitleBar">
        <item name="android:windowBackground">@color/launch_background_color</item>
    </style>
</resources>
'
    'values-night-v31/styles.xml' = '<?xml version="1.0" encoding="utf-8"?>
<resources>
    <!-- Sin presentacion nativa: la identidad empieza en la animacion Flutter. -->
    <style name="LaunchTheme" parent="@android:style/Theme.Black.NoTitleBar">
        <item name="android:windowBackground">@color/launch_background_color</item>
        <item name="android:windowSplashScreenBackground">@color/launch_background_color</item>
        <item name="android:windowSplashScreenAnimatedIcon">@drawable/launch_no_icon</item>
    </style>
</resources>
'
}
foreach ($relative in $resources.Keys) {
    $target = Join-Path $androidRes $relative
    New-Item -ItemType Directory -Force -Path (Split-Path -Parent $target) | Out-Null
    Set-Content -LiteralPath $target -Encoding UTF8 -Value $resources[$relative]
}
# Retirar exclusivamente los recursos del splash estatico anterior.
$obsolete = Join-Path $androidRes 'drawable-nodpi/chiguire_grove_splash_icon.png'
if (Test-Path -LiteralPath $obsolete) { Remove-Item -LiteralPath $obsolete }
$obsolete = Join-Path $androidRes 'drawable/grove_splash_android12.xml'
if (Test-Path -LiteralPath $obsolete) { Remove-Item -LiteralPath $obsolete }
$obsolete = Join-Path $androidRes 'values/mythos_brand_colors.xml'
if (Test-Path -LiteralPath $obsolete) { Remove-Item -LiteralPath $obsolete }
Write-Host 'Lanzamiento Android sin marca previa; la presentacion empieza en Flutter.'
