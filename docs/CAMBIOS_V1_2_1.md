# Mythos v1.2.1

- Inicio diferido del controlador de Chigüire Grove hasta un frame de Flutter + 300 ms. Evita gastar la duración de animación durante la transición desde la ventana nativa.
- Se conserva intacta la animación original al estar habilitadas las animaciones del dispositivo.
- Cuando Android solicita movimiento reducido, se muestra estáticamente el logo y los textos del estudio, sin una fase imperceptible.
- Mensajes `MYTHOS_STARTUP` en depuración para verificar secuencias en `adb logcat`/consola.
- Se incluyen pruebas de temporización y movimiento reducido; ejecutar en Windows (aquí no hay Flutter SDK).
- Ninguna modificación de historias, imágenes originales ni almacenamiento local.
