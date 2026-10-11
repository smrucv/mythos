# Corrección de integridad narrativa de Mythos — Fase 1

Fecha: 2026-10-11. Referencia: `docs/auditoria_narrativa.md`. Implementación limitada a unicidad, validación estructural y documentación editorial; no se ejecuta la fase de reconexión. Git se inspeccionó antes de modificar y se guardó una copia temporal del estado local, incluyendo archivos todavía sin commit. Los cambios anteriores se conservaron.

## Resultado

El Asalto Neon conserva sus 354 definiciones, ahora con 354 IDs únicos. Solo se modificó el campo ID de las 12 segundas definiciones. Las primeras conservan sus IDs, sus textos y todas sus decisiones. Ningún nextNodeId se cambió. No hubo fusiones ni eliminaciones. Se conservaron los 592 textos/definiciones de las cuatro historias.

| Historia | Definiciones / IDs únicos | Alcanzables | Borradores | Destinos inexistentes |
|---|---:|---:|---:|---:|
| `laberinto_medianoche` | 69 / 69 | 69 | 0 | 0 |
| `odisea_destino` | 157 / 157 | 157 | 0 | 0 |
| `android_secret` | 12 / 12 | 12 | 0 | 0 |
| `cyberpunk_heist` | 354 / 354 | 309 | 45 | 0 |

## Renombres estables

Manifiesto verificable: `docs/renombres_narrativos_fase1.json`. Índices desde cero; la primera definición retiene el ID original.

| ID anterior | Segunda definición | Nuevo ID |
|---|---:|---|
| `node8bg` | `nodes[153]` | `node8bg__v2` |
| `node8bh` | `nodes[154]` | `node8bh__v2` |
| `node8bi` | `nodes[155]` | `node8bi__v2` |
| `node8bj` | `nodes[156]` | `node8bj__v2` |
| `node8bk` | `nodes[157]` | `node8bk__v2` |
| `node8bl` | `nodes[158]` | `node8bl__v2` |
| `node8bm` | `nodes[159]` | `node8bm__v2` |
| `node8bn` | `nodes[160]` | `node8bn__v2` |
| `final134` | `nodes[318]` | `final134__v2` |
| `final135` | `nodes[319]` | `final135__v2` |
| `final136` | `nodes[320]` | `final136__v2` |
| `final137` | `nodes[321]` | `final137__v2` |

## Fuente y sincronización

`assets/stories/stories.json` es la fuente principal. Se ejecutó `py -3 tools/split_stories.py` para regenerar `assets/stories/index.json` y `assets/stories/content/*.json`. Únicamente cambió el contenido individual de cyberpunk_heist; las otras tres historias individuales son idénticas a la copia previa. El índice ahora enumera los 354 IDs, incluidos los 12 nuevos. No se añadieron propiedades editoriales a datos de ejecución ni se cambiaron títulos, descripciones, duración, imágenes o decisiones. Las pruebas comprueban igualdad semántica entre fuente y archivos separados e IDs del índice.

## Validaciones añadidas

- `Story.fromJson` valida tipos de metadatos, ID de historia no vacío, lista no vacía de nodos y nodo inicial válido (`nodes[0]`, contrato actual conservado). IDs de nodo y textos deben ser cadenas no vacías; la descripción puede estar vacía. Duración: entero no negativo. Imagen opcional: cadena.
- Cada nodo se identifica en los errores junto con historia y posición. IDs únicos dentro de esa historia; la construcción de Story también comprueba unicidad y referencias. La lista de nodos se conserva inmutable.
- Decisions: cada entrada es un objeto con text y nextNodeId de tipo cadena no vacía. Todos los destinos deben existir en esa misma historia, incluidos destinos desde borradores. Campo choices ausente o lista vacía representa un final legítimo; null u otro tipo se rechaza.
- `StoryCatalog` y `StoryRepository` rechazan IDs de historia repetidos. IDs de nodo compartidos entre historias diferentes se permiten. Se conserva carga diferida.
- El índice valida tipos, IDs no vacíos y sin repeticiones. La lectura individual valida ID de historia, conjunto de nodeIds y metadatos contra su ficha antes de cachear. JSON malformado comunica historia y recurso; los fallos permiten reintento.
- Ejemplo de error: `Historia "demo", "n": ID duplicado en nodes[0] y nodes[1]`. Un destino ausente informa historia, origen/decisión y destino.
- `StoryDiagnostics.inspect` calcula inaccesibles y componentes fuertemente conexas con Tarjan, incluidos autorreferencias y ciclos aislados. Es un diagnóstico editorial independiente de la carga. Convergencias, finales compartidos, borradores y ciclos no se rechazan. Ninguna historia real tiene ciclos.

## Compatibilidad demostrada

Se añadió la copia previa completa como fixture congelada `test/fixtures/stories_before_integrity_phase1.json`. Se decodifica como datos de prueba, no se carga en el motor estricto. No forma parte de los assets de ejecución. Las pruebas comparan cada definición y sus metadatos contra la copia: la única diferencia permitida es el ID en las 12 posiciones del manifiesto.

También se compara el mapa efectivo anterior (primera definición por ID) con el nuevo: los 580 IDs efectivos anteriores siguen resolviendo exactamente a la misma definición, incluidas todas sus decisiones. Se conserva el inicio y el conjunto alcanzable de cada historia. Al ser idénticos todos los nodos efectivos y sus aristas, permanecen todos los caminos jugables anteriores, sin necesidad de enumerar combinaciones de rutas.

Se prueban partidas con el formato anterior para los 547 nodos previamente alcanzables (69 + 157 + 12 + 309): restauración del nodo, texto, historial de un camino válido desde el inicio, completed, lectura desde ficha y deshacer. Abrir no reescribe los datos guardados. La persistencia no fue modificada; se conserva `mythos.progress.v1`. No se aplicó migración, reinicio ni borrado de historial. Los IDs __v2 no reciben entradas desde decisiones anteriores.

## Borradores editoriales pendientes

Manifiesto separado: `docs/borradores_narrativos.json`, con ID, posición, condición de final, motivo, todas las referencias entrantes y destinos salientes. La prueba de manifiesto exige coincidencia exacta con los inaccesibles calculados por el motor. Sus entradas se conservan sin cambiar narrativa.

45 borradores de El Asalto Neon:

- 12 variantes renombradas sin referencia entrante: 8 nodos y 4 finales.
- 16 finales (final86–final101) solo referenciados desde las ocho variantes de nodo sin entrada.
- 17 definiciones en componentes ya aisladas aun considerando las variantes anteriores: node7ae/node7af, node8bu–node8by y final114–final123.

El total de borradores no aumentó: eran 45 definiciones efectivamente inaccesibles antes y siguen siendo 45; ahora cada una tiene ID propio. Hay 15 nodos no finales y 30 finales inaccesibles.

| ID borrador | Posición | Tipo | Razón |
|---|---:|---|---|
| `node7ae` | `nodes[85]` | Nodo | Componente aislada previa; ninguna ruta desde inicio |
| `node7af` | `nodes[86]` | Nodo | Componente aislada previa; ninguna ruta desde inicio |
| `node8bg__v2` | `nodes[153]` | Nodo | Segunda definición renombrada; ninguna entrada autorizada |
| `node8bh__v2` | `nodes[154]` | Nodo | Segunda definición renombrada; ninguna entrada autorizada |
| `node8bi__v2` | `nodes[155]` | Nodo | Segunda definición renombrada; ninguna entrada autorizada |
| `node8bj__v2` | `nodes[156]` | Nodo | Segunda definición renombrada; ninguna entrada autorizada |
| `node8bk__v2` | `nodes[157]` | Nodo | Segunda definición renombrada; ninguna entrada autorizada |
| `node8bl__v2` | `nodes[158]` | Nodo | Segunda definición renombrada; ninguna entrada autorizada |
| `node8bm__v2` | `nodes[159]` | Nodo | Segunda definición renombrada; ninguna entrada autorizada |
| `node8bn__v2` | `nodes[160]` | Nodo | Segunda definición renombrada; ninguna entrada autorizada |
| `node8bu` | `nodes[167]` | Nodo | Componente aislada previa; ninguna ruta desde inicio |
| `node8bv` | `nodes[168]` | Nodo | Componente aislada previa; ninguna ruta desde inicio |
| `node8bw` | `nodes[169]` | Nodo | Componente aislada previa; ninguna ruta desde inicio |
| `node8bx` | `nodes[170]` | Nodo | Componente aislada previa; ninguna ruta desde inicio |
| `node8by` | `nodes[171]` | Nodo | Componente aislada previa; ninguna ruta desde inicio |
| `final86` | `nodes[265]` | Final | Solo recibe entradas de una variante sin conexión desde inicio |
| `final87` | `nodes[266]` | Final | Solo recibe entradas de una variante sin conexión desde inicio |
| `final88` | `nodes[267]` | Final | Solo recibe entradas de una variante sin conexión desde inicio |
| `final89` | `nodes[268]` | Final | Solo recibe entradas de una variante sin conexión desde inicio |
| `final90` | `nodes[269]` | Final | Solo recibe entradas de una variante sin conexión desde inicio |
| `final91` | `nodes[270]` | Final | Solo recibe entradas de una variante sin conexión desde inicio |
| `final92` | `nodes[271]` | Final | Solo recibe entradas de una variante sin conexión desde inicio |
| `final93` | `nodes[272]` | Final | Solo recibe entradas de una variante sin conexión desde inicio |
| `final94` | `nodes[273]` | Final | Solo recibe entradas de una variante sin conexión desde inicio |
| `final95` | `nodes[274]` | Final | Solo recibe entradas de una variante sin conexión desde inicio |
| `final96` | `nodes[275]` | Final | Solo recibe entradas de una variante sin conexión desde inicio |
| `final97` | `nodes[276]` | Final | Solo recibe entradas de una variante sin conexión desde inicio |
| `final98` | `nodes[277]` | Final | Solo recibe entradas de una variante sin conexión desde inicio |
| `final99` | `nodes[278]` | Final | Solo recibe entradas de una variante sin conexión desde inicio |
| `final100` | `nodes[279]` | Final | Solo recibe entradas de una variante sin conexión desde inicio |
| `final101` | `nodes[280]` | Final | Solo recibe entradas de una variante sin conexión desde inicio |
| `final114` | `nodes[293]` | Final | Componente aislada previa; ninguna ruta desde inicio |
| `final115` | `nodes[294]` | Final | Componente aislada previa; ninguna ruta desde inicio |
| `final116` | `nodes[295]` | Final | Componente aislada previa; ninguna ruta desde inicio |
| `final117` | `nodes[296]` | Final | Componente aislada previa; ninguna ruta desde inicio |
| `final118` | `nodes[297]` | Final | Componente aislada previa; ninguna ruta desde inicio |
| `final119` | `nodes[298]` | Final | Componente aislada previa; ninguna ruta desde inicio |
| `final120` | `nodes[299]` | Final | Componente aislada previa; ninguna ruta desde inicio |
| `final121` | `nodes[300]` | Final | Componente aislada previa; ninguna ruta desde inicio |
| `final122` | `nodes[301]` | Final | Componente aislada previa; ninguna ruta desde inicio |
| `final123` | `nodes[302]` | Final | Componente aislada previa; ninguna ruta desde inicio |
| `final134__v2` | `nodes[318]` | Final | Segunda definición renombrada; ninguna entrada autorizada |
| `final135__v2` | `nodes[319]` | Final | Segunda definición renombrada; ninguna entrada autorizada |
| `final136__v2` | `nodes[320]` | Final | Segunda definición renombrada; ninguna entrada autorizada |
| `final137__v2` | `nodes[321]` | Final | Segunda definición renombrada; ninguna entrada autorizada |

## Decisiones editoriales pendientes para una fase posterior

El autor debe decidir si y cómo dar entrada a las 12 variantes renombradas y a los grupos aislados, identificando decisiones concretas. No se propone añadir elecciones automáticamente. La conexión ambigua a finales134–137 sigue apuntando a las primeras definiciones: se preserva la conducta existente, incluso sus contradicciones semánticas ya documentadas. Decidir su reparto y sus desenlaces es trabajo de la segunda fase, no de esta corrección. Los cinco finales con IDs de nodo se mantienen intactos. Los borradores pueden continuar reservados durante desarrollo.

## Verificación final

- `flutter analyze --no-pub`: código 0, No issues found (34,5 s).
- `flutter test --no-pub`: código 0, 46 pruebas aprobadas. Se retiró la expectativa antigua de conservar duplicados y se añadieron 27 pruebas.
- Integridad: 354/354 IDs en El Asalto Neon; 592 definiciones en cuatro historias; cero colisiones y cero referencias inexistentes.
- Pruebas de convergencias, finales compartidos, IDs compartidos entre historias, ciclos y borradores: aprobadas.
- Fuente/individuales/índice y manifiesto editorial: consistentes.
- Hashes de Android, pantallas, main/app, secuencia de inicio, persistencia y pubspec coinciden con la copia previa. No se cambió applicationId ni dependencias.
- No se solicitó compilación ni emulador en esta fase; no se declara una revisión visual.

## Archivos modificados y nuevos

Cambios sobre archivos existentes en el estado local:

- `lib/models/story.dart` — lectura/validación del modelo y catálogo.
- `lib/services/story_repository.dart` — validación de índice y contenido en carga diferida.
- `assets/stories/stories.json` — solo 12 campos ID.
- `assets/stories/content/cyberpunk_heist.json` — mismos 12 renombres derivados.
- `assets/stories/index.json` — los 12 IDs nuevos.
- `test/story_catalog_test.dart` — sustituye expectativa de duplicados por unicidad.

Archivos añadidos:

- `lib/models/story_validation.dart` — errores y validadores compartidos.
- `lib/models/story_diagnostics.dart` — accesibilidad/ciclos como diagnóstico editorial.
- `test/story_integrity_test.dart` — validación, conservación y compatibilidad.
- `test/fixtures/stories_before_integrity_phase1.json` — referencia congelada previa.
- `docs/renombres_narrativos_fase1.json` — mapeo exacto autorizado.
- `docs/borradores_narrativos.json` — manifiesto editorial separado.
- `docs/correccion_integridad_narrativa.md` — este informe.
- `docs/correccion_integridad_narrativa.diff` — diff exclusivo contra estado previo a la fase, incluidos archivos nuevos; excluye su propia salida. Git diff mezcla cambios anteriores, por eso se entrega este diff separado. No se realizó commit ni push.

## Huellas reproducibles

- `test/fixtures/stories_before_integrity_phase1.json` SHA-256 `1fd1ed38f0812b088dde543c0aeaf859afadc21f09ac2608f3da180d22d27b1d`.
- `assets/stories/stories.json` SHA-256 `6d75ee2f265d826fc07e035abd54e34278daf67349b63819f7116a3ebc8be07e`.
- `assets/stories/index.json` SHA-256 `167c34da4e8f5eb1620a1b76e5610f532a22e9d1383fe674b9aff6a2da3294cb`.
- `assets/stories/content/cyberpunk_heist.json` SHA-256 `832a2df628d8398d11ca7e1b71df53d5f1ec33c18eaf5baa67667628147d4340`.
