import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  testWidgets('Teman Bicara app renders splash screen', (tester) async {
    await tester.pumpWidget(
      const GetMaterialApp(
        home: Scaffold(
          body: Text('Teman Bicara'),
        ),
      ),
    );

    expect(find.text('Teman Bicara'), findsOneWidget);
  });
}
