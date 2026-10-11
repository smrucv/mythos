import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mythos_recovery/widgets/startup_sequence.dart';

void main() {
  testWidgets('Chigüire Grove -> MYTHOS -> biblioteca', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: StartupSequence(
          child: Scaffold(body: Center(child: Text('Biblioteca lista'))),
        ),
      ),
    );
    expect(find.byKey(const ValueKey('chiguire-grove-stage')), findsOneWidget);

    // El primer frame se presenta antes de iniciar el cronómetro.
    await tester.pump(const Duration(milliseconds: 350));
    // Animación original del estudio: 5,7 segundos.
    await tester.pump(const Duration(milliseconds: 5800));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.byKey(const ValueKey('mythos-title-stage')), findsOneWidget);

    // Presentación de MYTHOS: 1,5 segundos + transición suave.
    await tester.pump(const Duration(milliseconds: 1600));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.byKey(const ValueKey('startup-ready')), findsOneWidget);
    expect(find.text('Biblioteca lista'), findsOneWidget);
  });

  testWidgets('movimiento reducido conserva identidad del estudio',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MediaQuery(
          data: MediaQueryData(disableAnimations: true),
          child: StartupSequence(
            child: Scaffold(body: Text('Biblioteca lista')),
          ),
        ),
      ),
    );
    expect(find.text('CHIGÜIRE GROVE'), findsOneWidget);
    // Presentación estática: sin germinación animada, pero visible 1,5 s.
    await tester.pump(const Duration(milliseconds: 350));
    await tester.pump(const Duration(milliseconds: 1600));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.byKey(const ValueKey('mythos-title-stage')), findsOneWidget);
  });

  testWidgets('se puede omitir el splash en las pruebas de navegación',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: StartupSequence(
          enabled: false,
          child: Scaffold(body: Text('Biblioteca lista')),
        ),
      ),
    );
    expect(find.byKey(const ValueKey('startup-ready')), findsOneWidget);
  });
}
