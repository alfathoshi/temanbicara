import 'package:get/get.dart';

import '../controllers/tracking_2_controller.dart';

class Tracking2Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Tracking2Controller>(
      () => Tracking2Controller(),
    );
  }
}
