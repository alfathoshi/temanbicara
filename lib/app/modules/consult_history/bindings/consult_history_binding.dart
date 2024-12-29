import 'package:get/get.dart';

import '../controllers/consult_history_controller.dart';

class ConsultHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConsultHistoryController>(
      () => ConsultHistoryController(),
    );
  }
}
