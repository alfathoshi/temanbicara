import 'package:get/get.dart';

import '../controllers/consult_schedule_controller.dart';

class ConsultScheduleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConsultScheduleController>(
      () => ConsultScheduleController(),
    );
  }
}
