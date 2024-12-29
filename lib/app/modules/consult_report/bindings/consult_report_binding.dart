import 'package:get/get.dart';

import '../controllers/consult_report_controller.dart';

class ConsultReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConsultReportController>(
      () => ConsultReportController(),
    );
  }
}
