# Mythos — Propuesta editorial de recuperación narrativa, Fase 2A

Fecha: 2026-10-11. Base revisada: commit `81f3d06`, árbol de trabajo limpio antes del análisis. Estado: **propuesta para revisión; ninguna conexión implementada**.

## Alcance, fuentes y criterio

Se consultaron `auditoria_narrativa.md`, `correccion_integridad_narrativa.md`, `borradores_narrativos.json` y `renombres_narrativos_fase1.json`. Se contrastaron con la fuente actual `assets/stories/stories.json`, su representación individual `assets/stories/content/cyberpunk_heist.json` y el índice. El informe histórico sirve de antecedente; las propuestas usan los IDs únicos vigentes, no la resolución antigua de duplicados.

El Asalto Neon tiene 354 definiciones, 309 alcanzables y 45 borradores: ocho variantes de escena y sus 16 finales, cuatro variantes de final y 17 definiciones en grupos previamente aislados. Se inspeccionaron los textos, decisiones y desenlaces, sus referencias entrantes y las rutas desde `node1`. Las simulaciones modificaron únicamente grafos en memoria: no se escribieron JSON, código, manifiestos existentes ni partidas.

Las decisiones se numeran desde **1**; `nodes[i]` conserva la posición desde cero del archivo. Toda flecha propuesta significa reasignar una decisión existente **solo si el autor la aprueba**. No representa una elección nueva. Los textos originales no se reescriben en esta propuesta.

Clasificación de las conexiones:

1. **Respaldada por el texto:** acción, estado y consecuencia encajan explícitamente. Esto acredita coherencia local, no demuestra la intención histórica del autor.
2. **Plausible pero ambigua:** hay afinidad, pero falta un criterio para elegir variante o confirmar una consecuencia.
3. **Contenido incompleto para reconexión:** falta contexto o continuidad que no puede resolverse con certeza cambiando un destino. Permanece como borrador; no se completa inventando escenas.

La confianza mide la correspondencia narrativa, no el beneficio numérico. Todas las reasignaciones necesitan aprobación expresa. Un final puede narrar la resolución de la acción elegida; se distingue eso de una elección que presupone datos que la escena anterior todavía no ha extraído.

## Recomendación para la revisión

Revisar primero **B1–B4**, las cuatro salidas del recorrido con ceguera/retirada. Recuperarían cuatro borradores sin reducir la accesibilidad de otras definiciones. No resuelven todavía la salida incoherente de `node9f` hacia `final134`: esa decisión requiere un acuerdo separado sobre éxito parcial o misión incompleta.

Después, decidir si se acepta ampliar rutas a costa de convertir algunos finales actuales en borradores. Las continuaciones **A3, A4, A7 y C1** tienen respaldo textual para examinarse: permitirían recuperar, junto con B1–B4, **16 de los 45 borradores**, pero cuatro finales actuales quedarían sin entrada. Una ampliación mayor alcanza **25 de los 45**, con siete finales actuales desplazados y dudas de continuidad adicionales. No se recomienda intercambiar rutas simplemente para subir la cifra de cobertura.

Si la condición editorial es conservar accesibles todas las definiciones hoy jugables y no autorizar nuevas elecciones, el conjunto de propuestas aquí analizadas que cumple esa condición es B1–B4. No se afirma que sea un máximo matemático global: no se exploraron conexiones sin respaldo textual para forzar cobertura.

## A. Ocho parejas de escenas

Cada original tiene una sola referencia entrante; ninguna variante `__v2` tiene entrada. El apéndice conserva el texto completo de ambas definiciones, sus decisiones y sus finales. Las rutas actuales completas se incluyen al final.

| Pareja / borrador afectado | Contexto anterior | Problema y relación entre variantes | Conexión o corrección propuesta | Justificación narrativa | Impacto sobre otras rutas | Confianza | Aprobación del autor |
|---|---|---|---|---|---|---|---|
| **A1:** `node8bg` / `node8bg__v2` | `node7w`, decisión 1: crear un plan detallado después de revisar datos | Versiones de la misma planificación; cambia la formulación, no el estado. Original → `final154/155`; v2 → `final86/87` | Mantener v2 como alternativa editorial. Sustituir la entrada de `node7w` solo si el autor elige explícitamente esa versión | Ambas responden a crear el mismo plan; no hay en el texto una condición que permita distinguirlas como dos situaciones | El intercambio aislado recuperaría tres borradores y dejaría inaccesibles original + `final154/155`: ganancia neta cero. Encadenarlas repetiría la planificación | Medio para equivalencia; bajo para un reparto entre rutas | Sí; no hay criterio aprobado de selección |
| **A2:** `node8bh` / `node8bh__v2` | `node7w`, decisión 2: compartir información con el equipo | Texto de escena idéntico; decisiones casi iguales. `final156/88` comparten escape coordinado; `final157` es catastrófico y `final89` describe conflictos sin fijar esa catástrofe | Mantener v2 como versión alternativa; no insertar una segunda escena de compartir información después de la primera | No existe una decisión entrante distinta que justifique cambiar la gravedad de la traición | Un intercambio recuperaría tres y desplazaría original + `final156/157`. La ruta ya contiene la muerte de Jax; no se debe asumir su presencia por la palabra equipo | Medio para equivalencia; bajo para el reparto | Sí; elegir versión y gravedad de traición |
| **A3:** `node8bi` / `node8bi__v2` | Original desde `node7x`, decisión 1: ejecutar el plan e iniciar hackeo. Candidato adicional: `node8bg`, decisión 1 | Escena idéntica de iniciar hackeo con plan mejorado. `final90` y `final158` tienen el mismo texto. `final91` declara misión incompleta; `final159` declara éxito parcial | `node8bg`, decisión 1: `final154` → `node8bi__v2`; conservar `node7x` → original | La decisión dice comenzar el hackeo y v2 dice que comienza. Da continuación al plan recién creado; las dos decisiones de v2 ya existen | Recupera v2 + `final90/91`; `final154` queda sin entrada. El original y `final158/159` siguen accesibles. Añade una decisión y permite retirarse en una ruta que antes terminaba en éxito | Alto para la continuación; la preferencia por v2 no es una intención histórica demostrada | Sí; aceptar ampliación y desplazamiento de `final154` |
| **A4:** `node8bj` / `node8bj__v2` | Original desde `node7x`, decisión 2: colocar trampas. Candidato: `node8bg`, decisión 2 | Escena idéntica de trampas según el plan. Los cuerpos narrativos de `final92/160` y `final93/161` son iguales; cambia parte del titulado | `node8bg`, decisión 2: `final155` → `node8bj__v2`; conservar la entrada del original | Colocar trampas según el plan conduce a una escena que las coloca; continuar hackeo o escapar ya son sus elecciones originales | Recupera tres; `final155` queda sin entrada. Conserva original y `final160/161`. Parte del contenido recuperado es repetición, no una escena nueva | Alto para continuidad | Sí; aceptar ampliación y desplazamiento de `final155` |
| **A5:** `node8bk` / `node8bk__v2` | `node7y`, decisión 1: iniciar hackeo desde el punto localizado | Misma escena, mismos textos de decisiones; `final94/162` y `final95/163` tienen textos iguales | Reservar v2. Alternativa a evaluar: cambiar `node7h`, decisión 1, de `node8ag` a v2, por tratarse también de iniciar hackeo; no recomendarla ahora | La acción es compatible, pero la rama de sigilo ya tiene su propia continuación adecuada. No hay evidencia de que deba reemplazarse | Cambiar `node7y` intercambia tres por tres. Cambiar `node7h` desplaza `node8ag` y `final62/63`; recupera tres y pierde tres. Encadenar tras una elección de extracción volvería a iniciar hackeo | Medio para la alternativa; bajo para su necesidad | Sí; conservar como borrador por ahora |
| **A6:** `node8bl` / `node8bl__v2` | `node7y`, decisión 2: proteger el punto antes de hackear | Misma etapa de protección, versiones diferentes. Original ofrece completar o escapar con defensas; v2 ofrece continuar o retirarse sin éxito. Finales distintos `164/165` frente a `96/97` | Reservar v2, o elegir explícitamente v2 como destino de `node7y`, decisión 2. No poner v2 después de completar hackeo ni después de reforzar otra vez la misma protección | Ambas encajan con proteger antes de hackear, pero no hay elección adicional que determine cuál versión ni qué resultado de retirada debe existir | Intercambio aislado: recupera tres y desplaza original + `final164/165`; no añade cobertura neta. Cambia una retirada con extracción segura por abandono sin éxito | Medio | Sí; decidir significado de retirada y versión |
| **A7:** `node8bm` / `node8bm__v2` | Original desde `node7z`, decisión 1: continuar tras sabotear. Dentro del original, decisión 1: descargar información antes de escapar | **Etapas distintas:** original ha saboteado y facilita extracción; v2 ha completado hackeo y extraído los datos. V2 ofrece escapar o protegerlos | `node8bm`, decisión 1: `final166` → `node8bm__v2`; mantener decisión 2 → `final167` | Descargar información permite pasar a una escena que afirma haberla extraído. Escapar/proteger son acciones posteriores, no una repetición del sabotaje | Recupera v2 + `final98/99`; `final166` queda sin entrada. Original y su salida de ocultación siguen. Amplía la rama sin mezclar el sabotaje con una ruta donde no ocurrió | Alto | Sí; aceptar ampliación y desplazamiento de `final166` |
| **A8:** `node8bn` / `node8bn__v2` | `node7z`, decisión 2: escapar antes de detectar sabotaje | Texto idéntico: extracción segura pero incompleta. Ambos ofrecen éxito o abandono; `final100/168` describen éxito y `final101/169` abandono | Mantener v2 como versión alternativa. No reasignar una salida de trampas o retirada genérica suponiendo que necesariamente hubo este sabotaje | No hay un antecedente distinto que justifique ambas variantes. Confirmar si los datos incompletos pueden satisfacer el objetivo; los textos no fijan ese criterio | Intercambio aislado recupera tres y desplaza original + `final168/169`; ganancia neta cero. Encadenar las dos repite la fuga | Medio para equivalencia; bajo para conexión nueva | Sí; decidir suficiencia de datos y eventual versión |

Las entradas adicionales propuestas en A3/A4 parten de la planificación de `node7w`; los originales continúan en la ejecución de `node7x`. A7 mantiene el contexto explícito de sabotaje de `node7z`. Son distinciones de rutas existentes, no nuevas escenas. No es válido repartir los ocho originales y variantes al azar, por numeración, por un temporizador o por estado no expresado en los textos.

### Los 16 finales subordinados a las variantes

No conviene reconectar un final solo porque su tema coincida con otra decisión: se revisa su escena de origen. En las filas reservadas, la coherencia interna no crea por sí sola una entrada al padre.

| Final afectado | Contexto anterior | Problema | Propuesta | Justificación narrativa | Impacto | Confianza | Aprobación del autor |
|---|---|---|---|---|---|---|---|
| `final86` | `node8bg__v2`, decisión 1: iniciar hackeo con plan | Padre sin entrada | Reservar con A1 | El desenlace completa el hackeo iniciado | Depende de elegir variante de planificación | Alto interno; bajo para entrada nueva | Sí para conectar padre |
| `final87` | `node8bg__v2`, decisión 2: implementar trampas | Padre sin entrada | Reservar con A1 | Trampas facilitan hackeo/extracción | No sustituir finales de otras trampas sin contexto | Alto interno; bajo para entrada | Sí |
| `final88` | `node8bh__v2`, decisión 1: hackeo coordinado | Padre sin entrada | Reservar con A2 | Hackeo y escape coordinado encajan | Alternativa a `final156` | Alto interno; medio editorial | Sí |
| `final89` | `node8bh__v2`, decisión 2: traiciones | Padre sin entrada; gravedad distinta | Reservar con A2 | Conflictos internos, sin catástrofe expresamente fijada | Elegirlo cambia gravedad frente a `final157` | Medio editorial | Sí |
| `final90` | `node8bi__v2`, decisión 1: completar con éxito | Padre sin entrada | Recuperar indirectamente con A3; conservar enlace interno | Extracción total y escape; texto igual al de `final158` | Cuenta como definición recuperada, no como texto inédito | Alto | Sí para A3 |
| `final91` | `node8bi__v2`, decisión 2: escapar antes de terminar | Padre sin entrada | Recuperar con A3; también candidato condicionado para `node9f`, decisión 1 | Misión incompleta y supervivencia encajan con retirada antes de completar | La alternativa de `node9f` depende de si acceso limitado implica objetivo incompleto; no contar dos veces | Alto en A3; medio en `node9f` | Sí |
| `final92` | `node8bj__v2`, decisión 1: continuar hackeo | Padre sin entrada | Recuperar con A4 | Final narra completar extracción y evitar rastreo; mismo cuerpo que `final160` | No implica novedad de contenido por sí solo | Alto | Sí para A4 |
| `final93` | `node8bj__v2`, decisión 2: escapar gracias a trampas | Padre sin entrada | Recuperar con A4 | Escape facilitado por sabotaje; misma resolución textual que `final161` | Se mantiene la lógica ya existente de trampas/sabotaje y extracción resuelta en el final | Alto para correspondencia existente | Sí para A4 |
| `final94` | `node8bk__v2`, decisión 1: descargar toda la información | Padre sin entrada | Reservar con A5 | Extracción total y dominio | Texto igual al de `final162` | Alto interno; medio para entrada | Sí |
| `final95` | `node8bk__v2`, decisión 2: destruir sistemas antes de extraer | Padre sin entrada | Reservar con A5 | Destrucción y extracción expresas | Texto igual al de `final163`; no unir con destrucciones sin datos por nombre | Alto interno | Sí |
| `final96` | `node8bl__v2`, decisión 1: continuar hackeo mejorado | Padre sin entrada | Reservar con A6 | Hackeo mejorado se completa | Cambia versión de protección, no justifica una conexión única | Alto interno; medio editorial | Sí |
| `final97` | `node8bl__v2`, decisión 2: abandonar por seguridad | Padre sin entrada | Reservar con A6 | Abandono sin éxito es explícito | Distinto de escape exitoso con defensas de `final165` | Alto interno; medio editorial | Sí |
| `final98` | `node8bm__v2`, decisión 1: escapar con datos | Padre sin entrada | Recuperar con A7 | Datos ya extraídos antes de elegir fuga | `final166` se desplaza al ampliar la escena anterior | Alto | Sí para A7 |
| `final99` | `node8bm__v2`, decisión 2: proteger y escapar | Padre sin entrada | Recuperar con A7 | Proteger datos ya obtenidos y evitar rastreo | Nueva decisión accesible, sin inventar su texto | Alto | Sí para A7 |
| `final100` | `node8bn__v2`, decisión 1: completar misión con éxito | Padre sin entrada; extracción previa incompleta | Reservar con A8 | Puede ser suficiente una parte de datos, pero no está establecido | No asumir automáticamente éxito pleno | Medio/bajo | Sí; aclarar objetivo |
| `final101` | `node8bn__v2`, decisión 2: abandonar y escapar | Padre sin entrada | Reservar con A8 | Supervivencia sin objetivo coincide con abandono | No justifica diferenciar variantes de la misma fuga | Alto interno; bajo para entrada | Sí |

## B. Cuatro parejas de finales

La contradicción no es que compartan finales varios caminos: eso es válido. Es que una salida de éxito, ocultación o captura conduce a un desenlace que describe otra acción. Los ocho finales se conservan; la propuesta no modifica sus textos.

| Nodo/final afectado | Contexto anterior | Problema identificado | Correspondencia propuesta | Justificación narrativa | Impacto sobre otras rutas | Confianza | Aprobación del autor |
|---|---|---|---|---|---|---|---|
| **B1:** `final134__v2` frente a `final134` | `node8au`, decisión 1: escapar con los datos ya extraídos pese a la ceguera | Actualmente termina en hackeo desastroso intentando extraer más información | `node8au`, decisión 1 → `final134__v2` | El nuevo destino existente dice explícitamente extracción exitosa a ciegas y escape. No exige otra descarga | Recupera un borrador; original sigue con entrada desde `node9f`, aunque esa entrada también es incoherente y debe revisarse por separado | Alto | Sí |
| **B2:** `final135__v2` frente a `final135` | `node8au`, decisión 2: ocultar huellas y escapar; `node9f`, decisión 2: continuar para más datos | La ocultación conduce actualmente a continuar hackeando | `node8au`, decisión 2 → `final135__v2`; mantener `node9f`, decisión 2 → `final135` | V2 borra huellas y escapa, con posible pérdida de datos. Original continúa y logra información crucial | Ambos finales quedan accesibles; se corrige solo una referencia | Alto | Sí |
| **B3:** `final136__v2` frente a `final136` | `node8av`, decisión 1: misión fallida/captura por defensas; `node9h`, decisión 1: mejorar equipo futuro | La captura conduce a preparación exitosa | `node8av`, decisión 1 → `final136__v2`; mantener `node9h`, decisión 1 → `final136` | V2 menciona fracaso por ceguera y captura; original prepara siguiente misión | Recupera v2 y conserva preparación; no resucita un personaje ni revierte la captura | Alto | Sí |
| **B4:** `final137__v2` frente a `final137` | `node8ax`, decisión 1: escapar tras abandonar hackeo; `node9h`, decisión 2: formar alianzas futuras | La retirada conduce a alianzas no elegidas | `node8ax`, decisión 1 → `final137__v2`; mantener `node9h`, decisión 2 → `final137` | V2 escapa sin datos esenciales; original forma alianzas | Recupera v2 y mantiene la rama de planificación futura | Alto | Sí |

### La correspondencia que sigue sin resolver: `node9f` → `final134`

`node9f` obtiene **acceso limitado** y su primera elección dice **iniciar la fuga con la información obtenida**. `final134` relata **intentar extraer datos adicionales**, detección y captura. Ninguna variante de `final134` resuelve inequívocamente esta salida: `final134__v2` añade ceguera y extracción total, estados ausentes de esta ruta.

| Afectado | Contexto anterior | Problema | Alternativas propuestas, excluyentes | Justificación | Impacto | Confianza | Aprobación del autor |
|---|---|---|---|---|---|---|---|
| `node9f`, decisión 1 | Acceso limitado tras acuerdo parcial con IA | Fuga elegida, extracción adicional narrada | Si el objetivo queda incompleto: destino existente `final91`. Si los datos bastan para éxito parcial: `final107` o `final159`, cuyos cuerpos son iguales. Mantener pendiente hasta decidir criterio | Esos finales relatan retirada antes de completar hackeo y supervivencia. No requieren ceguera. La cantidad/suficiencia de datos no está definida | Tras B1, cambiar esta entrada dejaría `final134` sin acceso. Elegir `final91` recupera ese borrador si A3 no lo recuperó ya; no duplica ganancias | Medio; depende de intención de misión | Sí; decidir fracaso incompleto o éxito parcial |
| `final134`, posible nueva entrada | `node8b`, decisión 1: completar extracción de más información a pesar del riesgo | Si se corrige `node9f`, desaparece su última entrada | Candidato: `node8b`, decisión 1, `final2` → `final134`, únicamente si se elige fallo por detección de IA | `node8b` ya intenta obtener más datos y atrae atención; el final relata exactamente ese riesgo materializado | Conserva acceso a `final134`, pero desplaza `final2`, que falla por reinicio/agotamiento de tiempo. Ambos fallos encajan; no hay evidencia para preferir uno | Medio, categoría 2 | Sí; elegir causa de fracaso, no reemplazar por cobertura |

No se propone dar dos finales a una sola elección mediante azar ni añadir una elección sobre riesgos sin autorización. Mantener temporalmente la inconsistencia de `node9f` es una cuestión editorial pendiente claramente registrada, no una afirmación de que B1–B4 resuelvan todos los problemas.

## C. Diecisiete definiciones previamente aisladas

### Procedencia del grupo de guardias

Existe un paralelismo textual directo:

- `node7g`, decisión 1, vence a todos los guardias y hoy llega a `node8ae`. `node7ae` también vence a todos y despeja el núcleo; sus dos elecciones tienen el mismo texto que las de `node8ae`.
- `node7g`, decisión 2, elimina algunos guardias y hoy llega a `node8af`. `node7af` también elimina algunos y mantiene el camino parcialmente bloqueado; sus elecciones equivalen a continuar entre bloqueos o cambiar estrategia.

Esto respalda el **contexto de combate**, pero no demuestra cuál versión quiso publicar el autor. La versión larga de borradores tiene dos niveles y cuatro parejas de finales; la jugable es más breve. No se recomienda ir de `node8ae` a `node7ae` después de elegir iniciar hackeo: repetiría vencer guardias y volvería a ofrecer el mismo inicio. Tampoco insertar `node7af` después de elegir continuar hacia el núcleo solo para repetir la retirada parcial.

Se plantean dos alternativas **excluyentes**:

- **G-extensión:** conservar `node8ae/af` y revisar sus cuatro decisiones hacia `node8bu/bv/bw/bx`. Recupera 12 borradores; deja `node7ae/af` reservados y desplaza cuatro finales actuales.
- **G-reemplazo:** cambiar las dos decisiones de `node7g` a `node7ae/af`, manteniendo los enlaces ya existentes de estos borradores. Recupera 14, pero desplaza `node8ae/af` y sus cuatro finales. Tiene el mismo aumento neto que G-extensión y más escenas actuales desplazadas. No se recomienda solo por recuperar dos IDs más.

### Tabla de los 17 afectados

| Nodo/final afectado | Contexto anterior | Problema identificado | Conexión o corrección propuesta | Justificación narrativa y clasificación | Impacto sobre otras rutas | Confianza | Aprobación del autor |
|---|---|---|---|---|---|---|---|
| `node7ae` | `node7g`, decisión 1: vencer todos los guardias; destino actual `node8ae` | Sin entrada; versión alternativa casi equivalente a escena actual | Solo en G-reemplazo: `node7g`, decisión 1 → `node7ae`; en G-extensión permanece borrador | **1:** victoria completa y acceso al núcleo son explícitos | Su subárbol recupera siete borradores y desplaza `node8ae`, `final58/59` | Alto para contexto; medio para preferencia de versión | Sí; escoger versión larga o conservar actual |
| `node7af` | `node7g`, decisión 2: eliminar algunos y continuar; destino actual `node8af` | Sin entrada; equivalente a escena actual de bloqueos | Solo en G-reemplazo: `node7g`, decisión 2 → `node7af`; en G-extensión permanece borrador | **1:** victoria parcial y camino bloqueado coinciden | Recupera siete del grupo y desplaza `node8af`, `final60/61`; revisar presuposición de datos en ciertas salidas | Alto para contexto; medio para paquete completo | Sí |
| **C1:** `node8bu` | `node7ae`, decisión 1, ya existente pero inaccesible; candidato jugable `node8ae`, decisión 1 | No hay ruta desde inicio | En G-extensión: `node8ae`, decisión 1, `final58` → `node8bu` | **1:** comenzar hackeo con libertad conduce a hackeo completo y datos extraídos. Después, ambas fugas disponen de datos | Recupera este nodo y `final114/115`; `final58` queda sin entrada | Alto | Sí; aceptar mayor detalle y desplazamiento de final |
| **C2:** `node8bv` | `node7ae`, decisión 2; candidato `node8ae`, decisión 2: ocultar antes de hackear | Entrada desconectada; segunda salida presupone datos | G-extensión: `node8ae`, decisión 2, `final59` → `node8bv`, condicionado a revisar la fuga con datos | **1** para ocultación antes del hackeo; **2** para disponer ya de datos en decisión 2 | Recupera tres; desplaza `final59`. No aprobar paquete entero ignorando el salto temporal | Alto para entrada; medio para rama completa | Sí; confirmar de dónde salen los datos |
| **C3:** `node8bw` | `node7af`, decisión 1; candidato `node8af`, decisión 1: continuar pese a bloqueos | Sin acceso; salida de fuga presupone extracción | G-extensión: `node8af`, decisión 1, `final60` → `node8bw`, condicionado a revisar la fuga | **1** para continuar hacia núcleo y defensas; **2** para escapar con datos antes de que la escena confirme hackeo completo | Recupera tres; desplaza `final60` | Alto para entrada; medio para paquete | Sí; confirmar continuidad de extracción |
| **C4:** `node8bx` | `node7af`, decisión 2; candidato `node8af`, decisión 2: ajustar enfoque | Sin acceso; fuga promete extracción segura sin estado explícito previo | G-extensión: `node8af`, decisión 2, `final61` → `node8bx`, con revisión de salida de fuga | **1** para estrategia nueva; **2** para éxito/extracción de retirada, no confirmado antes de salir | Recupera tres; desplaza `final61` | Alto para entrada; medio para paquete | Sí |
| `final114` | `node8bu`, decisión 1: escapar con datos | Padre aislado | Mantener enlace; accesible si se aprueba C1 o G-reemplazo | **1:** datos ya extraídos, fuga exitosa | Sin nueva reasignación propia | Alto | Sí para entrada del padre |
| `final115` | `node8bu`, decisión 2: borrar rastros y escapar | Padre aislado | Mantener enlace con C1 | **1:** ocultación después de extracción completa | Sin contradicción de posesión de datos | Alto | Sí para padre |
| `final116` | `node8bv`, decisión 1: completar hackeo | Padre aislado | Mantener enlace, si se aprueba C2 | **1:** final narra hackeo y extracción que se acaba de elegir | No obliga a corregir esta salida para resolver la otra | Alto | Sí para padre |
| `final117` | `node8bv`, decisión 2: retirarse con datos antes de detección | Escena solo ha borrado rastros antes de hackear | Reservar la rama completa C2 hasta confirmar si ya posee datos | **2:** el final sí es una fuga con datos, pero la elección los presupone y el antecedente no los obtiene | Requeriría una interpretación editorial expresa; no agregar descarga silenciosa al texto | Medio/bajo | Sí; falta estado de extracción |
| `final118` | `node8bw`, decisión 1: completar hackeo | Padre aislado | Mantener enlace con C3 aprobado | **1:** final resuelve completar y extraer antes de reacción de IA | Coherencia local aun si la otra salida está pendiente | Alto | Sí para padre |
| `final119` | `node8bw`, decisión 2: escapar con datos extraídos | Padre dice que continúa hacia núcleo, no que ha extraído | Reservar C3 completo hasta confirmar continuidad | **2:** final completa hackeo y fuga, pero la elección ya da por obtenidos los datos | No corregirlo solo porque comparte tema con `final118` | Medio/bajo | Sí |
| `final120` | `node8bx`, decisión 1: hackear con nueva estrategia | Padre aislado | Mantener enlace con C4 aprobado | **1:** el hackeo adaptado culmina con éxito | Resolución expresa de acción elegida | Alto | Sí para padre |
| `final121` | `node8bx`, decisión 2: escapar con estrategia nueva | Nueva táctica, pero aún no se confirma extracción | Reservar C4 completo hasta decidir si retirar implica obtener datos | **2:** la fuga es compatible; la extracción exitosa adicional necesita criterio | No intercambiar éxito y abandono por semejanza de nombres | Medio | Sí |
| `node8by` | Candidatos `node6t` (información secundaria) y `node8an` (buscar lo faltante) | Sin entrada; no está fijado si la información es imprescindible, adicional o posterior a completar hackeo | Mantener borrador. Hipótesis no recomendada: `node8an`, decisión 1, `final72` → `node8by` | **2** para buscar/descubrir información; **3** para su posición temporal: `node8an` ya dice finalizar hackeo y el borrador habla de ayudar a finalizarlo | Recuperaría tres y desplazaría `final72`, pero no soluciona la contradicción temporal | Bajo para implementación; medio solo para afinidad temática | Sí; definir estado de misión antes de conectar |
| `final122` | `node8by`, decisión 1: utilizar información adicional | Padre sin contexto de entrada | Mantener borrador con el padre | **1** interna: implementar información potencia hackeo; **3** para ruta completa si llega de hackeo ya finalizado | No habilitarlo aislado desde otra escena sin decidir papel de la información | Alto interno; bajo para ruta completa | Sí |
| `final123` | `node8by`, decisión 2: guardar información para futuro | Guardar para futuro culmina también en misión exitosa; antecedente no explica cómo se completó | Mantener borrador; no inventar final alternativo ni añadir una escena | **3:** falta justificar éxito de misión mientras se almacena información. Podría ser opcional tras una misión ya completa, pero entonces la otra rama habla de finalizar un hackeo ya terminado | No hay una conexión única que resuelva ambas salidas con los textos actuales | Bajo | Sí; resolver función de información y cronología |

### Candidatos de información descartados como corrección directa

`node6t` ya obtiene información adicional, así que su primera elección parece cercana a `node8by`. Sin embargo, dice **integrarla** y el borrador vuelve a ofrecer **guardarla para uso futuro**: difiere el compromiso de la elección. Reasignar esa entrada desplazaría `node8m` y `final22/23` y todavía no justificaría el éxito de `final123`. Su segunda elección dice **ignorarla**: descubrirla y usarla después contradiría esa acción.

`node8m` ya la integra; su primera elección inicia el hackeo. Reenviarla a descubrir información otra vez sería una repetición no justificada. `node8an` es el candidato temático más claro porque elige buscar lo faltante y su final actual descubre más secretos, pero el hackeo ya finalizado hace incompatible asumir sin decisión del autor una necesidad posterior de finalizarlo. Estos candidatos son categoría 2 o 3, no reparaciones de confianza alta.

## Estimación de accesibilidad: ganancias y contenido desplazado

Conteos obtenidos con BFS sobre copias del grafo en memoria, desde `node1`, usando exactamente las decisiones descritas. **Recuperados** cuenta IDs de los 45 borradores iniciales que pasan a ser alcanzables. **Desplazados** cuenta IDs de las 309 definiciones inicialmente jugables que dejan de serlo. No se borra su contenido. Borradores totales posteriores = 45 − recuperados + desplazados.

| Escenario excluyente o acumulativo | Borradores iniciales recuperados | Antes jugables desplazados | Cambio neto | Alcanzables totales | Borradores totales | Valor editorial |
|---|---:|---:|---:|---:|---:|---|
| Base, sin aplicar nada | 0 | 0 | 0 | 309 | 45 | Estado real actual |
| B1–B4 | 4 | 0 | +4 | 313 | 41 | Prioridad para aprobación; queda pendiente `node9f` |
| B1–B4 + A3/A4/A7 + C1 | 16 | 4 | +12 | 321 | 33 | Ampliaciones respaldadas; exige aprobar finales desplazados |
| B1–B4 + A3/A4/A7 + G-extensión completa | 25 | 7 | +18 | 327 | 27 | Condicionado a resolver/aceptar dudas de C2–C4 |
| B1–B4 + A3/A4/A7 + G-reemplazo | 27 | 9 | +18 | 327 | 27 | Alternativa a G-extensión; más escenas desplazadas, no recomendada por cobertura |
| Escenario de 25 + hipótesis `node8an` → `node8by` | 28 | 8 | +20 | 329 | 25 | Solo resultado mecánico, **no estimación de recuperación editorial válida**; cronología sin resolver |

Listas de contenido desplazado:

- Escenario de 16: `final154`, `final155`, `final166`, `final58`.
- Escenario de 25: los cuatro anteriores + `final59`, `final60`, `final61`.
- Escenario de 27: los siete anteriores + `node8ae`, `node8af`.
- Hipótesis de 28: los siete del escenario de 25 + `final72`.

Corregir también `node9f`, decisión 1, hacia `final91` después de B1–B4 recuperaría cinco borradores pero desplazaría `final134`: 313 alcanzables, 41 borradores totales. En el escenario de 25, `final91` ya se recupera con A3: esa corrección **no** suma otro borrador y baja el total a 326, con ocho desplazados. Reubicar `final134` en `node8b`, decisión 1, conservaría ese final pero desplazaría `final2`: seguirían 326 alcanzables. Las opciones `final107/159` tampoco permiten sumar un borrador, pues ya son jugables.

La estimación defendible para aprobación es **4** sin desplazar acceso existente, o **16** si se aceptan ampliaciones concretas y cuatro finales pasan a reserva. **25** es una opción condicionada; **27** solo cambia qué versión de combate se publica. No se prometen 45 recuperados ni se contabiliza contenido semánticamente repetido como 45 escenas nuevas. Las variantes restantes carecen de una conexión suficientemente diferenciada; se conservan.

## Preguntas para aprobación expresa

1. ¿Se aprueban B1–B4, manteniendo las salidas de preparación/alianzas de `node9h` y la continuación de `node9f` hacia `final135`?
2. Para escapar con acceso limitado desde `node9f`, ¿el objetivo queda incompleto (`final91`) o existe éxito parcial (`final107/159`)? ¿Debe `final134` continuar reservado o reemplazar el fallo por reinicio de `final2` en `node8b`? Ninguna de esas decisiones es automática.
3. ¿Se aprueban A3/A4/A7 como ampliaciones, aceptando que `final154/155/166` queden reservados? ¿Se desea conservarlos jugables? Si se exige esto último, falta una solución editorial explícita; no se inventarán elecciones.
4. ¿Se aprueba C1 y el desplazamiento de `final58`? Para el resto del combate, ¿se conserva la versión jugable ampliada o se prefiere G-reemplazo? ¿En C2–C4 se permite interpretar que ya se obtuvieron datos antes de la decisión de fuga, o deben seguir reservadas estas ramas?
5. Para A1/A2/A5/A6/A8, ¿son revisiones alternativas que deben permanecer como borradores, o existen antecedentes diferenciados que el autor pueda señalar? En A2 hay que decidir gravedad de la traición; en A6/A8, significado del éxito al retirarse.
6. ¿Qué estado de misión precede a `node8by` y por qué almacenar información futura completa la misión? Sin una decisión explícita no se conectan `node8by` ni `final122/123`.

## Condiciones para una implementación posterior

Una aprobación debe enumerar origen, número/texto de decisión, destino actual y destino autorizado, además del contenido que pasará a reserva. Aprobar una cifra de recuperación no equivale a aprobar todas las conexiones de su escenario. Los escenarios no deben mezclarse sin volver a simular el grafo.

La Fase 1 exige mediante pruebas que las decisiones permanezcan iguales a la referencia congelada. Implementar conexiones aprobadas requerirá **una lista explícita de cambios permitidos en nuevas pruebas**, conservando la fixture histórica; no actualizarla simplemente para hacer pasar las pruebas ni debilitar unicidad/tipos/referencias. El manifiesto editorial deberá reflejar tanto borradores recuperados como finales desplazados.

Las partidas guardadas en un final actual mantienen su ID y texto; cambiar la elección de entrada no permite reinterpretar retroactivamente su desenlace ni redirigir la partida automáticamente. Los historiales existentes necesitan pruebas de restauración y deshacer incluso si un nodo pasa a reserva. No se propone migración ni cambio de clave de almacenamiento. La futura autorización deberá separar cambios para nuevas elecciones de cualquier política sobre partidas previas.

No se repitieron analyze/test en esta fase exclusivamente documental; las 46 pruebas aprobadas corresponden a la Fase 1. La comprobación de esta fase es lectura de recursos, consistencia de representaciones, integridad del grafo y simulación editorial en memoria. No se afirma una verificación visual ni una implementación.

## Apéndices verificables

Las rutas, textos y resultados que siguen se extraen de los recursos actuales. Conservan errores de escritura del original únicamente como citas, sin corregirlos. El inventario cubre las 45 definiciones del manifiesto y los originales/candidatos necesarios para contrastarlas.



### Rutas actuales completas y referencias entrantes

Esta tabla enumera todos los caminos actuales desde el inicio hasta cada original de las ocho parejas y los contextos relevantes. No son propuestas. La variante __v2 de cada pareja no tiene ruta actual. Las referencias se indican por origen, decisión y texto, sin inferir conexiones por ID.

| Destino actual | Todas las rutas desde node1 (número de decisión entre paréntesis) | Todas las entradas actuales |
|---|---|---|
| `node8bg` | `node1` —(1)→ `node2a` —(2)→ `node3b` —(2)→ `node4d` —(2)→ `node5h` —(2)→ `node6p` —(1)→ `node7w` —(1)→ `node8bg` | `node7w`, decisión 1: [PLANIFICAR HACKEO] Crear un plan detallado basado en la información |
| `node8bh` | `node1` —(1)→ `node2a` —(2)→ `node3b` —(2)→ `node4d` —(2)→ `node5h` —(2)→ `node6p` —(1)→ `node7w` —(2)→ `node8bh` | `node7w`, decisión 2: [COMPARTIR INFORMACIÓN] Compartir la información con tu equipo |
| `node8bi` | `node1` —(1)→ `node2a` —(2)→ `node3b` —(2)→ `node4d` —(2)→ `node5h` —(2)→ `node6p` —(2)→ `node7x` —(1)→ `node8bi` | `node7x`, decisión 1: [INICIAR HACKEO] Comenzar el hackeo con el plan mejorado |
| `node8bj` | `node1` —(1)→ `node2a` —(2)→ `node3b` —(2)→ `node4d` —(2)→ `node5h` —(2)→ `node6p` —(2)→ `node7x` —(2)→ `node8bj` | `node7x`, decisión 2: [DEPLOY TRAMPAS] Colocar trampas según el nuevo plan |
| `node8bk` | `node1` —(2)→ `node2b` —(1)→ `node3c` —(2)→ `node4f` —(2)→ `node5j` —(1)→ `node6s` —(1)→ `node7y` —(1)→ `node8bk` | `node7y`, decisión 1: [INICIAR HACKEO] Comenzar el hackeo desde el punto localizado |
| `node8bl` | `node1` —(2)→ `node2b` —(1)→ `node3c` —(2)→ `node4f` —(2)→ `node5j` —(1)→ `node6s` —(1)→ `node7y` —(2)→ `node8bl` | `node7y`, decisión 2: [PROTEGER PUNTO] Establecer protecciones adicionales antes de hackear |
| `node8bm` | `node1` —(2)→ `node2b` —(1)→ `node3c` —(2)→ `node4f` —(2)→ `node5j` —(1)→ `node6s` —(2)→ `node7z` —(1)→ `node8bm` | `node7z`, decisión 1: [CONTINUAR HACKEO] Avanzar con el hackeo ahora que los sistemas están saboteados |
| `node8bn` | `node1` —(2)→ `node2b` —(1)→ `node3c` —(2)→ `node4f` —(2)→ `node5j` —(1)→ `node6s` —(2)→ `node7z` —(2)→ `node8bn` | `node7z`, decisión 2: [ESCAPAR RÁPIDAMENTE] Decidir escapar antes de que se detecte el sabotaje |
| `node8ae` | `node1` —(1)→ `node2a` —(1)→ `node3a` —(1)→ `node4a` —(2)→ `node5b` —(2)→ `node6d` —(1)→ `node7g` —(1)→ `node8ae` | `node7g`, decisión 1: [SUPERAR GUARDIAS] Vencer a todos los guardias |
| `node8af` | `node1` —(1)→ `node2a` —(1)→ `node3a` —(1)→ `node4a` —(2)→ `node5b` —(2)→ `node6d` —(1)→ `node7g` —(2)→ `node8af` | `node7g`, decisión 2: [RETIRARSE PARCIALMENTE] Eliminar algunos guardias y continuar |
| `node8au` | `node1` —(1)→ `node2a` —(2)→ `node3b` —(2)→ `node4d` —(1)→ `node5g` —(1)→ `node6m` —(1)→ `node7q` —(1)→ `node8au` | `node7q`, decisión 1: [EXITO A CIEGAS] Logras completar el hackeo pese a la ceguera |
| `node8av` | `node1` —(1)→ `node2a` —(2)→ `node3b` —(2)→ `node4d` —(1)→ `node5g` —(1)→ `node6m` —(1)→ `node7q` —(2)→ `node8av` | `node7q`, decisión 2: [FALLO POR CIEGUE] La ceguera interrumpe tu hackeo |
| `node8ax` | `node1` —(1)→ `node2a` —(2)→ `node3b` —(2)→ `node4d` —(1)→ `node5g` —(1)→ `node6m` —(2)→ `node7r` —(2)→ `node8ax` | `node7r`, decisión 2: [RETIRARSE] Decidir que es demasiado arriesgado continuar |
| `node9f` | `node1` —(1)→ `node2a` —(1)→ `node3a` —(2)→ `node4b` —(1)→ `node5c` —(2)→ `node6f` —(1)→ `node7k` —(2)→ `node9f` | `node7k`, decisión 2: [CUMPLIR CON PARCIALIDADES] Cumplir solo parcialmente las condiciones |
| `node9h` | `node1` —(2)→ `node2b` —(2)→ `node3d` —(2)→ `node4h` —(1)→ `node5m` —(2)→ `node6x` —(2)→ `node7ad` —(2)→ `node9h` | `node7ad`, decisión 2: [PLANIFICAR NUEVA INCURSION] Preparar una nueva incursión en el futuro |
| `node6t` | `node1` —(2)→ `node2b` —(1)→ `node3c` —(2)→ `node4f` —(2)→ `node5j` —(2)→ `node6t` | `node5j`, decisión 2: [HACKEAR SISTEMA] Usar el tiempo para hackear sistemas secundarios |
| `node8an` | `node1` —(1)→ `node2a` —(1)→ `node3a` —(2)→ `node4b` —(2)→ `node5d` —(1)→ `node6g` —(1)→ `node7m` —(2)→ `node8an` | `node7m`, decisión 2: [OCULTAR HUELLAS] Borrar rastros antes de finalizar |
| `node7h` | `node1` —(1)→ `node2a` —(1)→ `node3a` —(1)→ `node4a` —(2)→ `node5b` —(2)→ `node6d` —(2)→ `node7h` | `node6d`, decisión 2: [SIGILO] Intentar pasar desapercibido |
| `node8m` | `node1` —(2)→ `node2b` —(1)→ `node3c` —(2)→ `node4f` —(2)→ `node5j` —(2)→ `node6t` —(1)→ `node8m` | `node6t`, decisión 1: [UTILIZAR INFORMACIÓN] Integrar la información en tu estrategia principal |
| `node8n` | `node1` —(2)→ `node2b` —(1)→ `node3c` —(2)→ `node4f` —(2)→ `node5j` —(2)→ `node6t` —(2)→ `node8n` | `node6t`, decisión 2: [IGNORAR INFORMACIÓN] Decidir que la información no es relevante |

En las ocho parejas hay una única ruta actual hacia cada original. Los candidatos de continuación A3/A4 agregan entradas a variantes desde la ruta de planificación sin quitar la entrada del original por ejecución. A7 continúa después del sabotaje, no desde una ruta genérica de datos.


### Inventario exacto de los 45 borradores

| ID | Posición | Entradas actuales | Salidas actuales |
|---|---:|---|---|
| `node7ae` | `nodes[85]` | ninguna | decisión 1 → `node8bu`; decisión 2 → `node8bv` |
| `node7af` | `nodes[86]` | ninguna | decisión 1 → `node8bw`; decisión 2 → `node8bx` |
| `node8bg__v2` | `nodes[153]` | ninguna | decisión 1 → `final86`; decisión 2 → `final87` |
| `node8bh__v2` | `nodes[154]` | ninguna | decisión 1 → `final88`; decisión 2 → `final89` |
| `node8bi__v2` | `nodes[155]` | ninguna | decisión 1 → `final90`; decisión 2 → `final91` |
| `node8bj__v2` | `nodes[156]` | ninguna | decisión 1 → `final92`; decisión 2 → `final93` |
| `node8bk__v2` | `nodes[157]` | ninguna | decisión 1 → `final94`; decisión 2 → `final95` |
| `node8bl__v2` | `nodes[158]` | ninguna | decisión 1 → `final96`; decisión 2 → `final97` |
| `node8bm__v2` | `nodes[159]` | ninguna | decisión 1 → `final98`; decisión 2 → `final99` |
| `node8bn__v2` | `nodes[160]` | ninguna | decisión 1 → `final100`; decisión 2 → `final101` |
| `node8bu` | `nodes[167]` | `node7ae`, decisión 1 | decisión 1 → `final114`; decisión 2 → `final115` |
| `node8bv` | `nodes[168]` | `node7ae`, decisión 2 | decisión 1 → `final116`; decisión 2 → `final117` |
| `node8bw` | `nodes[169]` | `node7af`, decisión 1 | decisión 1 → `final118`; decisión 2 → `final119` |
| `node8bx` | `nodes[170]` | `node7af`, decisión 2 | decisión 1 → `final120`; decisión 2 → `final121` |
| `node8by` | `nodes[171]` | ninguna | decisión 1 → `final122`; decisión 2 → `final123` |
| `final86` | `nodes[265]` | `node8bg__v2`, decisión 1 | final sin decisiones |
| `final87` | `nodes[266]` | `node8bg__v2`, decisión 2 | final sin decisiones |
| `final88` | `nodes[267]` | `node8bh__v2`, decisión 1 | final sin decisiones |
| `final89` | `nodes[268]` | `node8bh__v2`, decisión 2 | final sin decisiones |
| `final90` | `nodes[269]` | `node8bi__v2`, decisión 1 | final sin decisiones |
| `final91` | `nodes[270]` | `node8bi__v2`, decisión 2 | final sin decisiones |
| `final92` | `nodes[271]` | `node8bj__v2`, decisión 1 | final sin decisiones |
| `final93` | `nodes[272]` | `node8bj__v2`, decisión 2 | final sin decisiones |
| `final94` | `nodes[273]` | `node8bk__v2`, decisión 1 | final sin decisiones |
| `final95` | `nodes[274]` | `node8bk__v2`, decisión 2 | final sin decisiones |
| `final96` | `nodes[275]` | `node8bl__v2`, decisión 1 | final sin decisiones |
| `final97` | `nodes[276]` | `node8bl__v2`, decisión 2 | final sin decisiones |
| `final98` | `nodes[277]` | `node8bm__v2`, decisión 1 | final sin decisiones |
| `final99` | `nodes[278]` | `node8bm__v2`, decisión 2 | final sin decisiones |
| `final100` | `nodes[279]` | `node8bn__v2`, decisión 1 | final sin decisiones |
| `final101` | `nodes[280]` | `node8bn__v2`, decisión 2 | final sin decisiones |
| `final114` | `nodes[293]` | `node8bu`, decisión 1 | final sin decisiones |
| `final115` | `nodes[294]` | `node8bu`, decisión 2 | final sin decisiones |
| `final116` | `nodes[295]` | `node8bv`, decisión 1 | final sin decisiones |
| `final117` | `nodes[296]` | `node8bv`, decisión 2 | final sin decisiones |
| `final118` | `nodes[297]` | `node8bw`, decisión 1 | final sin decisiones |
| `final119` | `nodes[298]` | `node8bw`, decisión 2 | final sin decisiones |
| `final120` | `nodes[299]` | `node8bx`, decisión 1 | final sin decisiones |
| `final121` | `nodes[300]` | `node8bx`, decisión 2 | final sin decisiones |
| `final122` | `nodes[301]` | `node8by`, decisión 1 | final sin decisiones |
| `final123` | `nodes[302]` | `node8by`, decisión 2 | final sin decisiones |
| `final134__v2` | `nodes[318]` | ninguna | final sin decisiones |
| `final135__v2` | `nodes[319]` | ninguna | final sin decisiones |
| `final136__v2` | `nodes[320]` | ninguna | final sin decisiones |
| `final137__v2` | `nodes[321]` | ninguna | final sin decisiones |


### Textos originales de las parejas, sus decisiones y desenlaces

#### Comparación node8bg / node8bg__v2

#### `node8bg`

```json
{
  "id": "node8bg",
  "text": "[PLANIFICAR HACKEO] Crear un plan detallado basado en la información recopilada, maximizando tus posibilidades de éxito.",
  "choices": [
    {
      "text": "[INICIAR HACKEO] Comenzar el hackeo con el plan mejorado",
      "nextNodeId": "final154"
    },
    {
      "text": "[IMPLEMENTAR TRAMPAS] Colocar trampas según el plan",
      "nextNodeId": "final155"
    }
  ]
}
```

#### `final154`

```json
{
  "id": "final154",
  "text": "**Final: Hackeo Completo con Éxito**\nCompletas el hackeo con éxito siguiendo el plan detallado, extrayendo toda la información necesaria y escapando sin contratiempos."
}
```

#### `final155`

```json
{
  "id": "final155",
  "text": "**Final: Implementación de Trampas y Éxito**\nColocas trampas según el plan, facilitando la extracción de datos y escapando exitosamente con la información."
}
```

#### `node8bg__v2`

```json
{
  "id": "node8bg__v2",
  "text": "[PLANIFICACIÓN DETALLADA] Creas un plan detallado basado en la información recopilada, maximizando tus posibilidades de éxito.",
  "choices": [
    {
      "text": "[INICIAR HACKEO] Comenzar el hackeo con el plan mejorado",
      "nextNodeId": "final86"
    },
    {
      "text": "[IMPLEMENTAR TRAMPAS] Colocar trampas según el plan",
      "nextNodeId": "final87"
    }
  ]
}
```

#### `final86`

```json
{
  "id": "final86",
  "text": "**Final: Hackeo Mejorado y Éxito**\nComienzas el hackeo con el plan mejorado, enfrentándote a las defensas de la IA y completando la misión con éxito.",
  "choices": []
}
```

#### `final87`

```json
{
  "id": "final87",
  "text": "**Final: Implementación de Trampas y Éxito**\nImplementas trampas según el plan, facilitando el hackeo y extrayendo la información necesaria con éxito.",
  "choices": []
}
```

#### Comparación node8bh / node8bh__v2

#### `node8bh`

```json
{
  "id": "node8bh",
  "text": "[COMPARTIR INFORMACIÓN] Compartes la información con tu equipo, mejorando la coordinación durante el hackeo.",
  "choices": [
    {
      "text": "[COMPLETAR HACKEO CON COORDINACIÓN] Proceder con el hackeo mejorado",
      "nextNodeId": "final156"
    },
    {
      "text": "[DESCUBRIR TRAICIONES] Detectar traiciones dentro del equipo",
      "nextNodeId": "final157"
    }
  ]
}
```

#### `final156`

```json
{
  "id": "final156",
  "text": "**Final: Hackeo Coordinado y Éxito**\nProcedes con el hackeo mejorado y escapas con los datos extraídos, asegurando el éxito de la misión gracias a la buena coordinación con tu equipo."
}
```

#### `final157`

```json
{
  "id": "final157",
  "text": "**Final: Descubrimiento de Traiciones**\nDetectas traiciones dentro del equipo, lo que complica la misión y conduce a un desenlace catastrófico."
}
```

#### `node8bh__v2`

```json
{
  "id": "node8bh__v2",
  "text": "[COMPARTIR INFORMACIÓN] Compartes la información con tu equipo, mejorando la coordinación durante el hackeo.",
  "choices": [
    {
      "text": "[COMPLETAR HACKEO CON COORDINACIÓN] Proceder con el hackeo mejorado",
      "nextNodeId": "final88"
    },
    {
      "text": "[DESCUBRIR TRAICIONES] Detectas traiciones dentro del equipo",
      "nextNodeId": "final89"
    }
  ]
}
```

#### `final88`

```json
{
  "id": "final88",
  "text": "**Final: Hackeo y Escape Coordinado**\nProcedes con el hackeo mejorado y escapas con los datos extraídos, asegurando el éxito de la misión.",
  "choices": []
}
```

#### `final89`

```json
{
  "id": "final89",
  "text": "**Final: Traición Dentro del Equipo**\nDetectas traiciones dentro del equipo, complicando la misión y enfrentándote a conflictos internos.",
  "choices": []
}
```

#### Comparación node8bi / node8bi__v2

#### `node8bi`

```json
{
  "id": "node8bi",
  "text": "[HACKEO EXITOSO] Comienzas el hackeo con el plan mejorado, enfrentándote a las defensas de la IA.",
  "choices": [
    {
      "text": "[FINALIZAR HACKEO] Completar el hackeo con éxito",
      "nextNodeId": "final158"
    },
    {
      "text": "[ESCAPAR PREVIA] Decidir escapar antes de finalizar el hackeo",
      "nextNodeId": "final159"
    }
  ]
}
```

#### `final158`

```json
{
  "id": "final158",
  "text": "**Final: Hackeo Exitoso y Escape**\nCompletas el hackeo con éxito, extrayendo toda la información necesaria y escapando sin ser detectado."
}
```

#### `final159`

```json
{
  "id": "final159",
  "text": "**Final: Escape Antes del Hackeo Completo**\nDecides escapar antes de finalizar el hackeo, completando la misión con éxito parcial y asegurando tu supervivencia."
}
```

#### `node8bi__v2`

```json
{
  "id": "node8bi__v2",
  "text": "[HACKEO EXITOSO] Comienzas el hackeo con el plan mejorado, enfrentándote a las defensas de la IA.",
  "choices": [
    {
      "text": "[FINALIZAR HACKEO] Completar el hackeo con éxito",
      "nextNodeId": "final90"
    },
    {
      "text": "[ESCAPAR PREVIA] Decidir escapar antes de finalizar el hackeo",
      "nextNodeId": "final91"
    }
  ]
}
```

#### `final90`

```json
{
  "id": "final90",
  "text": "**Final: Hackeo Exitoso y Escape**\nCompletas el hackeo con éxito, extrayendo toda la información necesaria y escapando sin ser detectado.",
  "choices": []
}
```

#### `final91`

```json
{
  "id": "final91",
  "text": "**Final: Escape Antes de Finalizar Hackeo**\nDecides escapar antes de finalizar el hackeo, dejando la misión incompleta pero sobreviviendo.",
  "choices": []
}
```

#### Comparación node8bj / node8bj__v2

#### `node8bj`

```json
{
  "id": "node8bj",
  "text": "[DEPLOY DE TRAMPAS] Colocas trampas según el nuevo plan, dificultando el avance de los guardias y la IA.",
  "choices": [
    {
      "text": "[CONTINUAR HACKEO] Proceder con el hackeo mejorado",
      "nextNodeId": "final160"
    },
    {
      "text": "[ESCAPAR EFECTIVAMENTE] Escapar aprovechando las trampas colocadas",
      "nextNodeId": "final161"
    }
  ]
}
```

#### `final160`

```json
{
  "id": "final160",
  "text": "**Final: Hackeo Completo con Sabotaje**\nFinalizas el hackeo exitosamente, extrayendo toda la información necesaria y asegurando que el NeuroBank no pueda rastrearte."
}
```

#### `final161`

```json
{
  "id": "final161",
  "text": "**Final: Escape Facilidado por Sabotaje**\nAprovechas el sabotaje para escapar con los datos extraídos de manera segura."
}
```

#### `node8bj__v2`

```json
{
  "id": "node8bj__v2",
  "text": "[DEPLOY DE TRAMPAS] Colocas trampas según el nuevo plan, dificultando el avance de los guardias y la IA.",
  "choices": [
    {
      "text": "[CONTINUAR HACKEO] Proceder con el hackeo mejorado",
      "nextNodeId": "final92"
    },
    {
      "text": "[ESCAPAR EFECTIVAMENTE] Escapar aprovechando las trampas colocadas",
      "nextNodeId": "final93"
    }
  ]
}
```

#### `final92`

```json
{
  "id": "final92",
  "text": "**Final: Hackeo Completo y Sabotaje**\nFinalizas el hackeo exitosamente, extrayendo toda la información necesaria y asegurando que el NeuroBank no pueda rastrearte.",
  "choices": []
}
```

#### `final93`

```json
{
  "id": "final93",
  "text": "**Final: Escape Facilidado por Sabotaje**\nAprovechas el sabotaje para escapar con los datos extraídos de manera segura.",
  "choices": []
}
```

#### Comparación node8bk / node8bk__v2

#### `node8bk`

```json
{
  "id": "node8bk",
  "text": "[COMPLETAR HACKEO] Inicias el hackeo y logras penetrar completamente en los sistemas del NeuroBank.",
  "choices": [
    {
      "text": "[EXTRAER DATOS] Descargar toda la información necesaria",
      "nextNodeId": "final162"
    },
    {
      "text": "[DESACTIVAR SISTEMAS] Destruir todos los sistemas antes de extraer datos",
      "nextNodeId": "final163"
    }
  ]
}
```

#### `final162`

```json
{
  "id": "final162",
  "text": "**Final: Extracción Total y Dominio**\nDescargas toda la información vital y logras escapar con éxito, dominando el NeuroBank y cambiando el destino de la humanidad."
}
```

#### `final163`

```json
{
  "id": "final163",
  "text": "**Final: Destrucción de Sistemas y Extracción**\nDestruyes todos los sistemas antes de extraer datos, asegurando que la información no pueda ser rastreada y completando la misión con éxito."
}
```

#### `node8bk__v2`

```json
{
  "id": "node8bk__v2",
  "text": "[COMPLETAR HACKEO] Inicias el hackeo y logras penetrar completamente en los sistemas del NeuroBank.",
  "choices": [
    {
      "text": "[EXTRAER DATOS] Descargar toda la información necesaria",
      "nextNodeId": "final94"
    },
    {
      "text": "[DESACTIVAR SISTEMAS] Destruir todos los sistemas antes de extraer datos",
      "nextNodeId": "final95"
    }
  ]
}
```

#### `final94`

```json
{
  "id": "final94",
  "text": "**Final: Extracción Total y Dominio**\nDescargas toda la información vital y logras escapar con éxito, dominando el NeuroBank y cambiando el destino de la humanidad.",
  "choices": []
}
```

#### `final95`

```json
{
  "id": "final95",
  "text": "**Final: Destrucción de Sistemas y Extracción**\nDestruyes todos los sistemas antes de extraer datos, asegurando que la información no pueda ser rastreada y completando la misión con éxito.",
  "choices": []
}
```

#### Comparación node8bl / node8bl__v2

#### `node8bl`

```json
{
  "id": "node8bl",
  "text": "[FORTALECER DEFENSAS] Decides mejorar aún más las defensas, creando una barrera adicional contra la IA.",
  "choices": [
    {
      "text": "[COMPLETAR HACKEO] Finalizar el hackeo con defensas reforzadas",
      "nextNodeId": "final164"
    },
    {
      "text": "[ESCAPAR EFECTIVAMENTE] Escapar aprovechando las defensas mejoradas",
      "nextNodeId": "final165"
    }
  ]
}
```

#### `final164`

```json
{
  "id": "final164",
  "text": "**Final: Hackeo Reforzado y Éxito**\nFinalizas el hackeo con defensas reforzadas, extrayendo toda la información necesaria y asegurando el éxito de la misión."
}
```

#### `final165`

```json
{
  "id": "final165",
  "text": "**Final: Escape con Defensas Mejoradas**\nEscapas aprovechando las defensas mejoradas, asegurando una extracción segura y exitosa."
}
```

#### `node8bl__v2`

```json
{
  "id": "node8bl__v2",
  "text": "[PROTEGER SISTEMAS] Decides fortalecer tus defensas antes de continuar con el hackeo.",
  "choices": [
    {
      "text": "[CONTINUAR HACKEO] Proceder con el hackeo mejorado",
      "nextNodeId": "final96"
    },
    {
      "text": "[RETIRARSE] Decidir abandonar el hackeo por seguridad",
      "nextNodeId": "final97"
    }
  ]
}
```

#### `final96`

```json
{
  "id": "final96",
  "text": "**Final: Hackeo Mejorado y Éxito**\nProcedes con el hackeo mejorado, enfrentándote a las defensas de la IA con mayor eficacia y completando la misión con éxito.",
  "choices": []
}
```

#### `final97`

```json
{
  "id": "final97",
  "text": "**Final: Abandono Seguro**\nDecides abandonar el hackeo por seguridad, escapando sin éxito pero asegurando tu supervivencia.",
  "choices": []
}
```

#### Comparación node8bm / node8bm__v2

#### `node8bm`

```json
{
  "id": "node8bm",
  "text": "[SABOTAJE EXITOSO] Logras sabotear el sistema completamente, facilitando la extracción de datos.",
  "choices": [
    {
      "text": "[EXTRAER DATOS] Descargar la información antes de escapar",
      "nextNodeId": "final166"
    },
    {
      "text": "[OCULTAR HUELLAS] Borrar rastros antes de extraer datos",
      "nextNodeId": "final167"
    }
  ]
}
```

#### `final166`

```json
{
  "id": "final166",
  "text": "**Final: Hackeo y Sabotaje Exitoso**\nLogras sabotear el sistema completamente y extraer todos los datos necesarios, escapando sin ser detectado."
}
```

#### `final167`

```json
{
  "id": "final167",
  "text": "**Final: Ocultación Exitosa y Escape**\nDecides borrar tus huellas antes de escapar, asegurando que tu actividad no pueda ser rastreada y completando la misión con éxito."
}
```

#### `node8bm__v2`

```json
{
  "id": "node8bm__v2",
  "text": "[COMPLETAR HACKEO CON SABOTAJE] Finalizas el hackeo con éxito, extrayendo toda la información necesaria.",
  "choices": [
    {
      "text": "[ESCAPAR CON DATOS] Iniciar la fuga con éxito",
      "nextNodeId": "final98"
    },
    {
      "text": "[PROTEGER DATOS Y ESCAPAR] Asegurar los datos antes de escapar",
      "nextNodeId": "final99"
    }
  ]
}
```

#### `final98`

```json
{
  "id": "final98",
  "text": "**Final: Hackeo Completo y Escape**\nFinalizas el hackeo con éxito, extrayendo toda la información necesaria y escapando del NeuroBank con éxito.",
  "choices": []
}
```

#### `final99`

```json
{
  "id": "final99",
  "text": "**Final: Protección y Escape Seguro**\nAseguras los datos antes de escapar, garantizando que la información llegue a su destino sin ser rastreada.",
  "choices": []
}
```

#### Comparación node8bn / node8bn__v2

#### `node8bn`

```json
{
  "id": "node8bn",
  "text": "[ESCAPADA SEGURA] Decides escapar antes de que se detecte el sabotaje, asegurando una extracción segura pero incompleta.",
  "choices": [
    {
      "text": "[FINAL EXITOSO] Completar la misión con éxito",
      "nextNodeId": "final168"
    },
    {
      "text": "[ABANDONAR MISION] Decidir abandonar la misión y escapar",
      "nextNodeId": "final169"
    }
  ]
}
```

#### `final168`

```json
{
  "id": "final168",
  "text": "**Final: Misión Exitosa**\nCompleta la misión con éxito, escapando con los datos extraídos y asegurando el cambio en el destino de la humanidad."
}
```

#### `final169`

```json
{
  "id": "final169",
  "text": "**Final: Abandono y Escape Seguro**\nDecides abandonar la misión y escapar, sobreviviendo pero sin lograr tu objetivo principal."
}
```

#### `node8bn__v2`

```json
{
  "id": "node8bn__v2",
  "text": "[ESCAPADA SEGURA] Decides escapar antes de que se detecte el sabotaje, asegurando una extracción segura pero incompleta.",
  "choices": [
    {
      "text": "[FINAL EXITOSO] Completar la misión con éxito",
      "nextNodeId": "final100"
    },
    {
      "text": "[ABANDONAR MISION] Decidir abandonar la misión y escapar",
      "nextNodeId": "final101"
    }
  ]
}
```

#### `final100`

```json
{
  "id": "final100",
  "text": "**Final: Misión Exitosa**\nCompleta la misión con éxito, escapando con los datos extraídos y cambiando el destino de la humanidad.",
  "choices": []
}
```

#### `final101`

```json
{
  "id": "final101",
  "text": "**Final: Abandono y Escape Seguro**\nDecides abandonar la misión y escapar, sobreviviendo pero sin lograr tu objetivo principal.",
  "choices": []
}
```


### Textos originales de los cuatro finales con variantes

#### `final134`

```json
{
  "id": "final134",
  "text": "**Final: Hackeo Desastroso**\nIntentas extraer datos adicionales, pero el sistema detecta tu actividad. La IA te atrapa y la misión fracasa.",
  "choices": []
}
```

#### `final134__v2`

```json
{
  "id": "final134__v2",
  "text": "**Final: Extracción Exitosa a Ciegas**\nA pesar de tu ceguera, logras extraer toda la información vital del NeuroBank. Escapas exitosamente, cambiando el destino de la humanidad con los datos obtenidos."
}
```

#### `final135`

```json
{
  "id": "final135",
  "text": "**Final: Hackeo Persistente**\nDecides continuar el hackeo para obtener más datos, enfrentándote a nuevas defensas de la IA, pero logras extraer información crucial.",
  "choices": []
}
```

#### `final135__v2`

```json
{
  "id": "final135__v2",
  "text": "**Final: Ocultación y Escape Seguro**\nDecides borrar tus huellas antes de escapar. Aunque logras ocultar tu actividad, algunos datos podrían perderse en el proceso, pero logras salir sin ser detectado."
}
```

#### `final136`

```json
{
  "id": "final136",
  "text": "**Final: Preparación Exitosa**\nMejoras tu equipo para la próxima misión, asegurando una mayor eficiencia y éxito en futuras incursiones.",
  "choices": []
}
```

#### `final136__v2`

```json
{
  "id": "final136__v2",
  "text": "**Final: Misión Fallida por Ceguera**\nLa ceguera interrumpe tu hackeo, y las defensas de la IA te capturan. La misión termina en fracaso, atrapándote dentro del NeuroBank."
}
```

#### `final137`

```json
{
  "id": "final137",
  "text": "**Final: Alianzas Fuertes**\nFormas nuevas alianzas que fortalecen tu posición en futuras misiones, aumentando tus posibilidades de éxito.",
  "choices": []
}
```

#### `final137__v2`

```json
{
  "id": "final137__v2",
  "text": "**Final: Escape Rápido sin Éxito**\nUtilizas tus habilidades para escapar rápidamente, pero sin los datos esenciales, limitando el impacto de tu misión."
}
```


### Textos originales de los grupos aislados

#### `node7ae`

```json
{
  "id": "node7ae",
  "text": "[SUPERAR GUARDIAS] Logras vencer a todos los guardias, despejando el camino hacia el núcleo.",
  "choices": [
    {
      "text": "[INICIAR HACKEO] Comenzar el hackeo con total libertad",
      "nextNodeId": "node8bu"
    },
    {
      "text": "[OCULTAR HUELLAS] Borrar rastros antes de hackear",
      "nextNodeId": "node8bv"
    }
  ]
}
```

#### `node7af`

```json
{
  "id": "node7af",
  "text": "[RETIRADA PARCIAL] Eliminas a algunos guardias y continúas hacia el núcleo, pero el camino aún está parcialmente bloqueado.",
  "choices": [
    {
      "text": "[CONTINUAR AVANZANDO] Seguir hacia el núcleo a pesar de los bloqueos",
      "nextNodeId": "node8bw"
    },
    {
      "text": "[REORGANIZAR ESTRATEGIA] Cambiar tu enfoque para superar los bloqueos",
      "nextNodeId": "node8bx"
    }
  ]
}
```

#### `node8bu`

```json
{
  "id": "node8bu",
  "text": "[HACKEO EXITOSO Y FUERZA TOTAL] Inicias el hackeo y logras penetrar completamente en los sistemas del NeuroBank, extrayendo toda la información necesaria.",
  "choices": [
    {
      "text": "[ESCAPAR CON DATOS] Iniciar la fuga con éxito",
      "nextNodeId": "final114"
    },
    {
      "text": "[OCULTAR HUELLAS Y ESCAPAR] Borrar rastros antes de escapar",
      "nextNodeId": "final115"
    }
  ]
}
```

#### `node8bv`

```json
{
  "id": "node8bv",
  "text": "[OCULTAR HUELLAS EXITOSAMENTE] Logras borrar rastros antes de hackear, reduciendo la probabilidad de ser detectado.",
  "choices": [
    {
      "text": "[COMPLETAR HACKEO] Finalizar el hackeo con éxito",
      "nextNodeId": "final116"
    },
    {
      "text": "[RETIRARSE CON DATOS] Escapar con los datos antes de ser detectado",
      "nextNodeId": "final117"
    }
  ]
}
```

#### `node8bw`

```json
{
  "id": "node8bw",
  "text": "[CONTINUAR HACKEANDO] Sigues hacia el núcleo a pesar de los bloqueos, enfrentándote a las defensas finales.",
  "choices": [
    {
      "text": "[FINALIZAR HACKEO] Completar el hackeo con éxito",
      "nextNodeId": "final118"
    },
    {
      "text": "[ESCAPAR CON DATOS] Iniciar la fuga con los datos extraídos",
      "nextNodeId": "final119"
    }
  ]
}
```

#### `node8bx`

```json
{
  "id": "node8bx",
  "text": "[CAMBIAR ESTRATEGIA EXITOSAMENTE] Ajustas tu enfoque para superar los bloqueos, implementando nuevas tácticas.",
  "choices": [
    {
      "text": "[CONTINUAR HACKEO] Proceder con el hackeo usando la nueva estrategia",
      "nextNodeId": "final120"
    },
    {
      "text": "[ESCAPAR EFECTIVAMENTE] Decidir escapar aprovechando la nueva estrategia",
      "nextNodeId": "final121"
    }
  ]
}
```

#### `node8by`

```json
{
  "id": "node8by",
  "text": "[INFORMACIÓN ADICIONAL] Descubres información adicional que puede ayudarte a finalizar el hackeo con mayor facilidad.",
  "choices": [
    {
      "text": "[UTILIZAR INFORMACIÓN] Implementar la información adicional en tu hackeo",
      "nextNodeId": "final122"
    },
    {
      "text": "[ALMACENAR INFORMACIÓN] Guardar la información para uso futuro",
      "nextNodeId": "final123"
    }
  ]
}
```

#### `final114`

```json
{
  "id": "final114",
  "text": "**Final: Hackeo Total y Escape Exitoso**\nCompletas el hackeo y logras penetrar completamente en los sistemas del NeuroBank, extrayendo toda la información necesaria y escapando con éxito.",
  "choices": []
}
```

#### `final115`

```json
{
  "id": "final115",
  "text": "**Final: Ocultación y Escape Exitosa**\nLogras borrar rastros antes de escapar, asegurando que tu actividad no pueda ser rastreada y completando la misión con éxito.",
  "choices": []
}
```

#### `final116`

```json
{
  "id": "final116",
  "text": "**Final: Hackeo Completo y Éxito**\nFinalizas el hackeo con éxito, extrayendo toda la información necesaria y completando la misión.",
  "choices": []
}
```

#### `final117`

```json
{
  "id": "final117",
  "text": "**Final: Escape Seguro con Datos Extraídos**\nEscapas con los datos extraídos antes de ser detectado, completando la misión con éxito.",
  "choices": []
}
```

#### `final118`

```json
{
  "id": "final118",
  "text": "**Final: Hackeo Completo y Dominio**\nCompletas el hackeo con éxito, extrayendo toda la información necesaria antes de que la IA pueda reaccionar.",
  "choices": []
}
```

#### `final119`

```json
{
  "id": "final119",
  "text": "**Final: Escape Exitoso con Hackeo Completo**\nLogras completar el hackeo y extraer la información necesaria, escapando exitosamente del NeuroBank.",
  "choices": []
}
```

#### `final120`

```json
{
  "id": "final120",
  "text": "**Final: Hackeo Adaptado y Éxito**\nProcedes con el hackeo usando la nueva táctica, enfrentándote a las defensas de la IA con mayor eficacia y completando la misión con éxito.",
  "choices": []
}
```

#### `final121`

```json
{
  "id": "final121",
  "text": "**Final: Escape Aprovechando Nueva Estrategia**\nDecides escapar aprovechando la nueva estrategia, asegurando una extracción segura y exitosa.",
  "choices": []
}
```

#### `final122`

```json
{
  "id": "final122",
  "text": "**Final: Hackeo Potenciado con Información Adicional**\nImplementas la información adicional en tu hackeo, mejorando tus posibilidades de éxito y completando la misión con éxito.",
  "choices": []
}
```

#### `final123`

```json
{
  "id": "final123",
  "text": "**Final: Almacenamiento de Información para Futuro**\nGuardas la información para uso futuro, completando la misión con éxito y preparando futuras incursiones.",
  "choices": []
}
```


### Textos de los antecedentes y finales desplazables usados para justificar propuestas

#### `node7w`

```json
{
  "id": "node7w",
  "text": "[REVISAR DATOS] Revisas y organizas la información recopilada, identificando vulnerabilidades clave en el sistema.",
  "choices": [
    {
      "text": "[PLANIFICAR HACKEO] Crear un plan detallado basado en la información",
      "nextNodeId": "node8bg"
    },
    {
      "text": "[COMPARTIR INFORMACIÓN] Compartir la información con tu equipo",
      "nextNodeId": "node8bh"
    }
  ]
}
```

#### `node7x`

```json
{
  "id": "node7x",
  "text": "[EXECUTAR PLAN] Implementas un nuevo plan basado en la información, ajustando tus tácticas para maximizar el éxito.",
  "choices": [
    {
      "text": "[INICIAR HACKEO] Comenzar el hackeo con el plan mejorado",
      "nextNodeId": "node8bi"
    },
    {
      "text": "[DEPLOY TRAMPAS] Colocar trampas según el nuevo plan",
      "nextNodeId": "node8bj"
    }
  ]
}
```

#### `node7y`

```json
{
  "id": "node7y",
  "text": "[LOCALIZACIÓN DEL PUNTO] Localizas el punto óptimo para iniciar el hackeo, minimizando la detección.",
  "choices": [
    {
      "text": "[INICIAR HACKEO] Comenzar el hackeo desde el punto localizado",
      "nextNodeId": "node8bk"
    },
    {
      "text": "[PROTEGER PUNTO] Establecer protecciones adicionales antes de hackear",
      "nextNodeId": "node8bl"
    }
  ]
}
```

#### `node7z`

```json
{
  "id": "node7z",
  "text": "[SABOTEAR SISTEMAS] Deshabilitas sistemas clave que podrían alertar a la IA o llamar refuerzos.",
  "choices": [
    {
      "text": "[CONTINUAR HACKEO] Avanzar con el hackeo ahora que los sistemas están saboteados",
      "nextNodeId": "node8bm"
    },
    {
      "text": "[ESCAPAR RÁPIDAMENTE] Decidir escapar antes de que se detecte el sabotaje",
      "nextNodeId": "node8bn"
    }
  ]
}
```

#### `node7g`

```json
{
  "id": "node7g",
  "text": "[COMBATE DIRECTO] Enfrentas a los guardias directamente, utilizando tus habilidades de hackeo y Lira su katana.",
  "choices": [
    {
      "text": "[SUPERAR GUARDIAS] Vencer a todos los guardias",
      "nextNodeId": "node8ae"
    },
    {
      "text": "[RETIRARSE PARCIALMENTE] Eliminar algunos guardias y continuar",
      "nextNodeId": "node8af"
    }
  ]
}
```

#### `node8ae`

```json
{
  "id": "node8ae",
  "text": "[SUPERAR GUARDIAS EXITOSAMENTE] Logras vencer a todos los guardias, despejando el camino hacia el núcleo.",
  "choices": [
    {
      "text": "[INICIAR HACKEO] Comenzar el hackeo con total libertad",
      "nextNodeId": "final58"
    },
    {
      "text": "[OCULTAR HUELLAS] Borrar rastros antes de hackear",
      "nextNodeId": "final59"
    }
  ]
}
```

#### `node8af`

```json
{
  "id": "node8af",
  "text": "[REORGANIZACIÓN PARCIAL] Eliminaste algunos guardias y continúas hacia el núcleo, pero el camino aún está parcialmente bloqueado.",
  "choices": [
    {
      "text": "[CONTINUAR HACKEANDO] Seguir hacia el núcleo a pesar de los bloqueos",
      "nextNodeId": "final60"
    },
    {
      "text": "[CAMBIAR ESTRATEGIA] Ajustar tu enfoque para superar los bloqueos",
      "nextNodeId": "final61"
    }
  ]
}
```

#### `node8au`

```json
{
  "id": "node8au",
  "text": "[EXITO A CIEGAS] Logras completar el hackeo pese a la ceguera, extrayendo toda la información necesaria del NeuroBank.",
  "choices": [
    {
      "text": "[ESCAPAR CON DATOS] Iniciar la fuga con los datos extraídos",
      "nextNodeId": "final134"
    },
    {
      "text": "[OCULTAR HUELLAS Y ESCAPAR] Borrar rastros antes de escapar",
      "nextNodeId": "final135"
    }
  ]
}
```

#### `node8av`

```json
{
  "id": "node8av",
  "text": "[FALLO POR CIEGUE] La ceguera interrumpe tu hackeo, fallando en extraer la información y alertando a las defensas de la IA.",
  "choices": [
    {
      "text": "[FINAL FALLIDO] Misión fallida, atrapado por las defensas",
      "nextNodeId": "final136"
    }
  ]
}
```

#### `node8ax`

```json
{
  "id": "node8ax",
  "text": "[RETIRADA] Decides que es demasiado arriesgado continuar, abandonando el hackeo y escapando con vida.",
  "choices": [
    {
      "text": "[ESCAPAR RAPIDAMENTE] Utilizar habilidades para escapar rápidamente",
      "nextNodeId": "final137"
    }
  ]
}
```

#### `node9f`

```json
{
  "id": "node9f",
  "text": "[CUMPLIMIENTO PARCIAL] Cumples parcialmente con las condiciones de la IA, obteniendo acceso limitado a la información.",
  "choices": [
    {
      "text": "[ESCAPAR CON DATOS LIMITADOS] Iniciar la fuga con la información obtenida",
      "nextNodeId": "final134"
    },
    {
      "text": "[COMPLETAR HACKEO] Continuar el hackeo para obtener más datos",
      "nextNodeId": "final135"
    }
  ]
}
```

#### `node9h`

```json
{
  "id": "node9h",
  "text": "[PLANIFICACIÓN FUTURA] Preparas una nueva incursión en el futuro, basándote en las lecciones aprendidas de la misión actual.",
  "choices": [
    {
      "text": "[PREPARAR EQUIPO] Mejorar tu equipo para la próxima misión",
      "nextNodeId": "final136"
    },
    {
      "text": "[FORMAR NUEVOS ALIANZAS] Buscar nuevas alianzas para fortalecer tu próxima incursión",
      "nextNodeId": "final137"
    }
  ]
}
```

#### `node7h`

```json
{
  "id": "node7h",
  "text": "[SIGILO EXITOSO] Logras pasar desapercibido entre los guardias, acercándote al núcleo sin ser detectado.",
  "choices": [
    {
      "text": "[INICIAR HACKEO] Comenzar el hackeo inmediatamente",
      "nextNodeId": "node8ag"
    },
    {
      "text": "[ESCONDERSE] Buscar un lugar seguro para prepararte",
      "nextNodeId": "node8ah"
    }
  ]
}
```

#### `node8ag`

```json
{
  "id": "node8ag",
  "text": "[INICIAR HACKEO DIRECTAMENTE] Comienzas el hackeo directamente desde el punto localizado, enfrentándote a las últimas defensas de la IA.",
  "choices": [
    {
      "text": "[FINALIZAR HACKEO] Completar el hackeo con éxito",
      "nextNodeId": "final62"
    },
    {
      "text": "[OCULTAR HUELLAS] Borrar rastros antes de finalizar",
      "nextNodeId": "final63"
    }
  ]
}
```

#### `node6t`

```json
{
  "id": "node6t",
  "text": "[HACKEO SECUNDARIO] Usas el tiempo para hackear sistemas secundarios, obteniendo información adicional.",
  "choices": [
    {
      "text": "[UTILIZAR INFORMACIÓN] Integrar la información en tu estrategia principal",
      "nextNodeId": "node8m"
    },
    {
      "text": "[IGNORAR INFORMACIÓN] Decidir que la información no es relevante",
      "nextNodeId": "node8n"
    }
  ]
}
```

#### `node8m`

```json
{
  "id": "node8m",
  "text": "[INTEGRACIÓN DE INFORMACIÓN] Integras la información adicional en tu estrategia principal, mejorando tus posibilidades de éxito.",
  "choices": [
    {
      "text": "[INICIAR HACKEO] Proceder con el hackeo mejorado",
      "nextNodeId": "final22"
    },
    {
      "text": "[UTILIZAR INFORMACIÓN] Usar la información para crear distracciones",
      "nextNodeId": "final23"
    }
  ]
}
```

#### `node8n`

```json
{
  "id": "node8n",
  "text": "[IGNORAR INFORMACIÓN] Decides que la información no es relevante y continúas con el hackeo original.",
  "choices": [
    {
      "text": "[CONTINUAR HACKEO] Proceder sin cambios",
      "nextNodeId": "final24"
    },
    {
      "text": "[ADAPTAR ESTRATEGIA] Ajustar ligeramente tu enfoque basado en la nueva información",
      "nextNodeId": "final25"
    }
  ]
}
```

#### `node8an`

```json
{
  "id": "node8an",
  "text": "[HUELRAS OCULTAS] Logras borrar rastros y finalizar el hackeo, pero te das cuenta de que algo falta.",
  "choices": [
    {
      "text": "[BUSCAR LO FALTANTE] Intentar encontrar lo que falta",
      "nextNodeId": "final72"
    },
    {
      "text": "[ACEPTAR INCOMPLETUD] Aceptar que la misión está incompleta y escapar",
      "nextNodeId": "final73"
    }
  ]
}
```

#### `node8b`

```json
{
  "id": "node8b",
  "text": "[PROLONGAR HACKEO] Intentas extraer más información, pero esto consume más tiempo y atrae más atención.",
  "choices": [
    {
      "text": "[FINALIZAR EXTRAER MÁS DATOS] Completar la extracción a pesar del riesgo",
      "nextNodeId": "final2"
    },
    {
      "text": "[RETRAER DATOS RELEVANTES] Decidir solo extraer datos cruciales y escapar",
      "nextNodeId": "final3"
    }
  ]
}
```

#### `final2`

```json
{
  "id": "final2",
  "text": "**Final: Exceso de Ambición**\nIntentas extraer más información de la necesaria, pero el tiempo se agota. El sistema se reinicia, dejando tu misión incompleta y atrapándote dentro del NeuroBank.",
  "choices": []
}
```

#### `final3`

```json
{
  "id": "final3",
  "text": "**Final: Extracción Estratégica**\nDecides solo extraer datos cruciales y escapar. La información es suficiente para cambiar el destino de la humanidad, asegurando el éxito de tu misión.",
  "choices": []
}
```

#### `final58`

```json
{
  "id": "final58",
  "text": "**Final: Hackeo y Escape Exitoso**\nCompletas el hackeo con éxito y escapas del NeuroBank, cambiando el destino de la humanidad.",
  "choices": []
}
```

#### `final59`

```json
{
  "id": "final59",
  "text": "**Final: Ocultación y Escape**\nBorras rastros antes de hackear, asegurando que tu actividad no pueda ser rastreada y escapando con éxito.",
  "choices": []
}
```

#### `final60`

```json
{
  "id": "final60",
  "text": "**Final: Hackeo y Escape Directo**\nSigues hacia el núcleo a pesar de los bloqueos, enfrentándote a las defensas finales y completando el hackeo con éxito.",
  "choices": []
}
```

#### `final61`

```json
{
  "id": "final61",
  "text": "**Final: Cambio de Enfoque y Escape**\nAjustas tu enfoque para superar los bloqueos y decides escapar aprovechando la nueva estrategia.",
  "choices": []
}
```

#### `final72`

```json
{
  "id": "final72",
  "text": "**Final: Búsqueda de Lo Faltante**\nIntentas encontrar lo que falta en la información, pero descubres más secretos oscuros del NeuroBank.",
  "choices": []
}
```

#### `final107`

```json
{
  "id": "final107",
  "text": "**Final: Escape Antes del Éxito Completo**\nDecides escapar antes de finalizar el hackeo, completando la misión con éxito parcial y asegurando tu supervivencia.",
  "choices": []
}
```


### Comprobación de integridad del análisis

La fuente y los cuatro archivos individuales coinciden semánticamente con sus fichas del índice. El Asalto Neon mantiene 354 IDs únicos, cero destinos inexistentes, 309 definiciones alcanzables y 45 borradores. Se verificaron los cinco escenarios de la tabla, sus ganancias y pérdidas, sin modificar los objetos narrativos ni escribir datos de ejecución.

Los documentos de la Fase 1 permanecen como evidencia histórica. La única salida nueva de esta fase es este informe; se conservaron hashes de todos los archivos existentes inspeccionados, incluidos lib, test, assets, Android, documentación previa, herramientas, scripts y pubspec.

- `assets/stories/stories.json`: SHA-256 `6d75ee2f265d826fc07e035abd54e34278daf67349b63819f7116a3ebc8be07e`.

- `assets/stories/content/cyberpunk_heist.json`: SHA-256 `832a2df628d8398d11ca7e1b71df53d5f1ec33c18eaf5baa67667628147d4340`.

- `assets/stories/index.json`: SHA-256 `167c34da4e8f5eb1620a1b76e5610f532a22e9d1383fe674b9aff6a2da3294cb`.

- `docs/auditoria_narrativa.md`: SHA-256 `45802427d7d7884a4aba4b708a4e5893fb39601d97444cfffb435afa3be5c2b3`.

- `docs/correccion_integridad_narrativa.md`: SHA-256 `ea9da145fabc1ee65b74164f450799c770b669097e6126e090bfff3b30298715`.

- `docs/borradores_narrativos.json`: SHA-256 `b06695b697ca6949cd12aa61f2c9579376aeb51de2f1bae24d32db0446ddcf7e`.

- `docs/renombres_narrativos_fase1.json`: SHA-256 `8a29e65fd14e9b0f08a27450cb1f398cb8e8d25bae432640e5a312829fa64b99`.


**Pendiente de autorización expresa del autor. Ninguna conexión se ha implementado.**
