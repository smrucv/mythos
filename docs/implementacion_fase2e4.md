# Mythos — Implementación Fase 2E.4

Fecha: 2026-10-13. Base: `f7cd2daabe3b362e4316a87d1a518f82447f9654`, rama main. Antes de editar, no había cambios rastreados; el informe de propuestas 2E.3 ya existía sin seguimiento y se preservó. Se verificó la coincidencia completa de la fuente con el commit base y de los textos afectados con las citas de 2E.3. No hubo discrepancias sustanciales.

## Alcance exacto

Se implementaron exclusivamente **E30-A, E56-B y E32-A**. Son nueve campos de nodos existentes y una definición nueva jugable. No se implementaron E30-B/E56-A/E32-B, recuperaciones de borradores ni ninguna otra reconexión.

Manifiesto: `docs/cambios_autorizados_fase2e4.json`; antes/después completo de los nueve campos y definición completa agregada. Diff literal de los tres recursos cambiados: `docs/diff_narrativo_fase2e4.patch`.

### node8q — text

**Antes**

[EVADIR EXITOSAMENTE] Utilizas rutas alternativas para escapar, evitando a las fuerzas de seguridad.

**Implementado**

[EVASIÓN DURANTE LA RETIRADA] Utilizas rutas alternativas para evitar a las fuerzas de seguridad. Has detenido el hackeo y la misión sigue incompleta. Todavía estás dentro del NeuroBank: puedes mantener la retirada o enfrentarte a los guardias que intentan alcanzarte.

### node8q — choices.0.text

**Antes**

[FINAL EXITOSO] Completar la misión con éxito

**Implementado**

[CONTINUAR LA RETIRADA] Seguir las rutas alternativas hasta salir del NeuroBank

### final30 — text

**Antes**

**Final: Escape Seguro**
Completa la misión con éxito, escapando con los datos extraídos sin contratiempos.

**Implementado**

**Final: Escape con Misión Incompleta**

Mantienes la retirada por las rutas alternativas y consigues dejar atrás a las fuerzas de seguridad. Sales del NeuroBank con vida, sin volver al núcleo ni reanudar el hackeo que decidiste detener. La extracción quedó inconclusa: escapar no ha completado el objetivo de la misión. Has logrado salir del banco, pero no puedes presentar tu retirada como una extracción exitosa.

### node8ad — text

**Antes**

[ESCAPADA EXITOSA] Decides escapar antes de que el sistema se reinicie, dejando atrás la misión incompleta.

**Implementado**

[ÚLTIMA DECISIÓN EN MANTENIMIENTO] Has decidido retirarte, pero todavía estás en la sala de mantenimiento. El terminal abrió el camino hacia el núcleo; no te entregó la información de la misión. El reinicio ha alertado a más guardias y cada demora aumenta el riesgo. Puedes continuar hacia la salida o detener la retirada y volver al camino del núcleo para intentar extraer los datos antes del reinicio.

### node8ad — choices.0.text

**Antes**

[FINAL EXITOSO] Completar la misión con éxito

**Implementado**

[INTENTAR LA EXTRACCIÓN] Detener la retirada y dirigirte al núcleo para hackear la información antes del reinicio

### node8ad — choices.0.nextNodeId

**Antes**

final56

**Implementado**

node_extraccion_desde_mantenimiento

### final56 — text

**Antes**

**Final: Misión Exitosa**
Completa la misión con éxito, escapando con los datos extraídos y cambiando el destino de la humanidad.

**Implementado**

**Final: Extracción y Escape Tras el Último Intento**

Mantienes el hackeo del núcleo mientras la IA intenta cortar tu acceso. Cada interrupción te obliga a ajustar los comandos y reanudar la transferencia; compruebas la descarga hasta obtener la información necesaria antes del reinicio. Después desconectas el acceso y emprendes la retirada. Vuelves por el trayecto de entrada, evitas a los guardias que buscas dejar atrás y alcanzas los ductos donde la barrera de láseres quedó destruida. Logras salir del NeuroBank con los datos. Has cumplido el objetivo de extracción y escape, pero el éxito no deshace los daños que Lira sufrió ni establece qué consecuencias tendrá esa información fuera del banco.

### node8r — choices.0.text

**Antes**

[ESCAPAR CON DATOS] Iniciar la fuga con los datos extraídos

**Implementado**

[APROVECHAR LA DISTRACCIÓN] Continuar la retirada mientras los guardias tienen la atención desviada

### final32 — text

**Antes**

**Final: Escape con Trampas**
Inicias la fuga con los datos extraídos, aprovechando las trampas colocadas para asegurar una extracción exitosa.

**Implementado**

**Final: Retirada Bajo Distracción**

Aprovechas la distracción que acabas de crear para alejarte de los guardias. Regresas desde el núcleo por el trayecto del ascensor de emergencia hacia la zona de carga y consigues salir del NeuroBank mientras su atención está desviada. No has reanudado el hackeo que decidiste detener: la extracción sigue incompleta y la misión no se ha cumplido. La distracción te permitió escapar; no convirtió la retirada en una obtención de datos.

## Nueva escena completa

Se añadió `node_extraccion_desde_mantenimiento` al final, posición nodes[354] base cero. Ninguna definición anterior se movió, renombró, eliminó o fusionó. Tiene dos decisiones distintas; no es un terminal y no salta automáticamente a victoria.

```json
{
  "id": "node_extraccion_desde_mantenimiento",
  "text": "[ACCESO AL NÚCLEO] Dejas el terminal de mantenimiento y sigues el trayecto hacia el núcleo que localizaste al manipular la seguridad. Los guardias alertados por el reinicio te obligan a avanzar con cuidado. Llegas al núcleo e inicias un hackeo de sus datos: abrir puertas no era suficiente para obtenerlos. La IA contrarresta la intrusión mientras el reinicio se aproxima. Puedes mantener el intento hasta completar la descarga o interrumpirlo y buscar la salida.",
  "choices": [
    {
      "text": "[SOSTENER EL HACKEO] Resolver los bloqueos de la IA y mantener la descarga hasta obtener la información necesaria",
      "nextNodeId": "final56"
    },
    {
      "text": "[CORTAR Y RETIRARSE] Interrumpir el hackeo y salir sin completar la misión",
      "nextNodeId": "final57"
    }
  ]
}
```

## Integridad y recursos

| Historia | Definiciones / IDs únicos | Accesibles | Terminales accesibles | Borradores |
|---|---:|---:|---:|---:|
| laberinto_medianoche | 69 / 69 | 69 | 8 | 0 |
| odisea_destino | 157 / 157 | 157 | 6 | 0 |
| android_secret | 12 / 12 | 12 | 3 | 0 |
| cyberpunk_heist | 355 / 355 | 314 | 153 | 41 |

Cero destinos inexistentes y ciclos en las cuatro historias, incluidas las definiciones inaccesibles. El conjunto de todos los terminales previamente accesibles es idéntico; ningún nodo antes accesible se perdió. El único nodo recién accesible es la escena creada; los 41 borradores son exactamente los mismos. Las cuatro recuperaciones de 2B permanecen intactas.

Las otras tres historias son idénticas a f7cd2da. De los 592 textos narrativos existentes, 587 permanecen iguales y cinco son reescrituras autorizadas; se añade el texto de la escena nueva, total 593 definiciones. Tres textos de decisión existentes y un destino cambian, además de las dos decisiones nuevas. Los textos reemplazados quedan documentados íntegros en este informe y manifiesto. No hubo ninguna otra pérdida o modificación.

Se ejecutó `py -3 tools/split_stories.py`. El índice solo incorpora el nuevo ID al final de nodeIds de Neon: no cambia títulos, descripciones, imágenes, duración ni otros metadatos. El JSON individual de Neon coincide semánticamente con la fuente; los otros derivados permanecen iguales. Se comprobaron fuente, índice y cuatro historias individuales dentro del APK debug contra los recursos actuales.

## Pruebas y compilación ejecutadas en esta fase

- `flutter analyze`: código 0, No issues found, 13,0 segundos.
- `flutter test --reporter compact`: código 0, **89 pruebas aprobadas**. Se conservaron las 74 anteriores y se añadieron 15 específicas.
- `flutter build apk --debug`: código 0, assembleDebug 29,5 segundos; caché Gradle estable C:\Mythos\.gradle-mythos.
- APK: `build/app/outputs/flutter-apk/app-debug.apk`.
- SHA-256: `b63166d02fffc3786f2e5fe9171671fd0c20413eb076965690c260343c50977e`.
- Tamaño: 195370399 bytes.

Las pruebas nuevas verifican el manifiesto frente a f7cd2da y los textos aprobados en 2E.3, igualdad completa del catálogo transformado, inversión exacta al catálogo anterior, nueva definición y posición, grafos y conjuntos de alcance, los cinco recorridos exigidos y cuatro hermanos (final31/33/54/55), guardado, restauración, retroceso, reelección y ausencia de IDs duplicados en esos historiales. También restauran guardados antiguos en final30/56/32 sin insertar pasos nuevos.

Las expectativas numéricas incompatibles se actualizaron a 593 definiciones totales, 355 de Neon y 314 accesibles. La comparación histórica de la fixture reconstruye 2E.2 eliminando exactamente la definición agregada y revirtiendo solo los nueve campos aprobados, con comprobaciones de igualdad previas; la prueba independiente de 2E.4 compara el catálogo completo actual contra el commit f7cd2da más el manifiesto. No se omiten campos ni se toleran cambios no autorizados. La fixture anterior a Fase 1 y los manifiestos/informes anteriores están intactos.

Los recorridos y comprobaciones de canon 2E.2 y 2B se ejecutaron otra vez como parte de las 89 pruebas: captura final134, ambos abandonos de node8ak, éxito final128 vía node9c, ruptura/cumplimiento del pacto, final9 y alianza final8, cumplimiento parcial y las cuatro variantes recuperadas. Estas son pruebas Flutter con SharedPreferences simulado y no se presentan como Android.

## Android 15: resultados efectivos

**Cinco recorridos completos aprobados en emulator-5554, Android 15/API35**, sobre el APK debug compilado en esta fase, instalado con adb install -r. Se navegaron elecciones reales desde node1; no se inyectaron IDs, partidas ni historial para llegar a los finales.

| Caso | Final | Recorrido Android completo |
|---|---|---|
| E30-A | final30 | node1 → node2b → node3d → node4g → node5k → node6v → node8q → final30 |
| E56-B: completar | final56 | node1 → node2a → node3a → node4a → node5b → node6c → node7f → node8ad → node_extraccion_desde_mantenimiento → final56 |
| E56-B: abandonar intento | final57 | node1 → node2a → node3a → node4a → node5b → node6c → node7f → node8ad → node_extraccion_desde_mantenimiento → final57 |
| E56-B: abandono directo | final57 | node1 → node2a → node3a → node4a → node5b → node6c → node7f → node8ad → final57 |
| E32-A | final32 | node1 → node2b → node3d → node4g → node5k → node6v → node8r → final32 |

En cada caso se comprobaron etiquetas y destinos, preferencias nativas escritas por la app, historial exacto y sin duplicados, retroceso, reelección, force-stop, reapertura y restauración del final mediante la ficha de la biblioteca. En las dos rutas con escena nueva también se retrocedió del final a la escena y de ella a node8ad, después se reeligió la escena y el final, manteniendo el historial esperado. En la ruta exitosa se cerró y reabrió además la app mientras estaba en la escena nueva: Continuar aventura restauró esa escena con completed=false y el historial exacto.

Se inspeccionaron visualmente las capturas de la escena nueva —texto y ambas elecciones— y de final30, final56, final57 y final32. Se verificó que la escena espera una elección y que ambas acciones realmente pueden ejecutarse. No se encontraron E/flutter, Unhandled Exception o FATAL EXCEPTION en el logcat de la ejecución aprobada. Estas pruebas no se confunden con los 89 tests Flutter con almacenamiento simulado.

El primer intento de automatización falló al buscar Neon antes de recorrer una ruta; la jerarquía observada quedó en el launcher. El arnés temporal pulsaba Atrás sin comprobar si había teclado visible. Se corrigió esa interacción para ocultar solo un teclado detectado y se reforzó la selección del buscador de la biblioteca. Los datos previos se restauraron y verificaron después del intento y después de la ejecución aprobada. No se modificó código de UI ni se cuenta ese intento fallido como prueba aprobada.

### Preservación de datos Android

Antes de instalar/probar, con la app detenida, se creó un archivo tar completo de su directorio privado mediante run-as y se validó su estructura y sus rutas. Tamaño: 67056640 bytes. SHA-256: `c0c4f9b3d0fdcf5944d4b2845b3873807031839ddc30ad3a117467efd87447dc`. Se comprobó el mismo hash al transferir el respaldo al dispositivo, antes de tocar las partidas de prueba. No se aceptó la salida de cat como un respaldo ni se usó wipe-data.

Al finalizar se restauraron los directorios persistentes originales desde el respaldo y se verificaron por SHA-256 los 1 archivos persistentes originales archivados. El archivo FlutterSharedPreferences.xml no existía originalmente, comprobado por el archivo tar validado: se retiró exclusivamente el archivo generado por las partidas de prueba y se verificó de nuevo su ausencia. No se borró ninguna preferencia preexistente ni se alteraron otras apps del emulador. Los respaldos y evidencia están fuera del repositorio, en la carpeta temporal mythos-phase2e4-evidence.

Limitaciones: se probó este emulador, no un dispositivo físico. No se certifican todos los frames ni fluidez del inicio. Las regresiones 2E.2/2B se repitieron en la suite Flutter; no se afirman nuevos recorridos Android de esas rutas antiguas en esta fase.


## Compatibilidad de partidas

No cambian ProgressStore, SharedPreferences, mythos.progress.v1, IDs existentes ni identidad Android. Los guardados en final30/56/32 muestran el canon corregido autorizado aunque su historial sea anterior. No se añade retroactivamente la escena nueva ni se borra progreso. Un final56 antiguo puede conservar historial directo node8ad→final56: se restaura así, sin fingir que realizó la nueva extracción. Al retroceder se vuelve a node8ad; una nueva elección explícita sí entra en la escena nueva. Los guardados en los padres ven textos/acciones nuevos sin navegación automática. El texto de final57 y sus tres rutas anteriores de abandono permanecen intactos.

## Archivos modificados o creados por esta fase

- assets/stories/stories.json
- assets/stories/index.json
- assets/stories/content/cyberpunk_heist.json
- test/narrative_phase2b_test.dart
- test/narrative_phase2e2_test.dart
- test/story_catalog_test.dart
- test/story_integrity_test.dart
- test/story_repository_test.dart
- test/support/narrative_phase2e2.dart
- test/narrative_phase2e4_test.dart
- test/support/narrative_phase2e4.dart
- docs/cambios_autorizados_fase2e4.json
- docs/diff_narrativo_fase2e4.patch
- docs/implementacion_fase2e4.md

El documento preexistente `docs/propuestas_correccion_narrativa_fase2e3.md` no se modificó ni se creó en esta fase. No se incluyen en los entregables archivos de build, cachés, respaldos privados, capturas ni arneses temporales.

## Pendientes y clasificación futura

No se modifica el registro 2D.2 ni sus cantidades. En una revisión aprobada, final30 y final32 serán candidatos a retirada con objetivo incumplido, con evasión/distracción como variantes; final32 ya no aporta evidencia de trampas. final56 será candidato a extracción y escape, con último intento y heridas de Lira como circunstancias; ya no afirma transformación de la humanidad. El historial antiguo de final56 no prueba que se recorrió la nueva escena. No se implementa colección de finales ni mapeos de descubrimiento.

final31/33/54/55, el mecanismo preciso del distractor y los 41 borradores siguen fuera del alcance. No se alteran el pacto de 2E.2, la traición, la fuga interceptada ni las recuperaciones 2B. UI, splash, branding, Firebase, motor, persistencia, duración y dependencias no se modificaron. No se certifica la fluidez o todos los frames del splash con estas pruebas narrativas.

## Estado Git

HEAD permanece en f7cd2da, rama main. No se realizó staging, commit ni push; el índice de Git conserva su estado limpio. El commit local por delante de origin/main es el de cierre 2E.2, preexistente, no un commit de esta fase.

Son nueve archivos rastreados modificados y cinco archivos nuevos de 2E.4 (catorce en total); además sigue sin seguimiento la propuesta 2E.3 preexistente y preservada. Este documento aprobado de 2E.3 es la fuente editorial comprobada por los nuevos tests y deberá incluirse intacto en un futuro commit autorizado, junto con la implementación.

Los hashes muestran que los demás archivos rastreados, los manifiestos/documentos anteriores, la fixture histórica y la propuesta preexistente siguen intactos. La propuesta y los otros archivos nuevos no se añaden a Git sin aprobación del autor.

Comprobación de diff: git diff --check correcto. No se considera incluida en el diff narrativo ninguna modificación de pruebas: el patch entregado reproduce únicamente los tres recursos JSON. La lista de archivos de este informe incluye ambos helpers y todos los tests ajustados.

Para reproducir la verificación: flutter analyze, flutter test y flutter build apk --debug, utilizando GRADLE_USER_HOME=C:\Mythos\.gradle-mythos cuando corresponda. APK generado en build/app/outputs/flutter-apk/app-debug.apk. Los resultados consignados arriba fueron realmente ejecutados en esta fase.

**Implementación terminada para revisión; se espera aprobación antes de crear un commit local.**
