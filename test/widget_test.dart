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
  setUp(() async {
    await GetStorage.init();
    final box = GetStorage();
    box.erase();
  });

  testWidgets('Splash screen renders logo and text',
      (WidgetTester tester) async {
    Get.put(SplashScreenController());

    await tester.pumpWidget(
      const GetMaterialApp(
        home: SplashScreenView(),
      ),
    );

    // Cek logo dan teks muncul
    expect(find.text('Teman Bicara'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
  });
}
