import 'package:get/get.dart';

import '../controllers/mood_report_controller.dart';

class MoodReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MoodReportController>(
      () => MoodReportController(),
    );
  }
}
