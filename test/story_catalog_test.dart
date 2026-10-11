import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import 'package:mythos_recovery/models/story.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('el catalogo recuperado contiene las cuatro historias y 592 nodos',
      () async {
    final catalog = await StoryCatalog.fromAssets();
    expect(catalog.stories.length, 4);
    expect(catalog.stories.fold<int>(0, (total, s) => total + s.nodes.length),
        592);
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

  test('los 12 IDs duplicados originales quedan auditados y sin alterar',
      () async {
    final catalog = await StoryCatalog.fromAssets();
    final problematic = catalog.byId('cyberpunk_heist')!;
    expect(problematic.duplicateNodeIds.length, 12);
    expect(problematic.nodes.length, 354);
    // El codigo de lectura usa la primera entrada en el archivo.
    final first = problematic.nodes.firstWhere(
      (node) => node.id == problematic.duplicateNodeIds.first,
    );
    expect(problematic.nodeById(first.id), same(first));
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
