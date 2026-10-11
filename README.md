# Mythos Recovery v1.2

**Reconstrucción de una app Flutter de aventuras de texto a partir de `mythos-3.apk`.**

**Versión 1.2 (splash y branding):** nuevo flujo de arranque con la animación original de Chigüire Grove (5,7 s), una pantalla MYTHOS minimalista con libro abierto y fondo `#10101A` (1,5 s) y, finalmente, la biblioteca. Se incluye branding Android para reemplazar el icono de Flutter. Las historias, imágenes y sistema de progreso no se modificaron.

**Revisión 1.1:** el script ya elimina la prueba generada por `flutter create` que importaba una clase `MyApp` inexistente.

Esta distribución es **código fuente editable**, no un APK compilado. Contiene el JSON y las 5 imágenes originales extraídos del APK, sin alterar sus bytes. El código Dart es nuevo: el APK no contenía los `.dart` originales.

## Actualización desde Mythos Recovery v1.1 (Windows)

Si ya tienes Mythos Recovery ejecutándose en el emulador, **no recrees Android ni borres el proyecto actual**:

1. Haz una copia de la carpeta actual `Mythos_Recovery_v1`.
2. Descarga el ZIP **parche v1.2** y extrae **su contenido** directamente en la carpeta de tu proyecto actual (`C:\Mythos\Mythos_Recovery_v1_Flutter\Mythos_Recovery_v1`). Acepta reemplazar los archivos con el mismo nombre. No borres la carpeta `android` que ya funciona.
3. En PowerShell, desde la raíz del proyecto, ejecuta:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\aplicar_branding_android.ps1
flutter pub get
flutter analyze
flutter test
flutter run -d emulator-5554
```

**Importante:** si Gradle vuelve a intentar utilizar la caché global corrupta que se detectó en tu PC, en esa misma ventana de PowerShell ejecuta `$env:GRADLE_USER_HOME = 'C:\Mythos\.gradle-mythos'` antes de `flutter run`.

**No uses solamente hot reload** para comprobar el splash nativo: sus cambios requieren recompilar/reinstalar la app (`flutter run`). El instalador **no modifica** `applicationId`, así que el progreso local existente se conserva cuando reinstalas la misma app sin desinstalarla ni borrar sus datos.

### Secuencia al abrir la app

- **Android nativo:** fondo crema y isotipo de Chigüire Grove, nunca icono de Flutter. Esta pantalla la controla Android (duración variable según arranque).
- **Chigüire Grove:** animación original adjunta del brote, isotipo SVG, marca y lema, 5,7 segundos. El sonido está desactivado por defecto, como en el archivo recibido. El archivo Dart usa la familia tipográfica `Sora`, pero esa fuente no fue adjuntada; Flutter utilizará una alternativa del sistema hasta que añadamos la fuente original.
- **MYTHOS:** fondo `#10101A`, libro abierto de trazado simple y texto `MYTHOS` en `#EECFA0`, 1,5 segundos. El dibujo se construye con Flutter; no se utiliza ninguna imagen generada de MYTHOS.
- **Biblioteca:** interfaz que ya usabas, sin cambios.

Con opciones de accesibilidad de movimiento reducido, se acortan ambas pantallas.

## Qué funciona en esta versión

- Biblioteca de cuatro historias con portadas originales, búsqueda y filtro por categoría.
- Detalles con sinopsis, duración estimada e inicio/continuación de partida.
- Motor narrativo con opciones que enlazan con `nextNodeId`, terminación automática cuando no hay opciones, soporte de campos `image` opcionales y negrita/cursiva simples.
- Historial de decisiones, deshacer último paso y reinicio con confirmación.
- Almacenamiento local por historia con `shared_preferences`, incluso tras cerrar la aplicación.
- Auditoría reproducible de la integridad de las historias.
- Pruebas de datos, persistencia y navegación (fuentes incluidas; **no ejecutadas en este entorno: Flutter SDK no disponible aquí**).

## Abrir en Windows con Android Studio

Se necesita Flutter SDK (3.41.5 verificada por el usuario; se recomienda una versión estable reciente), Android Studio con Android SDK, y un emulador o celular configurado para depuración USB.

1. Extrae este ZIP en una carpeta sin espacios problemáticos, por ejemplo `C:\proyectos\Mythos_Recovery_v1`.
2. Abre PowerShell en la carpeta del proyecto y ejecuta:

   ```powershell
   powershell -ExecutionPolicy Bypass -File .\scripts\iniciar_windows.ps1
   ```

   Esto genera Android **solo si no existe**, aplica el branding y luego instala dependencias, ejecuta análisis estático y pruebas. No modifica el contenido de las historias.

3. Si finaliza sin errores, abre en Android Studio **File > Open > Mythos_Recovery_v1** y pulsa Run con un dispositivo Android conectado.

### Si ya ejecutaste el script antiguo y apareció el error `MyApp`

Desde la carpeta raíz del proyecto que ya tienes instalado, ejecuta:

```powershell
Remove-Item .\test\widget_test.dart
flutter analyze
flutter test
```

No borres las otras tres pruebas (`app_smoke_test.dart`, `progress_store_test.dart`, `story_catalog_test.dart`). No es necesario descargar dependencias otra vez ni recrear Android. Si sustituyes el script por esta revisión 1.1, puedes volver a ejecutarlo: detecta y elimina el test de ejemplo sin tocar las pruebas propias.

Para ejecutar directamente desde PowerShell (una vez generado Android):

```powershell
flutter run
```

### Instalación manual alternativa

Desde la raíz del proyecto:

```powershell
flutter create --platforms=android --project-name=mythos_recovery --org com.mythos --no-pub .
powershell -ExecutionPolicy Bypass -File .\scripts\aplicar_branding_android.ps1
flutter pub get
flutter analyze
flutter test
flutter run
```

Flutter generará un identificador distinto del APK antiguo: `com.mythos.mythos_recovery`. Así se pueden instalar ambas apps lado a lado sin pisar la original. **No se importan partidas previas del APK antiguo**; sus datos privados no están dentro de un APK estándar.

## Estructura

```text
lib/
  main.dart                    # inicio
  app.dart                     # rutas con go_router
  models/story.dart            # lectura de JSON y validación
  services/progress_store.dart # progreso persistente
  screens/                     # biblioteca, detalle, lector
  widgets/                     # tema, imágenes, texto
assets/stories/stories.json     # archivo original intacto
assets/images/*.webp           # 5 imágenes originales intactas
assets/branding/*.svg          # isotipo original de Chigüire Grove
branding/android/res/          # bitmaps nativos para splash y launcher
scripts/                       # preparación con Flutter
  aplicar_branding_android.ps1 # splash nativo, iconos y nombre Android
  iniciar_windows.ps1
  iniciar_linux_macos.sh
test/                          # cuatro pruebas Flutter, incluido el flujo splash
tools/audit_assets.py          # auditoría de historias
  
docs/                          # auditorías y decisiones técnicas
```

## Limitaciones y decisiones intencionales

1. **El diseño de la app original no se conoce con precisión.** Esta interfaz es una propuesta de recuperación que utiliza el arte recuperado, no una reproducción exacta comprobada.
2. **El Asalto Neon tiene 12 IDs de nodo duplicados**, con rutas ambiguas. No se reescribió `stories.json`. Para IDs duplicados se usa de forma consistente la **primera** aparición; el resultado puede diferir del comportamiento de la app anterior.
3. El botón «atrás» en el lector deshace la última decisión; el botón del sistema Android regresa al detalle. Esto evita navegar a un estado no guardado.
4. La duración de la historia viene del JSON original. El contador «PASO» es el número de decisiones de esa partida, no un porcentaje de finalización (las historias ramifican).
5. **Sin Firebase:** no se incluyeron credenciales ni autenticación. La presencia de bibliotecas Firebase en el APK no permite restaurar la configuración original.
6. La actualización 1.2 no pudo compilarse en este entorno, que no tiene Flutter SDK; ejecutar `flutter analyze`, `flutter test` y `flutter run` localmente confirma el estado. Si un diagnóstico falla, conserva su salida para corregirlo.

## Integridad y copias de seguridad

El contenido extraído proviene de `mythos-3.apk`, cuyo SHA-256 se registra en `docs/INTEGRIDAD.json`. El script `tools/audit_assets.py` comprueba las historias y genera el informe en `docs/auditoria_historias.json`.

Para revisar con Python:

```powershell
python tools/audit_assets.py
```

Versiona **el código** en un repositorio privado Git y guarda por separado el **APK original** y el ZIP inicial `Mythos_recursos_recuperados.zip`.

## Próximas iteraciones

- Contrastar capturas de cada pantalla con el APK instalado.
- Resolver los nodos duplicados mediante inspección de las rutas entrantes y decisiones narrativas.
- Revisar restauración de progreso y pruebas en Android real.
- Solo entonces incorporar Firebase y nuevas funcionalidades del MVP.
