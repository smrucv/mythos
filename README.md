# Mythos

Aplicación Flutter de aventuras narrativas interactivas.

## Plataforma y paquetes

- Nombre de la aplicación: **Mythos**.
- Paquete Flutter: `mythos`.
- Identificador Android: `com.mythos.mythos`.
- Splash: animación de Chigüire Grove, presentación de MYTHOS y biblioteca.

## Preparación de un proyecto nuevo

1. Instala Flutter y el SDK de Android.
2. Desde esta carpeta ejecuta `powershell -ExecutionPolicy Bypass -File .\scripts\iniciar_windows.ps1`.
3. Abre el proyecto en Android Studio o utiliza `flutter run -d emulator-5554`.

## Actualización de una instalación existente

1. Haz respaldo de la carpeta del proyecto y conserva instalada la versión anterior.
2. Copia los archivos del parche en la carpeta del proyecto actual.
3. Ejecuta `powershell -ExecutionPolicy Bypass -File .\scripts\actualizar_identidad_android.ps1`.
4. Ejecuta `flutter clean`, `flutter pub get`, `flutter analyze`, `flutter test` y `flutter run -d emulator-5554`.

**Atención:** cambiar el identificador Android hace que el sistema instale la aplicación bajo una identidad distinta. El progreso de una instalación anterior no se migra automáticamente. No desinstales la aplicación anterior hasta exportar sus datos si necesitas conservarlos. Si ya hay otra aplicación instalada con el mismo identificador, verifica la firma antes de reemplazarla. Esta actualización no debe desinstalar nada automáticamente.

## Recursos

Las historias se encuentran en `assets/stories/stories.json`. La app conserva las imágenes narrativas y el splash de Chigüire Grove. La iconografía del launcher con una «M» queda pendiente de disponer de su archivo original; no se ha inventado un icono sustituto.

## Ejecutar el arranque corregido (Windows)

Los recursos nativos ya están incluidos en Android; no hace falta recrear la plataforma ni cambiar la identidad.
Desde la raíz del proyecto, en PowerShell:

```powershell
$env:GRADLE_USER_HOME = 'C:\Mythos\.gradle-mythos'
flutter run -d emulator-5554
```

Para generar e instalar el APK de prueba:

```powershell
$env:GRADLE_USER_HOME = 'C:\Mythos\.gradle-mythos'
flutter build apk --debug
flutter install --debug -d emulator-5554
```

Cerrar y volver a abrir Mythos permite comprobar el arranque. Hot reload no actualiza recursos nativos.
La secuencia conserva la animación original del estudio, usa fundidos de 600 ms con easeInOut y mantiene MYTHOS 1500 ms después de terminar el fundido de entrada. Con movimiento reducido, omite los fundidos y conserva esa permanencia.
Android solo mantiene un fondo neutro mientras prepara el primer frame, sin logo previo. La presentación comienza con la animación Flutter original; el launcher se conserva.

## Carga de historias

Flutter presenta el primer frame antes de leer datos. El índice de biblioteca y el progreso se abren en paralelo durante la presentación. El índice contiene las fichas y los IDs de nodo para validar las partidas, sin texto narrativo.
Cada historia completa se carga al abrirla y se reutiliza en memoria al pasar a lectura o volver a sus detalles. Los fallos permiten reintentar sin modificar el progreso.

`assets/stories/stories.json` se conserva como fuente original. Después de editarlo, regenera los archivos de ejecución con `py -3 tools/split_stories.py`. Las pruebas comparan esos archivos con la fuente para detectar diferencias de contenido.
