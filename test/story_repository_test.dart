import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mythos/services/story_repository.dart';
import 'package:mythos/services/progress_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _TrackingBundle extends CachingAssetBundle {
  final reads = <String>[];
  bool failNext = false;
  @override
  Future<ByteData> load(String key) => rootBundle.load(key);
  @override
  Future<String> loadString(String key, {bool cache = true}) async {
    reads.add(key);
    if (failNext) {
      failNext = false;
      throw const FormatException('Fallo de prueba');
    }
    return rootBundle.loadString(key, cache: cache);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('solo indice al iniciar; seleccion, concurrencia y cache por historia',
      () async {
    final bundle = _TrackingBundle();
    final repository = await StoryRepository.fromAssets(bundle: bundle);
    expect(bundle.reads, ['assets/stories/index.json']);
    final id = repository.stories.first.id;
    final first = repository.loadStory(id);
    final concurrent = repository.loadStory(id);
    expect(concurrent, same(first));
    final story = (await first)!;
    expect(await concurrent, same(story));
    expect(await repository.loadStory(id), same(story));
    expect(bundle.reads,
        ['assets/stories/index.json', repository.stories.first.storyAsset]);
    expect(await repository.loadStory('inexistente'), isNull);
    expect(bundle.reads.length, 2);
  });

  test('un fallo no bloquea el reintento', () async {
    final bundle = _TrackingBundle();
    final repository = await StoryRepository.fromAssets(bundle: bundle);
    bundle.failNext = true;
    final id = repository.stories.first.id;
    await expectLater(repository.loadStory(id), throwsFormatException);
    expect((await repository.loadStory(id))!.id, id);
    expect(bundle.reads.length, 3);
  });

  test('archivos separados conservan exactamente metadatos, nodos y decisiones',
      () async {
    final original =
        jsonDecode(await rootBundle.loadString('assets/stories/stories.json'))
            as List;
    final repository = await StoryRepository.fromAssets();
    expect(repository.stories.map((s) => s.id), original.map((s) => s['id']));
    var count = 0;
    for (final raw in original) {
      final summary = repository.byId(raw['id'] as String)!;
      final separated =
          jsonDecode(await rootBundle.loadString(summary.storyAsset));
      expect(separated, equals(raw));
      final story = (await repository.loadStory(summary.id))!;
      count += story.nodes.length;
      expect(summary.nodeIds, story.nodes.map((n) => n.id).toSet());
      expect(story.missingNodeIds, isEmpty);
      expect(summary.title, story.title);
      expect(summary.description, story.description);
    }
    expect(count, 593);
  });

  test(
      'biblioteca valida progreso sin cargar narrativa y conserva restauracion',
      () async {
    SharedPreferences.setMockInitialValues({});
    final repository = await StoryRepository.fromAssets();
    final summary = repository.stories.first;
    final story = (await repository.loadStory(summary.id))!;
    final store = await ProgressStore.open();
    final next = story.nodeById(story.startNode.choices.first.nextNodeId)!;
    await store.moveTo(story, next);
    final restored = await ProgressStore.open();
    expect(restored.forSummary(summary)!.currentNodeId, next.id);
    expect(restored.forSummary(summary), same(restored.forStory(story)));
    store.dispose();
    restored.dispose();
  });
}
