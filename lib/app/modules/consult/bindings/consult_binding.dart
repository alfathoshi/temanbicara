import 'package:get/get.dart';

import '../controllers/consult_controller.dart';

class ConsultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConsultController>(
      () => ConsultController(),
    );
  }
}
