import 'package:flutter/material.dart';

import 'app.dart';
import 'models/story.dart';
import 'services/progress_store.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final catalog = await StoryCatalog.fromAssets();
  final progress = await ProgressStore.open();
  runApp(MythosApp(catalog: catalog, progress: progress));
}
