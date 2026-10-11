import 'package:flutter/services.dart';

import '../models/story.dart';
import '../models/story_validation.dart';

/// Lee solamente el indice al iniciar; cachea las historias cuando se abren.
class StoryRepository {
  final List<StorySummary> stories;
  final AssetBundle _bundle;
  final Map<String, Story> _loaded = {};
  final Map<String, Future<Story>> _pending = {};

  StoryRepository._(this.stories, this._bundle);

  static Future<StoryRepository> fromAssets({AssetBundle? bundle}) async {
    final assets = bundle ?? rootBundle;
    final decoded = decodeNarrative(
        await assets.loadString('assets/stories/index.json'),
        '<indice>',
        'historias');
    if (decoded is! List) {
      narrativeError('<indice>', 'historias', 'se esperaba una lista');
    }
    final summaries = [
      for (var i = 0; i < decoded.length; i++)
        StorySummary.fromJson(
            narrativeObject(decoded[i], '<indice>', 'historias[$i]')),
    ];
    uniqueStoryIds(summaries.map((story) => story.id));
    return StoryRepository._(summaries, assets);
  }

  factory StoryRepository.fromCatalog(StoryCatalog catalog) {
    uniqueStoryIds(catalog.stories.map((story) => story.id));
    final repository = StoryRepository._(
        catalog.stories.map(StorySummary.fromStory).toList(growable: false),
        rootBundle);
    for (final story in catalog.stories) {
      repository._loaded[story.id] = story;
    }
    return repository;
  }

  StorySummary? byId(String id) {
    for (final story in stories) {
      if (story.id == id) return story;
    }
    return null;
  }

  Future<Story?> loadStory(String id) {
    final summary = byId(id);
    if (summary == null) return Future.value(null);
    final loaded = _loaded[id];
    if (loaded != null) return Future.value(loaded);
    return _pending.putIfAbsent(id, () => _read(summary));
  }

  Future<Story> _read(StorySummary summary) async {
    try {
      final data = decodeNarrative(await _bundle.loadString(summary.storyAsset),
          summary.id, summary.storyAsset);
      final story =
          Story.fromJson(narrativeObject(data, summary.id, summary.storyAsset));
      if (story.id != summary.id) {
        narrativeError(
            summary.id, story.id, 'ID de historia no coincide con el indice');
      }
      final actualIds = story.nodes.map((node) => node.id).toSet();
      if (actualIds.length != summary.nodeIds.length ||
          !actualIds.containsAll(summary.nodeIds)) {
        final difference = {
          ...actualIds.difference(summary.nodeIds),
          ...summary.nodeIds.difference(actualIds)
        };
        narrativeError(summary.id, difference.join(', '),
            'nodeIds no coincide con el indice');
      }
      if (story.title != summary.title ||
          story.category != summary.category ||
          story.estimatedDuration != summary.estimatedDuration ||
          story.coverImage != summary.coverImage ||
          story.description != summary.description) {
        narrativeError(
            summary.id, 'metadatos', 'contenido no coincide con el indice');
      }
      _loaded[story.id] = story;
      return story;
    } finally {
      // Un fallo no queda cacheado: la accion de reintentar vuelve a leer.
      _pending.remove(summary.id);
    }
  }
}
