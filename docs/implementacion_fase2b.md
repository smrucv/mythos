# Mythos — Implementación de la Fase 2B

Fecha: 2026-10-11. Autorización aplicada: **exclusivamente B1, B2, B3 y B4** de `propuesta_recuperacion_narrativa_fase2.md`.

## Resultado

El Asalto Neon conserva 354 definiciones con 354 IDs únicos. La accesibilidad real pasó de **309 a 313**; los borradores restantes pasaron de **45 a 41**. Se recuperaron únicamente `final134__v2`, `final135__v2`, `final136__v2` y `final137__v2`. Ninguna definición previamente accesible quedó inaccesible.

Las únicas diferencias narrativas respecto de la Fase 1 son los cuatro campos `nextNodeId` enumerados abajo. Los 592 textos, IDs, metadatos, imágenes, textos de elecciones y orden de nodos/decisiones permanecen iguales. No se modificaron el motor, la persistencia, Android, la identidad, el inicio ni las pantallas. No se realizó commit ni push.

Git se revisó antes de modificar. El documento de propuesta de la Fase 2A ya estaba sin seguimiento y se conservó intacto; se guardaron copias y hashes temporales del estado previo para distinguir esta fase de cambios preexistentes.

## Cuatro cambios exactos

Manifiesto explícito: `docs/cambios_autorizados_fase2b.json`. Las decisiones están numeradas desde 1; las posiciones `nodes[i]` usan base 0. Antes de editar se verificaron ID, posición, texto exacto de elección y destino anterior.

| Aprobación | Origen y posición | Decisión | Texto original, conservado | Antes | Después |
|---|---|---:|---|---|---|
| B1 | `node8au`, `nodes[133]` | 1 | [ESCAPAR CON DATOS] Iniciar la fuga con los datos extraídos | `final134` | `final134__v2` |
| B2 | `node8au`, `nodes[133]` | 2 | [OCULTAR HUELLAS Y ESCAPAR] Borrar rastros antes de escapar | `final135` | `final135__v2` |
| B3 | `node8av`, `nodes[134]` | 1 | [FINAL FALLIDO] Misión fallida, atrapado por las defensas | `final136` | `final136__v2` |
| B4 | `node8ax`, `nodes[136]` | 1 | [ESCAPAR RAPIDAMENTE] Utilizar habilidades para escapar rápidamente | `final137` | `final137__v2` |

Ahora la fuga tras extracción a ciegas termina en extracción exitosa; ocultar huellas termina en ocultación y escape; el fallo por ceguera termina en captura; la retirada termina en escape sin datos esenciales. Los textos de estos desenlaces no fueron reescritos.

Conexiones preservadas sin excepción:

- `node9f`, decisión 1 → `final134`.
- `node9f`, decisión 2 → `final135`.
- `node9h`, decisión 1 → `final136`.
- `node9h`, decisión 2 → `final137`.

## Comparación del grafo y auditoría de las cuatro historias

La prueba de auditoría usa **`StoryDiagnostics.inspect` existente**, sobre las historias reales actuales y una reconstrucción de la Fase 1. La reconstrucción aplica únicamente los 12 renombres históricos a una copia en memoria de la fixture congelada; no modifica la fixture ni evita las validaciones estrictas del motor.

| Historia | Definiciones / IDs únicos | Accesibles antes | Accesibles después | Borradores antes / después | Destinos inexistentes | Ciclos actuales |
|---|---:|---:|---:|---:|---:|---:|
| `laberinto_medianoche` | 69 / 69 | 69 | 69 | 0 / 0 | 0 | 0 |
| `odisea_destino` | 157 / 157 | 157 | 157 | 0 / 0 | 0 | 0 |
| `android_secret` | 12 / 12 | 12 | 12 | 0 / 0 | 0 | 0 |
| `cyberpunk_heist` | 354 / 354 | 309 | 313 | 45 / 41 | 0 | 0 |

La diferencia de conjuntos alcanzables es exactamente el conjunto de cuatro finales recuperados. La diferencia inversa está vacía. No se alteró ningún otro destino para ajustar la cifra. Se conservó el inicio `node1` y el orden de los 354 nodos. El número de aristas tampoco cambió: se sustituyeron cuatro destinos, sin añadir o eliminar elecciones.

### Accesibilidad de los ocho finales

| Final | Antes | Después | Entrada actual verificada | Desenlace conservado |
|---|---|---|---|---|
| `final134` | Accesible | Accesible | `node9f`, decisión 1 | Hackeo Desastroso |
| `final134__v2` | Borrador | Accesible | `node8au`, decisión 1 | Extracción Exitosa a Ciegas |
| `final135` | Accesible | Accesible | `node9f`, decisión 2 | Hackeo Persistente |
| `final135__v2` | Borrador | Accesible | `node8au`, decisión 2 | Ocultación y Escape Seguro |
| `final136` | Accesible | Accesible | `node9h`, decisión 1 | Preparación Exitosa |
| `final136__v2` | Borrador | Accesible | `node8av`, decisión 1 | Misión Fallida por Ceguera |
| `final137` | Accesible | Accesible | `node9h`, decisión 2 | Alianzas Fuertes |
| `final137__v2` | Borrador | Accesible | `node8ax`, decisión 1 | Escape Rápido sin Éxito |

Se añadieron ocho pruebas de recorridos completos, uno por final, que validan cada enlace desde el inicio, ejecutan las elecciones usando el repositorio y `ProgressStore` reales, comprueban el historial acumulado y reabren la partida en el mismo final. Son pruebas automatizadas del recorrido de datos y progreso; no son pruebas visuales de emulador.

## Sincronización y conservación de contenido

`assets/stories/stories.json` sigue siendo la fuente principal. Se ejecutó `py -3 tools/split_stories.py` para regenerar índice y archivos individuales.

- El archivo individual `cyberpunk_heist.json` refleja exactamente los mismos cuatro cambios.
- El índice se regeneró y quedó idéntico byte a byte: no cambiaron IDs ni metadatos.
- Los tres archivos individuales de las otras historias permanecieron idénticos a la copia previa.
- La igualdad semántica de todas las historias individuales con la fuente y sus metadatos/IDs del índice está verificada.
- Una comparación completa del JSON previo con una copia que aplica solo los cuatro cambios autorizados coincide exactamente con el resultado actual. No se cambiaron propiedades adicionales, textos de decisiones, orden, escenas ni finales.
- Las pruebas históricas siguen comparando las 592 definiciones completas contra la fixture. Solo permiten los 12 renombres de la Fase 1 y los cuatro destinos explícitamente autorizados aquí. Las validaciones de unicidad, tipos y referencias se mantienen intactas.

`docs/borradores_narrativos.json` se actualizó a la fase `2B` y 313 alcanzables. Solo se retiraron las cuatro entradas de finales recuperados; los otros 41 registros conservaron su contenido y orden. Los borradores restantes son las ocho variantes de escena con sus 16 finales, más las 17 definiciones previamente aisladas. Una prueba exige coincidencia exacta entre manifiesto y diagnóstico real.

## Partidas antiguas: compatibilidad comprobada

La clave `mythos.progress.v1`, IDs y código de persistencia se conservaron. El `applicationId` y los recursos Android permanecen intactos. No hay migración ni reinicio de partidas.

Las pruebas anteriores de restauración para los 547 nodos previamente jugables de las cuatro historias siguen aprobadas. Además, se añadieron cuatro casos dirigidos a partidas antiguas que llegaron a `final134/135/136/137` a través de las conexiones de ceguera/retirada que ahora cambiaron:

1. Se valida que el camino guardado era válido en la Fase 1.
2. Se restaura el ID original, su texto original, el historial completo, la marca de completado y la fecha guardada. Abrir no reescribe el JSON persistido.
3. Se deshace hasta la escena afectada y luego hasta el inicio, conservando los IDs históricos aunque la arista de entrada al final ahora sea distinta.
4. Se comprueba que el progreso de otra historia no se altera al guardar el retroceso.
5. Una partida guardada en la escena anterior a la elección tampoco se adelanta al abrir. Solo una nueva elección explícita conduce al final `__v2` y acumula el historial correspondiente.

Esto preserva las decisiones pasadas: una partida que ya estaba en un final original permanece en ese final, incluso si su ruta de entrada fue corregida. No se reinterpreta retroactivamente su desenlace. Deshacer y volver a elegir es una acción nueva del usuario y usa el destino aprobado.

## Pruebas y análisis finales

| Comprobación | Resultado real |
|---|---|
| `flutter analyze --no-pub` | Código 0, **No issues found**, 20,6 s |
| `flutter test --no-pub` | Código 0, **60 pruebas aprobadas** |
| Auditoría con diagnóstico existente | Cuatro historias estructuralmente válidas, 354 IDs únicos en El Asalto Neon, 313 alcanzables y 41 borradores |
| Diferencias narrativas vs. Fase 1 | Exactamente cuatro `nextNodeId`; ningún cambio adicional |
| Conservación de textos | 592 textos originales y todas las decisiones/metadatos conservados |
| Partidas antiguas e historial | Restauración y retroceso aprobados; sin migración o pérdida de historial |

Se conservan las 46 pruebas de la Fase 1 y se añaden 14: manifiesto exacto, auditoría antes/después, ocho recorridos y cuatro casos de compatibilidad. Solo se actualizó la expectativa histórica incompatible con los destinos B1–B4 y los cuatro finales recuperados. El manifiesto de autorizaciones se compara contra cuatro cambios fijados expresamente en los tests; ampliar el manifiesto no autoriza cambios accidentales ni hace pasar por sí solo la suite.

En la primera ejecución analyze señaló el uso de `print` en el test de auditoría; se sustituyó por `debugPrint` y se repitieron analyze y la suite completa, con los resultados finales de la tabla. Se utilizó `--no-pub` para ejecutar los controles sin regenerar dependencias ni modificar `pubspec.lock`.

No se realizó compilación Android ni verificación visual/de emulador: no fueron solicitadas para esta fase. Las pruebas de inicio y navegación existentes sí se ejecutaron dentro de la suite, sin modificar esas áreas.

## Archivos de esta fase

Modificados:

- `assets/stories/stories.json`: cuatro destinos autorizados.
- `assets/stories/content/cyberpunk_heist.json`: cuatro destinos derivados.
- `docs/borradores_narrativos.json`: 41 borradores, conservando los registros restantes.
- `test/story_integrity_test.dart`: expectativas completas con excepción exacta B1–B4, conservando el resto de garantías.

Añadidos:

- `docs/cambios_autorizados_fase2b.json`: autorización explícita por origen, posición, decisión, texto y destinos.
- `test/narrative_phase2b_test.dart`: cobertura de alcance, auditoría, ocho finales y partidas antiguas.
- `test/support/narrative_phase1.dart`: reconstrucción estricta de la Fase 1 únicamente en memoria para pruebas.
- `docs/implementacion_fase2b.md`: este informe.

La fixture `test/fixtures/stories_before_integrity_phase1.json`, los manifiestos de renombres anteriores y la propuesta editorial de Fase 2A no se sobrescribieron. El motor y todo el código de ejecución mantienen sus hashes previos.

Para revisar el diff narrativo exacto:

```powershell
git diff -- assets/stories/stories.json assets/stories/content/cyberpunk_heist.json
git diff -- docs/borradores_narrativos.json test/story_integrity_test.dart
git status --short
```

Los archivos nuevos de esta fase todavía no están añadidos a Git. No se efectuó commit ni push.

## Problemas editoriales que continúan pendientes

- `node9f`, decisión 1, sigue conduciendo a `final134`: la elección de fuga con acceso limitado sigue relatando una extracción adicional fallida. Se conserva expresamente por falta de autorización para corregirla.
- Las ocho variantes de escena y sus 16 finales continúan como borradores. No se implementaron A3, A4, A7 ni C1.
- Los grupos de guardias y de información adicional siguen pendientes de una elección editorial de conexiones, versión de escena y cronología. No se implementaron G-extensión ni G-reemplazo.
- Los otros problemas de continuidad y suficiencia de datos descritos en Fase 2A quedan para revisión; no se cambiaron finales ni se inventaron escenas o elecciones para resolverlos.

La Fase 2B satisface su alcance autorizado. Cualquier otra conexión requiere aprobación separada.


## Rutas completas de los ocho finales

Rutas vigentes verificadas desde el inicio; el número entre paréntesis es la decisión del origen (base 1). Las ocho también se ejecutaron en las pruebas de recorrido completo.

| Final | Ruta actual |
|---|---|
| `final134` | `node1` (1) → `node2a` (1) → `node3a` (2) → `node4b` (1) → `node5c` (2) → `node6f` (1) → `node7k` (2) → `node9f` (1) → `final134` |
| `final134__v2` | `node1` (1) → `node2a` (2) → `node3b` (2) → `node4d` (1) → `node5g` (1) → `node6m` (1) → `node7q` (1) → `node8au` (1) → `final134__v2` |
| `final135` | `node1` (1) → `node2a` (1) → `node3a` (2) → `node4b` (1) → `node5c` (2) → `node6f` (1) → `node7k` (2) → `node9f` (2) → `final135` |
| `final135__v2` | `node1` (1) → `node2a` (2) → `node3b` (2) → `node4d` (1) → `node5g` (1) → `node6m` (1) → `node7q` (1) → `node8au` (2) → `final135__v2` |
| `final136` | `node1` (2) → `node2b` (2) → `node3d` (2) → `node4h` (1) → `node5m` (2) → `node6x` (2) → `node7ad` (2) → `node9h` (1) → `final136` |
| `final136__v2` | `node1` (1) → `node2a` (2) → `node3b` (2) → `node4d` (1) → `node5g` (1) → `node6m` (1) → `node7q` (2) → `node8av` (1) → `final136__v2` |
| `final137` | `node1` (2) → `node2b` (2) → `node3d` (2) → `node4h` (1) → `node5m` (2) → `node6x` (2) → `node7ad` (2) → `node9h` (2) → `final137` |
| `final137__v2` | `node1` (1) → `node2a` (2) → `node3b` (2) → `node4d` (1) → `node5g` (1) → `node6m` (2) → `node7r` (2) → `node8ax` (1) → `final137__v2` |

## Evidencia de conservación

La comparación de hashes contra la copia previa confirmó que los únicos archivos existentes modificados fueron los cuatro enumerados en este informe. El índice y los tres archivos individuales restantes conservaron también sus bytes. Los nuevos documentos y tests no cambian recursos ni código de ejecución.

- `test/fixtures/stories_before_integrity_phase1.json` SHA-256: `1fd1ed38f0812b088dde543c0aeaf859afadc21f09ac2608f3da180d22d27b1d`.
- `assets/stories/stories.json` SHA-256: `20df32c972625e7af67a6127ec641dc621319ff2eb743019444142caa9ed4847`.
- `assets/stories/content/cyberpunk_heist.json` SHA-256: `c727b9c8c859784974046a82efb612ebff3745e1f5604df0902475b2dcab9fef`.
- `assets/stories/index.json` SHA-256: `167c34da4e8f5eb1620a1b76e5610f532a22e9d1383fe674b9aff6a2da3294cb`.
- `docs/cambios_autorizados_fase2b.json` SHA-256: `c5800d7be4969a0d57f5a55ec5fd1a7009f9312a0cc364ef0db552bb6cd6c16d`.
