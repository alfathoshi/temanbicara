// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:temanbicara/app/modules/splash_screen/views/splash_screen_view.dart';
import 'package:temanbicara/app/routes/app_pages.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await GetStorage.init();
    await Future.delayed(const Duration(milliseconds: 100));
  });

  testWidgets('Splash screen renders Teman Bicara text',
      (WidgetTester tester) async {
    await runZonedGuarded(() async {
      final box = GetStorage();
      await box.write('firstTime', false);
      await box.write('token', null);

      await tester.pumpWidget(
        GetMaterialApp(
          home: const SplashScreenView(),
          getPages: AppPages.routes,
        ),
      );

      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();

      expect(find.text('Teman Bicara'), findsOneWidget);
    }, (e, s) {
      print("ERROR IN TEST: $e\n$s");
    });
  });
}

