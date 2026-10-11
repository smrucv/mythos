import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/story.dart';
import '../services/progress_store.dart';
import '../widgets/mythos_theme.dart';
import '../widgets/narrative_text.dart';

class StoryReaderScreen extends StatefulWidget {
  final Story story;
  final ProgressStore progress;

  const StoryReaderScreen({
    super.key,
    required this.story,
    required this.progress,
  });

  @override
  State<StoryReaderScreen> createState() => _StoryReaderScreenState();
}

class _StoryReaderScreenState extends State<StoryReaderScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _working = false;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _runAction(Future<void> Function() action) async {
    if (_working) return;
    setState(() => _working = true);
    try {
      await action();
      if (mounted && _scrollController.hasClients) {
        _scrollController.jumpTo(0);
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se pudo guardar la partida.')),
        );
      }
    } finally {
      if (mounted) setState(() => _working = false);
    }
  }

  Future<void> _restart() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('¿Volver al principio?'),
        content: const Text('Se sustituirá el progreso de esta historia.'),
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
    if (confirmed == true) {
      await _runAction(() => widget.progress.restart(widget.story));
    }
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: widget.progress,
        builder: (context, _) {
          final saved = widget.progress.forStory(widget.story);
          final node = widget.story.nodeById(
                saved?.currentNodeId ?? widget.story.startNode.id,
              ) ??
              widget.story.startNode;
          final step = (saved?.previousNodeIds.length ?? 0) + 1;

          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_rounded),
                tooltip: 'Volver al detalle',
                onPressed: () => context.go('/story/${widget.story.id}'),
              ),
              title: Text(
                widget.story.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 16),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.restart_alt_rounded),
                  tooltip: 'Reiniciar historia',
                  onPressed: _working ? null : _restart,
                ),
              ],
            ),
            body: SafeArea(
              child: ListView(
                key: ValueKey('reader_${widget.story.id}'),
                controller: _scrollController,
                padding: const EdgeInsets.fromLTRB(22, 14, 22, 30),
                children: [
                  Row(
                    children: [
                      const Icon(Icons.auto_stories_outlined,
                          size: 16, color: MythosPalette.gold),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          widget.story.category.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 11,
                            letterSpacing: 1.7,
                            color: MythosPalette.gold,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Text(
                        'PASO $step',
                        style: const TextStyle(
                          color: MythosPalette.muted,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 26),
                  if (node.image != null) ...[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(node.image!, height: 180, fit: BoxFit.cover),
                    ),
                    const SizedBox(height: 24),
                  ],
                  NarrativeText(node.text, key: ValueKey(node.id)),
                  const SizedBox(height: 28),
                  if (node.isEnding) ...[
                    const Divider(color: MythosPalette.surfaceRaised),
                    const SizedBox(height: 18),
                    const Center(
                      child: Column(
                        children: [
                          Icon(Icons.auto_awesome_rounded,
                              color: MythosPalette.gold, size: 36),
                          SizedBox(height: 12),
                          Text(
                            'FIN DE ESTA RUTA',
                            style: TextStyle(
                              letterSpacing: 2.1,
                              fontWeight: FontWeight.w800,
                              color: MythosPalette.gold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Tu aventura ha llegado a un desenlace.',
                            style: TextStyle(color: MythosPalette.muted),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),
                    FilledButton.icon(
                      onPressed: () => context.go('/'),
                      icon: const Icon(Icons.collections_bookmark_outlined),
                      label: const Text('Volver a la biblioteca'),
                    ),
                    const SizedBox(height: 8),
                    OutlinedButton.icon(
                      onPressed: _working ? null : _restart,
                      icon: const Icon(Icons.restart_alt_rounded),
                      label: const Text('Jugar otra vez'),
                    ),
                  ] else ...[
                    const Text(
                      '¿QUÉ DECIDES?',
                      style: TextStyle(
                        letterSpacing: 1.7,
                        color: MythosPalette.gold,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 14),
                    for (var index = 0; index < node.choices.length; index++) ...[
                      _ChoiceTile(
                        index: index + 1,
                        text: node.choices[index].text,
                        enabled: !_working,
                        onTap: () {
                          final targetId = node.choices[index].nextNodeId;
                          final target = widget.story.nodeById(targetId);
                          if (target == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Nodo no disponible: $targetId'),
                              ),
                            );
                            return;
                          }
                          _runAction(
                            () => widget.progress.moveTo(widget.story, target),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                    ],
                  ],
                  if (saved != null && saved.previousNodeIds.isNotEmpty) ...[
                    const SizedBox(height: 20),
                    Center(
                      child: TextButton.icon(
                        onPressed: _working
                            ? null
                            : () => _runAction(
                                  () => widget.progress.back(widget.story),
                                ),
                        icon: const Icon(Icons.undo_rounded),
                        label: const Text('Volver a la decisión anterior'),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      );
}

class _ChoiceTile extends StatelessWidget {
  final int index;
  final String text;
  final bool enabled;
  final VoidCallback onTap;

  const _ChoiceTile({
    required this.index,
    required this.text,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => Material(
        color: MythosPalette.surface,
        borderRadius: BorderRadius.circular(14),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: enabled ? onTap : null,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 17),
            child: Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: MythosPalette.surfaceRaised,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Text(
                    '$index',
                    style: const TextStyle(
                      color: MythosPalette.purple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    text,
                    style: const TextStyle(fontSize: 14, height: 1.48),
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(Icons.chevron_right_rounded,
                    size: 21, color: MythosPalette.purple),
              ],
            ),
          ),
        ),
      );
}
