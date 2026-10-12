import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mythos/models/story.dart';

/// Reconstruye la Fase 1 sin sobrescribir la fixture anterior a sus renombres.
StoryCatalog phase1Catalog() {
  final original = jsonDecode(
      File('test/fixtures/stories_before_integrity_phase1.json')
          .readAsStringSync()) as List;
  final renames = jsonDecode(
      File('docs/renombres_narrativos_fase1.json').readAsStringSync()) as Map;
  final heist =
      original.singleWhere((story) => story['id'] == 'cyberpunk_heist');
  for (final rename in renames['renames'] as List) {
    final node = heist['nodes'][rename['definitionIndex']];
    expect(node['id'], rename['oldId']);
    node['id'] = rename['newId'];
  }
  return StoryCatalog.fromJsonString(jsonEncode(original));
}
