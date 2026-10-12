# Mythos — Cierre técnico de la Fase 2B

Fecha local: 2026-10-11. Referencia: `docs/implementacion_fase2b.md`. Se validó la implementación existente, sin introducir nuevas conexiones, funcionalidades, dependencias ni cambios de interfaz.

## Resultado de controles críticos

| Control | Resultado efectivamente obtenido |
|---|---|
| `flutter analyze --no-pub` | Código 0, **No issues found**, 24,5 s |
| `flutter test --no-pub` | Código 0, **60 pruebas aprobadas** |
| `flutter build apk --debug --no-pub` | Código 0, APK debug generado; `assembleDebug` 132,0 s |
| Ejecución Android del APK debug | Apertura de biblioteca/El Asalto Neon, elecciones, cuatro finales recuperados, retroceso y restauración comprobados |
| Integridad narrativa | 354 definiciones y 354 IDs únicos; 313 accesibles; 41 borradores; solo B1–B4 modificados |
| Conservación de contenido | Los 592 textos y todas las demás conexiones se conservan |
| Log de ejecución revisado | Sin coincidencias de `E/flutter`, `Unhandled Exception` ni `FATAL EXCEPTION`; sí hubo avisos de frames omitidos |

Los controles de datos, compilación, rutas y persistencia pasaron. **La certificación visual completa y de rendimiento del arranque queda limitada**, como se detalla abajo; no se declara una animación íntegra, fluida o cronometrada visualmente.

Se utilizó `--no-pub` para no actualizar dependencias. Las compilaciones usaron la caché estable `C:\Mythos\.gradle-mythos`. No se modificaron `pubspec.yaml`, `pubspec.lock`, el motor narrativo, el almacenamiento ni la identidad Android.

## Compilación Android y APK realmente probado

El APK debug de `build/app/outputs/flutter-apk/app-debug.apk` se instaló mediante `adb install -r`, conservando el directorio de datos. El paquete comprobado fue `com.mythos.mythos`.

- Tamaño debug: 195.369.592 bytes.
- SHA-256 debug: `565f93e93d1f97d12cddf44fdce387dd5f05dc4f930549647e703bfc1fd7fccc`.
- Se abrió el APK como archivo ZIP y se comprobó que su `assets/flutter_assets/assets/stories/stories.json` coincide semánticamente con la fuente validada del proyecto.
- El índice y los JSON individuales siguen sincronizados; ninguna dependencia ni dato narrativo se modificó durante este cierre.

Para investigar la limitación visual del inicio se realizó además una compilación de validación:

```powershell
flutter build apk --release --target-platform android-x64 --no-pub
```

También terminó con código 0: `assembleRelease` 162,9 s, APK de 21,3 MB. Su SHA-256 fue `03516a066973124700d4adec18e8046f6c30b5f3c20b5016a69a165a5c620c3a`. Sus datos narrativos también coincidieron con la fuente. La compilación emitió un aviso de familia `CupertinoIcons` no empaquetada y optimización de `MaterialIcons`; no se añadió ninguna dependencia para silenciarlo. Los controles Material observados en Android se mostraron correctamente.

Esta compilación adicional sirvió únicamente para observar el arranque sin JIT. **Las pruebas de cuatro desenlaces, elecciones, retroceso y persistencia descritas a continuación se ejecutaron sobre el APK debug**, no se sustituyeron por una prueba Dart ni por el APK release. Al terminar se dejó instalado de nuevo el APK debug validado.

## Dispositivos detectados

`flutter devices` detectó:

- `emulator-5554`: sdk gphone64 x86 64, Android 15, API 35, android-x64.
- Windows, Chrome y Edge, que no se utilizaron para afirmar validación Android.

El emulador tenía pantalla de 1080 × 2400. No había un teléfono Android físico disponible. Los resultados no se extrapolan a otros dispositivos o versiones del sistema.

## Pruebas efectivas en el emulador

Se automatizó la **interfaz Android real** mediante ADB y UIAutomator, desde un arnés Python temporal fuera del repositorio. Se consultaron etiquetas y coordenadas de la jerarquía de accesibilidad, se pulsaron los controles existentes y se comprobaron las preferencias escritas por la aplicación Android. No se inyectaron IDs ni partidas para saltar las rutas.

### Biblioteca, apertura y elecciones

Se observó la biblioteca y se abrió la ficha de El Asalto Neon mediante su tarjeta. Desde `Comenzar aventura` se recorrió:

```text
node1 → node2a → node3b → node4d → node5g → node6m → node7q → node8au
```

Cada elección se verificó contra el texto real del recurso y el nuevo ID guardado por la aplicación. La ficha, la primera escena y las pantallas de finales se capturaron desde el emulador y se inspeccionaron visualmente.

### Cuatro desenlaces recuperados

| Final alcanzado en Android | Elección real | Comprobación visible |
|---|---|---|
| `final134__v2` | `node8au`, decisión 1 | **Final: Extracción Exitosa a Ciegas**, texto correspondiente y `FIN DE ESTA RUTA` |
| `final135__v2` | Retroceso a `node8au`, decisión 2 | **Final: Ocultación y Escape Seguro**, texto correspondiente y fin de ruta |
| `final136__v2` | Retroceso a `node7q`, decisión 2 hacia `node8av`, luego decisión 1 | **Final: Misión Fallida por Ceguera**, texto correspondiente y fin de ruta |
| `final137__v2` | Retroceso a `node6m`, decisión 2 hacia `node7r`, decisión 2 hacia `node8ax`, luego decisión 1 | **Final: Escape Rápido sin Éxito**, texto correspondiente y fin de ruta |

Se reutilizó el prefijo de la partida mediante el botón de retroceso, sin reinicios ni edición de preferencias. Hubo 14 elecciones narrativas comprobadas y siete retrocesos verificados durante el recorrido y la restauración. Las cuatro pantallas de final se capturaron y revisaron; los registros guardados marcaban los finales como completados y mantenían el historial correcto.

### Cierre, reapertura y persistencia Android

Se verificaron dos cierres reales con `am force-stop`, no una simple reconstrucción de widgets:

1. Partida en `final137__v2`: se confirmó la ausencia del proceso, se volvió a iniciar Mythos, se abrió El Asalto Neon y `Ver final alcanzado`. La pantalla y el registro completo —ID, historial, completado y fecha— coincidieron con el guardado.
2. Tras retroceder a `node8ax`: se cerró y reabrió la aplicación y se seleccionó `Continuar aventura`. Se recuperaron el mismo nodo, el historial y la marca de partida no completada. La escena de retirada se observó en una captura real.

Se leyó la clave existente `flutter.mythos.progress.v1` del archivo Android `FlutterSharedPreferences.xml`; es la representación nativa del almacenamiento `mythos.progress.v1`. No se cambió ninguna clave ni código de persistencia.

El arnés temporal requirió corregir dos comprobaciones propias: aceptar el código 1 de `pidof` cuando el proceso ya no existe, y leer/escribir su registro temporal en UTF-8. Se completó después la verificación de restauración. Esas incidencias no fueron excepciones de Mythos ni cambios del motor.

### Conservación del estado previo del emulador

Antes de iniciar las pruebas se respaldó `shared_prefs` mediante `run-as`, después de instalar debug y antes de navegar. Al finalizar se detuvo la aplicación, se reinstaló debug y se restauraron las preferencias anteriores. Se compararon sus archivos y bytes contra el respaldo; la igualdad fue correcta. El respaldo inicial no tenía archivos de preferencias: solo se retiraron los archivos creados por estas pruebas, sin borrar una partida preexistente.

El APK debug quedó instalado y la aplicación detenida. No se modificaron las preferencias de otros paquetes. Los respaldos, scripts, logs, XML y capturas temporales no se añadieron a Git.

## Arranque: observaciones y limitaciones visuales

| Elemento | Evidencia observada | Límite de la comprobación |
|---|---|---|
| Chigüire Grove | En debug se capturó la identidad final del estudio. En release se capturó además una semilla visible y la aparición de la identidad | No se pudo confirmar visualmente toda la caída, el crecimiento/retracción, su duración o fluidez |
| Presentación MYTHOS | Libro y texto dorados sobre fondo oscuro capturados en debug; transición desde el estudio también visible en capturas release | Las capturas discretas no certifican todos los frames ni la duración exacta del fundido |
| Biblioteca | Capturas y jerarquía real de Android; navegación desde ella ejecutada en debug; biblioteca también observada en release | No implica validar todas las pantallas ajenas al alcance de esta fase |

Se realizaron arranques en frío y se capturaron frames. En este entorno se observó una pantalla neutra prolongada y avisos `Choreographer: Skipped ... frames`. Los logs debug registraron el inicio y el fin de Chigüire Grove con movimiento reducido desactivado, pero **un callback/log no demuestra que todos los frames se hayan mostrado**.

Se probó una vez el mismo APK debug con extras temporales de lanzamiento `enable-software-rendering=true` y `enable-impeller=false`, confirmados en el SDK Flutter local. No se cambiaron archivos de proyecto ni ajustes permanentes. La prueba no permitió certificar la animación completa y no demuestra que el problema se deba exclusivamente al renderizador. La compilación release permitió observar la semilla y la secuencia de identidades, pero tampoco acredita todo el crecimiento o el rendimiento en un teléfono real.

La causa de los frames no observados y del retraso no quedó determinada. No se corrigió ni rediseñó el inicio, por estar fuera del alcance autorizado. **La limitación queda abierta para una revisión específica de arranque/rendimiento; este commit preserva la corrección narrativa validada, no declara resuelta esa limitación.**

## Integridad narrativa final

La auditoría ejecutada mediante el diagnóstico existente obtuvo:

| Historia | Definiciones | IDs únicos | Accesibles | Borradores | Destinos inexistentes | Ciclos |
|---|---:|---:|---:|---:|---:|---:|
| `laberinto_medianoche` | 69 | 69 | 69 | 0 | 0 | 0 |
| `odisea_destino` | 157 | 157 | 157 | 0 | 0 | 0 |
| `android_secret` | 12 | 12 | 12 | 0 | 0 | 0 |
| `cyberpunk_heist` | 354 | 354 | 313 | 41 | 0 | 0 |

La comparación completa contra `HEAD` previo (`81f3d06`) coincide con una copia que aplica únicamente:

```text
node8au / decisión 1: final134 → final134__v2
node8au / decisión 2: final135 → final135__v2
node8av / decisión 1: final136 → final136__v2
node8ax / decisión 1: final137 → final137__v2
```

Los 592 textos, metadatos, IDs y orden de escenas/decisiones se conservan. `node9f` sigue hacia `final134/135` y `node9h` hacia `final136/137`; los finales originales siguen accesibles. No se implementaron A3/A4/A7/C1, G-extensión, G-reemplazo ni otra modificación narrativa. La fixture histórica permanece intacta.

## Alcance del commit local

Mensaje requerido:

```text
fix(mythos): restore four narrative endings in phase 2B
```

Se incluyen únicamente estos diez archivos:

1. `assets/stories/stories.json`
2. `assets/stories/content/cyberpunk_heist.json`
3. `docs/borradores_narrativos.json`
4. `docs/cambios_autorizados_fase2b.json`
5. `docs/implementacion_fase2b.md`
6. `docs/propuesta_recuperacion_narrativa_fase2.md`
7. `docs/cierre_fase2b.md`
8. `test/story_integrity_test.dart`
9. `test/narrative_phase2b_test.dart`
10. `test/support/narrative_phase1.dart`

El índice se regeneró en Fase 2B y siguió idéntico: no necesita un cambio artificial para aparecer en el commit. No se incluyeron APKs, `build`, cachés, datos del emulador, archivos personales ni herramientas temporales. `android/local.properties` cambió por las compilaciones, es generado e ignorado y quedó fuera del commit. Ninguna fuente existente cambió durante este cierre.

### Resultado del commit y estado Git

Commit local creado con el mensaje exacto indicado y los diez archivos revisados. La documentación de resultado se incorpora al mismo commit de cierre. El identificador final queda registrado en Git y se obtiene mediante:

```powershell
git log -1 --format="%H%n%s" -- docs/cierre_fase2b.md
```

Estado Git final: árbol de trabajo e índice limpios; rama `main` con un commit local por delante de `origin/main`. Se verifican nuevamente después de incorporar este resultado. No se ejecutó `git push`.
