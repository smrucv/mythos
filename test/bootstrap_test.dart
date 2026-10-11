import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mythos/app.dart';
import 'package:mythos/models/story.dart';
import 'package:mythos/services/progress_store.dart';
import 'package:mythos/services/story_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets(
      'primer frame y secuencia no esperan el catalogo ni se reinician al cargar',
      (tester) async {
    SharedPreferences.setMockInitialValues({});
    final progress = await ProgressStore.open();
    final pending = Completer<StoryRepository>();
    await tester.pumpWidget(
        MythosApp(progress: progress, loadCatalog: () => pending.future));
    expect(find.byKey(const ValueKey('chiguire-grove-stage')), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 350));
    await tester.pump(const Duration(milliseconds: 5800));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 601));
    expect(find.byKey(const ValueKey('mythos-title-stage')), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 1500));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 601));
    expect(find.byKey(const ValueKey('startup-ready')), findsOneWidget);
    pending.complete(StoryRepository.fromCatalog(const StoryCatalog([])));
    await tester.pump();
    await tester.pump();
    await tester.pump();
    expect(find.text('0 historias disponibles'), findsOneWidget);
    expect(find.byKey(const ValueKey('chiguire-grove-stage')), findsNothing);
    await tester.pumpWidget(const SizedBox.shrink());
    progress.dispose();
    expect(tester.takeException(), isNull);
  });

  testWidgets('carga tardia despues de dispose no ejecuta setState',
      (tester) async {
    SharedPreferences.setMockInitialValues({});
    final progress = await ProgressStore.open();
    final pending = Completer<StoryRepository>();
    await tester.pumpWidget(
        MythosApp(progress: progress, loadCatalog: () => pending.future));
    await tester.pumpWidget(const SizedBox.shrink());
    pending.complete(StoryRepository.fromCatalog(const StoryCatalog([])));
    await tester.pump();
    expect(tester.takeException(), isNull);
    progress.dispose();
  });
}
