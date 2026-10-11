# Mythos v1.2 — Inicio y branding

- Animación original `chiguire_grove_splash.dart` recibida del usuario, incorporada sin rediseño (5,7 segundos; 650 ms con movimiento reducido).
- Isotipo SVG original de Chigüire Grove incorporado como asset de Flutter.
- Intersticial MYTHOS hecho **solo con widgets Flutter**: fondo `#10101A`, icono sencillo de libro abierto y título `MYTHOS` en `#EECFA0` (1,5 s; 650 ms con movimiento reducido).
- Transición `AnimatedSwitcher` de 250 ms entre etapas y a la biblioteca; se presenta una sola vez por arranque del proceso.
- Eliminación del icono predeterminado Flutter durante el arranque de Android: isotipo Chigüire Grove sobre fondo crema en recursos nativos (Android 12+ y anteriores), lanzador con libro.
- `scripts/aplicar_branding_android.ps1` aplica recursos y modifica únicamente el tema de arranque y el nombre visible en Android. Guarda copias de los archivos originales en `android/.mythos_brand_backups/`, fuera del árbol `res`, cuando corresponde.
- `iniciar_windows.ps1` ya no recrea Android si existe; por defecto aplica el branding.
- Se mantiene sin cambios `assets/stories/stories.json` y los 5 archivos WebP originales. Los duplicados narrativos conocidos de El Asalto Neon no se modificaron en esta revisión.
- `MythosApp(showStartupSplash: false)` permite pruebas de navegación aisladas. Prueba adicional de orden de presentación incluida.

**Nota:** Flutter SDK no está disponible en el entorno que generó este ZIP. Se requiere `flutter pub get`, `flutter analyze`, `flutter test` y `flutter run` en Windows para verificar compilación/ejecución de v1.2.
