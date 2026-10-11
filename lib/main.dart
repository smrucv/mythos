import 'package:flutter/material.dart';

import 'app.dart';

void main() {
  final watch = Stopwatch()..start();
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    assert(() {
      debugPrint(
          'MYTHOS_STARTUP: primer frame Flutter ${watch.elapsedMilliseconds} ms desde main');
      return true;
    }());
  });
  // No esperar al catalogo ni al almacenamiento para presentar el primer frame.
  runApp(const MythosApp());
}
