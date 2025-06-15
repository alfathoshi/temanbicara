import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:temanbicara/app/modules/splash_screen/views/splash_screen_view.dart';
import 'package:temanbicara/app/routes/app_pages.dart';

void main() {
  testWidgets('Teman Bicara app renders and routes to splash screen', (tester) async {
    await tester.pumpWidget(
      GetMaterialApp(
        initialRoute: Routes.SPLASH_SCREEN,
        getPages: AppPages.routes,
      ),
    );

    expect(find.byType(SplashScreenView), findsOneWidget);
  });
}
