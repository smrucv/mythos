import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mythos/models/story.dart';
import 'package:mythos/models/story_diagnostics.dart';
import 'package:mythos/services/progress_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'support/narrative_phase2e2.dart';
import 'support/narrative_phase2e4.dart';

const prefix = ['node1', 'node2a', 'node3a', 'node4b', 'node5c'];
const pact = [...prefix, 'node6f', 'node7k'];
const technician = [
  'node1',
  'node2a',
  'node3b',
  'node4c',
  'node5f',
  'node6k',
  'node8e'
];
const abortSecond = [
  'node1',
  'node2a',
  'node3b',
  'node4d',
  'node5g',
  'node6m',
  'node7r',
  'node8aw',
  'node8ak'
];
const routes = [
  [...pact, 'node9f', 'final134'],
  [...prefix, 'node6f', 'node7l', 'node8ak', 'final57'],
  [...abortSecond, 'final57'],
  [...prefix, 'node6e', 'node7i', 'node9c', 'final128'],
  [...pact, 'node9e', 'final132'],
  [...pact, 'node9e', 'final133'],
  [...pact, 'node9f', 'final135'],
  [...technician, 'final9'],
  [...technician, 'final8'],
];

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('cierre: obtener datos mantiene destino y manifiesto adicional exactos',
      () async {
    final additional = jsonDecode(
        File('docs/ajuste_autorizado_cierre_fase2e2.json')
            .readAsStringSync()) as Map;
    expect(additional['extends'], 'docs/cambios_autorizados_fase2e2.json');
    expect(additional['changes'], [
      {
        'nodeId': 'node7k',
        'path': ['choices', 0, 'text'],
        'before': '[ACUERDO COMPLETO] Cumplir con las condiciones de la IA',
        'after':
            '[OBTENER LOS DATOS] Aprovechar el acceso concedido y obtener la información antes de pagar el precio acordado',
      }
    ]);
    final story = (await StoryCatalog.fromAssets()).byId('cyberpunk_heist')!;
    expect(story.nodeById('node7k')!.choices.first.nextNodeId, 'node9e');
    expect(story.nodeById('node7k')!.choices.first.text,
        (additional['changes'] as List).single['after']);
    expect(story.nodeById('node7k')!.choices[1].nextNodeId, 'node9f');
  });

  test('manifiesto exacto: diez campos autorizados, sin otras diferencias', () {
    final manifest = jsonDecode(
            File('docs/cambios_autorizados_fase2e2.json').readAsStringSync())
        as Map;
    expect(manifest['baseCommit'], 'a66c814');
    expect(manifest['storyId'], 'cyberpunk_heist');
    expect(originalPhase2e2Changes.length, 9);
    expect(phase2e2Changes.length, 10);
    expect(
        phase2e2Changes
            .map((c) => '${c['nodeId']}:${(c['path'] as List).join('.')}')
            .toSet(),
        {
          'final134:text',
          'node8ak:choices.1.nextNodeId',
          'node7k:text',
          'node7k:choices.0.text',
          'node9e:text',
          'node9e:choices.0.text',
          'node9e:choices.1.text',
          'final132:text',
          'final133:text',
          'final9:text',
        });
    // Independent committed baseline: changing the manifest cannot authorize extra content.
    final committed = Process.runSync(
        'git', ['show', 'a66c814:assets/stories/stories.json'],
        stdoutEncoding: utf8);
    expect(committed.exitCode, 0);
    final baseline = jsonDecode(committed.stdout as String) as List;
    final current =
        jsonDecode(File('assets/stories/stories.json').readAsStringSync())
            as List;
    for (final story in baseline) {
      story['nodes'] = [
        for (final node in story['nodes'])
          applyPhase2e2(story['id'], Map<String, dynamic>.from(node))
      ];
    }
    expect(current, applyPhase2e4Catalog(baseline));
  });

  test(
      'misma accesibilidad anterior mas escena autorizada, 355 IDs, 314 accesibles, 153 terminales, sin ciclos',
      () async {
    final old = phase2bFromCurrent();
    final current = await StoryCatalog.fromAssets();
    for (final story in current.stories) {
      final before = old.byId(story.id)!;
      final actual = StoryDiagnostics.inspect(story);
      expect(actual.unreachableNodeIds,
          StoryDiagnostics.inspect(before).unreachableNodeIds);
      expect(actual.cyclicComponents, isEmpty);
      expect(story.missingNodeIds, isEmpty);
      expect(story.nodes.map((n) => n.id).toSet().length, story.nodes.length);
      if (story.id == 'cyberpunk_heist') {
        expect(story.nodes.length, 355);
        expect(actual.unreachableNodeIds.length, 41);
        expect(
            story.nodes
                .where((n) =>
                    n.isEnding && !actual.unreachableNodeIds.contains(n.id))
                .length,
            153);
      }
    }
  });

  for (var index = 0; index < routes.length; index++) {
    final path = routes[index];
    test('recorrido completo E2E.$index -> ${path.last}, guardado y retroceso',
        () async {
      final story = (await StoryCatalog.fromAssets()).byId('cyberpunk_heist')!;
      final store = await ProgressStore.open();
      expect(path.first, story.startNode.id);
      for (var i = 1; i < path.length; i++) {
        expect(story.nodeById(path[i - 1])!.choices.map((c) => c.nextNodeId),
            contains(path[i]));
        await store.moveTo(story, story.nodeById(path[i])!);
      }
      expect(story.nodeById(path.last)!.isEnding, isTrue);
      final reopened = await ProgressStore.open();
      expect(reopened.forStory(story)!.currentNodeId, path.last);
      expect(reopened.forStory(story)!.previousNodeIds,
          path.sublist(0, path.length - 1));
      await reopened.back(story);
      expect(reopened.forStory(story)!.currentNodeId, path[path.length - 2]);
      expect(reopened.forStory(story)!.completed, isFalse);
      store.dispose();
      reopened.dispose();
    });
  }

  test('canon: acceso antes del pago, acciones y consecuencias explícitas',
      () async {
    final story = (await StoryCatalog.fromAssets()).byId('cyberpunk_heist')!;
    String text(String id) => story.nodeById(id)!.text;
    expect(text('node6f'), contains('información a cambio de tu libertad'));
    expect(text('node7k'), contains('Todavía no has entregado tu libertad'));
    expect(text('node9e'),
        contains('aún no has escapado ni entregado tu libertad'));
    expect(story.nodeById('node9e')!.choices.map((c) => c.text).toList(), [
      '[ROMPER EL PACTO] Intentar escapar con los datos sin entregar tu libertad a la IA',
      '[CUMPLIR EL PACTO] Proteger la información y entregar tu libertad como precio del acuerdo',
    ]);
    expect(
        text('final132'),
        allOf(
            contains('La IA detecta tu retirada'),
            contains('Retomas el hackeo'),
            contains('ductos'),
            contains('salir del NeuroBank'),
            contains('conservado tu libertad')));
    expect(
        text('final133'),
        allOf(contains('decides cumplir el acuerdo'), contains('confinado'),
            contains('no consigues sacarla personalmente')));
    expect(
        text('final134'),
        allOf(contains('inicias la fuga'), contains('Te captura'),
            isNot(contains('extraer datos adicionales'))));
    expect(
        text('final9'),
        allOf(contains('Lo dejas atrás'), contains('sales del NeuroBank'),
            isNot(contains('El técnico te traiciona'))));
    final baseline = phase2bFromCurrent().byId(story.id)!;
    for (final id in [
      'node6f',
      'node7b',
      'node9a',
      'final124',
      'final8',
      'final10',
      'final11',
      'final57',
      'final128',
      'final135',
      'final134__v2',
      'final135__v2',
      'final136__v2',
      'final137__v2'
    ]) {
      expect(text(id), baseline.nodeById(id)!.text);
    }
  });

  test('partida antigua en final128 desde abandono no se reinterpreta ni migra',
      () async {
    final story = (await StoryCatalog.fromAssets()).byId('cyberpunk_heist')!;
    final trail = [...prefix, 'node6f', 'node7l', 'node8ak'];
    final saved = jsonEncode({
      'cyberpunk_heist': {
        'currentNodeId': 'final128',
        'previousNodeIds': trail,
        'completed': true,
        'lastUpdated': '2026-10-01T12:00:00.000'
      }
    });
    SharedPreferences.setMockInitialValues({'mythos.progress.v1': saved});
    final store = await ProgressStore.open();
    expect(store.forStory(story)!.currentNodeId, 'final128');
    expect(store.forStory(story)!.previousNodeIds, trail);
    expect(
        (await SharedPreferences.getInstance()).getString('mythos.progress.v1'),
        saved);
    await store.back(story);
    expect(store.forStory(story)!.currentNodeId, 'node8ak');
    await store.moveTo(story,
        story.nodeById(story.nodeById('node8ak')!.choices[1].nextNodeId)!);
    expect(store.forStory(story)!.currentNodeId, 'final57');
    store.dispose();
  });
}
