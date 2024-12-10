import 'package:get/get.dart';

import '../controllers/change_language_controller.dart';

class ChangeLanguageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangeLanguageController>(
      () => ChangeLanguageController(),
    );
  }
}
