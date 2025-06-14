// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:temanbicara/app/modules/splash_screen/controllers/splash_screen_controller.dart';
import 'package:temanbicara/app/modules/splash_screen/views/splash_screen_view.dart';

void main() {
  setUpAll(() async {
    await GetStorage.init();
  });

  setUp(() async {
    final box = GetStorage();
    await box.erase();
  });

  testWidgets('Splash screen renders Teman Bicara text',
      (WidgetTester tester) async {
    Get.put(SplashScreenController());

    await tester.pumpWidget(
      const GetMaterialApp(
        home: SplashScreenView(),
      ),
    );

    await tester.pump(const Duration(seconds: 3));

    expect(find.text('Teman Bicara'), findsOneWidget);
  });
}
