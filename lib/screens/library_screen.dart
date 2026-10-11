import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/story.dart';
import '../services/story_repository.dart';
import '../services/progress_store.dart';
import '../widgets/mythos_theme.dart';
import '../widgets/story_cover.dart';

class LibraryScreen extends StatefulWidget {
  final StoryRepository catalog;
  final ProgressStore progress;

  const LibraryScreen({
    super.key,
    required this.catalog,
    required this.progress,
  });

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  String _query = '';
  String _category = 'Todas';

  @override
  Widget build(BuildContext context) {
    final categories = [
      'Todas',
      ...widget.catalog.stories.map((s) => s.category).toSet(),
    ];
    final stories = widget.catalog.stories.where((story) {
      final term = _query.toLowerCase().trim();
      final matchesSearch = term.isEmpty ||
          story.title.toLowerCase().contains(term) ||
          story.description.toLowerCase().contains(term) ||
          story.category.toLowerCase().contains(term);
      return matchesSearch &&
          (_category == 'Todas' || story.category == _category);
    }).toList(growable: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MYTHOS',
          style: TextStyle(
            letterSpacing: 3,
            fontWeight: FontWeight.w900,
            color: MythosPalette.gold,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Acerca de Mythos',
            onPressed: () => showAboutDialog(
              context: context,
              applicationName: 'Mythos',
              applicationVersion: '1.0.0',
              children: [
                const Text(
                  'Historias interactivas en las que cada decisión cuenta. '
                  'Tu progreso se guarda en este dispositivo.',
                ),
              ],
            ),
            icon: const Icon(Icons.info_outline_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 0, 18, 16),
              child: Container(
                height: 178,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0x33EECFA0)),
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      'assets/images/library.webp',
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Color(0xF010101A), Color(0x0010101A)],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'TU BIBLIOTECA',
                              style: TextStyle(
                                color: MythosPalette.gold,
                                fontSize: 11,
                                letterSpacing: 2,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Cada decisión\ncuenta una historia.',
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.w800,
                                height: 1.13,
                                shadows: [
                                  Shadow(color: Colors.black, blurRadius: 12),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: TextField(
                onChanged: (text) => setState(() => _query = text),
                decoration: const InputDecoration(
                  hintText: 'Buscar una historia',
                  prefixIcon: Icon(Icons.search_rounded),
                ),
              ),
            ),
            SizedBox(
              height: 62,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return Center(
                    child: ChoiceChip(
                      label: Text(category),
                      selected: _category == category,
                      onSelected: (_) => setState(() => _category = category),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
              child: Text(
                '${stories.length} historias disponibles',
                style: const TextStyle(
                  color: MythosPalette.muted,
                  fontSize: 12,
                ),
              ),
            ),
            Expanded(
              child: stories.isEmpty
                  ? const Center(child: Text('No hay historias para mostrar.'))
                  : AnimatedBuilder(
                      animation: widget.progress,
                      builder: (context, _) => ListView.separated(
                        padding: const EdgeInsets.fromLTRB(18, 0, 18, 26),
                        itemCount: stories.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final story = stories[index];
                          final saved = widget.progress.forSummary(story);
                          return _StoryCard(
                            story: story,
                            saved: saved,
                            onTap: () => context.go('/story/${story.id}'),
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  final StorySummary story;
  final StoryProgress? saved;
  final VoidCallback onTap;

  const _StoryCard({
    required this.story,
    required this.saved,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => Material(
        color: MythosPalette.surface,
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 106,
                  height: 140,
                  child: StoryCover(story: story),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: SizedBox(
                    height: 140,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          story.category.toUpperCase(),
                          style: const TextStyle(
                            color: MythosPalette.gold,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          story.title,
                          style: const TextStyle(
                            fontSize: 17,
                            height: 1.2,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          story.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: MythosPalette.muted,
                            fontSize: 12,
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Icon(
                              saved == null
                                  ? Icons.auto_stories_outlined
                                  : saved!.completed
                                      ? Icons.check_circle_outline
                                      : Icons.bookmark_added_outlined,
                              size: 15,
                              color: MythosPalette.purple,
                            ),
                            const SizedBox(width: 5),
                            Flexible(
                              child: Text(
                                saved == null
                                    ? '${story.estimatedDuration} min · Nueva'
                                    : saved!.completed
                                        ? 'Final alcanzado'
                                        : 'Continuar partida',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: MythosPalette.purple,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
