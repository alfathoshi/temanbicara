// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:temanbicara/app/modules/splash_screen/controllers/splash_screen_controller.dart';
import 'package:temanbicara/app/modules/splash_screen/views/splash_screen_view.dart';
import 'package:temanbicara/app/utils/localstorage.dart';

class MockLocalStorage extends Mock implements LocalStorage {}

class FakeSplashScreenController extends SplashScreenController {
  FakeSplashScreenController()
      : super(
          storage: MockLocalStorage(),
          delay: Duration.zero,
          navigate: (_, {arguments}) {},
        );

  @override
  void handleRouting() {}

  @override
  void onReady() {}
}

void main() {
  testWidgets('Splash shows logo and text', (tester) async {
    await tester.pumpWidget(
      const GetMaterialApp(
        home: SplashScreenView(),
      ),
    );

    expect(find.text('Teman Bicara'), findsOneWidget);
    expect(find.byType(FlutterLogo), findsOneWidget);
  });
}
