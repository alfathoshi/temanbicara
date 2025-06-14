// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:temanbicara/app/modules/splash_screen/views/splash_screen_view.dart';
import 'package:temanbicara/app/routes/app_pages.dart';

class FakeImageWidget extends StatelessWidget {
  final double? width;
  final double? height;

  const FakeImageWidget({this.width, this.height, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 100,
      height: height ?? 100,
      color: Colors.grey,
    );
  }
}

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
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();

    // Set mock asset handler buat ngehindarin error image not found
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMessageHandler('flutter/assets', (message) async {
      final image = await ui.instantiateImageCodec(
        Uint8List.fromList(List.filled(100, 0)),
        targetWidth: 1,
        targetHeight: 1,
      );
      final frame = await image.getNextFrame();
      final byteData = await frame.image.toByteData(format: ui.ImageByteFormat.png);
      return byteData?.buffer.asByteData();
    });

    await GetStorage.init(); // Init storage beneran, bukan dummy
    final box = GetStorage();
    await box.write('firstTime', false);
    await box.write('token', null);
  });

  testWidgets('Splash screen renders Teman Bicara text', (tester) async {
    await tester.pumpWidget(
      GetMaterialApp(
        home: SplashScreenView(),
        getPages: AppPages.routes,
      ),
    );

    await tester.pump(const Duration(seconds: 3)); // Delay dari splash
    await tester.pumpAndSettle();

    expect(find.text('Teman Bicara'), findsOneWidget);
  });
}
