import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'models/story.dart';
import 'screens/library_screen.dart';
import 'screens/story_detail_screen.dart';
import 'screens/story_reader_screen.dart';
import 'services/progress_store.dart';
import 'services/story_repository.dart';
import 'widgets/mythos_theme.dart';
import 'widgets/startup_sequence.dart';

class MythosApp extends StatefulWidget {
  final StoryCatalog? catalog;
  final ProgressStore? progress;
  final bool showStartupSplash;
  final Future<StoryRepository> Function()? loadCatalog;

  const MythosApp({
    super.key,
    this.catalog,
    this.progress,
    this.loadCatalog,
    this.showStartupSplash = true,
  });

  @override
  State<MythosApp> createState() => _MythosAppState();
}

class _MythosAppState extends State<MythosApp> {
  final _data = ValueNotifier<Future<_AppData>?>(null);
  ProgressStore? _ownedProgress;

  @override
  void initState() {
    super.initState();
    // Empezar la E/S despues del primer frame de la animacion Flutter.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _data.value = _load();
    });
  }

  Future<_AppData> _load() async {
    final watch = Stopwatch()..start();
    final repository = widget.catalog == null
        ? (widget.loadCatalog?.call() ?? StoryRepository.fromAssets())
        : Future.value(StoryRepository.fromCatalog(widget.catalog!));
    final progress = widget.progress == null
        ? ProgressStore.open().then((store) {
            if (!mounted) {
              store.dispose();
            } else {
              _ownedProgress = store;
            }
            return store;
          })
        : Future.value(widget.progress!);
    final results = await Future.wait<Object>([repository, progress]);
    assert(() {
      debugPrint(
          'MYTHOS_STARTUP: indice y progreso listos en ${watch.elapsedMilliseconds} ms');
      return true;
    }());
    return _AppData(results[0] as StoryRepository, results[1] as ProgressStore);
  }

  Widget _withData(Widget Function(_AppData) builder) =>
      ValueListenableBuilder<Future<_AppData>?>(
        valueListenable: _data,
        builder: (context, future, _) => FutureBuilder<_AppData>(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const _LoadingScreen();
            }
            if (snapshot.hasError) {
              return _LoadingScreen(
                  error: 'No se pudo abrir la biblioteca.',
                  onRetry: () {
                    _ownedProgress?.dispose();
                    _ownedProgress = null;
                    _data.value = _load();
                  });
            }
            if (!snapshot.hasData) return const _LoadingScreen();
            return builder(snapshot.requireData);
          },
        ),
      );

  late final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
          path: '/',
          builder: (context, state) => _withData((data) =>
              LibraryScreen(catalog: data.catalog, progress: data.progress))),
      GoRoute(
        path: '/story/:id',
        builder: (_, state) => _withData((data) => _StoryRoute(
            key: ValueKey('detail-${state.pathParameters['id']}'),
            data: data,
            id: state.pathParameters['id'] ?? '',
            reading: false)),
        routes: [
          GoRoute(
            path: 'play',
            builder: (_, state) => _withData((data) => _StoryRoute(
                key: ValueKey('reader-${state.pathParameters['id']}'),
                data: data,
                id: state.pathParameters['id'] ?? '',
                reading: true)),
          )
        ],
      ),
    ],
  );

  @override
  void dispose() {
    _router.dispose();
    _data.dispose();
    _ownedProgress?.dispose();
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

class _AppData {
  final StoryRepository catalog;
  final ProgressStore progress;
  const _AppData(this.catalog, this.progress);
}

/// Mantiene la carga fuera de build y acepta rutas directas a lectura.
class _StoryRoute extends StatefulWidget {
  final _AppData data;
  final String id;
  final bool reading;
  const _StoryRoute(
      {super.key, required this.data, required this.id, required this.reading});
  @override
  State<_StoryRoute> createState() => _StoryRouteState();
}

class _StoryRouteState extends State<_StoryRoute> {
  late Future<Story?> _story = widget.data.catalog.loadStory(widget.id);

  @override
  void didUpdateWidget(covariant _StoryRoute oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.id != widget.id ||
        oldWidget.data.catalog != widget.data.catalog) {
      _story = widget.data.catalog.loadStory(widget.id);
    }
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<Story?>(
        future: _story,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const _LoadingScreen();
          }
          if (snapshot.hasError) {
            return _LoadingScreen(
                error: 'No se pudo abrir la historia.',
                onRetry: () => setState(() {
                      _story = widget.data.catalog.loadStory(widget.id);
                    }));
          }
          final story = snapshot.data;
          if (story == null) return const _UnknownStoryScreen();
          return widget.reading
              ? StoryReaderScreen(story: story, progress: widget.data.progress)
              : StoryDetailScreen(story: story, progress: widget.data.progress);
        },
      );
}

class _LoadingScreen extends StatelessWidget {
  final String? error;
  final VoidCallback? onRetry;
  const _LoadingScreen({this.error, this.onRetry});
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
            child: error == null
                ? const CircularProgressIndicator()
                : Column(mainAxisSize: MainAxisSize.min, children: [
                    Text(error!),
                    const SizedBox(height: 16),
                    FilledButton(
                        onPressed: onRetry, child: const Text('Reintentar')),
                    TextButton(
                        onPressed: () => context.go('/'),
                        child: const Text('Volver a la biblioteca')),
                  ])),
      );
}
