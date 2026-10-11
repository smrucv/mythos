import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mythos/widgets/startup_sequence.dart';

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
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 601));
    expect(find.byKey(const ValueKey('mythos-title-stage')), findsOneWidget);

    // Presentación de MYTHOS: 1,5 segundos + transición suave.
    await tester.pump(const Duration(milliseconds: 1500));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 601));
    expect(find.byKey(const ValueKey('startup-ready')), findsOneWidget);
    expect(find.text('Biblioteca lista'), findsOneWidget);
  });

  testWidgets('fundido cubierto y permanencia completa de MYTHOS',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(
        home: StartupSequence(
      child: Scaffold(body: Text('Biblioteca lista')),
    )));
    await tester.pump(const Duration(milliseconds: 350));
    await tester.pump(const Duration(milliseconds: 5800));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    final finder = find.ancestor(
      of: find.byKey(const ValueKey('mythos-title-stage')),
      matching: find.byType(FadeTransition),
    );
    expect(tester.widget<FadeTransition>(finder.first).opacity.value,
        closeTo(0.5, 0.02));
    expect(find.byKey(const ValueKey('chiguire-grove-stage')), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 301));
    expect(find.byKey(const ValueKey('chiguire-grove-stage')), findsNothing);
    await tester.pump(const Duration(milliseconds: 1499));
    expect(tester.widget<FadeTransition>(finder.first).opacity.value, 1);
    expect(find.byKey(const ValueKey('startup-ready')), findsNothing);
    await tester.pump(const Duration(milliseconds: 1));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(tester.widget<FadeTransition>(finder.first).opacity.value,
        closeTo(0.5, 0.02));
    await tester.pump(const Duration(milliseconds: 301));
    expect(find.byKey(const ValueKey('startup-ready')), findsOneWidget);
    expect(find.byKey(const ValueKey('mythos-title-stage')), findsNothing);
  });

  testWidgets('dispose cancela callbacks en animacion y permanencia',
      (tester) async {
    for (final elapsed in [0, 300, 600, 1800, 2400]) {
      await tester.pumpWidget(const MaterialApp(
          home: StartupSequence(
        child: Scaffold(body: Text('Biblioteca lista')),
      )));
      if (elapsed > 0) {
        await tester.pump(const Duration(milliseconds: 350));
        await tester.pump(const Duration(milliseconds: 5800));
        await tester.pump();
        await tester.pump(Duration(milliseconds: elapsed.clamp(0, 600)));
        if (elapsed > 600) {
          await tester.pump(Duration(milliseconds: elapsed - 600));
        }
      }
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump(const Duration(seconds: 10));
      expect(tester.takeException(), isNull);
    }
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
    await tester.pump(const Duration(milliseconds: 1501));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 601));
    expect(find.byKey(const ValueKey('mythos-title-stage')), findsOneWidget);
  });

  testWidgets('desactivar durante fundido cancela la secuencia',
      (tester) async {
    Widget app(bool enabled) => MaterialApp(
            home: StartupSequence(
          enabled: enabled,
          child: const Scaffold(body: Text('Biblioteca lista')),
        ));
    await tester.pumpWidget(app(true));
    await tester.pump(const Duration(milliseconds: 350));
    await tester.pump(const Duration(milliseconds: 5800));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pumpWidget(app(false));
    await tester.pump(const Duration(seconds: 10));
    expect(find.byKey(const ValueKey('startup-ready')), findsOneWidget);
    expect(find.byKey(const ValueKey('mythos-title-stage')), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('movimiento reducido completa la secuencia sin fundidos',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(
        home: MediaQuery(
      data: MediaQueryData(disableAnimations: true),
      child: StartupSequence(child: Scaffold(body: Text('Biblioteca lista'))),
    )));
    await tester.pump(const Duration(milliseconds: 350));
    await tester.pump(const Duration(milliseconds: 1501));
    await tester.pump();
    expect(find.byKey(const ValueKey('chiguire-grove-stage')), findsNothing);
    expect(find.byKey(const ValueKey('mythos-title-stage')), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 1499));
    expect(find.byKey(const ValueKey('startup-ready')), findsNothing);
    await tester.pump(const Duration(milliseconds: 1));
    await tester.pump();
    expect(find.byKey(const ValueKey('startup-ready')), findsOneWidget);
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
