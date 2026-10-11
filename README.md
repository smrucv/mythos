# Mythos Recovery v1

**Reconstrucción de una app Flutter de aventuras de texto a partir de `mythos-3.apk`.**

Esta distribución es **código fuente editable**, no un APK compilado. Contiene el JSON y las 5 imágenes originales extraídos del APK, sin alterar sus bytes. El código Dart es nuevo: el APK no contenía los `.dart` originales.

## Qué funciona en esta versión

- Biblioteca de cuatro historias con portadas originales, búsqueda y filtro por categoría.
- Detalles con sinopsis, duración estimada e inicio/continuación de partida.
- Motor narrativo con opciones que enlazan con `nextNodeId`, terminación automática cuando no hay opciones, soporte de campos `image` opcionales y negrita/cursiva simples.
- Historial de decisiones, deshacer último paso y reinicio con confirmación.
- Almacenamiento local por historia con `shared_preferences`, incluso tras cerrar la aplicación.
- Auditoría reproducible de la integridad de las historias.
- Pruebas de datos, persistencia y navegación (fuentes incluidas; **no ejecutadas en este entorno**).

## Abrir en Windows con Android Studio

Se necesita Flutter SDK (>=3.24; se recomienda una versión estable reciente), Android Studio con Android SDK, y un emulador o celular configurado para depuración USB.

1. Extrae este ZIP en una carpeta sin espacios problemáticos, por ejemplo `C:\proyectos\Mythos_Recovery_v1`.
2. Abre PowerShell en la carpeta del proyecto y ejecuta:

   ```powershell
   powershell -ExecutionPolicy Bypass -File .\scripts\iniciar_windows.ps1
   ```

   Esto genera los archivos de plataforma Android de Flutter que **no se pudieron generar dentro del entorno de recuperación**, instala dependencias, ejecuta análisis estático y pruebas. No modifica el contenido de las historias.

3. Si finaliza sin errores, abre en Android Studio **File > Open > Mythos_Recovery_v1** y pulsa Run con un dispositivo Android conectado.

Para ejecutar directamente desde PowerShell (una vez generado Android):

```powershell
flutter run
```

### Instalación manual alternativa

Desde la raíz del proyecto:

```powershell
flutter create --platforms=android --project-name=mythos_recovery --org com.mythos --no-pub .
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
scripts/                       # preparación con Flutter
  iniciar_windows.ps1
  iniciar_linux_macos.sh
test/                          # tres pruebas Flutter
tools/audit_assets.py          # auditoría de historias
  
docs/                          # auditorías y decisiones técnicas
```

## Limitaciones y decisiones intencionales

1. **El diseño de la app original no se conoce con precisión.** Esta interfaz es una propuesta de recuperación que utiliza el arte recuperado, no una reproducción exacta comprobada.
2. **El Asalto Neon tiene 12 IDs de nodo duplicados**, con rutas ambiguas. No se reescribió `stories.json`. Para IDs duplicados se usa de forma consistente la **primera** aparición; el resultado puede diferir del comportamiento de la app anterior.
3. El botón «atrás» en el lector deshace la última decisión; el botón del sistema Android regresa al detalle. Esto evita navegar a un estado no guardado.
4. La duración de la historia viene del JSON original. El contador «PASO» es el número de decisiones de esa partida, no un porcentaje de finalización (las historias ramifican).
5. **Sin Firebase:** no se incluyeron credenciales ni autenticación. La presencia de bibliotecas Firebase en el APK no permite restaurar la configuración original.
6. No es posible garantizar compilación o ejecución hasta ejecutar `flutter analyze` y `flutter test` en una máquina con Flutter SDK instalado. Si un diagnóstico falla, conserva su salida para corregirlo.

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
