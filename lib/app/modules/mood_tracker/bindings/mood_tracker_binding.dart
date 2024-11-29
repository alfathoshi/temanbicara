import 'package:get/get.dart';

import '../controllers/mood_tracker_controller.dart';

class MoodTrackerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MoodTrackerController>(
      () => MoodTrackerController(),
    );
  }
}
