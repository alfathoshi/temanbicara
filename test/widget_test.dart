// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.


import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mockito/mockito.dart';
import 'package:temanbicara/app/modules/splash_screen/views/splash_screen_view.dart';
import 'package:temanbicara/app/routes/app_pages.dart';

class MockGetStorage extends Mock implements GetStorage {}

void main() {
  late MockGetStorage mockStorage;

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    Get.testMode = true;
    mockStorage = MockGetStorage();

    when(mockStorage.read('firstTime')).thenReturn(false);
    when(mockStorage.read('token')).thenReturn(null);

    Get.put<GetStorage>(mockStorage);
  });

  testWidgets('Splash screen test', (tester) async {
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

