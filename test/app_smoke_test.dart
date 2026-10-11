import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mythos_recovery/app.dart';
import 'package:mythos_recovery/models/story.dart';
import 'package:mythos_recovery/services/progress_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('biblioteca -> detalle -> elecciones -> final -> atras',
      (tester) async {
    SharedPreferences.setMockInitialValues({});
    final store = await ProgressStore.open();
    final catalog = StoryCatalog.fromJsonString('''[
      {"id":"demo", "title":"Una historia de prueba", "category":"Demo",
       "estimatedDuration":5, "coverImage":"assets/images/library.webp",
       "description":"Una descripcion de prueba.",
       "nodes":[
         {"id":"i","text":"Inicio del relato", "choices":[{"text":"Entrar","nextNodeId":"f"}]},
         {"id":"f","text":"Desenlace del relato", "choices":[]}
       ]}
    ]''');

    await tester.pumpWidget(MythosApp(
      catalog: catalog,
      progress: store,
      showStartupSplash: false,
    ));
    await tester.pumpAndSettle();
    expect(find.text('Una historia de prueba'), findsOneWidget);
    await tester.tap(find.text('Una historia de prueba'));
    await tester.pumpAndSettle();
    expect(find.text('Comenzar aventura'), findsOneWidget);
    await tester.tap(find.text('Comenzar aventura'));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('i')), findsOneWidget);
    await tester.tap(find.text('Entrar'));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('f')), findsOneWidget);
    expect(store.forStory(catalog.stories.single)!.completed, isTrue);
    await tester.ensureVisible(find.text('Volver a la decisión anterior'));
    await tester.tap(find.text('Volver a la decisión anterior'));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('i')), findsOneWidget);
  });
}
