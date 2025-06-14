// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:temanbicara/app/modules/splash_screen/views/splash_screen_view.dart';
import 'package:temanbicara/app/routes/app_pages.dart';

class DummyGetStorage implements GetStorage {
  final Map<String, dynamic> _store = {};

  @override
  T? read<T>(String key) => _store[key] as T?;

  @override
  Future<void> write(String key, dynamic value) async {
    _store[key] = value;
  }

  @override
  bool hasData(String key) => _store.containsKey(key);

  // Optional: implement other GetStorage members if needed
  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late DummyGetStorage box;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    box = DummyGetStorage(); 
  });

  testWidgets('Splash screen renders Teman Bicara text', (tester) async {
    await box.write('firstTime', false);
    await box.write('token', null);

    await tester.pumpWidget(
      GetMaterialApp(
        home: SplashScreenView(), 
        getPages: AppPages.routes,
      ),
    );

    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    expect(find.text('Teman Bicara'), findsOneWidget);
  });
}
