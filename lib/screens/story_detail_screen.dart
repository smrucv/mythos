import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/story.dart';
import '../services/progress_store.dart';
import '../widgets/mythos_theme.dart';
import '../widgets/story_cover.dart';

class StoryDetailScreen extends StatelessWidget {
  final Story story;
  final ProgressStore progress;

  const StoryDetailScreen({
    super.key,
    required this.story,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: progress,
        builder: (context, _) {
          final saved = progress.forStory(story);
          return Scaffold(
            appBar: AppBar(
              title: const Text('DETALLES DE LA HISTORIA',
                  style: TextStyle(fontSize: 13, letterSpacing: 1)),
              leading: IconButton(
                tooltip: 'Biblioteca',
                onPressed: () => context.go('/'),
                icon: const Icon(Icons.arrow_back_rounded),
              ),
            ),
            body: SafeArea(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                children: [
                  StoryCover(story: story, height: 270, darkenBottom: true),
                  const SizedBox(height: 26),
                  Text(
                    story.category.toUpperCase(),
                    style: const TextStyle(
                      color: MythosPalette.gold,
                      fontSize: 12,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    story.title,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 10,
                    runSpacing: 8,
                    children: [
                      _InfoPill(
                        icon: Icons.schedule_rounded,
                        text: '${story.estimatedDuration} min estimados',
                      ),
                      _InfoPill(
                        icon: Icons.alt_route_rounded,
                        text: 'Tus decisiones importan',
                      ),
                      if (saved != null)
                        _InfoPill(
                          icon: saved.completed
                              ? Icons.emoji_events_outlined
                              : Icons.bookmark_outlined,
                          text: saved.completed
                              ? 'Final alcanzado'
                              : '${saved.previousNodeIds.length} elecciones',
                        ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  Text(
                    story.description,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: const Color(0xFFE0DBE9),
                        ),
                  ),
                  if (story.duplicateNodeIds.isNotEmpty) ...[
                    const SizedBox(height: 22),
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.info_outline,
                            color: MythosPalette.gold, size: 18),
                        SizedBox(width: 9),
                        Expanded(
                          child: Text(
                            'Esta historia contiene identificadores de nodo duplicados. '
                            'Algunas rutas pueden no funcionar como se espera.',
                            style: TextStyle(
                              fontSize: 12,
                              color: MythosPalette.muted,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            bottomNavigationBar: SafeArea(
              minimum: const EdgeInsets.fromLTRB(20, 10, 20, 14),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FilledButton.icon(
                    onPressed: () => context.go('/story/${story.id}/play'),
                    icon: Icon(saved == null
                        ? Icons.play_arrow_rounded
                        : Icons.bookmark_added_outlined),
                    label: Text(saved == null
                        ? 'Comenzar aventura'
                        : saved.completed
                            ? 'Ver final alcanzado'
                            : 'Continuar aventura'),
                  ),
                  if (saved != null)
                    TextButton.icon(
                      icon: const Icon(Icons.restart_alt_rounded),
                      label: const Text('Comenzar desde el principio'),
                      onPressed: () => _confirmRestart(context),
                    ),
                ],
              ),
            ),
          );
        },
      );

  Future<void> _confirmRestart(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('¿Reiniciar historia?'),
        content: const Text(
          'Se perderá el progreso guardado de esta historia. '
          'Las otras partidas no se modificarán.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Reiniciar'),
          ),
        ],
      ),
    );
    if (confirm == true) {
      await progress.restart(story);
    }
  }
}

class _InfoPill extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoPill({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: MythosPalette.surfaceRaised,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: MythosPalette.purple),
            const SizedBox(width: 6),
            Text(text, style: const TextStyle(fontSize: 12)),
          ],
        ),
      );
}
