import 'package:flutter/services.dart';

import 'story_validation.dart';

/// Datos narrativos: la unica fuente de verdad es el JSON extraido del APK.
class StoryChoice {
  final String text;
  final String nextNodeId;

  const StoryChoice({required this.text, required this.nextNodeId});

  factory StoryChoice.fromJson(Map<String, dynamic> json,
          {String storyId = '<desconocida>', String affected = 'decision'}) =>
      StoryChoice(
        text: narrativeString(json, 'text', storyId, affected),
        nextNodeId: narrativeString(json, 'nextNodeId', storyId, affected),
      );
}

class StoryNode {
  final String id;
  final String text;
  final String? image;
  final List<StoryChoice> choices;

  const StoryNode({
    required this.id,
    required this.text,
    required this.choices,
    this.image,
  });

  bool get isEnding => choices.isEmpty;

  factory StoryNode.fromJson(Map<String, dynamic> json,
      {String storyId = '<desconocida>', String position = 'nodo'}) {
    final id = narrativeString(json, 'id', storyId, position);
    final affected = '$id ($position)';
    final rawChoices = json['choices'];
    if (json.containsKey('choices') && rawChoices is! List) {
      narrativeError(storyId, affected, 'choices debe ser una lista');
    }
    if (json.containsKey('image') && json['image'] is! String) {
      narrativeError(storyId, affected, 'image debe ser texto');
    }
    return StoryNode(
      id: id,
      text: narrativeString(json, 'text', storyId, affected),
      image: json['image'] is String && (json['image'] as String).isNotEmpty
          ? json['image'] as String
          : null,
      choices: rawChoices is List
          ? [
              for (var i = 0; i < rawChoices.length; i++)
                StoryChoice.fromJson(
                  narrativeObject(
                      rawChoices[i], storyId, '$affected choices[$i]'),
                  storyId: storyId,
                  affected: '$affected choices[$i]',
                ),
            ]
          : const [],
    );
  }
}

class Story implements StoryMetadata {
  @override
  final String id;
  @override
  final String title;
  @override
  final String category;
  @override
  final int estimatedDuration;
  @override
  final String coverImage;
  @override
  final String description;
  final List<StoryNode> nodes;

  /// La construccion valida unicidad antes de crear el indice de lectura.
  late final Map<String, StoryNode> _nodesById = {
    for (final node in nodes) node.id: node,
  };

  Story({
    required this.id,
    required this.title,
    required this.category,
    required this.estimatedDuration,
    required this.coverImage,
    required this.description,
    required List<StoryNode> nodes,
  }) : nodes = List.unmodifiable(nodes) {
    if (id.trim().isEmpty) narrativeError(id, 'id', 'ID de historia vacio');
    if (nodes.isEmpty) narrativeError(id, 'nodes[0]', 'no hay nodo inicial');
    final positions = <String, int>{};
    for (var i = 0; i < nodes.length; i++) {
      final node = nodes[i];
      if (node.id.trim().isEmpty) narrativeError(id, 'nodes[$i]', 'ID vacio');
      if (positions.containsKey(node.id)) {
        narrativeError(id, node.id,
            'ID duplicado en nodes[${positions[node.id]}] y nodes[$i]');
      }
      positions[node.id] = i;
    }
    for (final node in nodes) {
      for (var i = 0; i < node.choices.length; i++) {
        final choice = node.choices[i];
        if (choice.text.trim().isEmpty || choice.nextNodeId.trim().isEmpty) {
          narrativeError(id, '${node.id} choices[$i]', 'decision vacia');
        }
        if (!positions.containsKey(choice.nextNodeId)) {
          narrativeError(id, '${node.id} choices[$i]',
              'destino inexistente "${choice.nextNodeId}"');
        }
      }
    }
  }

  StoryNode get startNode => nodes.first;
  StoryNode? nodeById(String id) => _nodesById[id];

  List<String> get duplicateNodeIds {
    final observed = <String>{};
    final duplicates = <String>{};
    for (final node in nodes) {
      if (!observed.add(node.id)) duplicates.add(node.id);
    }
    return duplicates.toList(growable: false);
  }

  List<String> get missingNodeIds {
    final ids = nodes.map((node) => node.id).toSet();
    final missing = <String>{};
    for (final node in nodes) {
      for (final choice in node.choices) {
        if (!ids.contains(choice.nextNodeId)) missing.add(choice.nextNodeId);
      }
    }
    return missing.toList(growable: false);
  }

  factory Story.fromJson(Map<String, dynamic> json) {
    final id = narrativeStoryId(json);
    final rawNodes = json['nodes'];
    if (rawNodes is! List || rawNodes.isEmpty) {
      narrativeError(
          id, 'nodes[0]', 'nodes debe ser una lista no vacia con inicio');
    }
    return Story(
      id: id,
      title: narrativeString(json, 'title', id, 'title'),
      category: narrativeString(json, 'category', id, 'category'),
      estimatedDuration: narrativeDuration(json, id),
      coverImage: narrativeString(json, 'coverImage', id, 'coverImage'),
      description: narrativeString(json, 'description', id, 'description',
          allowEmpty: true),
      nodes: [
        for (var i = 0; i < rawNodes.length; i++)
          StoryNode.fromJson(narrativeObject(rawNodes[i], id, 'nodes[$i]'),
              storyId: id, position: 'nodes[$i]'),
      ],
    );
  }
}

class StoryCatalog {
  final List<Story> stories;

  const StoryCatalog(this.stories);

  Story? byId(String id) {
    for (final story in stories) {
      if (story.id == id) return story;
    }
    return null;
  }

  static StoryCatalog fromJsonString(String contents) {
    final decoded = decodeNarrative(contents, '<catalogo>', 'historias');
    if (decoded is! List) {
      throw const FormatException('stories.json debe contener una lista.');
    }
    final stories = [
      for (var i = 0; i < decoded.length; i++)
        Story.fromJson(
            narrativeObject(decoded[i], '<catalogo>', 'historias[$i]')),
    ];
    uniqueStoryIds(stories.map((story) => story.id));
    return StoryCatalog(stories);
  }

  static Future<StoryCatalog> fromAssets() async {
    final data = await rootBundle.loadString('assets/stories/stories.json');
    return fromJsonString(data);
  }
}

/// Campos comunes a una historia cargada y a su ficha ligera de biblioteca.
abstract interface class StoryMetadata {
  String get id;
  String get title;
  String get category;
  int get estimatedDuration;
  String get coverImage;
  String get description;
}

class StorySummary implements StoryMetadata {
  @override
  final String id;
  @override
  final String title;
  @override
  final String category;
  @override
  final int estimatedDuration;
  @override
  final String coverImage;
  @override
  final String description;
  final String storyAsset;
  // Permite validar el progreso en biblioteca sin leer los textos narrativos.
  final Set<String> nodeIds;

  const StorySummary(
      {required this.id,
      required this.title,
      required this.category,
      required this.estimatedDuration,
      required this.coverImage,
      required this.description,
      required this.storyAsset,
      required this.nodeIds});

  factory StorySummary.fromJson(Map<String, dynamic> data) {
    final id = narrativeStoryId(data);
    final rawIds = data['nodeIds'];
    if (rawIds is! List || rawIds.isEmpty) {
      narrativeError(id, 'nodeIds', 'debe ser una lista no vacia');
    }
    final ids = <String>{};
    for (var i = 0; i < rawIds.length; i++) {
      final value = rawIds[i];
      if (value is! String || value.trim().isEmpty) {
        narrativeError(id, 'nodeIds[$i]', 'ID debe ser texto no vacio');
      }
      if (!ids.add(value)) narrativeError(id, value, 'ID duplicado en indice');
    }
    return StorySummary(
      id: id,
      title: narrativeString(data, 'title', id, 'title'),
      category: narrativeString(data, 'category', id, 'category'),
      estimatedDuration: narrativeDuration(data, id),
      coverImage: narrativeString(data, 'coverImage', id, 'coverImage'),
      description: narrativeString(data, 'description', id, 'description',
          allowEmpty: true),
      storyAsset: narrativeString(data, 'storyAsset', id, 'storyAsset'),
      nodeIds: Set.unmodifiable(ids),
    );
  }

  factory StorySummary.fromStory(Story story) => StorySummary(
        id: story.id,
        title: story.title,
        category: story.category,
        estimatedDuration: story.estimatedDuration,
        coverImage: story.coverImage,
        description: story.description,
        storyAsset: '',
        nodeIds: story.nodes.map((node) => node.id).toSet(),
      );
}
