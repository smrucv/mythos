# Reconstrucción: alcance, riesgos y trazabilidad

## Procedencia

- APK original: `mythos-3.apk`.
- `assets/stories/stories.json` y `assets/images/` provienen de `assets/flutter_assets/` dentro del APK.
- Integridad: comparación binaria contra el APK, seis archivos idénticos (ver `INTEGRIDAD.json`).
- No se recuperó `lib/main.dart` ni el resto del árbol Dart original: el ejecutable Flutter de producción estaba compilado.
- Conservamos el `AssetManifest_original.json` de la extracción.

## Funcionalidad reconstruida

Se optó por separar modelos, persistencia, pantallas y widgets. Se conservan los nombres de campos del JSON de producción (`id`, `title`, `category`, `estimatedDuration`, `coverImage`, `description`, `nodes`, `choices`, `nextNodeId`, `image`). Las elecciones pueden llevar a un nodo con identificador compartido por varias entradas: para que el comportamiento sea reproducible, se resuelve el primer registro.

`StoryProgress` almacena la ruta recorrida en `SharedPreferences` (clave `mythos.progress.v1`), con el nodo actual, el historial de IDs y la marca de final completado. Se mantiene un registro independiente por historia.

## Riesgo conocido: IDs duplicados

Los 12 identificadores repetidos pertenecen a `cyberpunk_heist` («El Asalto Neon»). Algunas entradas tienen textos distintos. El archivo original se mantiene intacto; la primera ocurrencia queda activa hasta revisar a mano las rutas entrantes. El informe `auditoria_historias.json` identifica cada par repetido y los orígenes de las decisiones entrantes.

No cambiar IDs automáticamente: primero hay que decidir qué enlaces iban a cada variante, actualizar el JSON derivado para una nueva versión y ampliar las pruebas.

## Validaciones antes de considerar v1 aprobada

- [x] El ZIP de fuentes contiene los seis recursos originales, con hash igual al APK.
- [x] Parser Python: 4 historias, 592 nodos, todas las referencias resueltas, 12 IDs repetidos.
- [x] Código Flutter, configuración y tests incluidos.
- [ ] `flutter pub get`, `flutter analyze` y `flutter test` ejecutados en máquina con SDK.
- [ ] Instalada en Android real y comparada pantalla por pantalla con la app original.
- [ ] Interacción probada en todas las rutas narrativas.
- [ ] APK nuevo generado y probado en teléfono.

## Guion de comparación con el APK original

1. Iniciar la app original y anotar colores, tipografía, disposición, acciones y textos en la biblioteca.
2. Abrir una historia y registrar si hay controles especiales, portada, duración y estado guardado.
3. Jugar tres decisiones, cerrar la app y comprobar la restauración del progreso.
4. Comparar botones atrás, finales y reinicio.
5. Repetir en la app reconstruida y documentar diferencias.

No hay necesidad de desinstalar la app original. La nueva app usa identificador Android distinto.
