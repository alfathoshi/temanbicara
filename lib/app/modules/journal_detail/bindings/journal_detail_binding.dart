import 'package:get/get.dart';

import '../controllers/journal_detail_controller.dart';

class JournalDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JournalDetailController>(
      () => JournalDetailController(),
    );
  }
}
