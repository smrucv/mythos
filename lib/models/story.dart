import 'dart:convert';

import 'package:flutter/services.dart';

/// Datos narrativos: la unica fuente de verdad es el JSON extraido del APK.
class StoryChoice {
  final String text;
  final String nextNodeId;

  const StoryChoice({required this.text, required this.nextNodeId});

  factory StoryChoice.fromJson(Map<String, dynamic> json) => StoryChoice(
        text: (json['text'] ?? '').toString(),
        nextNodeId: (json['nextNodeId'] ?? '').toString(),
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

  factory StoryNode.fromJson(Map<String, dynamic> json) {
    final rawChoices = json['choices'];
    return StoryNode(
      id: (json['id'] ?? '').toString(),
      text: (json['text'] ?? '').toString(),
      image: json['image'] is String && (json['image'] as String).isNotEmpty
          ? json['image'] as String
          : null,
      choices: rawChoices is List
          ? rawChoices
              .map((item) => StoryChoice.fromJson(
                    Map<String, dynamic>.from(item as Map),
                  ))
              .toList(growable: false)
          : const [],
    );
  }
}

class Story {
  final String id;
  final String title;
  final String category;
  final int estimatedDuration;
  final String coverImage;
  final String description;
  final List<StoryNode> nodes;

  /// Mantiene la PRIMERA aparicion de un ID ambiguo, sin modificar el JSON.
  /// No sabemos si el codigo fuente original elegia esta misma estrategia.
  late final Map<String, StoryNode> _nodesById = {
    for (final node in nodes.reversed) node.id: node,
  };

  Story({
    required this.id,
    required this.title,
    required this.category,
    required this.estimatedDuration,
    required this.coverImage,
    required this.description,
    required this.nodes,
  });

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
    final rawNodes = json['nodes'];
    if (rawNodes is! List || rawNodes.isEmpty) {
      throw FormatException('La historia ${json['id']} no contiene nodos.');
    }
    return Story(
      id: (json['id'] ?? '').toString(),
      title: (json['title'] ?? '').toString(),
      category: (json['category'] ?? '').toString(),
      estimatedDuration: (json['estimatedDuration'] as num?)?.toInt() ?? 0,
      coverImage: (json['coverImage'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
      nodes: rawNodes
          .map((item) => StoryNode.fromJson(
                Map<String, dynamic>.from(item as Map),
              ))
          .toList(growable: false),
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
    final decoded = jsonDecode(contents);
    if (decoded is! List) {
      throw const FormatException('stories.json debe contener una lista.');
    }
    return StoryCatalog(decoded
        .map((item) => Story.fromJson(Map<String, dynamic>.from(item as Map)))
        .toList(growable: false));
  }

  static Future<StoryCatalog> fromAssets() async {
    final data = await rootBundle.loadString('assets/stories/stories.json');
    return fromJsonString(data);
  }
}
