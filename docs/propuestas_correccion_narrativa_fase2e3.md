# Mythos — Propuestas de causalidad narrativa, Fase 2E.3

Fecha: 2026-10-13. **Documento editorial para aprobación individual; no contiene cambios implementados.**

## 1. Estado de partida

Se inspeccionaron Git y el JSON canónico del proyecto, sin asumir correctos los diagnósticos anteriores. HEAD: `f7cd2daabe3b362e4316a87d1a518f82447f9654`; árbol de trabajo e índice inicialmente limpios. La referencia jugable es la Fase 2E.2 cerrada: diez campos autorizados, 354 definiciones únicas de Neon, 313 accesibles, 153 terminales accesibles y 41 borradores. Las 74 pruebas y los seis recorridos Android son resultados del cierre anterior, **no pruebas ejecutadas de nuevo en esta fase documental**.

Se consultaron `cierre_fase2e2.md`, `implementacion_fase2e2.md`, `propuestas_correccion_narrativa_fase2e1.md`, `clasificacion_finales_fase2d_revision.md` y `grupos_finales_revision.json`. Estos documentos permanecen intactos. La clasificación 2D.2 es una propuesta histórica, no un canon aprobado de grupos; sus evidencias deben contrastarse con las rutas.

Fuente: `assets/stories/stories.json`, historia `cyberpunk_heist`, inicio `node1`. Se recorrió el grafo completo de esta historia para contar todas las rutas a los tres terminales y todas sus referencias entrantes. También se revisó `ProgressStore` para evaluar compatibilidad. No se realiza otro inventario general de las cuatro historias.

**Resultado de alcance:** cada terminal tiene exactamente una ruta desde el inicio y una referencia entrante. Ninguno recibe actualmente una ruta independiente que sí haya completado la extracción. Conservar su actual texto de victoria no protege aquí una victoria legítima de otra ruta; crear una victoria legítima exigiría una acción nueva y aprobada.

## 2. Diagnóstico de los tres problemas

### 2.1 `final30`: supervivencia convertida en extracción

La decisión `node5k` (2) detiene el hackeo; `node6v` declara la misión incompleta. `node8q` solo narra evasión. No hay descarga posterior, pero su primera elección ofrece «Completar la misión con éxito» y `final30` afirma datos extraídos y éxito sin contratiempos. Son dos fallos relacionados: una decisión formulada como resultado y una extracción sin causa.

Llegar al núcleo en `node4g` no equivale a obtener información. Haber iniciado un hackeo en `node5k` tampoco acredita una descarga. La alarma está activa desde `node3d`; «sin contratiempos» no describe el recorrido completo, aunque una última maniobra pudiera salir bien.

### 2.2 `final56`: hackeo de seguridad convertido en hackeo de datos

La ruta abandona el avance al núcleo desde `node4a` (2), localiza mantenimiento y utiliza un terminal para abrir puertas y desactivar cámaras. El objetivo de `node6c` es **seguridad**, no extracción. La elección que habría llevado al núcleo es `node6c` (1) y no se toma. En cambio, se reinicia el sistema, se alerta a más guardias y se decide escapar. `node8ad` declara misión incompleta; `final56` declara extracción, fuga y transformación de la humanidad.

Cambiar solo «Completar la misión con éxito» por «Intentar completarla» mantendría el salto causal. O se reconoce la retirada con objetivo incumplido, o el jugador elige detenerla, llega realmente al núcleo y realiza la extracción antes de salir. Tampoco una descarga acredita por sí sola un cambio permanente sobre la humanidad: falta su uso o consecuencia.

### 2.3 `final32`: datos y trampas sin procedencia; fuga sin cierre

Comparte con `final30` el hackeo interrumpido y la misión incompleta. `node8r` crea una distracción efectiva, pero no explica su mecanismo ni coloca trampas. Su primera elección introduce «datos extraídos» por primera vez; el final introduce «trampas colocadas» y solo dice «Inicias la fuga», no que se salga del banco.

La distracción está confirmada; una trampa material o digital, su instalación y una descarga no lo están. No se puede convertir retrospectivamente un distractor en una trampa ni usar la afirmación del propio final como prueba de que hubo preparación previa. Hace falta corregir el estado de información, el recurso utilizado y la resolución de la salida.

### 2.4 Estado de información, fuga y recursos

| Ruta | Hechos explícitos al llegar al padre terminal | Información esencial | Fuga | Recursos establecidos y límites |
|---|---|---|---|---|
| `final30` | Entrada por dron; combate y alarma; ascensor hasta núcleo; hackeo iniciado y detenido; evasión por alternativas | No se narra extracción completada. La misión se declara incompleta. No se acredita una cantidad parcial | Retirada decidida y evasión en curso; no se afirma inequívocamente estar fuera | Habilidad de hackeo, dron usado para entrar, ascensor y trayecto de entrada, rutas alternativas y evasión. No control del dron para salir ni capacidad de vencer toda la IA |
| `final56` | Láseres destruidos por explosivos; Jax inconsciente; Lira con daños críticos; retirada a mantenimiento; terminal de seguridad; reinicio y guardias alertados | No se narra hackeo de datos ni llegada al núcleo en esta rama. Abrir puertas no obtiene la información de misión | `node7f`/`node8ad` dicen «Decidir/Decides escapar». El rótulo «ESCAPADA EXITOSA» no demuestra salida física | Hackeo usado en combate y en terminal; ubicación del núcleo y trayecto de entrada por ductos. No acceso remoto a secretos desde mantenimiento, curación de Lira ni disponibilidad consciente de Jax |
| `final32` | Los mismos antecedentes de hackeo interrumpido; distracción efectiva | No se narra extracción completada ni cantidad parcial | La distracción facilita una fuga todavía pendiente de culminación | Distractor de mecanismo no especificado, habilidad de hackeo y itinerario por ascensor/zona de carga. No trampas instaladas, explosivos de la otra rama, sigilo mejorado de `node4b` ni recuperación del dron |

**Información parcial:** no está confirmada en ninguna de estas tres rutas. En `final30/32` podría interpretarse que un hackeo interrumpido dejó algún dato, pero el texto no lo dice; no se escribe una propuesta de «escape con datos parciales» basándose en esa posibilidad. Tampoco se afirma que absolutamente ningún dato técnico se consultó. Las retiradas propuestas se definen por **extracción no completada / objetivo incumplido**, sin fabricar una cantidad.

**Compañeros:** en la rama del dron no se confirma muerte de Jax ni lesión de Lira. En la rama de mantenimiento Jax queda inconsciente y Lira sufre daños críticos; no se confirma que después mueran, se recuperen o sean evacuados. Las propuestas no convierten esas incógnitas en curaciones, rescates o muertes.

**Funciones diferentes:** el terminal de `node6c` controla seguridad; la IA contraataca el hackeo en `node5k`; el distractor de `node8r` desvía atención; `node8bj` sí dice expresamente «Colocas trampas». Esa escena pertenece a otra ruta y no puede importarse a `final32`. El contenedor de `node4h` y la interfaz de su continuación también pertenecen a una alternativa no tomada: no son inventario adquirido en las rutas estudiadas. Los 5000 Bitcreds no demuestran una compra de material. Los explosivos de `node2a` no estuvieron en la ruta del dron.

## 3. Rutas completas

### final30 — una ruta, 7 decisiones

`node1 → node2b → node3d → node4g → node5k → node6v → node8q → final30`

| Origen | Decisión | Texto original íntegro | Destino |
|---|---:|---|---|
| node1 | 2 | [HACKEO] Secuestrar un dron de transporte (precisión requerida) | node2b |
| node2b | 2 | [ATAQUE] ¡Lira, atácalo por la espalda! | node3d |
| node3d | 1 | [VELOCIDAD] Correr hacia el ascensor de emergencia | node4g |
| node4g | 1 | [ULTIMO ESFUERZO] Iniciar el hackeo a contrarreloj | node5k |
| node5k | 2 | [RETIRARSE] Decidir detener el hackeo y escapar | node6v |
| node6v | 1 | [EVADIR] Utilizar rutas alternativas para escapar | node8q |
| node8q | 1 | [FINAL EXITOSO] Completar la misión con éxito | final30 |

### final56 — una ruta, 8 decisiones

`node1 → node2a → node3a → node4a → node5b → node6c → node7f → node8ad → final56`

| Origen | Decisión | Texto original íntegro | Destino |
|---|---:|---|---|
| node1 | 1 | [INFILTRACIÓN] Usar los ductos de ventilación (riesgo de láseres termales) | node2a |
| node2a | 1 | [SALVAR JAX] Usar los explosivos (alerta al 80% de guardias) | node3a |
| node3a | 1 | [HÉROE] Quedarte a pelear junto a Lira | node4a |
| node4a | 2 | [RETIRADA] Buscar una ruta de escape segura | node5b |
| node5b | 1 | [UTILIZAR TERMINAL] Hackear el sistema de seguridad para abrir puertas | node6c |
| node6c | 2 | [REINICIAR SISTEMA] Reiniciar el sistema para cubrir tus huellas | node7f |
| node7f | 2 | [ESCAPAR RAPIDAMENTE] Decidir escapar antes de que el sistema se reinicie | node8ad |
| node8ad | 1 | [FINAL EXITOSO] Completar la misión con éxito | final56 |

### final32 — una ruta, 7 decisiones

`node1 → node2b → node3d → node4g → node5k → node6v → node8r → final32`

| Origen | Decisión | Texto original íntegro | Destino |
|---|---:|---|---|
| node1 | 2 | [HACKEO] Secuestrar un dron de transporte (precisión requerida) | node2b |
| node2b | 2 | [ATAQUE] ¡Lira, atácalo por la espalda! | node3d |
| node3d | 1 | [VELOCIDAD] Correr hacia el ascensor de emergencia | node4g |
| node4g | 1 | [ULTIMO ESFUERZO] Iniciar el hackeo a contrarreloj | node5k |
| node5k | 2 | [RETIRARSE] Decidir detener el hackeo y escapar | node6v |
| node6v | 2 | [CREAR DISTRAER] Crear una distracción para facilitar tu fuga | node8r |
| node8r | 1 | [ESCAPAR CON DATOS] Iniciar la fuga con los datos extraídos | final32 |


Los índices de decisión usan base 1. No hay rutas alternativas ocultas hacia estos tres IDs. Se comprobó el grafo de todas las definiciones, no solo los padres inmediatos.

### Conexiones compartidas que delimitan el alcance

- `node6v` (1) lleva a `node8q` y (2) a `node8r`: cambiar el estado de extracción en `node6v` afectaría **ambas** ramas y sus cuatro finales `final30/31/32/33`. No se propone hacerlo.
- `node8q` (2) sigue a `final31`; `node8r` (2) sigue a `final33`. Sus textos terminales no se cambian. La evasión local de `node8q` no impide una persecución posterior; no se presenta como salida ya consumada.
- `node7f` (1) sigue a `node8ac`, que sí narra extracción de toda la información necesaria; (2) sigue a `node8ad`, que narra retirada incompleta. No se retrotrae la extracción de la primera rama a la segunda.
- `final57` recibe actualmente `node8ad` (2) y `node8ak` (2). La segunda conexión tiene dos rutas completas, corregidas en 2E.2. Es un final genérico de abandono y supervivencia, sin condiciones de compañeros, trampas o datos; por ese contexto puede ser el abandono de una nueva tentativa, sin reescribir su texto.
- `node8q`, `node8r` y `node8ad` tienen cada uno un único acceso desde el inicio. `final30/32/56` tienen cada uno un único padre. Las propuestas sobre esos padres no alcanzan otras historias ni el pacto con la IA.

## 4. Textos originales

Se transcriben íntegros los textos y todas las decisiones de los nodos de las tres rutas. Los originales se conservan incluso si una alternativa propone reemplazarlos. Las escenas comunes se citan una vez.

### `node1`

> [Tejado del Edificio Atlas] Relámpagos artificiales iluminan la torre NeuroBank. Jax ajusta su interfaz neural: '¡El sistema de seguridad se reinicia en 27 minutos! ¿Entramos por los ductos o hackeamos un dron de carga?'. Lira afila su katana con un brillo siniestro.

1. `[INFILTRACIÓN] Usar los ductos de ventilación (riesgo de láseres termales)` → `node2a`.
2. `[HACKEO] Secuestrar un dron de transporte (precisión requerida)` → `node2b`.

### `node2a`

> [Ducto de Ventilación] Avanzas reptando entre gases tóxicos. De pronto, una red de láseres bloquea el camino. Jax tose sangre: '¡Mi chip de hackeo puede desactivarlos, pero me dejará ciego!' Lira señala su mochila: 'Tenemos explosivos plásticos...'

1. `[SALVAR JAX] Usar los explosivos (alerta al 80% de guardias)` → `node3a`.
2. `[SACRIFICIO] Dejar que Jax se sobrecargue (él muere, pero pasas en sigilo)` → `node3b`.

### `node2b`

> [Zona de Carga] Logras acoplarte a un dron, pero un guardia cyborg detecta anomalías. Apunta su arma a tu cabeza: '¡Identifícate o disparo!'. Lira susurra: '¿Lo sobornamos o lo eliminamos?' Tienes 5000 Bitcreds en tu cuenta.

1. `[SOBORNO] Ofrecer 3000 Bitcreds por tu vida` → `node3c`.
2. `[ATAQUE] ¡Lira, atácalo por la espalda!` → `node3d`.

### `node3a`

> [¡EXPLOSIÓN!] Los láseres se destruyen, pero 8 guardias te rodean. Jax está inconsciente. Lira grita: '¡Corre al núcleo! Yo los retendré'. Ves su brazo mecánico sobrecalentarse...

1. `[HÉROE] Quedarte a pelear junto a Lira` → `node4a`.
2. `[PRAGMÁTICO] Aprovechar su sacrificio y avanzar` → `node4b`.

### `node3d`

> [COMBATE] Lira decapita al guardia, pero su cabeza mecánica activa una alarma: '¡INTRUSOS EN SECTOR 5!'. Sirenas ensordecen el área...

1. `[VELOCIDAD] Correr hacia el ascensor de emergencia` → `node4g`.
2. `[ASTUCIA] Esconderse en un contenedor de basura` → `node4h`.

### `node4a`

> [COMBATE FINALE] Decides quedarte a pelear junto a Lira. Juntos, enfrentan a los guardias con una combinación letal de hackeo y katana. Aunque logran repeler a los enemigos, Lira sufre daños críticos.

1. `[URGENTE] Continuar hacia el núcleo` → `node5a`.
2. `[RETIRADA] Buscar una ruta de escape segura` → `node5b`.

### `node4g`

> [ASCENSOR DE EMERGENCIA] Corres hacia el ascensor de emergencia, esquivando a los guardias que patrullan frenéticamente. Llegas al núcleo, pero el tiempo se agota.

1. `[ULTIMO ESFUERZO] Iniciar el hackeo a contrarreloj` → `node5k`.
2. `[RETIRADA RÁPIDA] Escapar antes de que el sistema se reinicie` → `node5l`.

### `node5b`

> [RUTA DE ESCAPE] Buscas una ruta de escape segura y encuentras una sala de mantenimiento. Allí, encuentras un terminal de control.

1. `[UTILIZAR TERMINAL] Hackear el sistema de seguridad para abrir puertas` → `node6c`.
2. `[IGNORAR TERMINAL] Continuar sin utilizar el terminal` → `node6d`.

### `node5k`

> [ULTIMO ESFUERZO] Inicias el hackeo a contrarreloj. La IA intensifica sus contraataques.

1. `[PERSISTIR] No rendirse y continuar el hackeo` → `node6u`.
2. `[RETIRARSE] Decidir detener el hackeo y escapar` → `node6v`.

### `node6c`

> [USO DEL TERMINAL] Hackeas el sistema de seguridad, abriendo puertas y desactivando cámaras. Tu camino hacia el núcleo se despeja.

1. `[AVANZAR AL NÚCLEO] Dirigirte directamente al núcleo` → `node7e`.
2. `[REINICIAR SISTEMA] Reiniciar el sistema para cubrir tus huellas` → `node7f`.

### `node6v`

> [ESCAPAR ABANDONANDO HACKEO] Decides detener el hackeo y escapar, dejando atrás la misión incompleta.

1. `[EVADIR] Utilizar rutas alternativas para escapar` → `node8q`.
2. `[CREAR DISTRAER] Crear una distracción para facilitar tu fuga` → `node8r`.

### `node7f`

> [REINICIAR SISTEMA] Reinicias el sistema para cubrir tus huellas, pero esto alerta a más guardias y acelera el reinicio.

1. `[FINALIZAR HACKEO] Intentar finalizar el hackeo antes de que se reinicie` → `node8ac`.
2. `[ESCAPAR RAPIDAMENTE] Decidir escapar antes de que el sistema se reinicie` → `node8ad`.

### `node8q`

> [EVADIR EXITOSAMENTE] Utilizas rutas alternativas para escapar, evitando a las fuerzas de seguridad.

1. `[FINAL EXITOSO] Completar la misión con éxito` → `final30`.
2. `[PERSISTENCIA DEL SISTEMA] Enfrentar a las fuerzas de seguridad durante la fuga` → `final31`.

### `node8r`

> [CREACIÓN DE DISTRACTORES] Creas una distracción efectiva, facilitando tu fuga.

1. `[ESCAPAR CON DATOS] Iniciar la fuga con los datos extraídos` → `final32`.
2. `[OCULTAR HUELLAS Y ESCAPAR] Borrar rastros antes de escapar` → `final33`.

### `node8ad`

> [ESCAPADA EXITOSA] Decides escapar antes de que el sistema se reinicie, dejando atrás la misión incompleta.

1. `[FINAL EXITOSO] Completar la misión con éxito` → `final56`.
2. `[ABANDONAR Y ESCAPAR] Decidir abandonar la misión y escapar` → `final57`.

### `final30`

> **Final: Escape Seguro**
> Completa la misión con éxito, escapando con los datos extraídos sin contratiempos.

Terminal: no tiene decisiones.

### `final32`

> **Final: Escape con Trampas**
> Inicias la fuga con los datos extraídos, aprovechando las trampas colocadas para asegurar una extracción exitosa.

Terminal: no tiene decisiones.

### `final56`

> **Final: Misión Exitosa**
> Completa la misión con éxito, escapando con los datos extraídos y cambiando el destino de la humanidad.

Terminal: no tiene decisiones.

### Contrastes pertinentes fuera de las tres rutas

### `final31`

> **Final: Persecución Intensa**
> Enfrentas a las fuerzas de seguridad que intentan detenerte durante la fuga, resultando en un final dramático.

Terminal: no tiene decisiones.

### `final33`

> **Final: Ocultación Exitosa**
> Logras borrar rastros antes de escapar, asegurando que tu actividad no pueda ser rastreada.

Terminal: no tiene decisiones.

### `final57`

> **Final: Abandono de Misión**
> Decides abandonar la misión y escapar, sobreviviendo pero sin éxito en tu objetivo.

Terminal: no tiene decisiones.

### `node5l`

> [RETIRADA EXITOSA] Escapas justo antes de que el sistema se reinicie. Aunque no logras el hackeo, sobrevives para intentar nuevamente.

Terminal: no tiene decisiones.

### `node8ac`

> [HACKEO COMPLETO] Logras finalizar el hackeo antes de que el sistema se reinicie, extrayendo toda la información necesaria.

1. `[ESCAPAR CON ÉXITO] Iniciar la fuga con los datos extraídos` → `final54`.
2. `[OCULTAR HUELLAS Y ESCAPAR] Borrar rastros antes de escapar` → `final55`.

### `final54`

> **Final: Hackeo a Contrarreloj Exitoso**
> Logras completar el hackeo a contrarreloj, extrayendo toda la información vital antes de que el sistema se reinicie.

Terminal: no tiene decisiones.

### `final55`

> **Final: Extracción Segura y Escape**
> Decides borrar rastros antes de escapar, asegurando una extracción segura y sin ser detectado.

Terminal: no tiene decisiones.

### `node8bj`

> [DEPLOY DE TRAMPAS] Colocas trampas según el nuevo plan, dificultando el avance de los guardias y la IA.

1. `[CONTINUAR HACKEO] Proceder con el hackeo mejorado` → `final160`.
2. `[ESCAPAR EFECTIVAMENTE] Escapar aprovechando las trampas colocadas` → `final161`.

### `node4h`

> [ESCONDERSE] Te escondes en un contenedor de basura. La alerta disminuye momentáneamente, permitiéndote planificar tu próximo movimiento.

1. `[OCULTAR INTERFAZ] Desconectar temporalmente tu interfaz neural` → `node5m`.
2. `[REANUDAR HACKEO] Continuar el hackeo sin desconectar` → `node5n`.

`node8ac` demuestra que puede haber extracción en otra rama, pero no en las tres rutas examinadas. `final54` solo afirma descarga; su texto no resuelve la salida pese a la elección que lo precede. `final55` sí declara escape. No se reutilizan estos finales por sus títulos ni se corrigen en esta fase. `final31` deja abierto qué es un «final dramático» y `final33` garantiza irrasteabilidad sin detallar cómo; son límites de los hermanos, no permisos para inventar una resolución en los tres casos prioritarios.

## 5. Soluciones editoriales propuestas

Los textos de este apartado son **redacciones propuestas**, no citas del canon actual. Los IDs nuevos son nombres de trabajo sin colisiones con el JSON inspeccionado; solo existirían tras autorización. Los destinos no enumerados permanecen iguales. Se conserva el orden de las elecciones existentes.

### E30-A — Retirada lograda, objetivo incompleto (preferida)

**Alcance exacto:** `node8q.text`, `node8q.choices[0].text`, `final30.text`. Ningún destino cambia. La segunda elección hacia `final31` permanece intacta.

**Nuevo texto completo de `node8q`:**

> [EVASIÓN DURANTE LA RETIRADA] Utilizas rutas alternativas para evitar a las fuerzas de seguridad. Has detenido el hackeo y la misión sigue incompleta. Todavía estás dentro del NeuroBank: puedes mantener la retirada o enfrentarte a los guardias que intentan alcanzarte.

**Primera elección completa, hacia `final30`:**

> [CONTINUAR LA RETIRADA] Seguir las rutas alternativas hasta salir del NeuroBank

**Nuevo texto completo de `final30`:**

> **Final: Escape con Misión Incompleta**
>
> Mantienes la retirada por las rutas alternativas y consigues dejar atrás a las fuerzas de seguridad. Sales del NeuroBank con vida, sin volver al núcleo ni reanudar el hackeo que decidiste detener. La extracción quedó inconclusa: escapar no ha completado el objetivo de la misión. Has logrado salir del banco, pero no puedes presentar tu retirada como una extracción exitosa.

**Causalidad:** la evasión ya narrada permite sobrevivir; no proporciona datos. No se afirma descarga parcial ni desaparición de información. El éxito es salir, no completar la misión.

**Ventajas:** respeta dos decisiones previas de retirada, resuelve el final y conserva ambas ramas. **Desventaja:** deja de ser una victoria de misión, y su resultado principal puede equivaler a otras retiradas aunque conserve su variante de evasión.

### E30-B — Volver conscientemente al núcleo y completar la extracción

Alternativa legítima si el autor quiere conservar una victoria en este ID. **No es una extracción ocurrida durante la retirada:** el jugador cambia de plan expresamente antes de salir.

**Cambios exactos:** `node8q.text` igual a E30-A; primera elección y su destino como se indica abajo; agregar `node_reintento_extraccion_tras_evasion`; sustituir `final30.text`. La segunda elección original sigue a `final31`.

**Primera elección de `node8q`:**

> [VOLVER AL NÚCLEO] Interrumpir la retirada para intentar completar la extracción antes del reinicio

Destino propuesto: `node_reintento_extraccion_tras_evasion`, en vez de `final30`.

**Escena nueva completa:**

> [RETOMAR EL HACKEO] Detienes la retirada y vuelves hacia el núcleo por el trayecto que acabas de recorrer. El hackeo anterior quedó interrumpido; la extracción no está terminada. La IA sigue contrarrestando tus intentos y el reinicio se aproxima. Retomas el acceso que estabas intentando abrir, pero tendrás que sostener la intrusión para obtener la información. También puedes cortar de nuevo la conexión y retirarte.

Decisiones completas del nodo nuevo:

1. `[COMPLETAR LA DESCARGA] Mantener el hackeo hasta obtener la información necesaria y después retirarte` → `final30`.
2. `[ABANDONAR EL REINTENTO] Cortar la conexión y salir sin completar el objetivo` → `final57`.

**Nuevo texto completo de `final30`:**

> **Final: Extracción Tras el Último Intento**
>
> Reanudas el hackeo que habías detenido. La IA interrumpe el acceso una y otra vez; ajustas tus comandos y mantienes la conexión hasta alcanzar la información que buscabas. Inicias la descarga y no te retiras hasta comprobar que ha terminado. Solo entonces cortas el acceso y emprendes de nuevo la fuga. Regresas por el trayecto del ascensor de emergencia hacia la zona de carga, evitando a los guardias que la alarma ha movilizado, y consigues salir del NeuroBank con la información. Esta vez has completado la extracción: los datos no aparecieron durante la retirada, los obtuviste al volver al núcleo y afrontar el hackeo pendiente.

**Ventajas:** mantiene un desenlace exitoso con adquisición y salida narradas; añade una elección real entre persistir y abandonar. **Desventajas/dependencias:** requiere una escena y dos decisiones nuevas; la duración disponible tras evadir no se conoce. El autor debe ratificar que todavía existe margen para regresar. No se afirma una nueva ventana de 27 minutos, control total de la IA o un acceso concedido por un pacto. El desenlace exitoso narra el trabajo que logra el resultado; no depende de un sistema de habilidades o azar inexistente.

**Impacto:** `final30` sigue accesible mediante la nueva escena; `final31` no cambia; `final57` gana una referencia contextualmente válida. No se conecta ningún borrador ni se altera `node6v`. Se pierde la falsa ruta de victoria automática y se sustituye por otra, elegida y explicada.

### E56-A — Salida desde mantenimiento sin cumplir el objetivo

**Alcance exacto:** `node8ad.text`, `node8ad.choices[0].text`, `final56.text`. Destinos iguales; segunda elección y `final57` intactos.

**Nuevo texto completo de `node8ad`:**

> [RETIRADA DESDE MANTENIMIENTO] El reinicio que activaste ha alertado a más guardias. El terminal te permitió manipular la seguridad, pero no has completado la extracción de la información del núcleo. Sigues dentro del NeuroBank y buscas salir antes de que el reinicio cierre tu margen de escape. Puedes dejar el terminal y continuar la retirada; la misión quedará incompleta.

**Primera elección completa, hacia `final56`:**

> [DEJAR EL TERMINAL] Continuar la retirada desde la sala de mantenimiento

**Nuevo texto completo de `final56`:**

> **Final: Retirada Tras la Alarma**
>
> Dejas el terminal de mantenimiento y te alejas de los guardias alertados por el reinicio. Recorres el trayecto por el que entraste y alcanzas los ductos, donde los explosivos habían destruido la barrera de láseres. Consigues salir del NeuroBank, pero abrir puertas y desactivar cámaras no había completado la extracción de información. La misión queda incumplida. Tu retirada evita que sigas exponiéndote dentro del banco; no borra los daños críticos que Lira sufrió en el combate.

**Ventajas:** no fabrica acceso a secretos desde un terminal de seguridad; conserva la retirada y el coste del combate. **Desventajas:** ambas opciones de `node8ad` acaban esencialmente en retirada con objetivo incumplido. «Dejar el terminal» y «abandonar» no son decisiones estratégicamente profundas por tener dos IDs finales. Son variantes equivalentes, y deberían considerarse así en la futura colección. Esta opción es una corrección conservadora de coherencia, no una mejora de variedad.

No se afirma rescate de Jax, recuperación de Lira, explosivos sobrantes ni puertas garantizadas abiertas después del reinicio. Se usa el trayecto recorrido y una barrera física ya destruida.

### E56-B — Última tentativa real frente a retirada (preferida si se autoriza una escena)

Mantiene dos decisiones materialmente diferentes. Requiere precisar que el protagonista **todavía no salió** y ofrecer una reversión consciente de la retirada. No se reinterpreta retrospectivamente la elección de `node7f` como extracción.

**Cambios exactos:** reemplazar `node8ad.text`, primera elección y su destino; agregar `node_extraccion_desde_mantenimiento`; reemplazar `final56.text`. Segunda elección hacia `final57` intacta. `node7f` y su primera rama hacia `node8ac` no cambian.

**Nuevo texto completo de `node8ad`:**

> [ÚLTIMA DECISIÓN EN MANTENIMIENTO] Has decidido retirarte, pero todavía estás en la sala de mantenimiento. El terminal abrió el camino hacia el núcleo; no te entregó la información de la misión. El reinicio ha alertado a más guardias y cada demora aumenta el riesgo. Puedes continuar hacia la salida o detener la retirada y volver al camino del núcleo para intentar extraer los datos antes del reinicio.

**Primera elección completa:**

> [INTENTAR LA EXTRACCIÓN] Detener la retirada y dirigirte al núcleo para hackear la información antes del reinicio

Destino propuesto: `node_extraccion_desde_mantenimiento`, en vez de `final56`.

**Escena nueva completa:**

> [ACCESO AL NÚCLEO] Dejas el terminal de mantenimiento y sigues el trayecto hacia el núcleo que localizaste al manipular la seguridad. Los guardias alertados por el reinicio te obligan a avanzar con cuidado. Llegas al núcleo e inicias un hackeo de sus datos: abrir puertas no era suficiente para obtenerlos. La IA contrarresta la intrusión mientras el reinicio se aproxima. Puedes mantener el intento hasta completar la descarga o interrumpirlo y buscar la salida.

Decisiones completas:

1. `[SOSTENER EL HACKEO] Resolver los bloqueos de la IA y mantener la descarga hasta obtener la información necesaria` → `final56`.
2. `[CORTAR Y RETIRARSE] Interrumpir el hackeo y salir sin completar la misión` → `final57`.

**Nuevo texto completo de `final56`:**

> **Final: Extracción y Escape Tras el Último Intento**
>
> Mantienes el hackeo del núcleo mientras la IA intenta cortar tu acceso. Cada interrupción te obliga a ajustar los comandos y reanudar la transferencia; compruebas la descarga hasta obtener la información necesaria antes del reinicio. Después desconectas el acceso y emprendes la retirada. Vuelves por el trayecto de entrada, evitas a los guardias que buscas dejar atrás y alcanzas los ductos donde la barrera de láseres quedó destruida. Logras salir del NeuroBank con los datos. Has cumplido el objetivo de extracción y escape, pero el éxito no deshace los daños que Lira sufrió ni establece qué consecuencias tendrá esa información fuera del banco.

**Ventajas:** el jugador actúa para obtener lo que antes no tenía; finaliza extracción y fuga; mantiene el abandono como alternativa legítima. **Desventajas/dependencias:** escena y decisiones nuevas; el autor debe aprobar el margen temporal y el acceso físico al núcleo pese a los guardias. El terminal no se convierte en una herramienta omnipotente de descarga remota. El hackeo se apoya en la capacidad del protagonista ya narrada en combate y seguridad, no en ayuda consciente de Jax, curación de Lira, un chip nuevo o poderes nuevos.

Se retira la afirmación automática de «cambiar el destino de la humanidad». La propuesta establece información obtenida y salida; su efecto mundial queda sin resolver, en vez de inventar destinatarios, publicación o contenido del secreto. Si el autor quiere preservar una transformación mundial como identidad principal de este final, deberá definir su consecuencia y aprobar otra redacción; esta alternativa no la promete.

**Impacto:** la victoria de `final56` pasa a tener una causa; `final57` conserva las tres rutas actuales de abandono y gana otra desde la nueva tentativa. `final54/55` y la rama `node8ac` siguen accesibles e intactos.

### E32-A — Culminar la fuga utilizando el distractor existente (preferida)

**Alcance exacto:** `node8r.choices[0].text`, `final32.text`. Se conserva literalmente `node8r.text`, la segunda elección hacia `final33` y todos los destinos.

**Primera elección completa, hacia `final32`:**

> [APROVECHAR LA DISTRACCIÓN] Continuar la retirada mientras los guardias tienen la atención desviada

**Nuevo texto completo de `final32`:**

> **Final: Retirada Bajo Distracción**
>
> Aprovechas la distracción que acabas de crear para alejarte de los guardias. Regresas desde el núcleo por el trayecto del ascensor de emergencia hacia la zona de carga y consigues salir del NeuroBank mientras su atención está desviada. No has reanudado el hackeo que decidiste detener: la extracción sigue incompleta y la misión no se ha cumplido. La distracción te permitió escapar; no convirtió la retirada en una obtención de datos.

**Ventajas:** utiliza el único recurso confirmado, narra la salida y respeta el abandono; no convierte un distractor en trampas instaladas. **Desventaja:** renuncia a «Escape con Trampas» como identidad de ese terminal. El mecanismo de la distracción sigue sin especificarse, igual que en el canon: no se añade un dispositivo o una acción retroactiva. Definirlo posteriormente sería otra aprobación, no un requisito para corregir datos y fuga aquí.

La capacidad de escapar se apoya en distraer y volver por un itinerario conocido, no en drones recuperados, contenedores usados como trampas o sigilo mejorado importado de otra rama.

### E32-B — Añadir una decisión final de salida o confrontación

Alternativa independiente para profundizar la retirada sin fabricar una extracción. **No conserva las trampas**: mantenerlas exigiría primero decidir material, instalación y función, datos hoy inexistentes. Tampoco es necesario incluir una escena de preparación solo para justificar el título antiguo.

**Cambios exactos:** primera elección y destino de `node8r`; agregar `node_salida_tras_distraccion`; reemplazar `final32.text`; agregar un terminal `final_captura_tras_distraccion`. Segunda elección original de `node8r` hacia `final33` intacta.

**Primera elección completa de `node8r`:**

> [CONTINUAR LA FUGA] Aprovechar la distracción para volver a la zona de carga

Destino propuesto: `node_salida_tras_distraccion`, en vez de `final32`.

**Escena nueva completa:**

> [SALIDA EN LA ZONA DE CARGA] Te alejas del núcleo y regresas por el trayecto del ascensor de emergencia hasta la zona de carga. La distracción ha apartado a los guardias de tu camino, pero la alarma del sector 5 sigue activa. La extracción quedó inconclusa cuando detuviste el hackeo. Puedes seguir hacia el exterior mientras su atención permanece desviada o detener la retirada y enfrentarte a los guardias que te persiguen.

Decisiones completas:

1. `[SALIR AHORA] Cruzar la zona de carga y abandonar el NeuroBank mientras dura la distracción` → `final32`.
2. `[PLANTAR CARA] Detener la retirada y enfrentarte a los guardias que te persiguen` → `final_captura_tras_distraccion`.

**Nuevo texto completo de `final32`:**

> **Final: Retirada Bajo Distracción**
>
> Cruzas la zona de carga y sales del NeuroBank aprovechando la atención desviada de los guardias. La maniobra termina tu fuga, pero no completa la extracción que abandonaste en el núcleo. Sobrevives y conservas tu libertad; la misión sigue incumplida. No has obtenido una victoria por instalar trampas: has elegido salir mientras la distracción te ofrecía una oportunidad.

**Nuevo terminal completo `final_captura_tras_distraccion` (sin decisiones):**

> **Final: Retirada Interrumpida**
>
> Detienes la fuga para enfrentarte a los guardias. La distracción ya no basta para mantenerlos lejos de ti: al permanecer en la zona de carga les das tiempo para cerrar el paso. La alarma del sector 5 mantiene activa la persecución y terminas reducido y capturado dentro del NeuroBank. No completaste la extracción antes de detener el hackeo y ahora tampoco has conseguido salir. La misión termina en fracaso.

**Ventajas:** añade una decisión concreta con consecuencias materiales —libertad o captura— y cierra ambos resultados. **Desventajas/dependencias:** una escena, un final y dos elecciones nuevos; exige aprobar la confrontación y su captura. No debe añadirse si solo se busca ampliar duración. La elección no dice «combatir y ganar»: no garantiza una victoria que luego se niega. La captura se justifica por detener la evasión frente a una persecución ya establecida, sin inventar una herida mortal o un nuevo equipo enemigo.

El desenlace de captura no está ya establecido en esta ruta: es **canon nuevo propuesto**, no un hecho descubierto en el JSON. Su aprobación debe ser separada. No paga ningún pacto con la IA y no equivale al confinamiento voluntario de `final133`.

## 6. Comparación entre alternativas

### Efecto estructural calculado, no implementado

Las simulaciones se hacen sobre copias en memoria del grafo actual. Cada fila aplica solo esa alternativa. Terminal significa cero decisiones. No se modifica ningún JSON del proyecto ni se fuerzan cifras para conservar accesibilidad.

| Copia simulada | Definiciones / IDs únicos | Accesibles | Terminales accesibles | Borradores | IDs antes accesibles perdidos |
|---|---:|---:|---:|---:|---|
| Base f7cd2da | 354 / 354 | 313 | 153 | 41 | Ninguno |
| E30-A | 354 / 354 | 313 | 153 | 41 | Ninguno |
| E30-B | 355 / 355 | 314 | 153 | 41 | Ninguno |
| E56-A | 354 / 354 | 313 | 153 | 41 | Ninguno |
| E56-B | 355 / 355 | 314 | 153 | 41 | Ninguno |
| E32-A | 354 / 354 | 313 | 153 | 41 | Ninguno |
| E32-B | 356 / 356 | 315 | 154 | 41 | Ninguno |
| Preferida: E30-A + E56-B + E32-A | 355 / 355 | 314 | 153 | 41 | Ninguno |
| Tres A | 354 / 354 | 313 | 153 | 41 | Ninguno |
| Tres B | 358 / 358 | 317 | 154 | 41 | Ninguno |
| Solo redirigir final30 a final57 | 354 / 354 | 312 | 152 | 42 | final30 |
| Solo redirigir final56 a final57 | 354 / 354 | 312 | 152 | 42 | final56 |
| Solo redirigir final32 a final57 | 354 / 354 | 312 | 152 | 42 | final32 |
| Redirigir los tres a final57 | 354 / 354 | 310 | 150 | 44 | final30, final32, final56 |

| Alternativa | Ventaja narrativa principal | Coste / límite | Otros recorridos afectados |
|---|---|---|---|
| E30-A | Respeta el hackeo detenido y separa supervivencia de misión | El antiguo éxito deja de ser tal | El texto de `node8q` también aclara que puede haber persecución hacia `final31`; su decisión y final se conservan |
| E30-B | Éxito causado por retorno y extracción elegidos | Exige margen temporal y una escena nueva | Añade una entrada genérica de abandono a `final57`; no cambia sus rutas antiguas |
| E56-A | Corrige la confusión seguridad/datos sin reconectar | Ambas elecciones quedan como retiradas equivalentes | Escena de `node8ad` también afecta la presentación de su segunda elección; no altera su acción ni destino |
| E56-B | Diferencia tentativa real de abandono | Añade acceso al núcleo y hackeo explícitos, pendientes de aprobación | Nueva referencia a `final57`; preserva la rama separada de `node8ac` |
| E32-A | Usa distracción real y culmina escape sin datos inventados | No explica materialmente el distractor, ni mantiene las trampas | Ninguna otra conexión cambia; `final33` sigue con su límite editorial original |
| E32-B | Profundiza la salida mediante libertad/captura | Confrontación nueva, más contenido y canon nuevo | Añade un terminal; `final33` no se desplaza ni se reutiliza |

Las A cambian escenas/elecciones para conservar la agencia, además de los cuerpos terminales necesarios. Una sustitución aislada del final dejaría etiquetas que siguen prometiendo datos o victoria. Las B no fuerzan a continuar después de haber abandonado: ofrecen una decisión nueva, explícita, antes de una salida físicamente consumada.

### Cambiar un destino sin una escena de reparación

`final57` sí fue verificado en contexto: retirada, supervivencia y objetivo incumplido, sin condiciones específicas incompatibles. Redirigir hacia él la primera elección de cualquiera de los tres padres, con texto de retirada adecuado, sería estructuralmente posible. Sin embargo, **su terminal anterior perdería su único acceso**. Para cada caso aislado serían 354 definiciones, 312 accesibles, 152 terminales accesibles y 42 borradores. Si se redirigieran los tres serían 354, 310, 150 y 44 respectivamente. No se borraría el contenido y las partidas guardadas aún podrían localizar sus IDs, pero la nueva partida no los alcanzaría.

No se recomienda esa consolidación como atajo de corrección: las A conservan escenas terminales con causalidad honesta, y las B permiten mantener victorias mediante acciones reales. Si el autor prefiere consolidar finales equivalentes, deberá aprobar esa pérdida de accesibilidad; no se oculta ni se evita inventando entradas nuevas. E30-B/E56-B describen una forma legítima de conservar sus éxitos. E32-A/B conservan un escape legítimo; conservar además su antigua extracción/trampas requeriría otra propuesta con adquisición y preparación explícitas, hoy no aprobadas.

Tampoco se recomienda redirigir `node8ad` directamente a `node8ac`: saltaría la llegada al núcleo y convertiría la voluntad de volver en una extracción ya terminada. Reasignar a `final30/56` una elección exitosa de otra rama desplazaría finales como `final54/55` sin necesidad. No se hacen conexiones por numeración o títulos semejantes.

## 7. Efecto en los finales coleccionables

Este apartado describe una revisión futura; **no modifica el registro vigente ni aprueba membresías**.

| Terminal / alternativa | Asignación documental 2D.2 actual | Identidad principal propuesta después | Variantes y reservas |
|---|---|---|---|
| `final30`, A | `extraccion_y_escape` | Candidato a `retirada_objetivo_incumplido` | Evasión por rutas alternativas es modo de retirada; no un final adicional por sí solo |
| `final30`, B | `extraccion_y_escape` | Candidato a conservar `extraccion_y_escape` | Retorno y reintento de hackeo son variantes, con evidencia en el nodo nuevo; no hay cambio mundial confirmado |
| `final56`, A | `exito_transformacion_humana` | Candidato a `retirada_objetivo_incumplido` | `jax_inconsciente` y `lira_herida_critica` proceden del recorrido, no cambian automáticamente el contador |
| `final56`, B | `exito_transformacion_humana` | Candidato a `extraccion_y_escape` | Extracción/escape quedan establecidos; transformación humana deja de estar afirmada. Preservar ese efecto exige decisión adicional del autor |
| `final32`, A o B | `fuga_iniciada_con_trampas_pendiente` | Candidato a `retirada_objetivo_incumplido` | Fuga consumada y distractor confirmado. Eliminar `trampas_en_recorrido` para esta ruta en una revisión posterior; no retirarlo de las rutas que sí colocan trampas |
| Nuevo final de E32-B | No existe | Candidato a `confinamiento_mision_fallida` | Captura forzosa por confrontación, sin extracción completada. No agrupar automáticamente con pago voluntario de libertad del pacto |

No se dan nuevas cantidades globales de finales semánticos: el registro contiene pendientes y estas membresías no están aprobadas. Dos terminales de retirada no serían dos finales coleccionables por su método, y más nodos accesibles no demuestran más resultados distintos. Los grupos `extraccion_y_escape` y `exito_transformacion_humana` conservarían otros integrantes: aquí no se eliminan grupos completos.

La evidencia actual de `trampas_en_recorrido` incluye el propio `final32`; es una afirmación terminal no sustentada por preparación en su ruta. No debe utilizarse para legitimar ese recurso en la redacción. La futura detección de la distracción sí puede basarse en `node8r` dentro del historial activo. Ninguna variante de las rutas nuevas se asignaría a recorridos antiguos solo por compartir el terminal.

## 8. Cambios técnicos que serían necesarios posteriormente

1. Obtener aprobación por caso y alternativa, incluyendo cada escena, elección, destino y terminal escrito aquí. Las alternativas no se combinan automáticamente.
2. Partir de `f7cd2da` o verificar diferencias posteriores; aplicar un nuevo manifiesto de cambios autorizado, sin modificar los dos manifiestos de 2E.2. Mantener el canon del pacto y los cuatro finales recuperados en 2B.
3. Si se aprueban B, incorporar únicamente sus definiciones nuevas, sin renombrar ni suprimir IDs actuales. Comprobar los IDs de trabajo contra el estado real al implementar. No incorporar borradores ni A3/A4/A7/C1.
4. Editar solo la fuente canónica y regenerar con `py -3 tools/split_stories.py`; verificar igualdad de índice/derivados, ausencia de destinos inexistentes y ciclos, y conjunto exacto de nodos/finales previamente accesibles.
5. Mantener las pruebas históricas y la fixture congelada; aceptar solo campos aprobados mediante el nuevo manifiesto. Añadir recorridos completos de las tres rutas y de cada decisión nueva, estado de misión, información, recursos y salida. Comprobar las ramas hermanas y las tres rutas originales de `final57`.
6. Verificar explícitamente que E1–E4, el texto OBTENER LOS DATOS, el cumplimiento parcial y B1–B4 permanecen idénticos. Ejecutar analyze/tests/build y pruebas Android de los cambios implementados cuando se autoricen; las simulaciones de este informe no sustituyen esas comprobaciones.
7. Revisar por separado la clasificación semántica y las evidencias de variantes después de aprobar los textos; no implementar colección ni modificar almacenamiento en esta reparación.

### Partidas e historial

`ProgressStore` guarda `currentNodeId`, `previousNodeIds`, `completed` y fecha bajo `mythos.progress.v1`, no versiones de texto ni índices de decisiones. Las A conservarían los IDs y todos los destinos: un guardado en `final30/56/32` mostraría el nuevo texto y conservaría su historial. Ese cambio puede convertir una victoria antigua en retirada; requiere aprobación expresa de su efecto editorial, no un borrado o migración automática.

En las B, un guardado terminal antiguo conservaría su ID e historial sin el nodo nuevo. **No sería prueba de haber realizado la nueva extracción o confrontación.** No se añadirían pasos ficticios al historial, ni se reinterpretaría una decisión antigua de «final exitoso» como un retorno posterior al núcleo. Retroceder respetaría el historial almacenado; volver a elegir en el padre sí tomaría el destino nuevo aprobado. Un guardado en el padre seguiría allí y vería las acciones nuevas antes de elegirlas.

Si el autor desea versiones históricas exactas para los terminales, eso exige una aprobación técnica separada: el motor actual muestra un solo texto por ID. No se propone modificar persistencia en esta fase. El permiso de 2E.2 para sus reescrituras no se utiliza como aprobación automática de estos nuevos cambios materiales.

## 9. Matriz de riesgos y dependencias

| Riesgo / dependencia | Casos | Evaluación y mitigación propuesta |
|---|---|---|
| Interpretar intento de hackeo como datos parciales | 30/32 | Alto para coherencia. No cuantificar datos ni fabricar descarga; reconocer extracción incompleta |
| Confundir terminal de seguridad y secretos del núcleo | 56 | Alto. B requiere desplazamiento y hackeo de datos independientes; A solo permite retirada |
| Declarar que la fuga ya terminó por un rótulo | 30/56 | Medio. A/B aclaran lugar y fase en los padres; no hacen volver desde el exterior sin narrarlo |
| Tiempo suficiente para una segunda tentativa | 30-B/56-B | Pendiente del autor. No inventar segundos restantes ni resetear el plazo inicial. Si no hay margen, elegir A |
| Introducir trampas o equipo desde otras rutas | 32 | Alto. Ambas alternativas usan distractor confirmado; B no ofrece trampas sin materiales y preparación aprobados |
| Curación/rescate o muerte de compañeros no narrados | 56 | Alto. Mantener daños e inconsciencia como antecedentes, no resolver sus destinos por conveniencia |
| Dos opciones cosméticas de retirada | 56-A | Confirmado como limitación de la propuesta. Agrupar variantes; B ofrece tentativa/abandono materialmente diferentes |
| Captura nueva por detener la evasión | 32-B | Nueva consecuencia, no canon actual. Requiere aprobación separada; no volverla muerte ni pago voluntario de pacto |
| Modificar la identidad de antiguos finales | A de los tres / 56-B | Cambio material de clasificación futura. No actualizar registro ni descubrimientos retroactivamente sin aprobación |
| Inventar historia previa en guardados antiguos | Todas, especialmente B | Conservar IDs/historial; no insertar nodos nuevos en partidas antiguas. Informar cambio de texto |
| Redirección directa a `final57` | Los tres | Deja terminales originales inaccesibles. Solo realizar si el autor acepta; no borrar contenido |
| Resolver hermanos inconclusos por arrastre | 31/33/54 | Fuera del alcance. Documentados únicamente por sus conexiones; no reescribir ni reutilizar sus finales ambiguos |
| Recuperación de borradores o alteración de E2/2B | Todas | No necesaria ni propuesta. Verificar igualdad completa de los campos protegidos |

## 10. Recomendación final para aprobación del autor

**Propuesta preferida: E30-A + E56-B + E32-A**, si el autor autoriza una última tentativa jugable en la ruta de mantenimiento. Da dos retiradas honestas donde ya se abandonó el hackeo y una elección real de extracción/abandono donde todavía se puede precisar el regreso al núcleo. No se pide preservar tres victorias por su número: solo la tentativa de E56-B añade una causa nueva, escrita y elegida para una victoria.

Si el margen temporal o la ampliación no se aprueban, usar **E30-A + E56-A + E32-A**. Es la solución de menor alcance y reconoce las tres misiones incumplidas. Debe aceptarse que E56-A no añade profundidad decisional. E30-B queda disponible si se quiere invertir en la recuperación de esa victoria; E32-B solo conviene si la confrontación mejora realmente el cierre, no para sumar nodos o duración.

Decisiones de aprobación, independientes:

1. **E30:** aprobar A (retirada) o B (reintento con una escena y sus dos elecciones). En B, ratificar que no se había salido físicamente y queda margen de regreso. Si no se aprueba ninguna, no cambiar el final.
2. **E56:** aprobar B con retorno al núcleo, adquisición de datos y abandono todavía disponible, o A con objetivo incumplido. En B, ratificar posibilidad de llegar al núcleo antes del reinicio y aceptar que no se afirma transformación mundial. Conservarla exigiría definir una consecuencia posterior, no una frase automática.
3. **E32:** aprobar A con distractor y retirada terminada, o B con escena y captura nueva. No se propone retener datos extraídos ni trampas sin sus acciones de adquisición/preparación. El mecanismo específico del distractor puede continuar no definido; si se quiere detallarlo, deberá aprobarse otro texto.
4. **Compatibilidad editorial:** aprobar expresamente que los guardados en estos IDs muestren los textos corregidos sin borrar ni alterar su historial. Ningún guardado antiguo acredita las acciones nuevas de B.
5. **Clasificación:** las identidades y variantes sugeridas necesitan una revisión aprobada posterior. No se aprueban aquí cambios de contadores, mapeos persistentes o registro vigente.

**No se implementó ninguna alternativa. Se espera autorización expresa del autor.**

### Validación de esta entrega documental

Se verificaron exactamente una ruta a cada terminal, una referencia entrante a cada uno, IDs de trabajo sin colisiones, unicidad y destinos válidos de todas las copias simuladas, ausencia de ciclos mediante DFS y alcance desde node1. Ninguna de las alternativas A/B hace inaccesible un ID antes accesible ni recupera un borrador; solo las redirecciones comparativas documentadas pierden los terminales indicados. Estos resultados son cálculos estructurales de propuesta, no pruebas del motor ni validación de textos implementados.

SHA-256 de la fuente inspeccionada: `8a6b0fb36ce96883a0a1a08225ea5ce65df68d76fd70f6cd10968ad757ebb4c7`.

Se comprobaron hashes de los 109 archivos rastreados: sin cambios. Solo se añade este informe. No se ejecutaron flutter analyze/test/build ni pruebas Android porque no se implementó contenido ni código; los resultados citados de 74 pruebas y seis rutas pertenecen al cierre 2E.2. No se creó commit ni se ejecutó push.
