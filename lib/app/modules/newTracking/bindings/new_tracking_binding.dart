import 'package:get/get.dart';

import '../controllers/new_tracking_controller.dart';

class NewTrackingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewTrackingController>(
      () => NewTrackingController(),
    );
  }
}
