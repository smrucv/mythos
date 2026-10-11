import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mythos/app.dart';
import 'package:mythos/models/story.dart';
import 'package:mythos/services/story_repository.dart';
import 'package:mythos/services/progress_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('biblioteca -> detalle -> elecciones -> final -> atras',
      (tester) async {
    SharedPreferences.setMockInitialValues({});
    final store = await ProgressStore.open();
    const fixture = '''[
      {"id":"demo", "title":"Una historia de prueba", "category":"Demo",
       "estimatedDuration":5, "coverImage":"assets/images/library.webp",
       "description":"Una descripcion de prueba.",
       "nodes":[
         {"id":"i","text":"Inicio del relato", "choices":[{"text":"Entrar","nextNodeId":"f"}]},
         {"id":"f","text":"Desenlace del relato", "choices":[]}
       ]}
    ]''';
    final catalog = StoryCatalog.fromJsonString(fixture);
    final bundle = _FixtureBundle(fixture);
    final repository = await StoryRepository.fromAssets(bundle: bundle);

    await tester.pumpWidget(MythosApp(
      loadCatalog: () async => repository,
      progress: store,
      showStartupSplash: false,
    ));
    await tester.pumpAndSettle();
    expect(find.text('Una historia de prueba'), findsOneWidget);
    expect(find.text('MYTHOS'), findsOneWidget);
    expect(bundle.reads, ['assets/stories/index.json']);
    await tester.tap(find.text('Una historia de prueba'));
    await tester.pumpAndSettle();
    expect(find.text('Comenzar aventura'), findsOneWidget);
    expect(bundle.reads, ['assets/stories/index.json', 'demo.json']);
    await tester.tap(find.text('Comenzar aventura'));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('i')), findsOneWidget);
    await tester.tap(find.text('Entrar'));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('f')), findsOneWidget);
    expect(store.forStory(catalog.stories.single)!.completed, isTrue);
    await tester.ensureVisible(find.text('Volver a la decisión anterior'));
    await tester.tap(find.text('Volver a la decisión anterior'));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('i')), findsOneWidget);
    expect(bundle.reads.length, 2);
  });
}

class _FixtureBundle extends CachingAssetBundle {
  final String fixture;
  final reads = <String>[];
  _FixtureBundle(this.fixture);
  @override
  Future<ByteData> load(String key) => rootBundle.load(key);
  @override
  Future<String> loadString(String key, {bool cache = true}) async {
    reads.add(key);
    final story = (jsonDecode(fixture) as List).single as Map<String, dynamic>;
    if (key == 'assets/stories/index.json') {
      return jsonEncode([
        {
          ...story,
          'nodeIds': (story['nodes'] as List).map((n) => n['id']).toList(),
          'storyAsset': 'demo.json'
        }..remove('nodes')
      ]);
    }
    return jsonEncode(story);
  }
}
