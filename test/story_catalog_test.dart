import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import 'package:mythos/models/story.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('el catalogo de Mythos contiene las cuatro historias y 593 nodos',
      () async {
    final catalog = await StoryCatalog.fromAssets();
    expect(catalog.stories.length, 4);
    expect(catalog.stories.fold<int>(0, (total, s) => total + s.nodes.length),
        593);
    expect(catalog.stories.map((story) => story.id).toList(), [
      'laberinto_medianoche',
      'odisea_destino',
      'android_secret',
      'cyberpunk_heist',
    ]);
    for (final story in catalog.stories) {
      final coverBytes = await rootBundle.load(story.coverImage);
      expect(coverBytes.lengthInBytes, greaterThan(1000));
      expect(story.nodes, isNotEmpty);
      expect(story.missingNodeIds, isEmpty,
          reason: 'Referencias ausentes: ${story.title}');
      expect(story.nodeById(story.startNode.id), isNotNull);
    }
  });

  test('El Asalto Neon conserva 355 definiciones con IDs unicos', () async {
    final catalog = await StoryCatalog.fromAssets();
    final problematic = catalog.byId('cyberpunk_heist')!;
    expect(problematic.duplicateNodeIds, isEmpty);
    expect(problematic.nodes.length, 355);
    expect(problematic.nodes.map((node) => node.id).toSet().length, 355);
    expect(
        problematic.nodes.where((node) => node.id.endsWith('__v2')).length, 12);
  });

  test('una historia minima admite nodos sin campo choices', () {
    final catalog = StoryCatalog.fromJsonString('''[
      {"id":"prueba", "title":"Prueba", "category":"Demo",
       "estimatedDuration":5, "coverImage":"cover.webp", "description":"",
       "nodes":[{"id":"n1","text":"Fin"}]}
    ]''');
    expect(catalog.stories.single.startNode.isEnding, isTrue);
  });
}
