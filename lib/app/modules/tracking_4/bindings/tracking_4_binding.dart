import 'package:get/get.dart';

import '../controllers/tracking_4_controller.dart';

class Tracking4Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Tracking4Controller>(
      () => Tracking4Controller(),
    );
  }
}
