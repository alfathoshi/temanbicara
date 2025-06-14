import 'package:get/get.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/utils/localstorage.dart';

class SplashScreenController extends GetxController {
  
  final LocalStorage storage;
  final Duration delay;
  final void Function(String route, {dynamic arguments})? navigate;

  SplashScreenController({
    required this.storage,
    this.delay = const Duration(seconds: 3),
    this.navigate,
  });

  void handleRouting() {
    bool isFirstTime = storage.has('firstTime') ? storage.read('firstTime') : true;

    if (isFirstTime) {
      storage.write('firstTime', false);
      _go(Routes.ON_BOARDING);
      return;
    }

    if (storage.read('token') == null) {
      _go(Routes.LOGIN);
    } else if (storage.read('name') == null) {
      _go(Routes.ASSESMENT_1);
    } else {
      _go(Routes.NAVIGATION_BAR, arguments: {'indexPage': 0});
    }
  }

  void _go(String route, {dynamic arguments}) {
    if (navigate != null) {
      navigate!(route, arguments: arguments);
    } else {
      Get.offAllNamed(route, arguments: arguments);
    }
  }

  @override
  void onReady() {
    Future.delayed(delay, handleRouting);
    super.onReady();
  }
}   
