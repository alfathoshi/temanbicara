import 'package:get/get.dart';

import '../controllers/stress_level_controller.dart';

class StressLevelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StressLevelController>(
      () => StressLevelController(),
    );
  }
}
