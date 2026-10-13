# Mythos — Cierre de Fase 2E.2

Fecha: 2026-10-13. Base editorial/técnica original: a66c814. Estado previo al cierre: 5f7dab0, ya publicado por petición anterior del usuario. Este cierre no publica nada.

## Décimo ajuste autorizado

Solo se cambia node7k, primera elección, campo text:

- Antes: `[ACUERDO COMPLETO] Cumplir con las condiciones de la IA`.
- Después: `[OBTENER LOS DATOS] Aprovechar el acceso concedido y obtener la información antes de pagar el precio acordado`.
- Destino conservado: node9e. Segunda elección y destino node9f intactos.

Se conserva literalmente el manifiesto original de nueve cambios `docs/cambios_autorizados_fase2e2.json`, el informe `docs/implementacion_fase2e2.md` y su diff histórico. El nuevo `docs/ajuste_autorizado_cierre_fase2e2.json` extiende la aprobación con exactamente un campo; las pruebas aplican ambos manifiestos y siguen comparando el JSON completo contra a66c814. La regresión adicional exige texto exacto y ambos destinos. No se debilitan las validaciones ni se sobrescribe la fixture histórica.

## Verificaciones Flutter y datos

- `py -3 tools/split_stories.py`: índice y cuatro derivados regenerados y sincronizados. Solo cambia el derivado de Neon; el índice es idéntico.
- `flutter analyze --no-pub`: sin incidencias; comprobación final de 57,8 segundos.
- `flutter test --no-pub --reporter compact`: 74 pruebas aprobadas; 60 previas a 2E.2, 13 de implementación y una nueva de cierre.
- `flutter build apk --debug --no-pub`: correcto, assembleDebug en 118,6 segundos, caché C:\Mythos\.gradle-mythos.
- El APK contiene la fuente y los cuatro JSON individuales semánticamente idénticos al proyecto.
- Comparación completa contra 5f7dab0: solo cambia el texto autorizado de node7k. Frente a a66c814 son los nueve cambios originales más este décimo.
- Neon mantiene 354 definiciones e IDs únicos, 313 accesibles, 153 terminales accesibles y 41 borradores. Cero ciclos y referencias inexistentes. Las otras tres historias siguen intactas. Las pruebas comprueban todos los conjuntos de accesibilidad y los cuatro finales recuperados en 2B.
- No se tocaron motor, persistencia, interfaz, identidad, dependencias, metadatos de duración ni clasificación de finales.

## Android 15 — comprobación real

**Seis recorridos completos aprobados en emulator-5554, Android 15/API35.** Para cada recorrido se verificaron mediante controles reales el nodo terminal, historial, completed, retroceso a la última decisión y nueva elección; después se hizo force-stop, se reabrió la app, se buscó Neon en biblioteca, se abrió Ver final alcanzado y se comprobó el mismo final e historial en las preferencias nativas.

| Corrección | Final | Recorrido Android completo |
|---|---|---|
| E1: fuga interceptada | final134 | node1 → node2a → node3a → node4b → node5c → node6f → node7k → node9f → final134 |
| E2: abandono, entrada uno | final57 | node1 → node2a → node3a → node4b → node5c → node6f → node7l → node8ak → final57 |
| E2: abandono, entrada dos | final57 | node1 → node2a → node3b → node4d → node5g → node6m → node7r → node8aw → node8ak → final57 |
| E3: romper pacto | final132 | node1 → node2a → node3a → node4b → node5c → node6f → node7k → node9e → final132 |
| E3: cumplir pacto | final133 | node1 → node2a → node3a → node4b → node5c → node6f → node7k → node9e → final133 |
| E4: traicionar al técnico | final9 | node1 → node2a → node3b → node4c → node5f → node6k → node8e → final9 |

Se revisaron visualmente las capturas de final134, final57, final132, final133 y final9, además de validar las etiquetas Android. Los recorridos hacia node9e pulsaron el nuevo texto OBTENER LOS DATOS, verificando que su destino sigue siendo la escena que cobra el precio pendiente. No se encontraron E/flutter, Unhandled Exception o FATAL EXCEPTION en el logcat de la ejecución comprobada.

Al revisar el respaldo se detectó un fallo del arnés temporal: el archivo FlutterSharedPreferences.xml no existía inicialmente, pero adb exec-out devolvió el mensaje de cat por stdout y el arnés lo confundió con contenido de respaldo. Esto no era una partida previa. Se eliminó exclusivamente ese archivo generado por el arnés, restaurando su ausencia original; no había progreso previo en ese archivo que perder. Se comprobó la ausencia, después un arranque limpio regresó a biblioteca sin errores relevantes. No se considera el mensaje de restauración byte-for-byte del arnés como prueba de respaldo XML válido. La validación de guardado/cierre/restauración de las seis partidas de prueba sí usó XML válido escrito por la app, leído y analizado antes y después de cada cierre.


Estas verificaciones deben distinguirse de los tests Flutter: las pruebas unitarias usan SharedPreferences simulado; el arnés Android utiliza controles reales, jerarquías UIAutomator y el archivo de preferencias nativo escrito por el APK instalado mediante adb install -r. No se inyectan IDs ni partidas para alcanzar los finales. El estado previo de preferencias se verifica y conserva al finalizar, con la incidencia del arnés explicada arriba.

La detección inicial encontró emulator-5554 offline; posteriormente se conectó, pero procesaba las entradas con bloqueo. Se hizo arranque en frío del mismo MythosTestAPI35, sin wipe-data, con el ejecutable emulator-2 ya existente. El ejecutable del directorio emulator que invoca flutter emulators devuelve incompatibilidad Windows; no se reparó ni actualizó el SDK. La prueba se realiza con el dispositivo existente confirmado por ADB como Android 15/API35.

El primer intento del arnés recorrió final134 y comprobó retroceso, pero falló al reabrir su pantalla tras el cierre. Se intentó restaurar el respaldo temporal (su error se detectó y corrigió al cerrar); se revisó el arnés para descartar XML obsoleto de UIAutomator y usar búsqueda real en biblioteca. Ese intento no se cuenta como restauración aprobada.

No se certifica la fluidez ni todos los frames del splash: no forma parte del ajuste y permanece sin modificaciones. La certificación Android aquí corresponde a las rutas narrativas y la persistencia descritas, en este emulador, no en un teléfono físico.

## Revisión de archivos y commit

Antes de editar: git status limpio, HEAD 5f7dab0. Ese commit ya contiene la implementación E1–E4, sus pruebas y los siete informes/JSON editoriales de 2C, 2D, 2D.2 y 2E.1; se revisó su inventario y no se sobrescriben. El nuevo commit añade solo el cierre validado, sin duplicar o modificar artificialmente esos informes.

Archivos previstos del commit:

1. assets/stories/stories.json.
2. assets/stories/content/cyberpunk_heist.json.
3. test/narrative_phase2e2_test.dart.
4. test/support/narrative_phase2e2.dart.
5. docs/ajuste_autorizado_cierre_fase2e2.json.
6. docs/cierre_fase2e2.md.

No se incluyen APK, build, cachés, logs de Flutter, preferencias ni arneses temporales. Las evidencias Android se conservan fuera del repositorio, en la carpeta temporal mythos-phase2e-evidence.

Todos los controles críticos de aplicación, datos, pruebas y compilación han pasado; se crea un commit local con el mensaje exacto:

`fix(mythos): resolve narrative contradictions in Neon phase 2E`

El hash se obtiene de Git sin introducir una referencia circular en este mismo documento:

`git log -1 --format="%H%n%s" -- docs/cierre_fase2e2.md`

El cierre deja árbol e índice limpios, main un commit por delante de origin/main. No se ejecuta git push.

APK SHA-256: `c58b007d0b29628ff8656f766a141d73a4339f557dd80a4d2504768711c65808`. Tamaño: 195370399 bytes.
