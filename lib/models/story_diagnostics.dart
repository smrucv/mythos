import 'story.dart';

/// Diagnosticos editoriales; no impiden cargar una historia estructuralmente valida.
class StoryDiagnostics {
  final Set<String> unreachableNodeIds;
  final List<Set<String>> cyclicComponents;

  const StoryDiagnostics(this.unreachableNodeIds, this.cyclicComponents);

  factory StoryDiagnostics.inspect(Story story) {
    final graph = {
      for (final node in story.nodes)
        node.id: node.choices.map((choice) => choice.nextNodeId).toList(),
    };
    final reached = <String>{};
    final pending = [story.startNode.id];
    while (pending.isNotEmpty) {
      final id = pending.removeLast();
      if (reached.add(id)) pending.addAll(graph[id]!);
    }
    var counter = 0;
    final indices = <String, int>{};
    final low = <String, int>{};
    final stack = <String>[];
    final active = <String>{};
    final cycles = <Set<String>>[];
    void visit(String id) {
      indices[id] = low[id] = counter++;
      stack.add(id);
      active.add(id);
      for (final target in graph[id]!) {
        if (!indices.containsKey(target)) {
          visit(target);
          if (low[target]! < low[id]!) low[id] = low[target]!;
        } else if (active.contains(target) && indices[target]! < low[id]!) {
          low[id] = indices[target]!;
        }
      }
      if (low[id] == indices[id]) {
        final component = <String>{};
        String popped;
        do {
          popped = stack.removeLast();
          active.remove(popped);
          component.add(popped);
        } while (popped != id);
        if (component.length > 1 || graph[id]!.contains(id)) {
          cycles.add(Set.unmodifiable(component));
        }
      }
    }

    for (final id in graph.keys) {
      if (!indices.containsKey(id)) visit(id);
    }
    return StoryDiagnostics(
      Set.unmodifiable(graph.keys.toSet().difference(reached)),
      List.unmodifiable(cycles),
    );
  }
}
