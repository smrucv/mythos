# Mythos — Auditoría de calidad narrativa, Fase 2C

Fecha: 2026-10-12. Base: `a66c814bcbfc38a121afeb4e244dbe2b86c230f3`. **Análisis exclusivamente; ninguna propuesta implementada.**

## Método y alcance

Se revisaron la fuente `assets/stories/stories.json`, catálogo, individuales, modelo, repositorio, representación del texto y persistencia, junto con los informes de integridad y recuperación de Fase 2A y sus manifiestos. La entrada es la primera definición; un final es cualquier nodo sin decisiones, independientemente de su nombre. Los cuatro grafos, incluidos los borradores, son acíclicos y carecen de referencias inexistentes.

Las distribuciones son **exactas**, calculadas por programación dinámica de sufijos sobre `(decisiones, palabras)`: cada arista suma una elección y el texto de la escena. No hubo muestreo. Las historias pequeñas se contrastan mediante enumeración exhaustiva independiente; Odisea no necesita enumerar 201 millones de secuencias. Se distinguen secuencias de elecciones y secuencias de IDs: alternativas con el mismo destino duplican la primera cuenta, pero no la segunda.

La mediana es **estructural**: el centro del multiconjunto de secuencias posibles con su multiplicidad combinatoria. No se asigna probabilidad a las elecciones ni se presupone igual frecuencia entre jugadores, caminos o finales. No es una predicción de conducta ni de duración esperada. Retroceder/releer no pertenece a un recorrido directo: incluirlo permitiría tiempos arbitrarios aunque el grafo sea acíclico.

Palabras: tokens Unicode de letras/dígitos, conservando apóstrofos y guiones internos. Incluyen títulos visibles entre corchetes y cabeceras de finales; excluyen signos Markdown, descripción del catálogo, interfaz y arranque. `narrative_only` cuenta escenas; `selected_option` añade solo las opciones elegidas; **`full_menu`** añade todas las alternativas visibles para poder compararlas y constituye el modelo principal de tiempo.

Los escenarios son supuestos explícitos de sensibilidad para lectura en español, **no normas poblacionales medidas**: ágil, 250 palabras/minuto + 4 segundos adicionales por elección; intermedio, 200 + 8; pausado, 150 + 15; contemplativo, 120 + 25. Fórmula: `minutos = palabras full_menu / velocidad + decisiones × deliberación / 60`. La deliberación es adicional a leer las opciones. Se usa la distribución conjunta, no la suma de medianas marginales. No incluye carga, scroll, pausas externas ni relecturas. Los botones únicos cuentan como pasos, pero no como alternativas sustantivas.

Convergencia: al menos dos padres distintos accesibles; opciones paralelas de un padre no bastan. Ramificación: al menos dos destinos distintos, sin certificar diferencia semántica. Reutilización: escena no terminal presente en al menos dos secuencias completas, incluyendo la entrada. Un prefijo de árbol puede reutilizarse sin reconverger: este porcentaje no mide originalidad.

## Resultados cuantitativos

| Historia | Definiciones | Accesibles / borradores | Finales accesibles | Secuencias de elecciones / nodos | Decisiones mín. / mediana / máx. | Metadato, minutos |
|---|---:|---:|---:|---:|---:|---:|
| Laberinto | 69 | 69 / 0 | 8 | 87 / 87 | 4 / 4 / 5 | 120 |
| Odisea | 157 | 157 / 0 | 6 | 201.326.592 / 100.663.296 | 27 / 27 / 27 | 120 |
| Androide | 12 | 12 / 0 | 3 | 10 / 6 | 3 / 3 / 4 | 12 |
| Neon | 354 | 313 / 41 | 153 | 161 / 161 | 3 / 8 / 9 | 50 |

Distribuciones exactas de decisiones:

- Laberinto: 4 → 53 recorridos; 5 → 34.
- Odisea: 27 → 201.326.592. `3 × 2^26` secuencias; una pareja de opciones con el mismo destino por recorrido explica el factor dos frente a `3 × 2^25` rutas de IDs. No son millones de arcos escritos independientemente.
- Androide: 3 → 6; 4 → 4.
- Neon: 3 → 1; 4 → 1; 6 → 2; 7 → 43; 8 → 110; 9 → 4.

Palabras por recorrido: mínimo / mediana estructural / máximo.

| Historia | Solo narrativa | Narrativa + opción elegida | Narrativa + menú completo |
|---|---:|---:|---:|
| Laberinto | 294 / 322 / 394 | 330 / 360 / 444 | 406 / 436 / 533 |
| Odisea | 585 / 618 / 655 | 747 / 789 / 853 | 910 / 967 / 1044 |
| Androide | 79 / 85 / 100 | 90 / 94 / 119 | 99 / 106 / 133 |
| Neon | 121 / 217 / 252 | 141 / 286 / 329 | 164 / 350 / 405 |

Duración estimada en minutos: mínima / mediana estructural / máxima.

| Historia | Ágil | Intermedio | Pausado | Contemplativo |
|---|---:|---:|---:|---:|
| Laberinto | 1,89 / 2,01 / 2,47 | 2,56 / 2,71 / 3,33 | 3,71 / 3,91 / 4,80 | 5,05 / 5,30 / 6,53 |
| Odisea | 5,44 / 5,67 / 5,98 | 8,15 / 8,44 / 8,82 | 12,82 / 13,20 / 13,71 | 18,83 / 19,31 / 19,95 |
| Androide | 0,60 / 0,62 / 0,80 | 0,90 / 0,93 / 1,20 | 1,41 / 1,46 / 1,89 | 2,08 / 2,13 / 2,78 |
| Neon | 0,86 / 1,93 / 2,22 | 1,22 / 2,82 / 3,23 | 1,84 / 4,33 / 4,95 | 2,62 / 6,25 / 7,13 |

Ningún metadato se aproxima a un recorrido directo bajo estos supuestos, ni siquiera al máximo contemplativo. Podrían describir exploración acumulada, pero no lo explicitan y no hay sesiones de jugadores que lo confirmen. No multiplicar duración por finales: comparten contenido y cada lector explora una fracción distinta. Primero aclarar qué promete la duración; después medir lectores. No añadir relleno para alcanzar 120/12/50 minutos.

| Historia | Escenas no terminales | Escenas en varios recorridos | Ramificaciones distintas | Convergencias | Grupos con opciones al mismo destino |
|---|---:|---:|---:|---:|---:|
| Laberinto | 61 | 61 (100 %) | 61 | 8 | 0 |
| Odisea | 151 | 151 (100 %) | 145 | 141 | 6 |
| Androide | 9 | 9 (100 %) | 5 | 1 | 4 |
| Neon | 160 | 158 (98,75 %) | 158 | 6 | 0 |

Laberinto converge solo en sus ocho finales. Odisea reconverge en escenas intermedias: cada uno de sus seis finales recibe 33.554.432 secuencias, pero un único padre inmediato. Androide converge en `n12`, alcanzado por ocho de diez secuencias; `n10` y `n11` reciben una cada uno. Neon tiene dos pasos de opción única, `node8av` y `node8ax`: confirmaciones, no alternativas. Los 153 finales de Neon frente a 161 recorridos muestran anchura y cierre propio, no gran profundidad. El JSON incluye padres, recuentos por final y escenas, y pares de destinos con idénticos conjuntos de finales futuros; compartir ese conjunto no elimina el valor de sus escenas intermedias.

## Testigos completos de recorridos

- Laberinto corto: `node1 → node3 → node8 → node24 → final1` (4 decisiones). Largo: `node1 → node2 → node6 → node17 → node46 → final6` (5).
- Androide corto: `n1 → n2 → n5 → n10` (3). Largo: `n1 → n2 → n4 → n8 → n12` (4).
- Neon corto: `node1 → node2b → node3c → node4e` (3). Largo: `node1 → node2a → node3a → node4b → node5c → node6f → node7l → node8al → node8am → final70` (9).
- Odisea: todos tienen 27. Un testigo es `node1 → nodeA1 → nodeA2 → nodeA4 → nodeA6 → nodeA8 → nodeA10 → nodeA12 → nodeA14 → nodeA16 → nodeA18 → nodeA20 → nodeA22 → nodeA24 → nodeA26 → nodeA28 → nodeA30 → nodeA32 → nodeA34 → nodeA36 → nodeA38 → nodeA40 → nodeA42 → nodeA44 → nodeA46 → nodeA48 → nodeA50 → finalA1`. Sus testigos de menor/mayor carga textual pertenecen a las familias A/C y constan íntegros en el JSON.

`witnesses` documenta nodos, texto e índice de cada elección, decisiones y palabras. Profundidad mínima/máxima no implica mínimo/máximo de palabras; esos testigos también se entregan por separado.

## Evaluación cualitativa

Los IDs, fragmentos y destinos son hechos del JSON; los juicios de calidad siguientes son **interpretaciones editoriales**. Una muerte temprana, final compartido o experiencia contemplativa no es un defecto por sí mismo.

### El Laberinto de la Medianoche

Premisa clara de horror exploratorio, voz consistente, ruinas, sangre, agua y geometría extraña. Sus escenas son relativamente extensas, pero solo se actúa cuatro o cinco veces. No necesita compañeros para funcionar; sí necesita pagar los descubrimientos del protagonista. El espacio sobrenatural puede ser incierto sin volver arbitraria toda consecuencia.

- `node26`, “Encender más velas”, termina en `final8`, escape por abertura lunar, sin descubrimiento intermedio de la salida. `node29`, insultar las voces, y `node58`, atacar al espectro, comparten ese cierre. Convergencias válidas, pero falta explicar cómo esas acciones producen escape.
- `node40` entrega llave y corazón momificado; llevarlos termina en `final8`, sin uso explícito de la llave. `node28` promete pistas al reconstruir cerámica y salta a `final4` sin revelar lo aprendido. Desarrollar objetos existentes aportaría más que otro objeto decorativo.
- `node41`, continuar rezando, y `node59`, abandonarse a la locura, llegan a `final3`, que describe intentar escapar. La acción del cierre difiere de la decisión; falta transición.
- `node36`, correr hacia la luz, conecta con el escape de `final8` de modo más natural. Preservar esta convergencia es útil: no se necesitan finales exclusivos para cada escena.
- `node31` contrapone cuerda de raíces y descenso arriesgado; sus condenas no explican cómo influye la precaución. Imprevisibilidad genera horror, pero sin señales o consecuencias relacionadas debilita el aprendizaje del jugador.

Ocho finales representan siete condenas/muertes/locura y una salida con secuelas. Su diferencia formal no resuelve los misterios concretos. Rejugabilidad moderada por imágenes y enfoques iniciales, menor por consecuencias imprevisibles. Requiere **revisión causal y ampliación de descubrimientos existentes**, no más ramas por cantidad.

### La Odisea del Destino

Tres familias sensoriales diferenciadas: energía ancestral, paisaje/brisa y niebla/umbrales. El tono contemplativo es válido sin antagonista, pero secretos y transformación se prometen sin revelaciones concretas. Veintisiete elecciones no son veintisiete acontecimientos: observar/ignorar y avanzar/desviarse reconvergen repetidamente.

- `nodeA24` susurra tu nombre y `nodeA25` propone descifrar lenguaje vegetal; sus destinos `nodeA26/27` no revelan quién habla ni lo descifrado. Promesa de información pendiente, no error estructural.
- `nodeB20 → nodeB22` cruza un puente y el destino empieza “Tras cruzar”: convergencia útil. `nodeB21` también llega allí al escuchar insectos, sin cruce narrado: el destino presupone el estado de otro padre.
- `nodeC14` presenta altar y llega a `nodeC16`, “Alrededor del altar”; `nodeC15` llega buscando agua subterránea, sin establecer ese altar. Revisar entradas contextuales, no prohibir compartir escena.
- `nodeB34` busca refugio para la noche pero `nodeB36` presenta un tambor sin mostrar refugio. `nodeC30` recoge partículas y `nodeC36` retira una piedra energética, sin repercusión específica posterior.
- `nodeA48/49`, `nodeB48/49`, `nodeC48/49` envían ambas opciones al mismo nodo final de familia. Igualdad funcional comprobada; puede haber valor expresivo, pero no consecuencia diferenciada.
- `nodeB49` permite descender por un desfiladero y `nodeB50` vuelve al “filo del acantilado” sin transición. Sus finales `finalB1/B2` transforman al viajero/guardián positivamente; la diferencia temática existe, pero faltan costes o consecuencias concretas.

No hay cuerpos normalizados literalmente duplicados entre escenas accesibles; **sí repetición semántica** de luces, runas, brisas y curiosidad sin respuesta. No confundir ambas cosas. El horario B evoluciona hasta la noche, un desarrollo ambiental útil. Los finales A/C prometen conocimiento ancestral abstracto. Rejugabilidad combinatoria enorme, argumental menor: dentro de cada familia el desenlace depende de la última elección. Necesita **profundizar revelaciones y decisiones**, más que agregar otras cincuenta viñetas.

### El Secreto del Androide

Premisa ética muy clara: memoria, sufrimiento artificial y propiedad corporativa. El sacrificio del androide favorece empatía, pero 79–100 palabras narrativas y tres/cuatro acciones no desarrollan sus dilemas.

- `n1 → n2 → n4 → n9` borra el archivo y huye; luego aparecen datos y un disco oculto, aunque la copia se narra en otra rama, `n6`. Inconsistencia de procedencia de evidencia.
- `n6` publicar/chantajear, `n7` defenderse/rendirse, `n8` aceptar/destruir chip y `n9` investigar/vender conducen cada pareja a `n12`. El motor no conserva variables de consecuencia para distinguirlas.
- `n7` deja destruir la memoria y `n8` permite destruir el chip, pero `n12` expone la corporación sin otra fuente de pruebas narrada. Convergencia que omite un requisito del desenlace.
- `n5 → n10/n11` sí diferencia soborno y juicio: libertad culpable frente a verdad, descrédito y prisión. Es una decisión ética útil que conviene preservar.
- `n12` convierte al protagonista en leyenda perseguida sin resolver de forma específica publicación, chantaje, rendición o resistencia. No puede suponerse que todos esos actos hayan ocurrido.

Prioridad alta: **coherencia de evidencia y consecuencias**, seguida de ampliar resoluciones. No basta retocar la duración ni añadir ambientación hasta doce minutos. Rejugabilidad baja fuera del par soborno/juicio. No se demuestra cambio contradictorio de personalidad, pero sí del acto atribuido al protagonista.

### El Asalto Neon

Neo-Tokyo, NeuroBank, IA, Jax/Lira y plazo de 27 minutos establecen conflicto y riesgo claros. Ese plazo es tiempo de ficción, no contador ni duración de lectura. La anchura de 313 definiciones oculta recorridos de mediana ocho decisiones y 217 palabras de escena. Hackeo, extracción y fuga suelen reducirse a estados de éxito.

- `node9f` opción 1, “Iniciar la fuga con la información obtenida” → `final134`, “Intentas extraer datos adicionales”: **contradicción confirmada, pendiente y excluida de Fase 2B**. Su opción 2 → `final135` sí continúa hackeando.
- `node8ak` opción 2, abandonar intento → `final128`, “Completa la misión con éxito”: inversión sin transición. Su opción 1 → `final127` sí explica desactivación, extracción y fuga; no debe marcarse erróneamente como retirada.
- `node8ad` declara “misión incompleta” y ofrece “Completar la misión con éxito” → `final56`: se elige un resultado sin acción que complete lo abandonado.
- `node2b` declara 5000 Bitcreds y ofrece soborno de 3000; `node3c` pide “5000 más”, pagados en `node4e`. Falta financiación adicional, condicionado a que el soborno inicial se pagó como narra la rama. El motor no lleva contabilidad, pero la ficción sí plantea ese saldo.
- `node8al` usa disfraz → `final129`, confrontación dramática sin explicar el fallo; buscar túnel → `node8am`, extracción completa sin narrar el hackeo. Revisar el estado de misión de cada entrada.
- `node8av/node8ax` son confirmaciones únicas. Botones de éxito/fallo seleccionan resultados en lugar de tácticas: requieren criterio editorial sobre agencia, no conexión automática.
- `final130/19/35/43/79` tienen igual cuerpo normalizado; también `final146/164/20/40` y `final147/165/21/41`. Diferentes títulos no garantizan experiencias distintas. `node8bm/node8c` repiten sabotaje y `node8bl/node8l`, protección. El JSON lista los grupos, quitando cabeceras solo para comparar; no afirma igualdad íntegra de títulos.

La traición del guardia en tres elecciones y retirada de `node5l` en cuatro pueden ser finales tempranos deliberados: no extenderlos automáticamente. El problema está en cierres que omiten extracción, riesgo o consecuencias de compañeros. Jax/Lira dan vínculo inicial que muchos finales genéricos no pagan; eso es oportunidad afectiva, no prueba automática de resurrección. Los cuatro finales B1–B4 y sus originales permanecen accesibles. Rejugabilidad moderada por enfoques iniciales y dilemas, reducida por cierres repetidos. Necesita **revisión transversal de causalidad y desenlaces** antes de expandirse.

## Neon: borradores y propuestas A3/A4/A7/C1

41 borradores: variantes `node8bg__v2`–`node8bn__v2` y `final86`–`final101` (24); guardias `node7ae/node7af`, `node8bu`–`node8bx`, `final114`–`final121` (14); información `node8by`, `final122/123` (3). Son quince escenas y veintiséis finales. La lista completa consta en métricas; los cuatro finales recuperados en Fase 2B ya no están aquí.

| Propuesta previa | Cambio simulado en memoria | Valor potencial | Riesgo / juicio |
|---|---|---|---|
| A3 | `node8bg` opción 1: `final154` → `node8bi__v2` | Mostrar hackeo tras plan y posibilidad de retirarse | Repite escena `node8bi`; `final90` repite cuerpo de `final158`. Retirada puede aportar contraste. Valor medio, autor debe justificar desplazar el cierre completo de plan exitoso. |
| A4 | `node8bg` opción 2: `final155` → `node8bj__v2` | Elegir continuación/fuga tras trampas | Escena y finales repiten material accesible `node8bj/final160/161`. Poco contenido nuevo; valor bajo salvo agencia local. No desplazar final solo por IDs. |
| A7 | `node8bm` opción 1: `final166` → `node8bm__v2` | Separar sabotaje, extracción y tratamiento de datos | Secuencia causal clara, pero dos salidas exitosas; proteger datos requiere significado. Valor medio condicionado. Desplaza un final ya coherente. |
| C1 | `node8ae` opción 1: `final58` → `node8bu` | Extraer tras guardias y decidir sobre huellas | Extracción automática y dos fugas exitosas pueden ser cosméticas. Valor medio si huellas tienen relevancia; el cierre actual ya resuelve hackeo/fuga. |

Cada intervención recupera tres definiciones pero pierde accesibilidad de un final: **315 accesibles, 39 borradores, 162 recorridos**. Juntas recuperan doce y desplazan cuatro: **321 accesibles, 33 borradores, 165 recorridos**, no 325/29. Pierden acceso `final154`, `final155`, `final166`, `final58`, sin eliminar sus datos. No se propone inventar conexiones para conservarlos automáticamente.

Añaden una decisión únicamente en cuatro rutas afectadas. Máximo sigue nueve, mediana ocho; la mediana intermedia combinada cambia de 2,8167 a 2,8217 minutos. Es diferencia estructural, no tiempo esperado del jugador. No resuelven la duración global; su justificación debe ser local. Simulaciones completas en `neon_editorial_simulations_not_implemented`.

Guardias: `node7ae` repite victoria de `node8ae`, `node7af` retirada parcial de `node8af`. Insertarlos puede duplicar combate sin avanzar. `node8bv` oculta huellas antes de hackear pero ofrece retirarse con datos; `node8bw` avanza hacia núcleo bloqueado y ofrece datos extraídos; `node8bx` cambia estrategia y su fuga acaba en misión completa. Primero decidir dónde ocurre extracción. Información: `node8by` facilita finalizar; `final122` la usa, pero `final123` almacena y declara éxito sin explicar finalización. Enlazarlo desde `node6t` o después de una extracción completa requiere resolver integrar/ignorar frente a utilizar/almacenar y cronología. No conectar por nombres o numeración.

**Balance editorial:** A7/C1 tienen mejor progresión de fases; A3 posible contraste persistir/renunciar; A4 poco texto nuevo. Ninguna justifica por sí sola desplazar finales. Guardias/información requieren contexto y aprobación. Recuperar 41 IDs no es objetivo de calidad por sí mismo.

## Comparación y prioridades

Valoración verbal interpretativa; no se toma Neon como tamaño ideal.

| Historia | Profundidad / duración intermedia | Variedad y coherencia | Rejugabilidad | Debilidad y mejora |
|---|---|---|---|---|
| Laberinto | 4–5; mediana 2,71 min | Ambientación rica, cierres causales débiles | Moderada exploración, menor aprendizaje | Pagar objetos/pistas y justificar cierres; ampliar descubrimientos existentes |
| Odisea | 27; 8,44 min | Muchos tonos/viñetas, pocas consecuencias; entradas espaciales a revisar | Alta combinación, menor variedad argumental | Profundizar revelaciones y decisiones; no sumar viñetas primero |
| Androide | 3–4; 0,93 min | Dilema fuerte, evidencia/acciones incoherentes | Baja salvo soborno/juicio | Corregir continuidad y ampliar resoluciones éticas |
| Neon | 3–9; 2,82 min | Enfoques iniciales variados, éxito genérico y contradicciones locales | Moderada, baja al reconocer cierres repetidos | Revisar misión/compañeros y desenlaces; recuperación selectiva |

Ninguna historia queda acreditada como exclusivamente “ajustes menores” en toda su extensión. Algunos enlaces de Neon son problemas locales; el resto necesita revisión editorial. Androide requiere ampliación sustantiva de contenido existente; Laberinto, resolver hallazgos; Odisea, significado antes que volumen.

| Orden | Categoría | Recomendación concreta para aprobación | Criterio de valor |
|---|---|---|---|
| 1 | Correcciones de coherencia | Androide: disco/chip y prueba en `n2/n4/n7/n8/n9`; Neon: `node9f`, abandono `node8ak`, éxito `node8ad`, saldo de sobornos | El final no debe negar el acto ni crear recursos ausentes; autor decide estado canónico |
| 2 | Mejoras de decisiones | Androide `n6`–`n9`; seis parejas iguales de Odisea; botones éxito/fallo de Neon | Consecuencias perceptibles; autor puede confirmar decisiones expresivas sin efecto |
| 3 | Mejoras de desenlaces | Laberinto: puentes a escape/condena; Neon: cuerpos repetidos y continuidad del equipo; Androide: requisitos de `n12` | Resolución causal/emocional, sin exigir final exclusivo por padre |
| 4 | Ampliaciones de escenas | Cerámica/llave/ritual; exposición/rescate; nombre/runas; tratamiento de datos y pérdida/alianza | Pagar promesas ya presentes, sin ambientación de relleno |
| 5 | Recuperación de borradores | Revisar A7/C1, luego A3; A4 solo con valor de agencia; guardias/información tras revisar cronología | Balance explícito de final desplazado; ninguna eliminación ni conexión automática |
| 6 | Ajustes de duración | Definir primera lectura vs exploración en metadatos y después medir sesiones humanas | Promesa honesta; no imponer nuevos minutos desde una mediana combinatoria |

Preguntas del autor: ¿qué evidencia sobrevive a borrar/destruir en Androide? ¿Qué opciones iguales son deliberadamente expresivas? ¿Qué verdad concreta culmina cada familia de Odisea? ¿Cómo cada acción de Laberinto descubre la salida común? ¿Qué coste diferencia ocultar/proteger datos de huir en Neon? ¿Se autoriza desplazar esos cuatro finales y qué función debe conservarse? ¿Qué mide la duración declarada? No se han inventado respuestas ni escenas.

## Verificación y límites

El JSON entrega histogramas completos, distribución conjunta, padres, recuentos por final/escena, testigos, repetición normalizada, borradores y simulaciones. Recurrencia reproducible: final `{(0, palabras):1}`; escena suma distribuciones de cada sucesor desplazadas por una decisión y su propio coste textual; procesar cada arista, aunque repita destino. Para rutas de IDs, deduplicar destinos. Uso de escena = caminos de entrada × caminos de salida. La suma de llegadas a finales debe igualar masa del histograma raíz.

No se realizaron sesiones humanas, Flutter Analyze/Test ni ejecución Android/emulador en esta fase documental. No se atribuyen aquí validaciones anteriores. No se conocen preferencias ni velocidades reales de jugadores. Normalizar cabeceras permite detectar cuerpos repetidos, no equivalencia semántica total. Intenciones históricas requieren autor. Convergencia no implica defecto ni final distinto implica experiencia distinta.

El estado de Fase 2B y sus 592 textos se preserva; la auditoría solo crea los dos entregables. No hay modificaciones a historias, motor, diseño, splash, recursos, pruebas, persistencia ni partidas; no hay commit ni push. **Pendiente de autorización expresa antes de implementar cualquier mejora.**

Comprobación final: enumeración exhaustiva de 87/10/161 secuencias coincide con la programación dinámica; metadatos, rutas de recursos e IDs ordenados del índice coinciden con la fuente, y los cuatro individuales son iguales semánticamente. `git diff HEAD` no contiene modificaciones versionadas; `git status --short` muestra únicamente los dos entregables nuevos. SHA-256 de la fuente: `20df32c972625e7af67a6127ec641dc621319ff2eb743019444142caa9ed4847`.
