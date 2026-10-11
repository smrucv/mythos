import 'package:flutter_test/flutter_test.dart';
import 'package:mythos/models/story.dart';
import 'package:mythos/services/progress_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final story = StoryCatalog.fromJsonString('''[
    {"id":"demo", "title":"Demo", "category":"Prueba",
     "estimatedDuration":5, "coverImage":"demo.webp", "description":"",
     "nodes":[
       {"id":"n1", "text":"Inicio", "choices":[{"text":"Seguir","nextNodeId":"n2"}]},
       {"id":"n2", "text":"Intermedio", "choices":[{"text":"Final","nextNodeId":"f"}]},
       {"id":"f", "text":"Termino", "choices":[]}
     ]}
  ]''').stories.single;

  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('la clave de progreso usa la identidad Mythos', () {
    expect(ProgressStore.storageKey, 'mythos.progress.v1');
  });

  test('guarda, restaura, deshace decisiones y reinicia', () async {
    final store = await ProgressStore.open();
    expect(store.forStory(story), isNull);
    await store.moveTo(story, story.nodeById('n2')!);
    expect(store.forStory(story)!.previousNodeIds, ['n1']);
    await store.moveTo(story, story.nodeById('f')!);
    expect(store.forStory(story)!.completed, true);

    final restored = await ProgressStore.open();
    expect(restored.forStory(story)!.currentNodeId, 'f');
    expect(restored.forStory(story)!.previousNodeIds, ['n1', 'n2']);
    await restored.back(story);
    expect(restored.forStory(story)!.currentNodeId, 'n2');
    expect(restored.forStory(story)!.completed, false);
    await restored.restart(story);
    expect(restored.forStory(story), isNull);
  });
}
