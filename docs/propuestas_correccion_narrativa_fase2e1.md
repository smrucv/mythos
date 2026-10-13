# Mythos — Propuestas de corrección narrativa, Fase 2E.1

Fecha: 2026-10-12. Base real: `a66c814bcbfc38a121afeb4e244dbe2b86c230f3`. **Propuestas para aprobación expresa; ninguna corrección implementada.**

Se consultaron la auditoría 2C, revisión 2D.2, su JSON y la implementación 2B. Se contrastó todo con `assets/stories/stories.json`, las rutas actuales y `ProgressStore`. Los textos nuevos de este documento son alternativas mutuamente excluyentes; no son hechos ya añadidos al canon. Las frases que cierran una fuga, captura o traición son resoluciones propuestas compatibles con el mundo existente, no resultados comprobados de una partida.

## Recomendación concreta

| Caso | Solución preferida | Qué conservar | Cambio futuro solicitado |
|---|---|---|---|
| E1: fuga → captura | E1-A: la IA intercepta la fuga | Decisión de huir, ID, conexión y captura | Reescribir únicamente `final134.text` |
| E2: abandono → éxito | E2-A: retirada hacia `final57` | Ambas decisiones, éxito válido de `final128`, sus textos e IDs | Solo `node8ak`, elección 2, `nextNodeId`: `final128` → `final57` |
| E3: protección → dominio/traición | E3-A: información protegida a costa de libertad | Acción de proteger y precio literal del pacto | Reescribir únicamente `final133.text`, condicionado a ratificar el significado del pacto |
| E4: sujeto de la traición invertido | E4-A: el protagonista rompe la alianza y sale con datos | Elección de traicionar, hackeo completado, rama de alianza válida | Reescribir únicamente `final9.text` |

E3-A no es permiso para retocar el pacto global. `node6f` dice **«información a cambio de tu libertad»**. Se propone una lectura literal de ese precio, sin inventar concesiones, aliados o un implante. El autor debe ratificarla. `final132` permite escapar después de ese mismo pacto y requiere una decisión complementaria. `final124` se compara como otro acuerdo, pero procede de `node7b/9a`, con términos no especificados: no se le atribuye automáticamente el precio de `node6f`. Ninguna alternativa de E3 modifica esos finales.

## Evidencia y rutas completas actuales

Se enumeraron todas las rutas, no un testigo elegido por conveniencia: una hasta `node9f`, dos hasta `node8ak`, una hasta `node9e`, y una hasta `node8e`. Para evaluar efectos compartidos se incluyen todas las llegadas a `final128` (tres), y las rutas válidas de los finales de comparación. Las elecciones se numeran desde 1. En cada tabla se reproducen íntegramente los textos de las decisiones de la ruta.

### E1 — todas las rutas a `final134` (1)

Ruta 1: `node1 → node2a → node3a → node4b → node5c → node6f → node7k → node9f → final134`.

| Origen | Decisión base 1 | Texto original íntegro | Destino |
| --- | --- | --- | --- |
| node1 | 1 | [INFILTRACIÓN] Usar los ductos de ventilación (riesgo de láseres termales) | node2a |
| node2a | 1 | [SALVAR JAX] Usar los explosivos (alerta al 80% de guardias) | node3a |
| node3a | 2 | [PRAGMÁTICO] Aprovechar su sacrificio y avanzar | node4b |
| node4b | 1 | [HACKEAR NÚCLEO] Iniciar el hackeo del NeuroBank | node5c |
| node5c | 2 | [NEGOCIAR] Intentar negociar con la IA | node6f |
| node6f | 1 | [ACEPTAR TRATO] Aceptar el intercambio | node7k |
| node7k | 2 | [CUMPLIR CON PARCIALIDADES] Cumplir solo parcialmente las condiciones | node9f |
| node9f | 1 | [ESCAPAR CON DATOS LIMITADOS] Iniciar la fuga con la información obtenida | final134 |

### E2 — todas las rutas a `final128` (3)

Ruta 1: `node1 → node2a → node3a → node4b → node5c → node6e → node7i → node9c → final128`.

| Origen | Decisión base 1 | Texto original íntegro | Destino |
| --- | --- | --- | --- |
| node1 | 1 | [INFILTRACIÓN] Usar los ductos de ventilación (riesgo de láseres termales) | node2a |
| node2a | 1 | [SALVAR JAX] Usar los explosivos (alerta al 80% de guardias) | node3a |
| node3a | 2 | [PRAGMÁTICO] Aprovechar su sacrificio y avanzar | node4b |
| node4b | 1 | [HACKEAR NÚCLEO] Iniciar el hackeo del NeuroBank | node5c |
| node5c | 1 | [FORTALECER HACKEO] Utilizar el chip de Jax para potenciar el hackeo | node6e |
| node6e | 1 | [EXTRAER DATOS] Descargar la información vital | node7i |
| node7i | 1 | [ESCAPAR CON DATOS] Iniciar la fuga ahora que tienes los datos | node9c |
| node9c | 1 | [FINAL EXITOSO] Completar la misión con éxito | final128 |

Ruta 2: `node1 → node2a → node3a → node4b → node5c → node6f → node7l → node8ak → final128`.

| Origen | Decisión base 1 | Texto original íntegro | Destino |
| --- | --- | --- | --- |
| node1 | 1 | [INFILTRACIÓN] Usar los ductos de ventilación (riesgo de láseres termales) | node2a |
| node2a | 1 | [SALVAR JAX] Usar los explosivos (alerta al 80% de guardias) | node3a |
| node3a | 2 | [PRAGMÁTICO] Aprovechar su sacrificio y avanzar | node4b |
| node4b | 1 | [HACKEAR NÚCLEO] Iniciar el hackeo del NeuroBank | node5c |
| node5c | 2 | [NEGOCIAR] Intentar negociar con la IA | node6f |
| node6f | 2 | [RECHAZAR TRATO] Rechazar y continuar el hackeo | node7l |
| node7l | 1 | [PERSISTIR] No rendirse y continuar el hackeo | node8ak |
| node8ak | 2 | [ABANDONAR MISION] Decidir abandonar el intento debido a la alta dificultad | final128 |

Ruta 3: `node1 → node2a → node3b → node4d → node5g → node6m → node7r → node8aw → node8ak → final128`.

| Origen | Decisión base 1 | Texto original íntegro | Destino |
| --- | --- | --- | --- |
| node1 | 1 | [INFILTRACIÓN] Usar los ductos de ventilación (riesgo de láseres termales) | node2a |
| node2a | 2 | [SACRIFICIO] Dejar que Jax se sobrecargue (él muere, pero pasas en sigilo) | node3b |
| node3b | 2 | [FRÍO] Recuperar su chip de hackeo del cadáver | node4d |
| node4d | 1 | [USAR CHIP] Utilizar el chip para desactivar las defensas | node5g |
| node5g | 1 | [CONTINUAR A CEGARTE] Seguir adelante pese a la ceguera | node6m |
| node6m | 2 | [USAR TECNOLOGÍA] Activar ayudas tecnológicas para compensar la ceguera | node7r |
| node7r | 1 | [CONTINUAR HACKEO] Continuar con el hackeo mejorado | node8aw |
| node8aw | 2 | [DESACTIVAR SISTEMAS] Intentar desactivar los sistemas de seguridad manualmente | node8ak |
| node8ak | 2 | [ABANDONAR MISION] Decidir abandonar el intento debido a la alta dificultad | final128 |

### E3 — todas las rutas a `final133` (1)

Ruta 1: `node1 → node2a → node3a → node4b → node5c → node6f → node7k → node9e → final133`.

| Origen | Decisión base 1 | Texto original íntegro | Destino |
| --- | --- | --- | --- |
| node1 | 1 | [INFILTRACIÓN] Usar los ductos de ventilación (riesgo de láseres termales) | node2a |
| node2a | 1 | [SALVAR JAX] Usar los explosivos (alerta al 80% de guardias) | node3a |
| node3a | 2 | [PRAGMÁTICO] Aprovechar su sacrificio y avanzar | node4b |
| node4b | 1 | [HACKEAR NÚCLEO] Iniciar el hackeo del NeuroBank | node5c |
| node5c | 2 | [NEGOCIAR] Intentar negociar con la IA | node6f |
| node6f | 1 | [ACEPTAR TRATO] Aceptar el intercambio | node7k |
| node7k | 1 | [ACUERDO COMPLETO] Cumplir con las condiciones de la IA | node9e |
| node9e | 2 | [PROTEGER INFORMACIÓN] Asegurar los datos antes de escapar | final133 |

### E4 — todas las rutas a `final9` (1)

Ruta 1: `node1 → node2a → node3b → node4c → node5f → node6k → node8e → final9`.

| Origen | Decisión base 1 | Texto original íntegro | Destino |
| --- | --- | --- | --- |
| node1 | 1 | [INFILTRACIÓN] Usar los ductos de ventilación (riesgo de láseres termales) | node2a |
| node2a | 2 | [SACRIFICIO] Dejar que Jax se sobrecargue (él muere, pero pasas en sigilo) | node3b |
| node3b | 1 | [RABIA] Jurar venganza y continuar | node4c |
| node4c | 2 | [BUSCAR ALIADOS] Intentar reclutar a otros dentro del edificio | node5f |
| node5f | 1 | [TRABAJAR JUNTOS] Colaborar con el técnico para hackear el sistema | node6k |
| node6k | 1 | [COMPLETAR HACKEO] Finalizar el hackeo con la ayuda del técnico | node8e |
| node8e | 2 | [TRAICIONAR AL TÉCNICO] Usar la información para traicionar al técnico | final9 |

### Rutas completas de comparación que se conservan

| Final | Rutas desde el inicio | Entradas originales |
| --- | --- | --- |
| final135 | node1 → node2a → node3a → node4b → node5c → node6f → node7k → node9f → final135 | node9f (2): [COMPLETAR HACKEO] Continuar el hackeo para obtener más datos |
| final127 | node1 → node2a → node3a → node4a → node5a → node6b → node7c → node9b → final127; node1 → node2a → node3a → node4b → node5c → node6f → node7l → node8ak → final127; node1 → node2a → node3b → node4d → node5g → node6m → node7r → node8aw → node8ak → final127 | node8ak (1): [CONTINUAR HACKEO] Proceder con el hackeo mientras desactivas los sistemas; node9b (2): [RETIRARSE SEGURAMENTE] Escapar de manera segura con los datos |
| final132 | node1 → node2a → node3a → node4b → node5c → node6f → node7k → node9e → final132 | node9e (1): [ESCAPAR CON ÉXITO] Iniciar la fuga con los datos extraídos |
| final85 | node1 → node2a → node3a → node4b → node5d → node6h → node7p → node8at → final85 | node8at (2): [TRAICIONAR ALIANZAS] Utilizar las alianzas para tu beneficio personal |
| final151 | node1 → node2a → node3b → node4d → node5h → node6o → node7v → node8be → final151 | node8be (2): [TRAICIONAR ALIANZAS] Utilizar las alianzas para tu beneficio personal |
| final8 | node1 → node2a → node3b → node4c → node5f → node6k → node8e → final8 | node8e (1): [ESCAPAR CON ÉXITO] Escapar con los datos extraídos |
| final10 | node1 → node2a → node3b → node4c → node5f → node6k → node8f → final10 | node8f (1): [COMBATIR TRAICIÓN] Enfrentar al técnico traicionero |
| final11 | node1 → node2a → node3b → node4c → node5f → node6k → node8f → final11 | node8f (2): [RETIRARSE] Decidir escapar antes de que el técnico te destruya |
| final57 | node1 → node2a → node3a → node4a → node5b → node6c → node7f → node8ad → final57 | node8ad (2): [ABANDONAR Y ESCAPAR] Decidir abandonar la misión y escapar |
| final_secu | node1 → node2a → node3b → node4c → node5e → node6i → node8a → final_secu | node8a (2): [PERSECUCIÓN] Enfrentar a las fuerzas de seguridad que intentan detenerte |

El argumento declarado es robar un secreto del NeuroBank que cambiará el destino humano. No identifica el contenido concreto del secreto ni una organización destinataria; ninguna propuesta inventa esos elementos. El plazo de 27 minutos es ficción, no duración de lectura ni un temporizador comprobado.

## E1. `node9f` → `final134`

### Original íntegro

Escena `node9f`:

```text
[CUMPLIMIENTO PARCIAL] Cumples parcialmente con las condiciones de la IA, obteniendo acceso limitado a la información.
```

Decisión 1 y destino `final134`:

```text
[ESCAPAR CON DATOS LIMITADOS] Iniciar la fuga con la información obtenida
```

Desenlace `final134`:

```text
**Final: Hackeo Desastroso**
Intentas extraer datos adicionales, pero el sistema detecta tu actividad. La IA te atrapa y la misión fracasa.
```

**Confirmado:** cumplimiento parcial del pacto, acceso limitado y elección de iniciar fuga con información obtenida. La IA conserva defensas; no se ha narrado tomar el control del banco. Jax quedó inconsciente en esta ruta y Lira se sacrificó para permitir el avance, sin muerte confirmada.

**Desconocido:** suficiencia de ese subconjunto, qué restricciones exactas aplica la IA, destino posterior de los compañeros y de los datos tras captura. No se sabe si el acceso limitado incluye el secreto esencial.

**Contradicción:** el final hace intentar extraer datos adicionales después de elegir marcharse. Capturar al protagonista no es por sí mismo una contradicción: una fuga puede fracasar. El problema es sustituir la acción elegida sin transición.

### E1-A — Fuga interceptada (preferida)

Mantener literalmente las dos decisiones y sus destinos. Sustituir solo el texto completo de `final134` por:

```text
**Final: Fuga Interceptada**
Con la información que has obtenido, inicias la fuga y buscas la salida. La IA todavía controla las defensas del NeuroBank: detecta tu retirada y bloquea la fuga. Te captura antes de que logres salir del edificio. La misión termina en fracaso; no has conseguido salir del NeuroBank con la información.
```

El bloqueo es una resolución editorial propuesta a partir de las defensas/IA ya establecidas. No introduce nuevos poderes, fuerzas externas ni extracción extra. No afirma que los datos hayan sido destruidos o que Jax/Lira hayan muerto. Tampoco impone cantidad limitada dentro del cuerpo: esa cantidad está en node9f y no debe atribuirse a guardados antiguos que llegaron desde una extracción completa de node8au. Conserva el resultado de captura que ya tenía `final134` y hace causal su fracaso durante la acción realmente elegida.

**Campos futuros:** únicamente `final134.text`, incluido su título. Ningún `nextNodeId`, texto de decisión o nodo previo. `final135` y los cuatro finales `__v2` recuperados en 2B permanecen intactos.

**Coleccionable posterior propuesto:** `confinamiento_mision_fallida`, con información limitada y pacto parcial como circunstancias de la ruta actual, no etiquetas automáticas de todo guardado en ese ID. Solo es una propuesta de correspondencia; no se modifica el registro 2D.2.

### E1-B — Elegir explícitamente forzar el acceso

Si el autor quiere conservar la captura por extracción adicional, puede conservar íntegro `final134` y reemplazar las dos etiquetas/acciones de `node9f` para que las opciones no sean dos maneras indistinguibles de «buscar más». Textos completos propuestos:

Decisión 1, conserva destino `final134`:

```text
[FORZAR EL ACCESO] Intentar extraer datos adicionales saltándote las restricciones de la IA
```

Decisión 2, conserva destino `final135`:

```text
[CONTINUAR EL HACKEO] Explorar el acceso concedido y buscar más información sin saltar directamente a las zonas restringidas
```

Desenlace 1 completo, conservado:

```text
**Final: Hackeo Desastroso**
Intentas extraer datos adicionales, pero el sistema detecta tu actividad. La IA te atrapa y la misión fracasa.
```

Desenlace 2 completo, conservado:

```text
**Final: Hackeo Persistente**
Decides continuar el hackeo para obtener más datos, enfrentándote a nuevas defensas de la IA, pero logras extraer información crucial.
```

La primera rompe restricciones; la segunda continúa por acceso disponible. La información crucial final la establece ya `final135`; no se inventa qué contiene ni se promete salida. La incompletitud de ese cierre sigue en el inventario posterior.

**Campos futuros:** textos de las dos elecciones de `node9f`; no cambia ningún destino ni final. **Desventaja:** elimina la retirada que ya se ofrecía al jugador y cambia su agencia. Por eso E1-A es más conservadora. B no debe implementarse como si la elección antigua hubiese sido «forzar».

**Coleccionable posterior:** confinamiento para `final134`; `final135` mantiene su reserva de extracción con salida pendiente, sin afirmar misión cerrada.

### Impacto y partidas

`final134` solo tiene entrada actual desde `node9f`, elección 1. No se desconecta ningún final con A o B. A conserva estado terminal/ID pero cambia causa y título vistos por todas las partidas en ese final; B conserva su texto pero cambia las opciones de quien vuelva a `node9f`.

También existen partidas anteriores a 2B que llegaron a `final134` desde `node8au`: 2B comprobó que se restauran por el ID original, no por el nuevo `__v2`. No se deben migrar automáticamente a otro final ni inferir una elección nueva a partir del historial antiguo. Véase el apartado de compatibilidad.

## E2. `node8ak` → `final128`

### Original íntegro y entrada válida compartida

Escena `node8ak`:

```text
[DESACTIVAR SISTEMAS MANUALMENTE] Intentas desactivar los sistemas de seguridad manualmente, requiriendo precisión y rapidez.
```

Decisión 2 y destino `final128`:

```text
[ABANDONAR MISION] Decidir abandonar el intento debido a la alta dificultad
```

Desenlace `final128`:

```text
**Final: Misión Exitosa**
Completa la misión con éxito, escapando con los datos extraídos y asegurando el cambio en el destino de la humanidad.
```

Entrada compartida correcta: `node9c` y decisión 1:

```text
[ESCAPADA EXITOSA] Inicias la fuga con los datos extraídos, logrando escapar antes de ser detectado.
```

```text
[FINAL EXITOSO] Completar la misión con éxito
```

**Confirmado:** ambas rutas de `node8ak` intentan desactivar seguridad manualmente; ninguna ha narrado una extracción completada antes de esa escena. Una llega tras rechazar el trato y otra con Jax muerto/ceguera compensada. En cambio, la ruta `node7i → node9c` ya descargó información vital y escapó antes de ser detectada. Esa tercera ruta sí justifica `final128`.

**Desconocido:** cuánto trabajo parcial conserva quien abandona la desactivación y la suerte final de sus compañeros. No puede atribuirse al abandono la descarga completa de otra ruta.

**Contradicción:** abandonar por dificultad acaba en misión exitosa/cambio humano. Reescribir globalmente `final128` como fracaso dañaría la llegada válida desde `node9c`.

### E2-A — Reutilizar la retirada existente (preferida)

Conservar íntegra la decisión 2:

```text
[ABANDONAR MISION] Decidir abandonar el intento debido a la alta dificultad
```

Cambiar exclusivamente su destino a `final57`. Su desenlace completo, que no necesitaría reescritura, es:

```text
**Final: Abandono de Misión**
Decides abandonar la misión y escapar, sobreviviendo pero sin éxito en tu objetivo.
```

No se afirma cantidad de datos ni se resucita a Jax. La retirada resuelve la elección y converge con otra retirada: convergencia válida. `final57` ya tiene ruta desde `node8ad`, elección 2, compatible con misión incompleta y supervivencia. Los antecedentes distintos permanecen como variantes.

**Campos futuros:** solo `node8ak.choices[1].nextNodeId`: `final128` → `final57`. Mantener `node8ak` elección 1 → `final127`, `node9c` elección 1 → `final128`, ambos cuerpos y sus IDs. **Coleccionable posterior propuesto:** `retirada_objetivo_incumplido`.

### E2-B — Retirada mortal, si el autor desea ese riesgo

Existe un resultado fatal compatible con seguridad activa que no requiere borrar el éxito válido ni añadir un final: `final_secu`. Esta alternativa es más severa y solo se propone si el autor quiere que interrumpir la desactivación deje la salida expuesta. Para anunciar el riesgo, sustituir la decisión 2 por el siguiente texto completo y dirigirla a `final_secu`:

```text
[ABANDONAR MISIÓN] Interrumpir el hackeo e intentar salir sin haber desactivado la seguridad
```

Desenlace completo existente, sin reescritura:

```text
**Final: Persecución Mortal**
Durante la fuga, las fuerzas de seguridad te persiguen implacablemente. A pesar de tus esfuerzos, no logras escapar y la misión termina en fracaso, convirtiéndote en otro cadáver en el basurero digital de Neo-Tokio.
```

La persecución/muerte es una resolución alternativa propuesta, no algo confirmado en las rutas actuales de abandono. Seguridad y resultado mortal ya existen en la historia, pero **canon compatible no equivale a intención histórica probada**. No atribuir muerte a Lira/Jax cuando no está narrada. Su antigua ruta desde `node8a`, elección 2, permanece intacta.

**Campos futuros:** texto y destino de la elección 2 de `node8ak`. Nada más. **Coleccionable posterior:** `muerte_en_asalto`; ceguera y compañía son variantes. A es más coherente con una retirada ya ofrecida y evita castigar automáticamente la prudencia. B necesita aprobación explícita del coste fatal, no aprobación genérica de «arreglar abandono».

### Impacto y partidas

`final128` conservaría su entrada válida desde `node9c` y su texto original en ambas opciones; `final57/final_secu` conservarían sus entradas anteriores. Ningún final se desconecta.

Una partida guardada en `final128` desde el antiguo abandono **debe continuar restaurándose en `final128`**, sin convertirla retrospectivamente en retirada o muerte. El historial original permanece. Volver a `node8ak` y elegir nuevamente sería una acción nueva con destino aprobado; abrir la partida no lo es. Quien esté guardado en `node9c`, `final127`, `final57` o `final_secu` no necesita migración.

## E3. `node9e` → `final133`

### Original íntegro y precio del pacto

Escena `node9e`:

```text
[ACUERDO COMPLETO EXITOSO] Cumples completamente con las condiciones de la IA, obteniendo acceso seguro y exitoso a la información.
```

Decisión 2 y destino `final133`:

```text
[PROTEGER INFORMACIÓN] Asegurar los datos antes de escapar
```

Desenlace `final133`:

```text
**Final: Traición y Dominio**
Utilizas las alianzas para tu beneficio personal, traicionando a tus aliados y dominando el NeuroBank a tu manera.
```

Oferta original de `node6f`:

```text
[NEGOCIAR CON IA] Intentas establecer una comunicación con la IA. La IA ofrece un trato: información a cambio de tu libertad.
```

Acuerdo de `node7k`:

```text
[ACEPTAR INTERCAMBIO] Aceptas los términos de la IA, obteniendo acceso seguro a la información a cambio de ciertas concesiones.
```

**Confirmado:** negociación con IA, cumplimiento completo, acceso seguro y elección de proteger datos antes de escapar. No se formaron alianzas con facciones en esta ruta. Jax está inconsciente y el sacrificio de Lira no prueba su muerte. El texto de `node6f` establece información a cambio de libertad; `node7k` alude a concesiones sin definir el mecanismo.

**Desconocido:** cómo cobra la IA esa libertad, si el autor pretendía otra lectura del trato, qué protección técnica se aplica y el destino de los compañeros. No se presupone contrato de cesión de voluntad, implante ni facciones aliadas.

**Contradicción:** proteger información se sustituye por traicionar aliados no establecidos y dominar el banco. El mismo cuerpo tiene soporte distinto en `final85/151`, donde sí se formaron alianzas y se eligió traicionarlas. Esos dos finales no necesitan trasladarse a esta ruta ni modificarse.

### E3-A — Proteger información y pagar con libertad (preferida bajo lectura literal)

Conservar literalmente la decisión y destino. Sustituir solo `final133.text` por:

```text
**Final: Información Protegida, Libertad Perdida**
Aseguras la información que has obtenido antes de intentar marcharte. Pero el intercambio te concedía acceso a los datos, no una salida libre: su precio era tu libertad. La IA mantiene bloqueada la fuga y quedas bajo su control dentro del NeuroBank. Conservas la información protegida, pero no consigues sacarla del edificio. El acuerdo se ha cumplido; tu libertad ha sido el coste.
```

La protección procede de la acción elegida; el control de la salida concreta editorialmente el precio ya escrito. No se inventa muerte, destrucción de datos ni un sometimiento mental. El dato esencial **no se declara entregado ni capaz de cambiar el mundo desde cautiverio**. La incertidumbre posterior es sobre futuro/destinatario, no sobre qué sucedió en este cierre: información protegida y pérdida de libertad.

**Campos futuros:** solo `final133.text`, título incluido. **Condición de aprobación:** ratificar lectura literal del pacto. Si el autor no quiso ese precio, no se ejecuta A ni se redefine el pacto por nuestra cuenta. Debe decidir primero `node6f/7k` y el alcance de `final132` en una corrección distinta. El pacto de `node7b/9a → final124` tiene otros términos no definidos; no se cambia por analogía.

**Coleccionable posterior propuesto:** candidato `libertad_entregada_datos_protegidos`, por intercambio cumplido cuyo coste de libertad constituye el resultado central. No se añade ese ID al registro vigente. Tampoco se presume equivalencia automática con una captura tras extracción ilícita: el sacrificio pactado y datos protegidos requieren aprobación editorial.

### E3-B — Elegir romper el pacto y disputar dominio

Si el autor quiere conservar un desenlace de dominio en esta posición, la decisión tiene que expresarlo y la traición debe referirse al vínculo realmente establecido: el pacto con IA. Sustituir la decisión 2, conservando `nextNodeId: final133`, por:

```text
[ROMPER EL ACUERDO] Usar el acceso obtenido para intentar tomar el control del NeuroBank, traicionando el pacto con la IA
```

Sustituir el texto completo de `final133` por:

```text
**Final: Pacto Roto y Dominio**
Utilizas el acceso obtenido para reanudar el hackeo contra la IA. Esta vez no buscas solamente información: disputas el control de los sistemas. Tras enfrentarte de nuevo a sus defensas, consigues imponerte y tomar el control del NeuroBank. Has roto el acuerdo que te dio acceso a los datos; la cooperación con la IA termina en confrontación y el banco queda bajo tu dominio.
```

No se convierte «acceso a información» en permiso administrativo automático: se narra el nuevo esfuerzo de hackeo y confrontación usando capacidades ya existentes del protagonista. La toma de control era el resultado original de `final133`; no se inventan una facción o una vulnerabilidad específica. No se promete salida física ni entrega de datos. Haber cumplido condiciones antes de elegir no impide elegir romper el pacto después.

**Campos futuros:** decisión 2 de `node9e` y `final133.text`. Mantener escena `node9e`, elección 1 → `final132`, y `final85/151` sin cambios. **Desventaja:** retira la alternativa de proteger información; por eso se prefiere A si se ratifica el pacto literal. B es legítima para priorizar dominio/ruptura ética, pero cambia la intención ofrecida.

**Coleccionable posterior propuesto:** candidato `dominio_por_ruptura_pacto_ia`. No se agrupa automáticamente con traición a aliados humanos ni control con difusión mundial: víctima del pacto y efecto narrado difieren. Se requiere aprobación posterior; registro vigente intacto.

### Impacto y partidas

`final133` solo recibe `node9e`, elección 2; no es un nodo compartido con `final85/151`, aunque sus textos originales coincidan. Ninguna conexión ni accesibilidad cambia con A/B. La escena anterior continúa sirviendo a `final132`: **no reescribirla para que el acuerdo ya haya sido traicionado antes de ambas opciones**.

Partidas en `final133` verían un resultado nuevo si se reemplaza su cuerpo con el motor actual. B también cambia una decisión al volver a `node9e`; una elección vieja de proteger no puede reinterpretarse como ruptura de pacto. Otras partidas con textos idénticos en `final85/151` no se alteran si solo se cambia el ID objetivo correcto. Las concesiones y finales de acuerdo exitoso constituyen una dependencia de canon, no una licencia para editarlos ahora.

## E4. Ruta a `final9`: quién traiciona

### Original íntegro y extracción ya completada

Escena `node8e`:

```text
[HACKEO CON COLABORACIÓN] Completas el hackeo con éxito gracias a la colaboración del técnico, extrayendo los datos necesarios.
```

Decisión 2 y destino `final9`:

```text
[TRAICIONAR AL TÉCNICO] Usar la información para traicionar al técnico
```

Desenlace `final9`:

```text
**Final: Traición Desenfrenada**
El técnico te traiciona, interfiriendo en el hackeo. La misión se desmorona y debes enfrentar las consecuencias.
```

**Confirmado:** Jax murió en esta ruta; se reclutó al técnico, ambos colaboraron y `node8e` declara hackeo completado con datos necesarios extraídos. La elección es **traicionar al técnico**, no descubrir que él traiciona. La otra decisión de `node8e` ya conduce a salida conjunta y alianza futura en `final8`.

**Desconocido:** obligaciones de reparto, destino final del técnico y consecuencias personales de una confrontación. No se inventa una promesa de dinero/datos compartidos. `node8f` sí narra traición del técnico en otra rama previa a la extracción; no debe contaminar retrospectivamente la colaboración de `node8e`.

**Contradicciones:** cambia sujeto de la traición y vuelve a interferir en un hackeo ya terminado. Una pérdida de datos durante fuga sería posible, pero tendría que narrarse: no se reinicia implícitamente el hackeo.

### E4-A — El protagonista rompe la alianza y sale con datos (preferida)

Conservar literalmente la decisión, su destino y `node8e.text`. Sustituir solo `final9.text` por:

```text
**Final: Extracción Exitosa, Alianza Rota**
El hackeo ya está terminado y los datos están en tus manos. Aprovechas esa ventaja para romper la colaboración: te niegas a continuar la fuga junto al técnico que te ayudó a obtenerlos. Lo dejas atrás y sales del NeuroBank con la información. La extracción se ha logrado, pero la alianza no sobrevive a tu decisión. No sabes qué será del técnico dentro del banco; lo que sí sabes es que has utilizado su ayuda para abandonarlo.
```

El abandono del aliado y salida individual son la resolución propuesta de la traición elegida. No se dice que el técnico murió, recibió pago prometido, perdió una copia que tuviera o trató de traicionarte primero. El destino del técnico queda deliberadamente abierto **después de** resolver extracción/salida y ruptura; no se corta una fuga a mitad. No se declara que la humanidad ya haya cambiado ni que nadie pueda rastrear al protagonista.

**Campos futuros:** solo `final9.text`, título incluido. La elección sigue ofreciendo traición; `final8` conserva alianza duradera. `node6k → node8f → final10/11` mantiene traición sufrida, combate/huida y sus textos. Reescribir globalmente `node6k` o `node8e` desharía hechos válidos de esas ramas.

**Coleccionable posterior propuesto:** candidato `extraccion_con_alianza_tecnico_rota`. Traición consumada es resultado ético central y contrapunto a la alianza futura; no se reduce a variante de escape neutro ni se confunde con traición encubierta de `final153`.

### E4-B — El técnico sabotea la fuga, no el hackeo ya completado

Para conservar que el técnico sea el traidor y que la misión fracase, sustituir la elección 2 de `node8e` por:

```text
[DESCONFIAR DEL TÉCNICO] Mantener los datos contigo y preparar la fuga sin confiar tu salida al técnico
```

Mantener destino `final9` y reescribir su texto completo:

```text
**Final: Fuga Saboteada**
El hackeo ya está completado y conservas los datos extraídos. Antes de que logres salir, el técnico rompe la colaboración y utiliza su conocimiento de los sistemas para obstaculizar la fuga. Su intervención alerta a la seguridad del NeuroBank. Las defensas interceptan tu salida y quedas atrapado dentro del edificio. No has perdido por repetir el hackeo: la misión fracasa porque la información no llega a salir contigo.
```

Es una resolución editorial nueva de la consecuencia antes indefinida: cautiverio después de una extracción lograda. Se apoya en técnico con conocimiento de sistemas y capacidad de interferencia ya narrados en `node6k/8f`, no en un arma o programa nuevo. No afirma destrucción de información ni muerte del protagonista. La alarma y bloqueo durante la fuga **no están confirmados en la ruta actual**: se proponen para darle causalidad y cierre, no se presentan como canon preexistente.

**Campos futuros:** elección 2 de `node8e` y `final9.text`. `node8e.text`, la salida amistosa y la rama `node8f` siguen iguales. **Coleccionable posterior propuesto:** `confinamiento_mision_fallida`, con extracción previa y traición sufrida como variantes; ratificar si el vínculo roto merece tratamiento central distinto. No se actualiza el registro.

B conserva fracaso/traición sufrida, pero elimina la decisión de traicionar que ya existía y repite una temática de la rama `node8f`. A conserva mejor la agencia y crea contraste ético con `final8`, sin obligar a que toda deslealtad reciba castigo mortal automático.

### Impacto y partidas

`final9` solo tiene entrada desde `node8e`, elección 2. No se desconecta ningún final. A cambia fallo indefinido por robo logrado con ruptura ética; B concreta ese fallo en captura. Ambas cambian lo que lee una partida guardada allí. Una partida en `node8e` mantiene extracción lograda; una en `final8`, `node8f`, `final10` o `final11` no necesita modificación. B no autoriza reinterpretar la elección antigua de traicionar como una decisión antigua de desconfiar.

## Compatibilidad: límites reales y decisiones necesarias

`ProgressStore` guarda ID actual, IDs de historial, completed y fecha; **no guarda copia del texto ni versión de contenido ni índice de elección**. Un ID conservado sigue siendo restaurable, pero cambiar su cuerpo cambia lo que verá una partida antigua. No confundir compatibilidad de estructura con preservación semántica/textual. No se borra, reinicia ni migra ninguna partida en esta fase.

| Solución | Partidas en escena antes de elegir | Partidas en el final | Partidas ajenas |
|---|---|---|---|
| E1-A | Misma fuga y destino; nuevo resultado causal al elegir | `final134` muestra cuerpo nuevo, incluidos guardados previos a 2B desde `node8au` | `final134__v2`, `final135`, demás historias intactos |
| E1-B | Nuevas acciones; no atribuirlas a elección vieja | `final134/135` conservan cuerpo e ID | Resto sin cambios |
| E2-A | Nuevo abandono conduce a `final57` | Viejo `final128` se restaura en éxito original; no remapearlo | `node9c/final127/final57` conservan contenido |
| E2-B | Nueva advertencia/destino mortal, solo elección nueva | Viejo `final128` permanece igual, no convertirlo en cadáver | Ruta mortal antigua intacta |
| E3-A/B | A protege; B cambia intención a romper pacto | `final133` muestra cuerpo nuevo; B no prueba que antes se eligiera romper pacto | `final85/151/132` permanecen iguales, salvo dependencia pendiente no implementada |
| E4-A/B | A conserva intención; B cambia acción ofrecida | `final9` muestra nuevo resultado y sujeto/causalidad | `final8/10/11` conservan cuerpos y referencias |

Si el autor exige **texto original idéntico para partidas antiguas** en E1-A, E3 o E4, esas reescrituras quedan bloqueadas para implementación con el motor actual. Haría falta aprobar separadamente conservación/versionado de contenido o una estrategia de nuevos destinos que preserve también accesibilidad válida de los antiguos. No se diseña ni ejecuta una migración automática aquí; no se promete una solución mágica manteniendo simultáneamente ID único, texto único y dos versiones. Si el autor acepta corregir el canon mostrado al restaurar, debe autorizar explícitamente ese efecto. Git y las citas originales preservan evidencia histórica, pero no son un respaldo que el lector cargue automáticamente.

## Próximos problemas: inventario priorizado, sin redactarlos aún

El inventario parte de los 80 terminales incluidos en registros pendientes 2D.2 más cuatro asignaciones con preguntas individuales. Se excluyen los cuatro finales prioritarios de este documento; quedan **80**. Se añaden `final30/56`, con contradicción contextual aunque su resultado figuraba como principal propuesto: **82 terminales restantes**, inventariados una vez. Esta revisión **no cambia** su clasificación vigente ni sus cifras. No cuenta borradores y no incorpora A3/A4/A7/C1.

Una categoría principal por grupo de trabajo, con dependencias aparte. «Podría constituir final abierto» no afirma intención del autor: exige que el resultado central ya esté establecido y solo quede futuro abierto, no una acción preparatoria o una confrontación sin resultado. Ninguno de estos terminales recibe texto nuevo en esta fase.

| Prioridad | Clasificación principal | Terminales | Trabajo | Hechos/dependencias y límite |
| --- | --- | --- | --- | --- |
| P0 | Requiere decisión del autor antes de redactar | `final124`, `final132` | Canon del pacto | final132 permite salir después de node6f/7k, donde se intercambian información/libertad. final124 llega por node7b/9a, con otros términos no definidos. Precisar quién entrega qué y el mecanismo de cada pacto; no transferir el precio por texto final idéntico ni inventar concesiones. |
| P1 | Requiere corregir contradicción | `final30`, `final56` | Abandono que se convierte en victoria | node6v deja misión incompleta antes de final30; node8ad declara incompleta antes de final56. No basta ampliar con fuga: datos y objetivo se transforman sin acción intermedia. Dependencia: estado real de extracción. |
| P1 | Requiere corregir contradicción | `final32` | Datos y trampas aparecidos al huir | Ruta de node6v abandona hackeo; node8r solo crea distractores. Decisión/final introducen datos extraídos y trampas sin haberlos narrado. Primero resolver cantidades y método; no explicar únicamente supervivencia. |
| P1 | Requiere decisión del autor antes de redactar | `final15`, `final39`, `final16`, `final44`, `final45`, `final135__v2`, `final73` | Suficiencia y pérdida de información | Huellas borradas desembocan en sacrificio; éxitos completos/parciales y pérdidas posibles no son equivalentes. Precisar qué faltó, si era esencial y si el riesgo se consumó. Sobrevivir y conocer cantidad no implica cumplir misión. |
| P1 | Requiere decisión del autor antes de redactar | `final31`, `final36`, `final49`, `final129` | Confrontaciones sin resultado | No se especifica fuga, captura, muerte ni datos después del combate. Autor elige estado final; no llamarlos abiertos solo por decir dramático o acción. Fijar escenario/posición tras fuga ya narrada y qué objetivo sigue en juego. |
| P1 | Requiere decisión del autor antes de redactar | `final10`, `final157` | Heridas graves o catástrofe indefinida | Técnico derrotado con escape comprometido, o traiciones del equipo catastróficas sin efecto concreto. Definir supervivencia, capacidad de salir y datos antes de redactar; no convertir catástrofe en muerte automáticamente. |
| P2 | Requiere ampliar el desenlace | `final12`, `final14`, `final20`, `final26`, `final38`, `final40`, `final46`, `final47`, `final54`, `final62`, `final84`, `final110`, `final135`, `final146`, `final148`, `final150`, `final164` | Información obtenida, destino personal omitido | La extracción necesaria/crucial se narra, pero fuga/destino no. Cerrar el efecto de la acción ya elegida sin repetir otro hackeo. final135 depende del pacto; alianzas/trampas/defensas son variantes salvo efecto central expreso. |
| P2 | Requiere ampliar el desenlace | `final74`, `final82`, `final83`, `final106`, `final112`, `final142`, `final143` | Éxito declarado sin resultado legible | Afirman misión lograda o eficiencia, pero falta concretar información y cierre personal. Antes acordar significado de cumplir misión; no redactar nuevas herramientas ni otra confrontación de relleno. |
| P2 | Requiere continuar la historia con otra escena | `final52`, `final60` | Hackeo concluido pero asalto no resuelto | Supera defensa/avanza y completa hackeo, sin cerrar obtención y salida. Es etapa intermedia: si el autor quiere jugabilidad posterior, necesita escena de consecuencia, no terminal automático. No se proponen aquí elecciones ni destinos. |
| P2 | Requiere ampliar el desenlace | `final19`, `final35`, `final43`, `final79`, `final125`, `final130` | Protección antes de salir | Establecen protección/garantía, no destino. Cerrar alcance de protección y salida; distinguir menor riesgo de imposibilidad de rastreo. final125 depende del pacto, final130 recibe probabilidad reducida en node9d. |
| P2 | Requiere ampliar el desenlace | `final55`, `final67`, `final103`, `final167` | Actividad oculta sin fuga consumada | Huellas y misión/extracción están descritas, pero antes de escapar no asegura haber salido. Cerrar resultado personal conservando método; no duplicar recompensa por momento de borrar rastros. |
| P2 | Requiere ampliar el desenlace | `final33`, `final63` | Ocultación sin cierre de objetivo o salida | final33 está en retirada después de misión incompleta; no regalar datos. final63 finaliza misión/hackeo, pero omite salida. Diferenciar sus estados antes de usar una frase común. |
| P2 | Requiere continuar la historia con otra escena | `final59` | Ocultar antes de hackear y salir prematuramente | node8ae elección 2 pide borrar rastros antes de hackear; el final pasa a fuga sin narrar la fase objetivo. Continuar preparación hacia consecuencia si se conserva esa intención; si el autor quería retirada debe decidirlo primero. |
| P3 | Podría constituir un final abierto deliberado | `final50`, `final70` | Dominio e información transformadora | Dominio y efecto mundial están establecidos; futuro personal podría quedar abierto como epílogo de poder. Ratificar que ese es el cierre central, no olvidar un combate/fuga pendiente. No declarar salida que no está escrita. |
| P3 | Podría constituir un final abierto deliberado | `final80`, `final139`, `final163` | Destrucción, datos y consecuencia permanente | Resultado material e información extraída expresos podrían cerrar el objetivo central con futuro abierto. Autor ratifica qué ocurre con información y libertad; sin esa intención permanece reserva, no texto aprobado. |
| P2 | Requiere decisión del autor antes de redactar | `final27` | Destrucción y recuperación impedida | No se establece quién conserva el secreto ni qué significa impedir recuperación frente a uso. Definir dato esencial/propiedad y si destrucción es fracaso o cambio central; no inferir difusión externa. |
| P2 | Requiere ampliar el desenlace | `final160` | Hackeo no rastreable sin salida | Hackeo y datos logrados, efecto de rastreo concreto pero fuga omitida. Precisar alcance y consecuencia al salir, sin confundir sabotaje con demolición permanente. |
| P2 | Requiere ampliar el desenlace | `final81`, `final105` | Fuga decidida bajo control de sistemas | Decidir escapar mientras controla sistemas no resuelve por sí solo el trayecto. Completar salida y destino de datos con el control ya narrado; no declarar destrucción irreversible. |
| P3 | Podría constituir un final abierto deliberado | `final17` | Entrega lograda con futuro personal abierto | Información esencial llega a destino, resultado sustancial expreso; suerte posterior podría ser abierta si autor lo quiso. No inventar destinatario, muerte ni cautiverio para rellenar silencio. |
| P2 | Requiere decisión del autor antes de redactar | `final72` | Secretos sin contenido ni culminación | Descubre secretos oscuros, pero no se define revelación, importancia del faltante ni destino. Autor determina contenido canónico y si cierra investigación o abre otra escena; no generar secretos nuevos. |
| P2 | Requiere continuar la historia con otra escena | `final22`, `final23`, `final24`, `final25`, `final28`, `final29` | Acceso, distracción o preparación sin culminación | Penetrar, facilitar, continuar o mejorar posibilidades son procesos; no resuelven obtención/salida. No es final abierto si la escena solo dejó de avanzar. Decidir consecuencia jugable sin inventar elecciones aquí. |
| P2 | Requiere continuar la historia con otra escena | `final64`, `final140`, `final65`, `final141` | Campamento/equipo en incursión activa | node8ah/8az buscan preparar antes de continuar; no han cerrado la incursión actual. Si se quiere epílogo de aplazamiento requiere decisión y transición, no salto temporal implícito. |
| P3 | Podría constituir un final abierto deliberado | `final136`, `final137` | Incursión futura después de posponer | node7ad decide posponer y node9h prepara regreso, soporte para epílogo. Precisar término de la incursión presente; equipo es medio, alianza puede ser resultado central. No confundir con campamento en fase activa. |
| P2 | Requiere ampliar el desenlace | `final61`, `final113` | Fuga con misión/datos omitidos | Se sale con estrategia o antes de contraataque, pero no se define información/objetivo. Completar resultado a partir del estado real anterior, no atribuir extracción que no se haya narrado. |

### Orden de trabajo recomendado

1. **Canon del pacto (antes de E3):** decidir quién entrega información/libertad en `node6f` y revisar `final132`; comparar separadamente los términos no definidos de `node7b/9a → final124`. No sustituirlo por concesiones inventadas para habilitar fuga.
2. **Elegir las cuatro alternativas prioritarias:** aprobación por caso y campos exactos, más decisión sobre textos de partidas antiguas. Recomendación E1-A/E2-A/E3-A condicionada/E4-A.
3. **Abandono que se convierte en victoria y datos que aparecen:** `final30/56/32`; corregir estado de misión antes de ampliar finales dependientes de esa información.
4. **Suficiencia de información y protección:** definir qué falta o se arriesga, alcance de garantías, y salidas de finales ya extractivos. No inventar el secreto.
5. **Confrontaciones y pérdidas del equipo:** autor establece quién vive, qué se conserva y cuándo se termina episodio antes de redactar.
6. **Continuaciones y epílogos:** separar preparación en incursión activa de decisión explícita de posponer; un final abierto se aprueba como intención, no como excusa para un nodo sin continuación.

## Alcance futuro verificable, si se aprueba

Los campos narrativos vivirían en la fuente `assets/stories/stories.json`; después se regenerarían índice/individuales mediante el procedimiento existente y se comprobaría igualdad semántica. Esto no se ejecutó. No cambiar IDs, orden, contenido de otras rutas o datos de partidas por accidente. Las pruebas históricas tendrían que permitir únicamente el manifiesto exacto que autorice el autor; no se debilitan ni se modifican ahora.

Todas las alternativas aquí diseñadas usan IDs actuales: sin añadir/eliminar definiciones, y sin retirar las entradas válidas de `final128`, `final57`, `final_secu`, `final8/10/11` o los finales de traición `final85/151`. Se comprueba por simulación en memoria la accesibilidad de las alternativas de destino, no se declara ejecución de Flutter ni Android. La clasificación posterior por desenlace se expone como correspondencia propuesta de estos cuatro casos, no como otra clasificación general o actualización de archivos vigentes.

## Aprobación pendiente

Se requiere elegir A/B por caso (no ambas), ratificar lectura del pacto y efectos sobre guardados, y después aprobar una implementación limitada a los campos elegidos. Los textos de este documento no son modificaciones jugables. No se ejecutan commit, push, migración, Analyze/Test/build ni emulador en esta fase editorial.

Fuente SHA-256: `20df32c972625e7af67a6127ec641dc621319ff2eb743019444142caa9ed4847`.

| Simulación en memoria | Definiciones | IDs únicos | Accesibles | Terminales accesibles | Resultado |
| --- | --- | --- | --- | --- | --- |
| E2-A | 354 | 354 | 313 | 153 | Sin nodos o finales desconectados; texto simulado no escrito |
| E2-B | 354 | 354 | 313 | 153 | Sin nodos o finales desconectados; texto simulado no escrito |

Las otras alternativas cambian solo texto, por lo que no alteran aristas. Las decisiones y desenlaces originales citados se tomaron directamente del JSON actual. Inventario complementario: 82 IDs únicos, accesibles y no terminales borrador. No se ejecutó la app ni se observó una partida real; rutas y simulaciones son comprobaciones del grafo.

Nota de canon comprobada: `final124` sigue la ruta `node1 → node2a → node3a → node4a → node5a → node6a → node7b → node9a → final124`. Su negociación dice «a cambio de ciertos términos»; no atraviesa node6f. La lectura propuesta del precio de libertad se limita a la rama prioritaria de node6f/7k/9e y no se impone al otro acuerdo.

Validación final: originales de los cuatro casos y textos reutilizados coinciden íntegramente con JSON; ocho alternativas completas documentadas; inventario complementario de 82 terminales únicos verificado. 101 archivos preexistentes conservan SHA-256, incluidos los informes y manifiestos de clasificación. HEAD sigue a66c814; no hay diff versionado. El único archivo nuevo de esta fase es este informe.
