import 'dart:convert';
import 'dart:io';

import 'support/narrative_phase2e2.dart';
import 'support/narrative_phase2e4.dart';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mythos/models/story.dart';
import 'package:mythos/models/story_diagnostics.dart';
import 'package:mythos/services/progress_store.dart';
import 'package:mythos/services/story_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

Map<String, dynamic> fixture(List<Object?> nodes, {String id = 'demo'}) => {
      'id': id,
      'title': 'Demo',
      'category': 'Prueba',
      'estimatedDuration': 5,
      'coverImage': 'demo.webp',
      'description': '',
      'nodes': nodes,
    };

Map<String, dynamic> node(String id, [List<String> targets = const []]) => {
      'id': id,
      'text': 'Texto $id',
      'choices': [
        for (final target in targets)
          {'text': 'Ir a $target', 'nextNodeId': target},
      ],
    };

Map<String, Map<String, dynamic>> firstDefinitions(Map<String, dynamic> story) {
  final result = <String, Map<String, dynamic>>{};
  for (final item in story['nodes'] as List) {
    final n = Map<String, dynamic>.from(item as Map);
    result.putIfAbsent(n['id'] as String, () => n);
  }
  return result;
}

Set<String> reachable(Map<String, Map<String, dynamic>> graph, String start) {
  final seen = <String>{};
  final pending = [start];
  while (pending.isNotEmpty) {
    final id = pending.removeLast();
    if (!seen.add(id)) continue;
    for (final choice in graph[id]!['choices'] as List? ?? const []) {
      pending.add(choice['nextNodeId'] as String);
    }
  }
  return seen;
}

Map<String, List<String>> histories(
    Map<String, Map<String, dynamic>> graph, String start) {
  final result = <String, List<String>>{start: []};
  final pending = [start];
  for (var i = 0; i < pending.length; i++) {
    final id = pending[i];
    for (final choice in graph[id]!['choices'] as List? ?? const []) {
      final target = choice['nextNodeId'] as String;
      if (!result.containsKey(target)) {
        result[target] = [...result[id]!, id];
        pending.add(target);
      }
    }
  }
  return result;
}

Map<String, dynamic> expectedPhase2Node(String storyId,
    Map<String, dynamic> historical, List<dynamic> authorizedChanges) {
  final expected = jsonDecode(jsonEncode(historical)) as Map<String, dynamic>;
  if (storyId != 'cyberpunk_heist') return expected;
  for (final change in authorizedChanges) {
    if (expected['id'] != change['sourceNodeId']) continue;
    final choice = expected['choices'][change['decisionNumber'] - 1];
    expect(choice['text'], change['choiceText']);
    expect(choice['nextNodeId'], change['from']);
    choice['nextNodeId'] = change['to'];
  }
  return applyPhase2e2(storyId, expected);
}

class MemoryBundle extends CachingAssetBundle {
  final Map<String, String> data;
  MemoryBundle(this.data);
  @override
  Future<ByteData> load(String key) async =>
      ByteData.sublistView(Uint8List.fromList(utf8.encode(data[key]!)));
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('duplicados dentro de historia informan ID, posiciones y causa', () {
    expect(
      () => Story.fromJson(fixture([node('n'), node('n')])),
      throwsA(isA<FormatException>().having(
          (e) => e.message,
          'diagnostico',
          allOf(contains('demo'), contains('n'), contains('duplicado'),
              contains('nodes[0]'), contains('nodes[1]')))),
    );
  });

  test('IDs de nodo compartidos entre historias son validos', () {
    final catalog = StoryCatalog.fromJsonString(jsonEncode([
      fixture([node('n')], id: 'uno'),
      fixture([node('n')], id: 'dos'),
    ]));
    expect(catalog.stories.length, 2);
    expect(
        () => StoryCatalog.fromJsonString(jsonEncode([
              fixture([node('n')]),
              fixture([node('otro')]),
            ])),
        throwsFormatException);
  });

  test('referencia inexistente informa historia, origen y destino', () {
    expect(
        () => Story.fromJson(fixture([
              node('n', ['ausente'])
            ])),
        throwsA(isA<FormatException>().having((e) => e.message, 'diagnostico',
            allOf(contains('demo'), contains('n'), contains('ausente')))));
  });

  test('convergencias y finales compartidos son validos, sin falsos ciclos',
      () {
    final story = Story.fromJson(fixture([
      node('inicio', ['a', 'b', 'fin']),
      node('a', ['comun', 'fin']),
      node('b', ['comun', 'fin']),
      node('comun', ['fin']),
      node('fin'),
    ]));
    final diagnostics = StoryDiagnostics.inspect(story);
    expect(diagnostics.unreachableNodeIds, isEmpty);
    expect(diagnostics.cyclicComponents, isEmpty);
  });

  test('borradores y ciclos son diagnosticos editoriales, no rechazo', () {
    final story = Story.fromJson(fixture([
      node('inicio', ['a', 'fin']),
      node('a', ['inicio']),
      node('fin'),
      node('borrador', ['borrador']),
      node('finalBorrador'),
    ]));
    final d = StoryDiagnostics.inspect(story);
    expect(d.unreachableNodeIds, {'borrador', 'finalBorrador'});
    expect(
        d.cyclicComponents,
        containsAll([
          {'inicio', 'a'},
          {'borrador'},
        ]));
  });

  final malformed = <String, Map<String, dynamic>>{
    'ID de historia vacio': {
      ...fixture([node('n')]),
      'id': ' '
    },
    'ID de nodo vacio': fixture([node(' ')]),
    'ID de nodo numerico': fixture([
      {...node('n'), 'id': 7}
    ]),
    'texto numerico': fixture([
      {...node('n'), 'text': 7}
    ]),
    'choices null': fixture([
      {...node('n'), 'choices': null}
    ]),
    'choices objeto': fixture([
      {...node('n'), 'choices': {}}
    ]),
    'decision no objeto': fixture([
      {
        ...node('n'),
        'choices': [7]
      }
    ]),
    'decision sin texto': fixture([
      {
        ...node('n'),
        'choices': [
          {'nextNodeId': 'n'}
        ]
      }
    ]),
    'decision sin destino': fixture([
      {
        ...node('n'),
        'choices': [
          {'text': 'Ir'}
        ]
      }
    ]),
    'destino vacio': fixture([
      {
        ...node('n'),
        'choices': [
          {'text': 'Ir', 'nextNodeId': ''}
        ]
      }
    ]),
    'destino numerico': fixture([
      {
        ...node('n'),
        'choices': [
          {'text': 'Ir', 'nextNodeId': 1}
        ]
      }
    ]),
    'imagen invalida': fixture([
      {...node('n'), 'image': 42}
    ]),
    'sin inicio': fixture([]),
    'nodo inicial no objeto': fixture([null]),
    'duracion decimal': {
      ...fixture([node('n')]),
      'estimatedDuration': 1.5
    },
    'metadatos invalidos': {
      ...fixture([node('n')]),
      'title': 7
    },
  };
  for (final entry in malformed.entries) {
    test('rechaza estructura: ${entry.key}', () {
      expect(() => Story.fromJson(entry.value), throwsFormatException);
    });
  }

  test('final sin choices sigue siendo valido', () {
    final n = node('fin')..remove('choices');
    expect(Story.fromJson(fixture([n])).startNode.isEnding, isTrue);
  });

  test('JSON malformado informa la historia y el recurso afectado', () async {
    final summary = {
      ...fixture([node('inicio')])
    }..remove('nodes');
    summary.addAll({
      'storyAsset': 'story.json',
      'nodeIds': ['inicio']
    });
    final bundle = MemoryBundle({
      'assets/stories/index.json': jsonEncode([summary]),
      'story.json': '{',
    });
    final repo = await StoryRepository.fromAssets(bundle: bundle);
    await expectLater(
      repo.loadStory('demo'),
      throwsA(isA<FormatException>().having(
          (e) => e.message,
          'diagnostico',
          allOf(contains('demo'), contains('story.json'),
              contains('JSON invalido')))),
    );
  });

  test(
      'cuatro historias conservan contenido salvo los cambios autorizados B1-B4 y 2E.2',
      () async {
    final old = jsonDecode(
        File('test/fixtures/stories_before_integrity_phase1.json')
            .readAsStringSync()) as List;
    final now = applyPhase2e4Catalog(
        jsonDecode(await rootBundle.loadString('assets/stories/stories.json'))
            as List,
        reverse: true);
    final renames = jsonDecode(
        File('docs/renombres_narrativos_fase1.json').readAsStringSync()) as Map;
    final byPosition = {
      for (final row in renames['renames'] as List)
        row['definitionIndex'] as int: row,
    };
    final authorizedChanges = (jsonDecode(
            File('docs/cambios_autorizados_fase2b.json').readAsStringSync())
        as Map)['changes'] as List;
    var total = 0;
    for (var si = 0; si < old.length; si++) {
      final before = Map<String, dynamic>.from(old[si] as Map);
      final after = Map<String, dynamic>.from(now[si] as Map);
      final previousNodes = before['nodes'] as List;
      final newNodes = after['nodes'] as List;
      expect({...after}..remove('nodes'), {...before}..remove('nodes'));
      expect(newNodes.length, previousNodes.length);
      for (var i = 0; i < previousNodes.length; i++) {
        final expected = Map<String, dynamic>.from(previousNodes[i] as Map);
        if (before['id'] == 'cyberpunk_heist' && byPosition.containsKey(i)) {
          expect(expected['id'], byPosition[i]['oldId']);
          expected['id'] = byPosition[i]['newId'];
        }
        expect(
            newNodes[i],
            expectedPhase2Node(
                before['id'] as String, expected, authorizedChanges),
            reason: '${before['id']} nodes[$i]');
      }
      final oldGraph = firstDefinitions(before);
      final newGraph = firstDefinitions(after);
      for (final id in oldGraph.keys) {
        expect(
            newGraph[id],
            expectedPhase2Node(
                before['id'] as String, oldGraph[id]!, authorizedChanges),
            reason: 'Nodo efectivo anterior $id');
      }
      final start = previousNodes.first['id'] as String;
      final expectedReachable = reachable(oldGraph, start);
      if (before['id'] == 'cyberpunk_heist') {
        expectedReachable
            .addAll(authorizedChanges.map((change) => change['to'] as String));
      }
      expect(reachable(newGraph, start), expectedReachable);
      final story = Story.fromJson(after);
      expect(story.duplicateNodeIds, isEmpty);
      expect(story.missingNodeIds, isEmpty);
      total += story.nodes.length;
    }
    expect(total, 592);
  });

  test('partidas anteriores restauran los mismos nodos efectivos e historial',
      () async {
    final before = jsonDecode(
        File('test/fixtures/stories_before_integrity_phase1.json')
            .readAsStringSync()) as List;
    final catalog = await StoryCatalog.fromAssets();
    final repo = await StoryRepository.fromAssets();
    for (final raw in before) {
      final old = Map<String, dynamic>.from(raw as Map);
      final graph = firstDefinitions(old);
      final story = catalog.byId(old['id'] as String)!;
      final playable = reachable(graph, story.startNode.id);
      final previousPaths = histories(graph, story.startNode.id);
      // Cada nodo jugable previo se prueba como nodo actual y como historial.
      for (final id in playable) {
        final completed = (graph[id]!['choices'] as List? ?? []).isEmpty;
        final record = {
          'currentNodeId': id,
          'previousNodeIds': previousPaths[id]!,
          'completed': completed,
          'lastUpdated': '2026-10-01T12:00:00.000',
        };
        final saved = jsonEncode({story.id: record});
        SharedPreferences.setMockInitialValues({'mythos.progress.v1': saved});
        final store = await ProgressStore.open();
        final restored = store.forStory(story)!;
        expect(restored.currentNodeId, id);
        expect(restored.previousNodeIds, record['previousNodeIds']);
        expect(restored.completed, completed);
        expect(store.forSummary(repo.byId(story.id)!)!.currentNodeId, id);
        expect(
            story.nodeById(id)!.text,
            applyPhase2e4Node(
                story.id, applyPhase2e2(story.id, graph[id]!))['text']);
        expect(
            (await SharedPreferences.getInstance())
                .getString('mythos.progress.v1'),
            saved);
        await store.back(story);
        final path = previousPaths[id]!;
        expect(store.forStory(story)!.currentNodeId,
            path.isEmpty ? id : path.last);
        expect(store.forStory(story)!.previousNodeIds,
            path.isEmpty ? const <String>[] : path.sublist(0, path.length - 1));
        store.dispose();
      }
    }
  });

  test('manifiesto editorial coincide con borradores reales', () async {
    final manifest =
        jsonDecode(File('docs/borradores_narrativos.json').readAsStringSync())
            as Map;
    final catalog = await StoryCatalog.fromAssets();
    for (final story in catalog.stories) {
      final editorial = (manifest['stories'] as List)
          .firstWhere((item) => item['storyId'] == story.id);
      final ids = {
        for (final n in editorial['drafts'] as List) n['id'] as String
      };
      expect(ids, StoryDiagnostics.inspect(story).unreachableNodeIds);
    }
  });

  test(
      'repositorio rechaza indice incoherente y datos invalidos sin cachearlos',
      () async {
    final raw = fixture([node('inicio')]);
    final summary = {...raw}..remove('nodes');
    summary.addAll({
      'storyAsset': 'story.json',
      'nodeIds': ['inicio']
    });
    final bundle = MemoryBundle({
      'assets/stories/index.json': jsonEncode([summary]),
      'story.json': jsonEncode(fixture([node('inicio'), node('inicio')]))
    });
    final repo = await StoryRepository.fromAssets(bundle: bundle);
    await expectLater(repo.loadStory('demo'), throwsFormatException);
    bundle.data['story.json'] = jsonEncode(raw);
    // CachingAssetBundle solo cachea resultados correctos de lectura de texto.
    bundle.evict('story.json');
    expect((await repo.loadStory('demo'))!.id, 'demo');
    for (final changed in [
      {...raw, 'id': 'otra'},
      fixture([node('distinto')]),
      {...raw, 'title': 'Otro titulo'},
    ]) {
      final b = MemoryBundle({
        'assets/stories/index.json': jsonEncode([summary]),
        'story.json': jsonEncode(changed)
      });
      final repository = await StoryRepository.fromAssets(bundle: b);
      await expectLater(repository.loadStory('demo'), throwsFormatException);
    }
    for (final badIndex in [
      [summary, summary],
      [
        {
          ...summary,
          'nodeIds': ['inicio', 'inicio']
        }
      ],
      [
        {
          ...summary,
          'nodeIds': ['']
        }
      ],
      [
        {...summary, 'estimatedDuration': 'cinco'}
      ],
    ]) {
      final b =
          MemoryBundle({'assets/stories/index.json': jsonEncode(badIndex)});
      await expectLater(
          StoryRepository.fromAssets(bundle: b), throwsFormatException);
    }
  });
}
