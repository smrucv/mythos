# Mythos — Implementación de la Fase 2E.2

Fecha: 2026-10-13. Base técnica: `a66c814`.

## Alcance y diferencias exactas

Se aplicaron E1-A, E2-A, E4-A y el canon definitivo de E3 autorizado por el autor. Son exactamente nueve campos: seis textos narrativos, dos textos de elección y un destino. Todos los IDs, decisiones restantes, orden, imágenes y metadatos se conservaron. Los siete informes previos sin seguimiento se preservaron; la clasificación 2D.2 no fue actualizada.

Manifiesto verificable: `docs/cambios_autorizados_fase2e2.json`, con valores anteriores y nuevos. Diff literal canónico y derivado: `docs/diff_narrativo_fase2e2.patch`.

### final134 — text

**Antes**

**Final: Hackeo Desastroso**
Intentas extraer datos adicionales, pero el sistema detecta tu actividad. La IA te atrapa y la misión fracasa.

**Después**

**Final: Fuga Interceptada**
Con la información que has obtenido, inicias la fuga y buscas la salida. La IA todavía controla las defensas del NeuroBank: detecta tu retirada y bloquea la fuga. Te captura antes de que logres salir del edificio. La misión termina en fracaso; no has conseguido salir del NeuroBank con la información.

### node8ak — choices.1.nextNodeId

**Antes**

final128

**Después**

final57

### node7k — text

**Antes**

[ACEPTAR INTERCAMBIO] Aceptas los términos de la IA, obteniendo acceso seguro a la información a cambio de ciertas concesiones.

**Después**

[ACEPTAR INTERCAMBIO] Aceptas acceder a la información a cambio de entregar tu libertad a la IA. La IA te concede acceso a los datos y espera que pagues el precio acordado. Todavía no has entregado tu libertad: después de obtener la información podrás cumplir el pacto o intentar quebrantarlo.

### node9e — text

**Antes**

[ACUERDO COMPLETO EXITOSO] Cumples completamente con las condiciones de la IA, obteniendo acceso seguro y exitoso a la información.

**Después**

[EL PRECIO DEL ACUERDO] Has recibido acceso a la información y obtenido los datos. Sigues dentro del NeuroBank; la IA exige ahora la libertad que prometiste a cambio del acceso. Todavía puedes decidir: cumplir el pacto y permanecer bajo su control, o romperlo e intentar salir con la información. La salida sigue bajo la vigilancia de la IA; aún no has escapado ni entregado tu libertad.

### node9e — choices.0.text

**Antes**

[ESCAPAR CON ÉXITO] Iniciar la fuga con los datos extraídos

**Después**

[ROMPER EL PACTO] Intentar escapar con los datos sin entregar tu libertad a la IA

### node9e — choices.1.text

**Antes**

[PROTEGER INFORMACIÓN] Asegurar los datos antes de escapar

**Después**

[CUMPLIR EL PACTO] Proteger la información y entregar tu libertad como precio del acuerdo

### final132 — text

**Antes**

**Final: Acuerdo Completo y Escape**
Aceptas los términos de la IA y obtienes acceso seguro a la información. Escapas exitosamente con los datos necesarios, asegurando el éxito de la misión.

**Después**

**Final: Datos Recuperados, Pacto Roto**
Decides romper el acuerdo y conservar tanto los datos obtenidos como tu libertad. Abandonas el acceso concedido por la IA y comienzas a regresar por el camino de entrada. La IA detecta tu retirada, activa la alarma y empieza a bloquear el paso mientras los guardias se acercan. Retomas el hackeo para retrasar el cierre del acceso: la IA contrarresta la intrusión, pero logras cruzar antes de que termine de cerrarse. No puedes sostener el hackeo; cortas la conexión y sigues avanzando. Recurres al sigilo con el que llegaste al núcleo para evitar a los guardias y alcanzas los ductos por los que entraste. Los atraviesas hasta salir del NeuroBank, con la información todavía en tus manos. Has conservado tu libertad, pero la IA conoce tu traición: el pacto queda roto.

### final133 — text

**Antes**

**Final: Traición y Dominio**
Utilizas las alianzas para tu beneficio personal, traicionando a tus aliados y dominando el NeuroBank a tu manera.

**Después**

**Final: Información Protegida, Libertad Perdida**
Proteges los datos que has obtenido y decides cumplir el acuerdo. La IA te concedió acceso a la información a cambio de tu libertad; ahora aceptas pagar ese precio y renuncias a la fuga. La IA bloquea tu salida y quedas confinado bajo su control dentro del NeuroBank. Conservas la información protegida, pero no consigues sacarla personalmente del edificio. No has destruido los datos ni los has entregado a terceros. El pacto se ha cumplido: el acceso a la información te ha costado la libertad.

### final9 — text

**Antes**

**Final: Traición Desenfrenada**
El técnico te traiciona, interfiriendo en el hackeo. La misión se desmorona y debes enfrentar las consecuencias.

**Después**

**Final: Extracción Exitosa, Alianza Rota**
El hackeo ya está terminado y los datos están en tus manos. Aprovechas esa ventaja para romper la colaboración: te niegas a continuar la fuga junto al técnico que te ayudó a obtenerlos. Lo dejas atrás y sales del NeuroBank con la información. La extracción se ha logrado, pero la alianza no sobrevive a tu decisión. No sabes qué será del técnico dentro del banco; lo que sí sabes es que has utilizado su ayuda para abandonarlo.

## Integridad y sincronización

| Historia | Definiciones / IDs únicos | Accesibles | Borradores | Terminales accesibles |
|---|---:|---:|---:|---:|
| laberinto_medianoche | 69 / 69 | 69 | 0 | 8 |
| odisea_destino | 157 / 157 | 157 | 0 | 6 |
| android_secret | 12 / 12 | 12 | 0 | 3 |
| cyberpunk_heist | 354 / 354 | 313 | 41 | 153 |

Los conjuntos completos de nodos accesibles y terminales coinciden con la base 2B en las cuatro historias. Cero ciclos y destinos inexistentes, incluidos los borradores. Las 592 definiciones permanecen: 586 textos narrativos idénticos y seis reescrituras autorizadas. Solo cambia una conexión: la segunda elección de node8ak. Las otras tres historias son semánticamente idénticas y no aparecen en el diff. Los cuatro finales recuperados en 2B y los originales siguen accesibles.

Se ejecutó `py -3 tools/split_stories.py`; los cuatro archivos individuales y el índice son semánticamente iguales a la fuente. Solo el derivado de Neon cambia; índice y otros derivados permanecen intactos. La fixture histórica anterior a Fase 1 permanece intacta.

## Compatibilidad y comprobaciones de recorridos

No se modificaron ProgressStore, SharedPreferences, la clave mythos.progress.v1 ni la identidad Android. Cada ID sigue restaurándose con su historial, sin migración, borrado ni reinterpretación de decisiones. Los guardados en final9, final132, final133 o final134 muestran el nuevo texto, efecto expresamente autorizado. Los guardados en node7k/node9e muestran las nuevas escenas; en node9e se ofrecen las acciones corregidas para decisiones futuras.

Una partida antigua en final128 procedente del abandono se conserva allí: no se convierte retroactivamente en final57. Al retroceder a node8ak y elegir nuevamente abandonar sí se llega a final57. Esa limitación intencional conserva el historial real.

Las nuevas pruebas recorren desde node1: fuga interceptada; las dos entradas de node8ak y su abandono; extracción válida de final128 vía node9c; ruptura y cumplimiento del pacto; cumplimiento parcial hacia node9f/final135; traición al técnico y alianza final8. Cada recorrido comprueba guardado, restauración y retroceso con SharedPreferences simulado. Las pruebas 2B conservan los cuatro recorridos recuperados y la restauración antigua. La prueba histórica sigue comprobando todos los nodos efectivos antiguos contra el contenido corregido autorizado.

## Fundamento del texto E3

La oferta literal de node6f queda intacta. node7k explicita el precio aún pendiente; node9e sitúa el cobro después del acceso, dentro del banco. final132 utiliza el hackeo ya iniciado en node5c, el sigilo establecido en node4b y los ductos de entrada de node2a: la IA reacciona, el protagonista retrasa el bloqueo y cruza antes del cierre, evita guardias y retorna por los ductos. No se añaden poderes, aliados, receptores de datos ni contenido del secreto. final133 narra una entrega voluntaria de libertad y confinamiento conservando la información. El otro pacto node7b/node9a/final124 permanece intacto.

## Archivos de esta fase

- assets/stories/stories.json
- assets/stories/content/cyberpunk_heist.json
- test/story_integrity_test.dart
- test/narrative_phase2b_test.dart
- test/narrative_phase2e2_test.dart (nuevo)
- test/support/narrative_phase2e2.dart (nuevo)
- docs/cambios_autorizados_fase2e2.json (nuevo)
- docs/diff_narrativo_fase2e2.patch (nuevo)
- docs/implementacion_fase2e2.md (nuevo)

## Pendientes editoriales

La clasificación 2D.2 conserva deliberadamente su estado histórico. En una revisión aprobada deberán revisarse final134 (captura tras fuga), final128 (ya sin entradas de abandono), final132 (extracción libre rompiendo el pacto), final133 (confinamiento voluntario pagando libertad), final9 (extracción con alianza rota) y las evidencias de variantes de node7k/node9e. No se les asignan aquí grupos nuevos ni se implementa colección.

Los demás terminales inconclusos de 2E.1, final135, el pacto independiente y los 41 borradores siguen pendientes. No se implementaron A3/A4/A7/C1 ni reconexiones.

## Resultados de ejecución

- `flutter analyze`: sin incidencias (primera ejecución: 95,9 segundos; comprobación final con `--no-pub`: 69,5 segundos, sin incidencias).
- `flutter test --no-pub --reporter compact`: **73 pruebas aprobadas**, incluidas las 60 existentes y 13 nuevas de esta fase.
- La primera ejecución tuvo una prueba nueva fallida por decodificar la salida Git con la codificación Windows; se corrigió a UTF-8 y la suite completa pasó después. No fue un fallo del contenido ni se debilitó ninguna validación.
- `flutter build apk --debug`: **correcto**, assembleDebug en 152,6 segundos, usando GRADLE_USER_HOME=C:\Mythos\.gradle-mythos. APK: `build/app/outputs/flutter-apk/app-debug.apk`.
- `git diff --check`: correcto. El aviso de conversión futura LF/CRLF de Git no representa un cambio narrativo.
- No se ejecutó esta versión en emulador ni se realizó una verificación visual. Las pruebas de navegación/progreso descritas son Dart/Flutter con almacenamiento simulado, no pruebas Android.
- No se actualizaron dependencias ni se modificaron archivos de producción fuera de los dos JSON enumerados.
- HEAD sigue en a66c814; no se realizó commit, staging ni push. Hay cuatro archivos rastreados modificados y cinco archivos nuevos de esta fase; los siete documentos editoriales preexistentes siguen sin seguimiento.

Para revisar: `git diff -- assets/stories/stories.json assets/stories/content/cyberpunk_heist.json test/story_integrity_test.dart test/narrative_phase2b_test.dart`; revisar también los cinco archivos nuevos, especialmente el manifiesto, los dos archivos de pruebas y este informe. El diff narrativo entregado no incluye cambios de pruebas: reproduce exactamente ambos JSON de ejecución.

Para reproducir: `py -3 tools/split_stories.py`, `flutter analyze`, `flutter test`, y en PowerShell configurar `$env:GRADLE_USER_HOME='C:\Mythos\.gradle-mythos'` antes de `flutter build apk --debug`.
