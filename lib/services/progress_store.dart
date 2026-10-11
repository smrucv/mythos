import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/story.dart';

class StoryProgress {
  final String currentNodeId;
  final List<String> previousNodeIds;
  final bool completed;
  final DateTime lastUpdated;

  const StoryProgress({
    required this.currentNodeId,
    required this.previousNodeIds,
    required this.completed,
    required this.lastUpdated,
  });

  Map<String, dynamic> toJson() => {
        'currentNodeId': currentNodeId,
        'previousNodeIds': previousNodeIds,
        'completed': completed,
        'lastUpdated': lastUpdated.toIso8601String(),
      };

  factory StoryProgress.fromJson(Map<String, dynamic> data) => StoryProgress(
        currentNodeId: (data['currentNodeId'] ?? '').toString(),
        previousNodeIds: (data['previousNodeIds'] as List? ?? const [])
            .map((value) => value.toString())
            .toList(growable: false),
        completed: data['completed'] == true,
        lastUpdated:
            DateTime.tryParse((data['lastUpdated'] ?? '').toString()) ??
                DateTime.fromMillisecondsSinceEpoch(0),
      );
}

/// Persistencia local; deliberadamente no inicia Firebase ni solicita login.
class ProgressStore extends ChangeNotifier {
  static const storageKey = 'mythos.recovery.progress.v1';
  final SharedPreferences _preferences;
  final Map<String, StoryProgress> _progress;

  ProgressStore._(this._preferences, this._progress);

  static Future<ProgressStore> open() async {
    final prefs = await SharedPreferences.getInstance();
    final progress = <String, StoryProgress>{};
    final saved = prefs.getString(storageKey);
    if (saved != null) {
      try {
        final decoded = jsonDecode(saved);
        if (decoded is Map) {
          for (final entry in decoded.entries) {
            if (entry.value is Map) {
              final record = StoryProgress.fromJson(
                Map<String, dynamic>.from(entry.value as Map),
              );
              if (record.currentNodeId.isNotEmpty) {
                progress[entry.key.toString()] = record;
              }
            }
          }
        }
      } on FormatException {
        // No bloquear el arranque si un respaldo previo estaba corrupto.
      } on TypeError {
        // Ignorar datos antiguos que no coincidan con este esquema.
      }
    }
    return ProgressStore._(prefs, progress);
  }

  StoryProgress? forStory(Story story) {
    final record = _progress[story.id];
    if (record == null || story.nodeById(record.currentNodeId) == null) {
      return null;
    }
    return record;
  }

  Future<void> moveTo(Story story, StoryNode nextNode) async {
    final existing = forStory(story);
    final currentId = existing?.currentNodeId ?? story.startNode.id;
    final trail = [...?existing?.previousNodeIds, currentId];
    await _save(
      story.id,
      StoryProgress(
        currentNodeId: nextNode.id,
        previousNodeIds: trail,
        completed: nextNode.isEnding,
        lastUpdated: DateTime.now(),
      ),
    );
  }

  Future<void> back(Story story) async {
    final existing = forStory(story);
    if (existing == null || existing.previousNodeIds.isEmpty) return;
    final trail = [...existing.previousNodeIds];
    final previousId = trail.removeLast();
    final previousNode = story.nodeById(previousId);
    if (previousNode == null) return;
    await _save(
      story.id,
      StoryProgress(
        currentNodeId: previousId,
        previousNodeIds: trail,
        completed: previousNode.isEnding,
        lastUpdated: DateTime.now(),
      ),
    );
  }

  Future<void> restart(Story story) async {
    _progress.remove(story.id);
    await _persist();
  }

  Future<void> _save(String storyId, StoryProgress progress) async {
    _progress[storyId] = progress;
    await _persist();
  }

  Future<void> _persist() async {
    final encoded = jsonEncode(
      _progress.map((key, value) => MapEntry(key, value.toJson())),
    );
    final ok = await _preferences.setString(storageKey, encoded);
    if (!ok) throw StateError('No se pudo guardar el progreso local.');
    notifyListeners();
  }
}
