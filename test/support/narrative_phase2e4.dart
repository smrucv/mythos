import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mythos/models/story.dart';

Map<String, dynamic> get phase2e4Manifest =>
    jsonDecode(File('docs/cambios_autorizados_fase2e4.json').readAsStringSync())
        as Map<String, dynamic>;

Map<String, dynamic> applyPhase2e4Node(
    String storyId, Map<String, dynamic> node,
    {bool reverse = false}) {
  final result = jsonDecode(jsonEncode(node)) as Map<String, dynamic>;
  if (storyId != 'cyberpunk_heist') return result;
  for (final change in phase2e4Manifest['changes'] as List) {
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

List<dynamic> applyPhase2e4Catalog(List<dynamic> raw, {bool reverse = false}) {
  final result = jsonDecode(jsonEncode(raw)) as List;
  for (final story in result) {
    if (story['id'] == 'cyberpunk_heist' && reverse) {
      for (final addition in phase2e4Manifest['addedDefinitions'] as List) {
        final nodes = story['nodes'] as List;
        final index = addition['definitionIndex'] as int;
        expect(nodes.length, index + 1);
        expect(nodes[index], addition['node']);
        nodes.removeAt(index);
      }
    }
    story['nodes'] = [
      for (final node in story['nodes'])
        applyPhase2e4Node(story['id'], Map<String, dynamic>.from(node),
            reverse: reverse),
    ];
    if (story['id'] == 'cyberpunk_heist' && !reverse) {
      for (final addition in phase2e4Manifest['addedDefinitions'] as List) {
        final nodes = story['nodes'] as List;
        expect(nodes.length, addition['definitionIndex']);
        expect(
            nodes.any((node) => node['id'] == addition['node']['id']), isFalse);
        nodes.add(addition['node']);
      }
    }
  }
  return result;
}

StoryCatalog phase2e2FromCurrent() =>
    StoryCatalog.fromJsonString(jsonEncode(applyPhase2e4Catalog(
        jsonDecode(File('assets/stories/stories.json').readAsStringSync())
            as List,
        reverse: true)));
