import 'package:get/get.dart';

import '../controllers/tracking_3_controller.dart';

class Tracking3Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Tracking3Controller>(
      () => Tracking3Controller(),
    );
  }
}
