# Auditoría narrativa de Mythos

Fecha: 2026-10-11. Estado local actual; solo documentación, sin implementar correcciones. Se conservan las modificaciones previas sin commit.

## Método

Inspeccionados modelos, repositorio, lector, persistencia, JSON original, índice, cuatro JSON individuales y pruebas. Cada definición es un vértice independiente `ID @ nodes[i]`, con índice desde cero. El inicio es `nodes[0]`. BFS recorre el grafo efectivo (primera definición por ID, como el motor) y un grafo hipotético de posibilidades (todas las variantes por ID). Este segundo grafo delimita incertidumbre: no autoriza conexiones. DFS con pila activa detecta ciclos en todas las componentes, incluso aisladas; las rutas testigo no enumeran todos los caminos. Final significa ausencia de decisiones, no prefijo de ID. Convergencias y finales compartidos son válidos; reutilizar IDs entre historias es válido.

## Resultado individual

| Historia | Definiciones / IDs únicos | Finales / alcanzables | Inaccesibles efectivos / posibles | Duplicados | Destinos inexistentes | Ciclos efectivos / posibles |
|---|---:|---:|---:|---:|---:|---:|

| El Laberinto de la Medianoche (`laberinto_medianoche`) | 69 / 69 | 8 / 8 | 0 / 0 | 0 | 0 | 0 / 0 |

| La Odisea del Destino (`odisea_destino`) | 157 / 157 | 6 / 6 | 0 / 0 | 0 | 0 | 0 / 0 |

| El Secreto del Androide (`android_secret`) | 12 / 12 | 3 / 3 | 0 / 0 | 0 | 0 | 0 / 0 |

| El Asalto Neon (`cyberpunk_heist`) | 354 / 342 | 179 / 149 | 45 / 17 | 12 | 0 | 0 / 0 |

592 definiciones totales. Los 12 IDs duplicados están únicamente en El Asalto Neon, con dos definiciones cada uno. Los cuatro archivos individuales coinciden semánticamente con el original y su índice: también reproducen los defectos. No hay IDs de historia duplicados ni referencias inexistentes.

### El Laberinto de la Medianoche

Inicio: `node1 @ nodes[0]`. Sin errores estructurales detectados de unicidad, referencias ni accesibilidad.

**Nodos no finales inaccesibles (0):** ninguno.

**Finales inaccesibles (0):** ninguno.

**Inaccesibles aun considerando todas las variantes (0):** ninguno.

**Ciclos del grafo efectivo:** ninguno en ninguna componente.

**Ciclos del grafo hipotético:** ninguno en ninguna componente.

**Alcanzables sin camino hacia algún final:** ninguno.

### La Odisea del Destino

Inicio: `node1 @ nodes[0]`. Sin errores estructurales detectados de unicidad, referencias ni accesibilidad.

**Nodos no finales inaccesibles (0):** ninguno.

**Finales inaccesibles (0):** ninguno.

**Inaccesibles aun considerando todas las variantes (0):** ninguno.

**Ciclos del grafo efectivo:** ninguno en ninguna componente.

**Ciclos del grafo hipotético:** ninguno en ninguna componente.

**Alcanzables sin camino hacia algún final:** ninguno.

### El Secreto del Androide

Inicio: `n1 @ nodes[0]`. Sin errores estructurales detectados de unicidad, referencias ni accesibilidad.

**Nodos no finales inaccesibles (0):** ninguno.

**Finales inaccesibles (0):** ninguno.

**Inaccesibles aun considerando todas las variantes (0):** ninguno.

**Ciclos del grafo efectivo:** ninguno en ninguna componente.

**Ciclos del grafo hipotético:** ninguno en ninguna componente.

**Alcanzables sin camino hacia algún final:** ninguno.

### El Asalto Neon

Inicio: `node1 @ nodes[0]`. Colisiones e inaccesibilidad confirmadas; las conexiones correctas requieren decisión editorial.

**Nodos no finales inaccesibles (15):** `node7ae @ nodes[85]`, `node7af @ nodes[86]`, `node8bg @ nodes[153]`, `node8bh @ nodes[154]`, `node8bi @ nodes[155]`, `node8bj @ nodes[156]`, `node8bk @ nodes[157]`, `node8bl @ nodes[158]`, `node8bm @ nodes[159]`, `node8bn @ nodes[160]`, `node8bu @ nodes[167]`, `node8bv @ nodes[168]`, `node8bw @ nodes[169]`, `node8bx @ nodes[170]`, `node8by @ nodes[171]`.

**Finales inaccesibles (30):** `final86 @ nodes[265]`, `final87 @ nodes[266]`, `final88 @ nodes[267]`, `final89 @ nodes[268]`, `final90 @ nodes[269]`, `final91 @ nodes[270]`, `final92 @ nodes[271]`, `final93 @ nodes[272]`, `final94 @ nodes[273]`, `final95 @ nodes[274]`, `final96 @ nodes[275]`, `final97 @ nodes[276]`, `final98 @ nodes[277]`, `final99 @ nodes[278]`, `final100 @ nodes[279]`, `final101 @ nodes[280]`, `final114 @ nodes[293]`, `final115 @ nodes[294]`, `final116 @ nodes[295]`, `final117 @ nodes[296]`, `final118 @ nodes[297]`, `final119 @ nodes[298]`, `final120 @ nodes[299]`, `final121 @ nodes[300]`, `final122 @ nodes[301]`, `final123 @ nodes[302]`, `final134 @ nodes[318]`, `final135 @ nodes[319]`, `final136 @ nodes[320]`, `final137 @ nodes[321]`.

**Inaccesibles aun considerando todas las variantes (17):** `node7ae @ nodes[85]`, `node7af @ nodes[86]`, `node8bu @ nodes[167]`, `node8bv @ nodes[168]`, `node8bw @ nodes[169]`, `node8bx @ nodes[170]`, `node8by @ nodes[171]`, `final114 @ nodes[293]`, `final115 @ nodes[294]`, `final116 @ nodes[295]`, `final117 @ nodes[296]`, `final118 @ nodes[297]`, `final119 @ nodes[298]`, `final120 @ nodes[299]`, `final121 @ nodes[300]`, `final122 @ nodes[301]`, `final123 @ nodes[302]`.

**Ciclos del grafo efectivo:** ninguno en ninguna componente.

**Ciclos del grafo hipotético:** ninguno en ninguna componente.

**Alcanzables sin camino hacia algún final:** ninguno.

## Tabla de IDs duplicados y todas sus referencias entrantes

Decisiones numeradas desde 1; definiciones desde 0.

| ID | Definiciones | Entradas | Renombre candidato de segunda definición |
|---|---|---|---|

| `node8bg` | `nodes[145]`, `nodes[153]` | `node7w @ nodes[77]`, decisión 1 | `node8bg__v2` |

| `node8bh` | `nodes[146]`, `nodes[154]` | `node7w @ nodes[77]`, decisión 2 | `node8bh__v2` |

| `node8bi` | `nodes[147]`, `nodes[155]` | `node7x @ nodes[78]`, decisión 1 | `node8bi__v2` |

| `node8bj` | `nodes[148]`, `nodes[156]` | `node7x @ nodes[78]`, decisión 2 | `node8bj__v2` |

| `node8bk` | `nodes[149]`, `nodes[157]` | `node7y @ nodes[79]`, decisión 1 | `node8bk__v2` |

| `node8bl` | `nodes[150]`, `nodes[158]` | `node7y @ nodes[79]`, decisión 2 | `node8bl__v2` |

| `node8bm` | `nodes[151]`, `nodes[159]` | `node7z @ nodes[80]`, decisión 1 | `node8bm__v2` |

| `node8bn` | `nodes[152]`, `nodes[160]` | `node7z @ nodes[80]`, decisión 2 | `node8bn__v2` |

| `final134` | `nodes[313]`, `nodes[318]` | `node8au @ nodes[133]`, decisión 1; `node9f @ nodes[177]`, decisión 1 | `final134__v2` |

| `final135` | `nodes[314]`, `nodes[319]` | `node8au @ nodes[133]`, decisión 2; `node9f @ nodes[177]`, decisión 2 | `final135__v2` |

| `final136` | `nodes[315]`, `nodes[320]` | `node8av @ nodes[134]`, decisión 1; `node9h @ nodes[179]`, decisión 1 | `final136__v2` |

| `final137` | `nodes[316]`, `nodes[321]` | `node8ax @ nodes[136]`, decisión 1; `node9h @ nodes[179]`, decisión 2 | `final137__v2` |

## Expedientes: definiciones, decisiones y caminos afectados

### `node8bg`

**Definición 1, `nodes[145]`:** alcanzable actualmente.

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

Finales descendientes al entrar en esta variante, resolviendo sus destinos como el motor: `final154 @ nodes[338]`, `final155 @ nodes[339]`.

**Definición 2, `nodes[153]`:** inaccesible actualmente.

```json
{
  "id": "node8bg",
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

Finales descendientes al entrar en esta variante, resolviendo sus destinos como el motor: `final86 @ nodes[265]`, `final87 @ nodes[266]`.

**Entrada:** `node7w @ nodes[77]`, decisión 1: `{"text": "[PLANIFICAR HACKEO] Crear un plan detallado basado en la información", "nextNodeId": "node8bg"}`.

Texto del origen: [REVISAR DATOS] Revisas y organizas la información recopilada, identificando vulnerabilidades clave en el sistema.

Ruta efectiva testigo: node1 @ nodes[0] → node2a @ nodes[1] → node3b @ nodes[4] → node4d @ nodes[10] → node5h @ nodes[22] → node6p @ nodes[44] → node7w @ nodes[77] → `node8bg` (definición 1). Ruta hipotética al origen: node1 @ nodes[0] → node2a @ nodes[1] → node3b @ nodes[4] → node4d @ nodes[10] → node5h @ nodes[22] → node6p @ nodes[44] → node7w @ nodes[77]. Todos los recorridos que alcancen este origen y elijan esta decisión resultan afectados, incluidas rutas convergentes.

**Propuesta:** conservar íntegros ambos textos y decisiones. Mantener provisionalmente `node8bg` para la primera definición y renombrar la segunda a `node8bg__v2`, sin colisión actual. Ninguna entrada se reasigna automáticamente: el autor debe indicar la variante de destino de cada decisión. El renombre por sí solo no hace jugable la segunda variante.

**Decisión del autor:** existe una única entrada para las dos variantes. ¿Cuál corresponde a esa decisión y cómo se conserva/disponibiliza la otra? No inventar una decisión adicional ni elegir por numeración de finales.

### `node8bh`

**Definición 1, `nodes[146]`:** alcanzable actualmente.

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

Finales descendientes al entrar en esta variante, resolviendo sus destinos como el motor: `final156 @ nodes[340]`, `final157 @ nodes[341]`.

**Definición 2, `nodes[154]`:** inaccesible actualmente.

```json
{
  "id": "node8bh",
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

Finales descendientes al entrar en esta variante, resolviendo sus destinos como el motor: `final88 @ nodes[267]`, `final89 @ nodes[268]`.

**Entrada:** `node7w @ nodes[77]`, decisión 2: `{"text": "[COMPARTIR INFORMACIÓN] Compartir la información con tu equipo", "nextNodeId": "node8bh"}`.

Texto del origen: [REVISAR DATOS] Revisas y organizas la información recopilada, identificando vulnerabilidades clave en el sistema.

Ruta efectiva testigo: node1 @ nodes[0] → node2a @ nodes[1] → node3b @ nodes[4] → node4d @ nodes[10] → node5h @ nodes[22] → node6p @ nodes[44] → node7w @ nodes[77] → `node8bh` (definición 1). Ruta hipotética al origen: node1 @ nodes[0] → node2a @ nodes[1] → node3b @ nodes[4] → node4d @ nodes[10] → node5h @ nodes[22] → node6p @ nodes[44] → node7w @ nodes[77]. Todos los recorridos que alcancen este origen y elijan esta decisión resultan afectados, incluidas rutas convergentes.

**Propuesta:** conservar íntegros ambos textos y decisiones. Mantener provisionalmente `node8bh` para la primera definición y renombrar la segunda a `node8bh__v2`, sin colisión actual. Ninguna entrada se reasigna automáticamente: el autor debe indicar la variante de destino de cada decisión. El renombre por sí solo no hace jugable la segunda variante.

**Decisión del autor:** existe una única entrada para las dos variantes. ¿Cuál corresponde a esa decisión y cómo se conserva/disponibiliza la otra? No inventar una decisión adicional ni elegir por numeración de finales.

### `node8bi`

**Definición 1, `nodes[147]`:** alcanzable actualmente.

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

Finales descendientes al entrar en esta variante, resolviendo sus destinos como el motor: `final158 @ nodes[342]`, `final159 @ nodes[343]`.

**Definición 2, `nodes[155]`:** inaccesible actualmente.

```json
{
  "id": "node8bi",
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

Finales descendientes al entrar en esta variante, resolviendo sus destinos como el motor: `final90 @ nodes[269]`, `final91 @ nodes[270]`.

**Entrada:** `node7x @ nodes[78]`, decisión 1: `{"text": "[INICIAR HACKEO] Comenzar el hackeo con el plan mejorado", "nextNodeId": "node8bi"}`.

Texto del origen: [EXECUTAR PLAN] Implementas un nuevo plan basado en la información, ajustando tus tácticas para maximizar el éxito.

Ruta efectiva testigo: node1 @ nodes[0] → node2a @ nodes[1] → node3b @ nodes[4] → node4d @ nodes[10] → node5h @ nodes[22] → node6p @ nodes[44] → node7x @ nodes[78] → `node8bi` (definición 1). Ruta hipotética al origen: node1 @ nodes[0] → node2a @ nodes[1] → node3b @ nodes[4] → node4d @ nodes[10] → node5h @ nodes[22] → node6p @ nodes[44] → node7x @ nodes[78]. Todos los recorridos que alcancen este origen y elijan esta decisión resultan afectados, incluidas rutas convergentes.

**Propuesta:** conservar íntegros ambos textos y decisiones. Mantener provisionalmente `node8bi` para la primera definición y renombrar la segunda a `node8bi__v2`, sin colisión actual. Ninguna entrada se reasigna automáticamente: el autor debe indicar la variante de destino de cada decisión. El renombre por sí solo no hace jugable la segunda variante.

**Decisión del autor:** existe una única entrada para las dos variantes. ¿Cuál corresponde a esa decisión y cómo se conserva/disponibiliza la otra? No inventar una decisión adicional ni elegir por numeración de finales.

### `node8bj`

**Definición 1, `nodes[148]`:** alcanzable actualmente.

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

Finales descendientes al entrar en esta variante, resolviendo sus destinos como el motor: `final160 @ nodes[344]`, `final161 @ nodes[345]`.

**Definición 2, `nodes[156]`:** inaccesible actualmente.

```json
{
  "id": "node8bj",
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

Finales descendientes al entrar en esta variante, resolviendo sus destinos como el motor: `final92 @ nodes[271]`, `final93 @ nodes[272]`.

**Entrada:** `node7x @ nodes[78]`, decisión 2: `{"text": "[DEPLOY TRAMPAS] Colocar trampas según el nuevo plan", "nextNodeId": "node8bj"}`.

Texto del origen: [EXECUTAR PLAN] Implementas un nuevo plan basado en la información, ajustando tus tácticas para maximizar el éxito.

Ruta efectiva testigo: node1 @ nodes[0] → node2a @ nodes[1] → node3b @ nodes[4] → node4d @ nodes[10] → node5h @ nodes[22] → node6p @ nodes[44] → node7x @ nodes[78] → `node8bj` (definición 1). Ruta hipotética al origen: node1 @ nodes[0] → node2a @ nodes[1] → node3b @ nodes[4] → node4d @ nodes[10] → node5h @ nodes[22] → node6p @ nodes[44] → node7x @ nodes[78]. Todos los recorridos que alcancen este origen y elijan esta decisión resultan afectados, incluidas rutas convergentes.

**Propuesta:** conservar íntegros ambos textos y decisiones. Mantener provisionalmente `node8bj` para la primera definición y renombrar la segunda a `node8bj__v2`, sin colisión actual. Ninguna entrada se reasigna automáticamente: el autor debe indicar la variante de destino de cada decisión. El renombre por sí solo no hace jugable la segunda variante.

**Decisión del autor:** existe una única entrada para las dos variantes. ¿Cuál corresponde a esa decisión y cómo se conserva/disponibiliza la otra? No inventar una decisión adicional ni elegir por numeración de finales.

### `node8bk`

**Definición 1, `nodes[149]`:** alcanzable actualmente.

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

Finales descendientes al entrar en esta variante, resolviendo sus destinos como el motor: `final162 @ nodes[346]`, `final163 @ nodes[347]`.

**Definición 2, `nodes[157]`:** inaccesible actualmente.

```json
{
  "id": "node8bk",
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

Finales descendientes al entrar en esta variante, resolviendo sus destinos como el motor: `final94 @ nodes[273]`, `final95 @ nodes[274]`.

**Entrada:** `node7y @ nodes[79]`, decisión 1: `{"text": "[INICIAR HACKEO] Comenzar el hackeo desde el punto localizado", "nextNodeId": "node8bk"}`.

Texto del origen: [LOCALIZACIÓN DEL PUNTO] Localizas el punto óptimo para iniciar el hackeo, minimizando la detección.

Ruta efectiva testigo: node1 @ nodes[0] → node2b @ nodes[2] → node3c @ nodes[5] → node4f @ nodes[12] → node5j @ nodes[24] → node6s @ nodes[47] → node7y @ nodes[79] → `node8bk` (definición 1). Ruta hipotética al origen: node1 @ nodes[0] → node2b @ nodes[2] → node3c @ nodes[5] → node4f @ nodes[12] → node5j @ nodes[24] → node6s @ nodes[47] → node7y @ nodes[79]. Todos los recorridos que alcancen este origen y elijan esta decisión resultan afectados, incluidas rutas convergentes.

**Propuesta:** conservar íntegros ambos textos y decisiones. Mantener provisionalmente `node8bk` para la primera definición y renombrar la segunda a `node8bk__v2`, sin colisión actual. Ninguna entrada se reasigna automáticamente: el autor debe indicar la variante de destino de cada decisión. El renombre por sí solo no hace jugable la segunda variante.

**Decisión del autor:** existe una única entrada para las dos variantes. ¿Cuál corresponde a esa decisión y cómo se conserva/disponibiliza la otra? No inventar una decisión adicional ni elegir por numeración de finales.

### `node8bl`

**Definición 1, `nodes[150]`:** alcanzable actualmente.

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

Finales descendientes al entrar en esta variante, resolviendo sus destinos como el motor: `final164 @ nodes[348]`, `final165 @ nodes[349]`.

**Definición 2, `nodes[158]`:** inaccesible actualmente.

```json
{
  "id": "node8bl",
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

Finales descendientes al entrar en esta variante, resolviendo sus destinos como el motor: `final96 @ nodes[275]`, `final97 @ nodes[276]`.

**Entrada:** `node7y @ nodes[79]`, decisión 2: `{"text": "[PROTEGER PUNTO] Establecer protecciones adicionales antes de hackear", "nextNodeId": "node8bl"}`.

Texto del origen: [LOCALIZACIÓN DEL PUNTO] Localizas el punto óptimo para iniciar el hackeo, minimizando la detección.

Ruta efectiva testigo: node1 @ nodes[0] → node2b @ nodes[2] → node3c @ nodes[5] → node4f @ nodes[12] → node5j @ nodes[24] → node6s @ nodes[47] → node7y @ nodes[79] → `node8bl` (definición 1). Ruta hipotética al origen: node1 @ nodes[0] → node2b @ nodes[2] → node3c @ nodes[5] → node4f @ nodes[12] → node5j @ nodes[24] → node6s @ nodes[47] → node7y @ nodes[79]. Todos los recorridos que alcancen este origen y elijan esta decisión resultan afectados, incluidas rutas convergentes.

**Propuesta:** conservar íntegros ambos textos y decisiones. Mantener provisionalmente `node8bl` para la primera definición y renombrar la segunda a `node8bl__v2`, sin colisión actual. Ninguna entrada se reasigna automáticamente: el autor debe indicar la variante de destino de cada decisión. El renombre por sí solo no hace jugable la segunda variante.

**Decisión del autor:** existe una única entrada para las dos variantes. ¿Cuál corresponde a esa decisión y cómo se conserva/disponibiliza la otra? No inventar una decisión adicional ni elegir por numeración de finales.

### `node8bm`

**Definición 1, `nodes[151]`:** alcanzable actualmente.

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

Finales descendientes al entrar en esta variante, resolviendo sus destinos como el motor: `final166 @ nodes[350]`, `final167 @ nodes[351]`.

**Definición 2, `nodes[159]`:** inaccesible actualmente.

```json
{
  "id": "node8bm",
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

Finales descendientes al entrar en esta variante, resolviendo sus destinos como el motor: `final98 @ nodes[277]`, `final99 @ nodes[278]`.

**Entrada:** `node7z @ nodes[80]`, decisión 1: `{"text": "[CONTINUAR HACKEO] Avanzar con el hackeo ahora que los sistemas están saboteados", "nextNodeId": "node8bm"}`.

Texto del origen: [SABOTEAR SISTEMAS] Deshabilitas sistemas clave que podrían alertar a la IA o llamar refuerzos.

Ruta efectiva testigo: node1 @ nodes[0] → node2b @ nodes[2] → node3c @ nodes[5] → node4f @ nodes[12] → node5j @ nodes[24] → node6s @ nodes[47] → node7z @ nodes[80] → `node8bm` (definición 1). Ruta hipotética al origen: node1 @ nodes[0] → node2b @ nodes[2] → node3c @ nodes[5] → node4f @ nodes[12] → node5j @ nodes[24] → node6s @ nodes[47] → node7z @ nodes[80]. Todos los recorridos que alcancen este origen y elijan esta decisión resultan afectados, incluidas rutas convergentes.

**Propuesta:** conservar íntegros ambos textos y decisiones. Mantener provisionalmente `node8bm` para la primera definición y renombrar la segunda a `node8bm__v2`, sin colisión actual. Ninguna entrada se reasigna automáticamente: el autor debe indicar la variante de destino de cada decisión. El renombre por sí solo no hace jugable la segunda variante.

**Decisión del autor:** existe una única entrada para las dos variantes. ¿Cuál corresponde a esa decisión y cómo se conserva/disponibiliza la otra? No inventar una decisión adicional ni elegir por numeración de finales.

### `node8bn`

**Definición 1, `nodes[152]`:** alcanzable actualmente.

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

Finales descendientes al entrar en esta variante, resolviendo sus destinos como el motor: `final168 @ nodes[352]`, `final169 @ nodes[353]`.

**Definición 2, `nodes[160]`:** inaccesible actualmente.

```json
{
  "id": "node8bn",
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

Finales descendientes al entrar en esta variante, resolviendo sus destinos como el motor: `final100 @ nodes[279]`, `final101 @ nodes[280]`.

**Entrada:** `node7z @ nodes[80]`, decisión 2: `{"text": "[ESCAPAR RÁPIDAMENTE] Decidir escapar antes de que se detecte el sabotaje", "nextNodeId": "node8bn"}`.

Texto del origen: [SABOTEAR SISTEMAS] Deshabilitas sistemas clave que podrían alertar a la IA o llamar refuerzos.

Ruta efectiva testigo: node1 @ nodes[0] → node2b @ nodes[2] → node3c @ nodes[5] → node4f @ nodes[12] → node5j @ nodes[24] → node6s @ nodes[47] → node7z @ nodes[80] → `node8bn` (definición 1). Ruta hipotética al origen: node1 @ nodes[0] → node2b @ nodes[2] → node3c @ nodes[5] → node4f @ nodes[12] → node5j @ nodes[24] → node6s @ nodes[47] → node7z @ nodes[80]. Todos los recorridos que alcancen este origen y elijan esta decisión resultan afectados, incluidas rutas convergentes.

**Propuesta:** conservar íntegros ambos textos y decisiones. Mantener provisionalmente `node8bn` para la primera definición y renombrar la segunda a `node8bn__v2`, sin colisión actual. Ninguna entrada se reasigna automáticamente: el autor debe indicar la variante de destino de cada decisión. El renombre por sí solo no hace jugable la segunda variante.

**Decisión del autor:** existe una única entrada para las dos variantes. ¿Cuál corresponde a esa decisión y cómo se conserva/disponibiliza la otra? No inventar una decisión adicional ni elegir por numeración de finales.

### `final134`

**Definición 1, `nodes[313]`:** alcanzable actualmente.

```json
{
  "id": "final134",
  "text": "**Final: Hackeo Desastroso**\nIntentas extraer datos adicionales, pero el sistema detecta tu actividad. La IA te atrapa y la misión fracasa.",
  "choices": []
}
```

Finales descendientes al entrar en esta variante, resolviendo sus destinos como el motor: `final134 @ nodes[313]`.

**Definición 2, `nodes[318]`:** inaccesible actualmente.

```json
{
  "id": "final134",
  "text": "**Final: Extracción Exitosa a Ciegas**\nA pesar de tu ceguera, logras extraer toda la información vital del NeuroBank. Escapas exitosamente, cambiando el destino de la humanidad con los datos obtenidos."
}
```

Finales descendientes al entrar en esta variante, resolviendo sus destinos como el motor: `final134 @ nodes[318]`.

**Entrada:** `node8au @ nodes[133]`, decisión 1: `{"text": "[ESCAPAR CON DATOS] Iniciar la fuga con los datos extraídos", "nextNodeId": "final134"}`.

Texto del origen: [EXITO A CIEGAS] Logras completar el hackeo pese a la ceguera, extrayendo toda la información necesaria del NeuroBank.

Ruta efectiva testigo: node1 @ nodes[0] → node2a @ nodes[1] → node3b @ nodes[4] → node4d @ nodes[10] → node5g @ nodes[21] → node6m @ nodes[41] → node7q @ nodes[71] → node8au @ nodes[133] → `final134` (definición 1). Ruta hipotética al origen: node1 @ nodes[0] → node2a @ nodes[1] → node3b @ nodes[4] → node4d @ nodes[10] → node5g @ nodes[21] → node6m @ nodes[41] → node7q @ nodes[71] → node8au @ nodes[133]. Todos los recorridos que alcancen este origen y elijan esta decisión resultan afectados, incluidas rutas convergentes.

**Entrada:** `node9f @ nodes[177]`, decisión 1: `{"text": "[ESCAPAR CON DATOS LIMITADOS] Iniciar la fuga con la información obtenida", "nextNodeId": "final134"}`.

Texto del origen: [CUMPLIMIENTO PARCIAL] Cumples parcialmente con las condiciones de la IA, obteniendo acceso limitado a la información.

Ruta efectiva testigo: node1 @ nodes[0] → node2a @ nodes[1] → node3a @ nodes[3] → node4b @ nodes[8] → node5c @ nodes[17] → node6f @ nodes[34] → node7k @ nodes[65] → node9f @ nodes[177] → `final134` (definición 1). Ruta hipotética al origen: node1 @ nodes[0] → node2a @ nodes[1] → node3a @ nodes[3] → node4b @ nodes[8] → node5c @ nodes[17] → node6f @ nodes[34] → node7k @ nodes[65] → node9f @ nodes[177]. Todos los recorridos que alcancen este origen y elijan esta decisión resultan afectados, incluidas rutas convergentes.

**Propuesta:** conservar íntegros ambos textos y decisiones. Mantener provisionalmente `final134` para la primera definición y renombrar la segunda a `final134__v2`, sin colisión actual. Ninguna entrada se reasigna automáticamente: el autor debe indicar la variante de destino de cada decisión. El renombre por sí solo no hace jugable la segunda variante.

**Hipótesis editorial pendiente de aprobación:** node8au promete extracción exitosa a ciegas, coherente con la segunda definición. node9f promete escapar con datos limitados, pero la primera definición describe extraer datos adicionales y fracasar; no hay correspondencia inequívoca para esa salida.

### `final135`

**Definición 1, `nodes[314]`:** alcanzable actualmente.

```json
{
  "id": "final135",
  "text": "**Final: Hackeo Persistente**\nDecides continuar el hackeo para obtener más datos, enfrentándote a nuevas defensas de la IA, pero logras extraer información crucial.",
  "choices": []
}
```

Finales descendientes al entrar en esta variante, resolviendo sus destinos como el motor: `final135 @ nodes[314]`.

**Definición 2, `nodes[319]`:** inaccesible actualmente.

```json
{
  "id": "final135",
  "text": "**Final: Ocultación y Escape Seguro**\nDecides borrar tus huellas antes de escapar. Aunque logras ocultar tu actividad, algunos datos podrían perderse en el proceso, pero logras salir sin ser detectado."
}
```

Finales descendientes al entrar en esta variante, resolviendo sus destinos como el motor: `final135 @ nodes[319]`.

**Entrada:** `node8au @ nodes[133]`, decisión 2: `{"text": "[OCULTAR HUELLAS Y ESCAPAR] Borrar rastros antes de escapar", "nextNodeId": "final135"}`.

Texto del origen: [EXITO A CIEGAS] Logras completar el hackeo pese a la ceguera, extrayendo toda la información necesaria del NeuroBank.

Ruta efectiva testigo: node1 @ nodes[0] → node2a @ nodes[1] → node3b @ nodes[4] → node4d @ nodes[10] → node5g @ nodes[21] → node6m @ nodes[41] → node7q @ nodes[71] → node8au @ nodes[133] → `final135` (definición 1). Ruta hipotética al origen: node1 @ nodes[0] → node2a @ nodes[1] → node3b @ nodes[4] → node4d @ nodes[10] → node5g @ nodes[21] → node6m @ nodes[41] → node7q @ nodes[71] → node8au @ nodes[133]. Todos los recorridos que alcancen este origen y elijan esta decisión resultan afectados, incluidas rutas convergentes.

**Entrada:** `node9f @ nodes[177]`, decisión 2: `{"text": "[COMPLETAR HACKEO] Continuar el hackeo para obtener más datos", "nextNodeId": "final135"}`.

Texto del origen: [CUMPLIMIENTO PARCIAL] Cumples parcialmente con las condiciones de la IA, obteniendo acceso limitado a la información.

Ruta efectiva testigo: node1 @ nodes[0] → node2a @ nodes[1] → node3a @ nodes[3] → node4b @ nodes[8] → node5c @ nodes[17] → node6f @ nodes[34] → node7k @ nodes[65] → node9f @ nodes[177] → `final135` (definición 1). Ruta hipotética al origen: node1 @ nodes[0] → node2a @ nodes[1] → node3a @ nodes[3] → node4b @ nodes[8] → node5c @ nodes[17] → node6f @ nodes[34] → node7k @ nodes[65] → node9f @ nodes[177]. Todos los recorridos que alcancen este origen y elijan esta decisión resultan afectados, incluidas rutas convergentes.

**Propuesta:** conservar íntegros ambos textos y decisiones. Mantener provisionalmente `final135` para la primera definición y renombrar la segunda a `final135__v2`, sin colisión actual. Ninguna entrada se reasigna automáticamente: el autor debe indicar la variante de destino de cada decisión. El renombre por sí solo no hace jugable la segunda variante.

**Hipótesis editorial pendiente de aprobación:** node8au ofrece ocultar huellas y escapar, coherente con la segunda; node9f ofrece continuar para obtener más datos, coherente con la primera.

### `final136`

**Definición 1, `nodes[315]`:** alcanzable actualmente.

```json
{
  "id": "final136",
  "text": "**Final: Preparación Exitosa**\nMejoras tu equipo para la próxima misión, asegurando una mayor eficiencia y éxito en futuras incursiones.",
  "choices": []
}
```

Finales descendientes al entrar en esta variante, resolviendo sus destinos como el motor: `final136 @ nodes[315]`.

**Definición 2, `nodes[320]`:** inaccesible actualmente.

```json
{
  "id": "final136",
  "text": "**Final: Misión Fallida por Ceguera**\nLa ceguera interrumpe tu hackeo, y las defensas de la IA te capturan. La misión termina en fracaso, atrapándote dentro del NeuroBank."
}
```

Finales descendientes al entrar en esta variante, resolviendo sus destinos como el motor: `final136 @ nodes[320]`.

**Entrada:** `node8av @ nodes[134]`, decisión 1: `{"text": "[FINAL FALLIDO] Misión fallida, atrapado por las defensas", "nextNodeId": "final136"}`.

Texto del origen: [FALLO POR CIEGUE] La ceguera interrumpe tu hackeo, fallando en extraer la información y alertando a las defensas de la IA.

Ruta efectiva testigo: node1 @ nodes[0] → node2a @ nodes[1] → node3b @ nodes[4] → node4d @ nodes[10] → node5g @ nodes[21] → node6m @ nodes[41] → node7q @ nodes[71] → node8av @ nodes[134] → `final136` (definición 1). Ruta hipotética al origen: node1 @ nodes[0] → node2a @ nodes[1] → node3b @ nodes[4] → node4d @ nodes[10] → node5g @ nodes[21] → node6m @ nodes[41] → node7q @ nodes[71] → node8av @ nodes[134]. Todos los recorridos que alcancen este origen y elijan esta decisión resultan afectados, incluidas rutas convergentes.

**Entrada:** `node9h @ nodes[179]`, decisión 1: `{"text": "[PREPARAR EQUIPO] Mejorar tu equipo para la próxima misión", "nextNodeId": "final136"}`.

Texto del origen: [PLANIFICACIÓN FUTURA] Preparas una nueva incursión en el futuro, basándote en las lecciones aprendidas de la misión actual.

Ruta efectiva testigo: node1 @ nodes[0] → node2b @ nodes[2] → node3d @ nodes[6] → node4h @ nodes[14] → node5m @ nodes[27] → node6x @ nodes[52] → node7ad @ nodes[84] → node9h @ nodes[179] → `final136` (definición 1). Ruta hipotética al origen: node1 @ nodes[0] → node2b @ nodes[2] → node3d @ nodes[6] → node4h @ nodes[14] → node5m @ nodes[27] → node6x @ nodes[52] → node7ad @ nodes[84] → node9h @ nodes[179]. Todos los recorridos que alcancen este origen y elijan esta decisión resultan afectados, incluidas rutas convergentes.

**Propuesta:** conservar íntegros ambos textos y decisiones. Mantener provisionalmente `final136` para la primera definición y renombrar la segunda a `final136__v2`, sin colisión actual. Ninguna entrada se reasigna automáticamente: el autor debe indicar la variante de destino de cada decisión. El renombre por sí solo no hace jugable la segunda variante.

**Hipótesis editorial pendiente de aprobación:** node8av ofrece fracaso por ceguera, coherente con la segunda; node9h ofrece preparar equipo, coherente con la primera.

### `final137`

**Definición 1, `nodes[316]`:** alcanzable actualmente.

```json
{
  "id": "final137",
  "text": "**Final: Alianzas Fuertes**\nFormas nuevas alianzas que fortalecen tu posición en futuras misiones, aumentando tus posibilidades de éxito.",
  "choices": []
}
```

Finales descendientes al entrar en esta variante, resolviendo sus destinos como el motor: `final137 @ nodes[316]`.

**Definición 2, `nodes[321]`:** inaccesible actualmente.

```json
{
  "id": "final137",
  "text": "**Final: Escape Rápido sin Éxito**\nUtilizas tus habilidades para escapar rápidamente, pero sin los datos esenciales, limitando el impacto de tu misión."
}
```

Finales descendientes al entrar en esta variante, resolviendo sus destinos como el motor: `final137 @ nodes[321]`.

**Entrada:** `node8ax @ nodes[136]`, decisión 1: `{"text": "[ESCAPAR RAPIDAMENTE] Utilizar habilidades para escapar rápidamente", "nextNodeId": "final137"}`.

Texto del origen: [RETIRADA] Decides que es demasiado arriesgado continuar, abandonando el hackeo y escapando con vida.

Ruta efectiva testigo: node1 @ nodes[0] → node2a @ nodes[1] → node3b @ nodes[4] → node4d @ nodes[10] → node5g @ nodes[21] → node6m @ nodes[41] → node7r @ nodes[72] → node8ax @ nodes[136] → `final137` (definición 1). Ruta hipotética al origen: node1 @ nodes[0] → node2a @ nodes[1] → node3b @ nodes[4] → node4d @ nodes[10] → node5g @ nodes[21] → node6m @ nodes[41] → node7r @ nodes[72] → node8ax @ nodes[136]. Todos los recorridos que alcancen este origen y elijan esta decisión resultan afectados, incluidas rutas convergentes.

**Entrada:** `node9h @ nodes[179]`, decisión 2: `{"text": "[FORMAR NUEVOS ALIANZAS] Buscar nuevas alianzas para fortalecer tu próxima incursión", "nextNodeId": "final137"}`.

Texto del origen: [PLANIFICACIÓN FUTURA] Preparas una nueva incursión en el futuro, basándote en las lecciones aprendidas de la misión actual.

Ruta efectiva testigo: node1 @ nodes[0] → node2b @ nodes[2] → node3d @ nodes[6] → node4h @ nodes[14] → node5m @ nodes[27] → node6x @ nodes[52] → node7ad @ nodes[84] → node9h @ nodes[179] → `final137` (definición 1). Ruta hipotética al origen: node1 @ nodes[0] → node2b @ nodes[2] → node3d @ nodes[6] → node4h @ nodes[14] → node5m @ nodes[27] → node6x @ nodes[52] → node7ad @ nodes[84] → node9h @ nodes[179]. Todos los recorridos que alcancen este origen y elijan esta decisión resultan afectados, incluidas rutas convergentes.

**Propuesta:** conservar íntegros ambos textos y decisiones. Mantener provisionalmente `final137` para la primera definición y renombrar la segunda a `final137__v2`, sin colisión actual. Ninguna entrada se reasigna automáticamente: el autor debe indicar la variante de destino de cada decisión. El renombre por sí solo no hace jugable la segunda variante.

**Hipótesis editorial pendiente de aprobación:** node8ax ofrece escapar sin completar la misión, coherente con la segunda; node9h ofrece formar alianzas, coherente con la primera.

## Material aislado aun sin resolver las colisiones

17 definiciones: grupo `node7ae`/`node7af` → `node8bu`–`node8bx` → `final114`–`final121`; grupo `node8by` → `final122`/`final123`. La falta de entrada desde el inicio es un hecho; si son conexiones omitidas o material reservado requiere al autor. No eliminarlos ni conectarlos por semejanza de nombres.

- `node7ae @ nodes[85]`: entradas ninguna; salidas node8bu, node8bv.

- `node7af @ nodes[86]`: entradas ninguna; salidas node8bw, node8bx.

- `node8bu @ nodes[167]`: entradas node7ae @ nodes[85], decisión 1; salidas final114, final115.

- `node8bv @ nodes[168]`: entradas node7ae @ nodes[85], decisión 2; salidas final116, final117.

- `node8bw @ nodes[169]`: entradas node7af @ nodes[86], decisión 1; salidas final118, final119.

- `node8bx @ nodes[170]`: entradas node7af @ nodes[86], decisión 2; salidas final120, final121.

- `node8by @ nodes[171]`: entradas ninguna; salidas final122, final123.

- `final114 @ nodes[293]`: entradas node8bu @ nodes[167], decisión 1; salidas ninguna: final.

- `final115 @ nodes[294]`: entradas node8bu @ nodes[167], decisión 2; salidas ninguna: final.

- `final116 @ nodes[295]`: entradas node8bv @ nodes[168], decisión 1; salidas ninguna: final.

- `final117 @ nodes[296]`: entradas node8bv @ nodes[168], decisión 2; salidas ninguna: final.

- `final118 @ nodes[297]`: entradas node8bw @ nodes[169], decisión 1; salidas ninguna: final.

- `final119 @ nodes[298]`: entradas node8bw @ nodes[169], decisión 2; salidas ninguna: final.

- `final120 @ nodes[299]`: entradas node8bx @ nodes[170], decisión 1; salidas ninguna: final.

- `final121 @ nodes[300]`: entradas node8bx @ nodes[170], decisión 2; salidas ninguna: final.

- `final122 @ nodes[301]`: entradas node8by @ nodes[171], decisión 1; salidas ninguna: final.

- `final123 @ nodes[302]`: entradas node8by @ nodes[171], decisión 2; salidas ninguna: final.

## Motor: validaciones y deficiencias confirmadas

`lib/models/story.dart`: `Story.fromJson` solo exige nodos no vacíos. No rechaza colisiones, IDs vacíos ni destinos ausentes. `duplicateNodeIds`/`missingNodeIds` son diagnósticos no aplicados al cargar. `_nodesById` recorre al revés para conservar la primera definición y ocultar las restantes. `StoryChoice.fromJson` permite destino vacío y convierte tipos a texto. `StoryNode.fromJson` trata cualquier `choices` que no sea lista como final; debe distinguir campo ausente legítimo de tipo inválido. `startNode` depende del orden del JSON.

`lib/services/story_repository.dart`: carga diferida y caché funcionan, pero `_read` solo compara ID de historia con índice, sin validación del grafo ni igualdad de IDs al cargar. `StorySummary.fromJson` convierte a conjunto y oculta multiplicidades. Conviene validar también IDs de historia únicos; nunca prohibir compartir IDs entre historias.

`lib/screens/story_reader_screen.dart`: avisa de destino ausente al pulsar, pero no detecta ambigüedad. `lib/services/progress_store.dart`: clave `mythos.progress.v1`, partidas por ID de historia, nodo actual e historial. Valida existencia del actual, no toda la trayectoria; `back` no avanza si falta un ID histórico. `moveTo` confía en el nodo recibido. Son riesgos para una reparación futura, no autorización para alterar persistencia.

## Pruebas existentes

`story_catalog_test.dart` exige explícitamente los 12 duplicados y conservar la primera aparición: una suite verde no acredita integridad. Comprueba referencias existentes, no grafo. `story_repository_test.dart` comprueba igualdad original/individuales, caché, reintento, carga diferida y progreso básico; la igualdad conserva defectos. `app_smoke_test.dart` recorre una historia de muestra. `progress_store_test.dart` cubre guardado/restauración/deshacer/reinicio básico. También se revisaron/ejecutaron las pruebas de bootstrap y secuencia existentes, sin modificarlas. `tools/audit_assets.py` no analiza accesibilidad/ciclos ni falla por duplicados; no se ejecutó porque escribiría otro informe.

## Plan concreto de reparación y riesgos

1. Congelar hashes y preparar copia candidata más manifiesto por puntero JSON: historia, definición, decisión, destino anterior/nuevo. No editar la fuente hasta aprobación.
2. Obtener decisiones para las 16 entradas de los 12 IDs (8 entradas a nodos y 8 a finales). Aprobar renombres de la tabla, conservando las 354 definiciones y todos los textos/decisiones. No fusionar por similitud. Resolver variantes jugables o material reservado explícitamente; no inventar conexiones.
3. Resolver los 17 aislados con conexiones precisas autorizadas o excepción editorial documentada. Confirmar los cinco finales con IDs de nodo: `node4e`, `node5l`, `node7d`, `node8h`, `node9g`; son finales válidos, no un error por el nombre.
4. Editar fuente aprobada y regenerar índice/individuales; verificar igualdad y diff de cada texto/decisión, no solo cantidades.
5. Validar unicidad por historia, IDs no vacíos, tipos y referencias en carga compartida. No prohibir convergencias, finales compartidos ni ciclos automáticamente. Accesibilidad/ciclos producen diagnóstico editorial salvo política aprobada. Mantener carga diferida. No desplegar rechazo estricto antes de reparar: bloquearía El Asalto Neon.
6. Mantener IDs originales de primeras definiciones reduce riesgo nominal de progreso, pero modificar conexiones aún puede alterar reanudación. Un ID duplicado guardado no distingue variantes. Aprobar política de compatibilidad/migración antes de desplegar, verificando nodo actual, historial y completado. No reiniciar ni sobrescribir partidas, no migrar referencias ambiguas automáticamente; conservar clave actual.
7. Sustituir el test que exige duplicados solo con los datos aprobados. Ejecutar suite y auditoría del candidato; entregar diff revisable. Inicio, identidad, diseño y pantallas permanecen fuera de alcance.

Riesgos: elegir primera/última variante puede invertir éxito/fracaso; renombrar sin entradas mantiene nodos inaccesibles; eliminar variantes pierde texto; añadir rutas por cobertura inventa narrativa; regenerar índice desde una fuente equivocada desincroniza validación del progreso. Una partida antigua puede guardar un ID ambiguo y no ofrecer información suficiente para migrarlo.

## Pruebas automatizadas que deberían añadirse

- Rechazar IDs duplicados con historia y posiciones, vacíos y destinos ausentes; aceptar IDs iguales en historias distintas.
- Aceptar caminos convergentes y finales compartidos. Validar decisiones y tipos; aceptar finales sin choices o con lista vacía, rechazar tipo inválido.
- Fixtures de inaccesibilidad, finales aislados, ciclo alcanzable/aislado y autorreferencia; distinguir ciclo de convergencia, sin prohibición narrativa automática.
- Auditar los cuatro datos aprobados: unicidad, referencias y cobertura con excepciones explícitas; verificar cada reasignación del manifiesto y conservación de todo texto/decisión.
- Validar índice/contenido; historia inválida no queda cacheada y permite reintento, sin carga global al inicio.
- Probar cada ID afectado en reanudar/deshacer/historial/completado, aislamiento por historia y ausencia de migración ambigua o reinicio implícito.
- Recorrer desde inicio cada variante/final habilitado según el autor, incluyendo finales134–137, vuelta atrás y reapertura.

## Preguntas que requieren decisión del autor

1. Para cada `node8bg`–`node8bn`, ¿qué variante corresponde a su única entrada y cómo debe quedar disponible la otra, sin inventar decisiones?
2. ¿Aprobar el reparto semántico sugerido para final135–137? ¿Qué final corresponde a escapar con datos limitados desde node9f para final134, cuya primera variante contradice esa decisión?
3. ¿Qué decisiones existentes deben llegar a node7ae, node7af y node8by, o son rutas deliberadamente reservadas?
4. ¿Son intencionales los cinco finales con IDs de nodo?
5. ¿Aprobar renombres __v2 manteniendo los originales para primeras definiciones? ¿Qué política se aplica a partidas previas ambiguas, sin borrar su progreso?
6. ¿Exigir accesibilidad total para publicación o permitir material reservado documentado? Las correcciones quedan pendientes de estas aprobaciones.

## Evidencia y verificación

Comandos: `flutter analyze --no-pub` y `flutter test --no-pub`. Resultados: `flutter analyze --no-pub` termino con codigo 0 y **No issues found** (78,3 s); `flutter test --no-pub` termino con codigo 0 y **19 pruebas aprobadas**. No se modificaron las pruebas. La suite verde no garantiza unicidad: exige conservar los 12 IDs duplicados. No se solicitó compilación ni emulador para esta auditoría; no se afirma verificación visual.

- `assets/stories/stories.json` SHA-256: `1fd1ed38f0812b088dde543c0aeaf859afadc21f09ac2608f3da180d22d27b1d`.

- `assets/stories/index.json` SHA-256: `669fc5837810a8638bf8b805d87c0500ee8c399a607939565a611850f313b4f5`.

- `assets/stories/content/android_secret.json` SHA-256: `dad1ff9383e28f906bc977c7430bd09055fd32092685f06628a26d0d9eec6b97`.

- `assets/stories/content/cyberpunk_heist.json` SHA-256: `955b222298fc934c66bb1f9ebb8be4ad58bb239cccb34755935826512e458e8c`.

- `assets/stories/content/laberinto_medianoche.json` SHA-256: `fe5abe94bbe68d1090aed531fb8bc8d23ed72eb66e1072ded75d80d26af888a1`.

- `assets/stories/content/odisea_destino.json` SHA-256: `68a940c89c22814644b561a10dea6fd44ccea52e4d9da72302636cc9043f32a8`.

Hashes de lib, test, historias y pubspec comprobados sin cambios durante generación. Único archivo nuevo generado por la auditoría: `docs/auditoria_narrativa.md`.
