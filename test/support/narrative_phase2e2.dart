import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mythos/models/story.dart';

List<dynamic> get originalPhase2e2Changes => (jsonDecode(
        File('docs/cambios_autorizados_fase2e2.json').readAsStringSync())
    as Map)['changes'] as List;

List<dynamic> get phase2e2Changes => [
      ...originalPhase2e2Changes,
      ...(jsonDecode(File('docs/ajuste_autorizado_cierre_fase2e2.json')
          .readAsStringSync()) as Map)['changes'] as List,
    ];

Map<String, dynamic> applyPhase2e2(String storyId, Map<String, dynamic> node,
    {bool reverse = false}) {
  final result = jsonDecode(jsonEncode(node)) as Map<String, dynamic>;
  if (storyId != 'cyberpunk_heist') return result;
  for (final change in phase2e2Changes) {
    if (change['nodeId'] != result['id']) continue;
    final path = change['path'] as List;
    dynamic parent = result;
    for (final key in path.take(path.length - 1)) {
      parent = parent[key];
    }
    expect(parent[path.last], change[reverse ? 'after' : 'before']);
    parent[path.last] = change[reverse ? 'before' : 'after'];
  }
  return result;
}

StoryCatalog phase2bFromCurrent() {
  final raw = jsonDecode(File('assets/stories/stories.json').readAsStringSync())
      as List;
  for (final story in raw) {
    story['nodes'] = [
      for (final node in story['nodes'])
        applyPhase2e2(story['id'], Map<String, dynamic>.from(node),
            reverse: true)
    ];
  }
  return StoryCatalog.fromJsonString(jsonEncode(raw));
}
