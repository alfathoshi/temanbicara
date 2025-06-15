import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:temanbicara/app/modules/splash_screen/views/splash_screen_view.dart';

void main() {
  testWidgets('Splash shows logo and text', (tester) async {
    await tester.pumpWidget(
      const GetMaterialApp(
        home: SplashScreenView(),
      ),
    );

    expect(find.text('Teman Bicara'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
  });
}
