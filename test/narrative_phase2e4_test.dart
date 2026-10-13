import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mythos/models/story.dart';
import 'package:mythos/models/story_diagnostics.dart';
import 'package:mythos/services/progress_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'support/narrative_phase2e4.dart';

const newId = 'node_extraccion_desde_mantenimiento';
const drone = ['node1', 'node2b', 'node3d', 'node4g', 'node5k', 'node6v'];
const maintenance = [
  'node1',
  'node2a',
  'node3a',
  'node4a',
  'node5b',
  'node6c',
  'node7f'
];
const routes = [
  [...drone, 'node8q', 'final30'],
  [...maintenance, 'node8ad', newId, 'final56'],
  [...maintenance, 'node8ad', newId, 'final57'],
  [...maintenance, 'node8ad', 'final57'],
  [...drone, 'node8r', 'final32'],
  [...drone, 'node8q', 'final31'],
  [...drone, 'node8r', 'final33'],
  [...maintenance, 'node8ac', 'final54'],
  [...maintenance, 'node8ac', 'final55'],
];

List<dynamic> baseline() {
  final result = Process.runSync(
      'git', ['show', 'f7cd2da:assets/stories/stories.json'],
      stdoutEncoding: utf8);
  expect(result.exitCode, 0);
  return jsonDecode(result.stdout as String) as List;
}

List<String> approvedParagraphs(String name) {
  final text = File('docs/propuestas_correccion_narrativa_fase2e3.md')
      .readAsStringSync()
      .replaceAll('\r\n', '\n');
  final start = text.indexOf('### $name');
  expect(start, greaterThanOrEqualTo(0));
  final chunk = text.substring(start, text.indexOf('\n### ', start + 4));
  return RegExp(r'(?:^>[^\n]*(?:\n|$))+', multiLine: true)
      .allMatches(chunk)
      .map((m) => m
          .group(0)!
          .trimRight()
          .split('\n')
          .map((line) => line.startsWith('> ') ? line.substring(2) : '')
          .join('\n'))
      .toList();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() => SharedPreferences.setMockInitialValues({}));

  test(
      'exactamente nueve campos y una definicion aprobada; todo lo demas intacto',
      () {
    final manifest = phase2e4Manifest;
    expect(manifest['baseCommit'], 'f7cd2daabe3b362e4316a87d1a518f82447f9654');
    expect(manifest['storyId'], 'cyberpunk_heist');
    expect(manifest['approvedAlternatives'], ['E30-A', 'E56-B', 'E32-A']);
    final a = approvedParagraphs('E30-A');
    final b = approvedParagraphs('E56-B');
    final c = approvedParagraphs('E32-A');
    final fields = {
      'node8q:text': a[0],
      'node8q:choices.0.text': a[1],
      'final30:text': a[2],
      'node8ad:text': b[0],
      'node8ad:choices.0.text': b[1],
      'node8ad:choices.0.nextNodeId': newId,
      'final56:text': b[3],
      'node8r:choices.0.text': c[0],
      'final32:text': c[1],
    };
    expect((manifest['changes'] as List).length, 9);
    expect({
      for (final change in manifest['changes'] as List)
        '${change['nodeId']}:${(change['path'] as List).join('.')}':
            change['after']
    }, fields);
    expect(manifest['addedDefinitions'], [
      {
        'definitionIndex': 354,
        'node': {
          'id': newId,
          'text': b[2],
          'choices': [
            {
              'text':
                  '[SOSTENER EL HACKEO] Resolver los bloqueos de la IA y mantener la descarga hasta obtener la información necesaria',
              'nextNodeId': 'final56'
            },
            {
              'text':
                  '[CORTAR Y RETIRARSE] Interrumpir el hackeo y salir sin completar la misión',
              'nextNodeId': 'final57'
            },
          ],
        },
      }
    ]);
    final current =
        jsonDecode(File('assets/stories/stories.json').readAsStringSync())
            as List;
    expect(current, applyPhase2e4Catalog(baseline()));
    // Inversion is exact, including positions, metadata, old drafts and complete added node.
    expect(applyPhase2e4Catalog(current, reverse: true), baseline());
  });

  test(
      'grafo real: 355 IDs, 314 accesibles, 153 terminales y 41 borradores; 2E.2/2B preservadas',
      () async {
    final before = StoryCatalog.fromJsonString(jsonEncode(baseline()));
    final current = await StoryCatalog.fromAssets();
    for (final story in current.stories) {
      final old = before.byId(story.id)!;
      final actual = StoryDiagnostics.inspect(story);
      final previous = StoryDiagnostics.inspect(old);
      expect(actual.unreachableNodeIds, previous.unreachableNodeIds);
      expect(actual.cyclicComponents, isEmpty);
      expect(story.missingNodeIds, isEmpty);
      expect(story.duplicateNodeIds, isEmpty);
      final oldReachable = old.nodes
          .map((n) => n.id)
          .toSet()
          .difference(previous.unreachableNodeIds);
      final reached = story.nodes
          .map((n) => n.id)
          .toSet()
          .difference(actual.unreachableNodeIds);
      expect(reached.difference(oldReachable),
          story.id == 'cyberpunk_heist' ? {newId} : <String>{});
      expect(oldReachable.difference(reached), isEmpty);
      expect(
          story.nodes
              .where((n) => n.isEnding && reached.contains(n.id))
              .map((n) => n.id)
              .toSet(),
          old.nodes
              .where((n) => n.isEnding && oldReachable.contains(n.id))
              .map((n) => n.id)
              .toSet());
      if (story.id == 'cyberpunk_heist') {
        expect(story.nodes.length, 355);
        expect(reached.length, 314);
        expect(
            story.nodes
                .where((n) => n.isEnding && reached.contains(n.id))
                .length,
            153);
        expect(actual.unreachableNodeIds.length, 41);
        expect(story.nodeById(newId)!.isEnding, isFalse);
        expect(story.nodeById(newId)!.choices.length, 2);
      }
    }
  });

  for (var caseIndex = 0; caseIndex < routes.length; caseIndex++) {
    final path = routes[caseIndex];
    test(
        '2E.4 recorrido completo $caseIndex -> ${path.last}, restauracion, retroceso y reeleccion',
        () async {
      final story = (await StoryCatalog.fromAssets()).byId('cyberpunk_heist')!;
      final store = await ProgressStore.open();
      expect(path.first, story.startNode.id);
      for (var i = 1; i < path.length; i++) {
        final choice = story
            .nodeById(path[i - 1])!
            .choices
            .singleWhere((c) => c.nextNodeId == path[i]);
        await store.moveTo(story, story.nodeById(choice.nextNodeId)!);
        if (path[i] == newId) {
          final reopened = await ProgressStore.open();
          expect(reopened.forStory(story)!.currentNodeId, newId);
          expect(reopened.forStory(story)!.previousNodeIds, path.sublist(0, i));
          expect(reopened.forStory(story)!.completed, isFalse);
          reopened.dispose();
        }
      }
      final reopened = await ProgressStore.open();
      final restored = reopened.forStory(story)!;
      expect(restored.currentNodeId, path.last);
      expect(restored.previousNodeIds, path.sublist(0, path.length - 1));
      expect(restored.completed, isTrue);
      await reopened.back(story);
      expect(reopened.forStory(story)!.currentNodeId, path[path.length - 2]);
      expect(reopened.forStory(story)!.previousNodeIds,
          path.sublist(0, path.length - 2));
      expect(reopened.forStory(story)!.completed, isFalse);
      await reopened.moveTo(story, story.nodeById(path.last)!);
      final record = reopened.forStory(story)!;
      expect(record.previousNodeIds, path.sublist(0, path.length - 1));
      expect(
          record.previousNodeIds.toSet().length, record.previousNodeIds.length);
      store.dispose();
      reopened.dispose();
    });
  }

  for (final id in ['final30', 'final56', 'final32']) {
    test(
        'partida antigua $id: conserva ID e historial sin insertar escena, permite retroceder',
        () async {
      final story = (await StoryCatalog.fromAssets()).byId('cyberpunk_heist')!;
      final trail = id == 'final30'
          ? [...drone, 'node8q']
          : id == 'final32'
              ? [...drone, 'node8r']
              : [...maintenance, 'node8ad'];
      final saved = jsonEncode({
        'cyberpunk_heist': {
          'currentNodeId': id,
          'previousNodeIds': trail,
          'completed': true,
          'lastUpdated': '2026-10-13T12:00:00.000'
        }
      });
      SharedPreferences.setMockInitialValues({'mythos.progress.v1': saved});
      final store = await ProgressStore.open();
      expect(store.forStory(story)!.currentNodeId, id);
      expect(store.forStory(story)!.previousNodeIds, trail);
      expect(store.forStory(story)!.previousNodeIds, isNot(contains(newId)));
      expect(store.forStory(story)!.completed, isTrue);
      expect(
          story.nodeById(id)!.text,
          (phase2e4Manifest['changes'] as List)
              .singleWhere((c) => c['nodeId'] == id)['after']);
      expect(
          (await SharedPreferences.getInstance())
              .getString(ProgressStore.storageKey),
          saved);
      await store.back(story);
      expect(store.forStory(story)!.currentNodeId, trail.last);
      expect(store.forStory(story)!.previousNodeIds,
          trail.sublist(0, trail.length - 1));
      final target = story.nodeById(trail.last)!.choices.first.nextNodeId;
      await store.moveTo(story, story.nodeById(target)!);
      expect(
          store.forStory(story)!.currentNodeId, id == 'final56' ? newId : id);
      expect(store.forStory(story)!.previousNodeIds, trail);
      store.dispose();
    });
  }

  test(
      'causalidad: retirada sin extraccion ficticia, distractores sin trampas, extraccion con accion',
      () async {
    final story = (await StoryCatalog.fromAssets()).byId('cyberpunk_heist')!;
    expect(story.nodeById('node6v')!.text, contains('misión incompleta'));
    expect(
        story.nodeById('final30')!.text,
        allOf(contains('La extracción quedó inconclusa'),
            isNot(contains('datos extraídos'))));
    expect(
        story.nodeById('final32')!.text,
        allOf(contains('la misión no se ha cumplido'),
            isNot(contains('datos extraídos')), isNot(contains('trampas'))));
    expect(
        story.nodeById(newId)!.text,
        allOf(contains('Llegas al núcleo e inicias un hackeo'),
            contains('interrumpirlo y buscar la salida')));
    expect(
        story.nodeById('final56')!.text,
        allOf(
            contains('compruebas la descarga'),
            contains('Logras salir del NeuroBank con los datos'),
            contains('no deshace los daños'),
            isNot(contains('humanidad'))));
  });
}
