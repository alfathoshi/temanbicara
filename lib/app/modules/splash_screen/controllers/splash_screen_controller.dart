import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:temanbicara/app/routes/app_pages.dart';

class SplashScreenController extends GetxController {
  final box = GetStorage();

  void handleRouting() {
    bool isFirstTime = box.hasData('firstTime') ? box.read('firstTime') : true;

    if (isFirstTime) {
      box.write('firstTime', false);
      Get.offAllNamed(Routes.ON_BOARDING);
      return;
    }

    if (box.read('token') == null) {
      Get.offAllNamed(Routes.LOGIN);
    } else if (box.read('name') == null) {
      Get.offAllNamed(Routes.ASSESMENT_1);
    } else {
      Get.offAllNamed(Routes.NAVIGATION_BAR, arguments: {'indexPage': 0});
    }
  }

  @override
  void onReady() {
    Future.delayed(const Duration(seconds: 3), handleRouting);
    super.onReady();
  }
}
