import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mythos/models/story.dart';
import 'package:mythos/models/story_diagnostics.dart';
import 'package:mythos/services/progress_store.dart';
import 'package:mythos/services/story_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'support/narrative_phase1.dart';

const approved = [
  {
    'approval': 'B1',
    'sourceNodeId': 'node8au',
    'definitionIndex': 133,
    'decisionNumber': 1,
    'choiceText': '[ESCAPAR CON DATOS] Iniciar la fuga con los datos extraídos',
    'from': 'final134',
    'to': 'final134__v2',
  },
  {
    'approval': 'B2',
    'sourceNodeId': 'node8au',
    'definitionIndex': 133,
    'decisionNumber': 2,
    'choiceText': '[OCULTAR HUELLAS Y ESCAPAR] Borrar rastros antes de escapar',
    'from': 'final135',
    'to': 'final135__v2',
  },
  {
    'approval': 'B3',
    'sourceNodeId': 'node8av',
    'definitionIndex': 134,
    'decisionNumber': 1,
    'choiceText': '[FINAL FALLIDO] Misión fallida, atrapado por las defensas',
    'from': 'final136',
    'to': 'final136__v2',
  },
  {
    'approval': 'B4',
    'sourceNodeId': 'node8ax',
    'definitionIndex': 136,
    'decisionNumber': 1,
    'choiceText':
        '[ESCAPAR RAPIDAMENTE] Utilizar habilidades para escapar rápidamente',
    'from': 'final137',
    'to': 'final137__v2',
  },
];

const correctedPaths = [
  [
    'node1',
    'node2a',
    'node3b',
    'node4d',
    'node5g',
    'node6m',
    'node7q',
    'node8au',
    'final134__v2'
  ],
  [
    'node1',
    'node2a',
    'node3b',
    'node4d',
    'node5g',
    'node6m',
    'node7q',
    'node8au',
    'final135__v2'
  ],
  [
    'node1',
    'node2a',
    'node3b',
    'node4d',
    'node5g',
    'node6m',
    'node7q',
    'node8av',
    'final136__v2'
  ],
  [
    'node1',
    'node2a',
    'node3b',
    'node4d',
    'node5g',
    'node6m',
    'node7r',
    'node8ax',
    'final137__v2'
  ],
];

const preservedPaths = [
  [
    'node1',
    'node2a',
    'node3a',
    'node4b',
    'node5c',
    'node6f',
    'node7k',
    'node9f',
    'final134'
  ],
  [
    'node1',
    'node2a',
    'node3a',
    'node4b',
    'node5c',
    'node6f',
    'node7k',
    'node9f',
    'final135'
  ],
  [
    'node1',
    'node2b',
    'node3d',
    'node4h',
    'node5m',
    'node6x',
    'node7ad',
    'node9h',
    'final136'
  ],
  [
    'node1',
    'node2b',
    'node3d',
    'node4h',
    'node5m',
    'node6x',
    'node7ad',
    'node9h',
    'final137'
  ],
];

void verifyPath(Story story, List<String> path) {
  expect(path.first, story.startNode.id);
  for (var i = 1; i < path.length; i++) {
    expect(
        story.nodeById(path[i - 1])!.choices.map((choice) => choice.nextNodeId),
        contains(path[i]),
        reason: '${path[i - 1]} -> ${path[i]}');
  }
  expect(story.nodeById(path.last)!.isEnding, isTrue);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('manifiesto autoriza exactamente B1-B4, sin ampliar su alcance',
      () async {
    final manifest = jsonDecode(
        File('docs/cambios_autorizados_fase2b.json').readAsStringSync());
    expect(manifest, {
      'phase': '2B',
      'storyId': 'cyberpunk_heist',
      'source': 'assets/stories/stories.json',
      'changes': approved,
    });
    final before = phase1Catalog().byId('cyberpunk_heist')!;
    final after = (await StoryCatalog.fromAssets()).byId('cyberpunk_heist')!;
    final differences = <String>{};
    for (var i = 0; i < before.nodes.length; i++) {
      final old = before.nodes[i];
      final current = after.nodes[i];
      expect(current.id, old.id);
      expect(current.text, old.text);
      expect(current.image, old.image);
      expect(current.choices.length, old.choices.length);
      for (var k = 0; k < old.choices.length; k++) {
        expect(current.choices[k].text, old.choices[k].text);
        if (current.choices[k].nextNodeId != old.choices[k].nextNodeId) {
          differences.add('${old.id}:${k + 1}');
        }
      }
    }
    expect(differences, {'node8au:1', 'node8au:2', 'node8av:1', 'node8ax:1'});
    for (final change in approved) {
      final old = before.nodes[change['definitionIndex'] as int];
      final current = after.nodes[change['definitionIndex'] as int];
      final choiceIndex = (change['decisionNumber'] as int) - 1;
      expect(old.id, change['sourceNodeId']);
      expect(old.choices[choiceIndex].text, change['choiceText']);
      expect(old.choices[choiceIndex].nextNodeId, change['from']);
      expect(current.choices[choiceIndex].nextNodeId, change['to']);
    }
  });

  test(
      'auditoria real: cuatro historias validas, 313 accesibles y 41 borradores',
      () async {
    final before = phase1Catalog();
    final after = await StoryCatalog.fromAssets();
    var total = 0;
    for (final story in after.stories) {
      final old = before.byId(story.id)!;
      final previous = StoryDiagnostics.inspect(old);
      final actual = StoryDiagnostics.inspect(story);
      expect(story.nodes.length, old.nodes.length);
      expect(story.nodes.map((n) => n.id).toSet().length, story.nodes.length);
      expect(story.duplicateNodeIds, isEmpty);
      expect(story.missingNodeIds, isEmpty);
      expect(actual.cyclicComponents, isEmpty);
      if (story.id == 'cyberpunk_heist') {
        final recovered =
            approved.map((change) => change['to'] as String).toSet();
        expect(old.nodes.length, 354);
        expect(previous.unreachableNodeIds.length, 45);
        expect(actual.unreachableNodeIds.length, 41);
        expect(story.nodes.length - actual.unreachableNodeIds.length, 313);
        expect(
            previous.unreachableNodeIds.difference(actual.unreachableNodeIds),
            recovered);
        expect(
            actual.unreachableNodeIds.difference(previous.unreachableNodeIds),
            isEmpty);
        for (final id in [
          ...recovered,
          'final134',
          'final135',
          'final136',
          'final137'
        ]) {
          expect(actual.unreachableNodeIds, isNot(contains(id)));
        }
      } else {
        expect(actual.unreachableNodeIds, isEmpty);
        expect(actual.unreachableNodeIds, previous.unreachableNodeIds);
      }
      total += story.nodes.length;
      // Salida del diagnostico existente para la auditoria de las cuatro historias.
      debugPrint(jsonEncode({
        'storyId': story.id,
        'definitions': story.nodes.length,
        'uniqueIds': story.nodes.map((n) => n.id).toSet().length,
        'reachable': story.nodes.length - actual.unreachableNodeIds.length,
        'drafts': actual.unreachableNodeIds.length,
        'missingTargets': story.missingNodeIds,
        'cycles': actual.cyclicComponents.length
      }));
    }
    expect(total, 592);
  });

  for (final path in [...correctedPaths, ...preservedPaths]) {
    test('recorrido completo desde inicio hasta ${path.last}', () async {
      final repository = await StoryRepository.fromAssets();
      final story = (await repository.loadStory('cyberpunk_heist'))!;
      verifyPath(story, path);
      final store = await ProgressStore.open();
      expect(store.forStory(story), isNull);
      for (var i = 1; i < path.length; i++) {
        final current =
            store.forStory(story)?.currentNodeId ?? story.startNode.id;
        expect(current, path[i - 1]);
        final choice = story
            .nodeById(current)!
            .choices
            .singleWhere((choice) => choice.nextNodeId == path[i]);
        await store.moveTo(story, story.nodeById(choice.nextNodeId)!);
      }
      final record = store.forStory(story)!;
      expect(record.currentNodeId, path.last);
      expect(record.previousNodeIds, path.sublist(0, path.length - 1));
      expect(record.completed, isTrue);
      final reopened = await ProgressStore.open();
      expect(reopened.forStory(story)!.currentNodeId, path.last);
      expect(reopened.forStory(story)!.previousNodeIds, record.previousNodeIds);
      store.dispose();
      reopened.dispose();
    });
  }

  for (var caseIndex = 0; caseIndex < approved.length; caseIndex++) {
    final change = approved[caseIndex];
    test(
        'partida antigua ${change['from']}: no migra, conserva texto e historial y retrocede',
        () async {
      final before = phase1Catalog().byId('cyberpunk_heist')!;
      final after = (await StoryCatalog.fromAssets()).byId('cyberpunk_heist')!;
      final oldPath = [...correctedPaths[caseIndex]];
      oldPath[oldPath.length - 1] = change['from'] as String;
      verifyPath(before, oldPath);
      final trail = oldPath.sublist(0, oldPath.length - 1);
      final savedRecord = {
        'currentNodeId': change['from'],
        'previousNodeIds': trail,
        'completed': true,
        'lastUpdated': '2026-10-01T12:00:00.000'
      };
      final unrelated = {
        'currentNodeId': 'node1',
        'previousNodeIds': <String>[],
        'completed': false,
        'lastUpdated': '2026-10-01T12:00:00.000'
      };
      final saved = jsonEncode(
          {'cyberpunk_heist': savedRecord, 'laberinto_medianoche': unrelated});
      SharedPreferences.setMockInitialValues({'mythos.progress.v1': saved});
      final store = await ProgressStore.open();
      final restored = store.forStory(after)!;
      expect(ProgressStore.storageKey, 'mythos.progress.v1');
      expect(restored.currentNodeId, change['from']);
      expect(restored.previousNodeIds, trail);
      expect(restored.completed, isTrue);
      expect(restored.lastUpdated,
          DateTime.parse(savedRecord['lastUpdated'] as String));
      expect(after.nodeById(restored.currentNodeId)!.text,
          before.nodeById(change['from'] as String)!.text);
      final preferences = await SharedPreferences.getInstance();
      expect(preferences.getString('mythos.progress.v1'), saved);
      // Deshacer respeta la historia antigua aunque la arista ya haya cambiado.
      await store.back(after);
      expect(store.forStory(after)!.currentNodeId, change['sourceNodeId']);
      expect(store.forStory(after)!.previousNodeIds,
          trail.sublist(0, trail.length - 1));
      expect(store.forStory(after)!.completed, isFalse);
      for (var i = trail.length - 2; i >= 0; i--) {
        await store.back(after);
        expect(store.forStory(after)!.currentNodeId, trail[i]);
        expect(store.forStory(after)!.previousNodeIds, trail.sublist(0, i));
      }
      expect(
          (jsonDecode(preferences.getString('mythos.progress.v1')!)
              as Map)['laberinto_medianoche'],
          unrelated);
      store.dispose();
      // Una partida en la escena anterior tampoco se adelanta automaticamente.
      final originRecord = {
        ...savedRecord,
        'currentNodeId': change['sourceNodeId'],
        'previousNodeIds': trail.sublist(0, trail.length - 1),
        'completed': false
      };
      final originSaved = jsonEncode({'cyberpunk_heist': originRecord});
      SharedPreferences.setMockInitialValues(
          {'mythos.progress.v1': originSaved});
      final originStore = await ProgressStore.open();
      expect(
          originStore.forStory(after)!.currentNodeId, change['sourceNodeId']);
      expect(
          (await SharedPreferences.getInstance())
              .getString('mythos.progress.v1'),
          originSaved);
      final origin = after.nodeById(change['sourceNodeId'] as String)!;
      final choice = origin.choices[(change['decisionNumber'] as int) - 1];
      expect(choice.text, change['choiceText']);
      // Solo una nueva eleccion explicita alcanza el desenlace corregido.
      await originStore.moveTo(after, after.nodeById(choice.nextNodeId)!);
      expect(originStore.forStory(after)!.currentNodeId, change['to']);
      expect(originStore.forStory(after)!.previousNodeIds, trail);
      expect(originStore.forStory(after)!.completed, isTrue);
      originStore.dispose();
    });
  }
}
