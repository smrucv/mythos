import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'models/story.dart';
import 'screens/library_screen.dart';
import 'screens/story_detail_screen.dart';
import 'screens/story_reader_screen.dart';
import 'services/progress_store.dart';
import 'widgets/mythos_theme.dart';
import 'widgets/startup_sequence.dart';

class MythosApp extends StatefulWidget {
  final StoryCatalog catalog;
  final ProgressStore progress;
  final bool showStartupSplash;

  const MythosApp({
    super.key,
    required this.catalog,
    required this.progress,
    this.showStartupSplash = true,
  });

  @override
  State<MythosApp> createState() => _MythosAppState();
}

class _MythosAppState extends State<MythosApp> {
  late final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => LibraryScreen(
          catalog: widget.catalog,
          progress: widget.progress,
        ),
      ),
      GoRoute(
        path: '/story/:id',
        builder: (_, state) {
          final story = widget.catalog.byId(state.pathParameters['id'] ?? '');
          return story == null
              ? const _UnknownStoryScreen()
              : StoryDetailScreen(story: story, progress: widget.progress);
        },
        routes: [
          GoRoute(
            path: 'play',
            builder: (_, state) {
              final story =
                  widget.catalog.byId(state.pathParameters['id'] ?? '');
              return story == null
                  ? const _UnknownStoryScreen()
                  : StoryReaderScreen(story: story, progress: widget.progress);
            },
          ),
        ],
      ),
    ],
  );

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        title: 'Mythos',
        debugShowCheckedModeBanner: false,
        theme: createMythosTheme(),
        routerConfig: _router,
        builder: (context, child) => StartupSequence(
          enabled: widget.showStartupSplash,
          child: child ?? const SizedBox.shrink(),
        ),
      );
}

class _UnknownStoryScreen extends StatelessWidget {
  const _UnknownStoryScreen();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Historia no encontrada')),
        body: Center(
          child: FilledButton(
            onPressed: () => context.go('/'),
            child: const Text('Volver a la biblioteca'),
          ),
        ),
      );
}
