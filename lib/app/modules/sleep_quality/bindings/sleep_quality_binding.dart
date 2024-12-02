import 'package:get/get.dart';

import '../controllers/sleep_quality_controller.dart';

class SleepQualityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SleepQualityController>(
      () => SleepQualityController(),
    );
  }
}
