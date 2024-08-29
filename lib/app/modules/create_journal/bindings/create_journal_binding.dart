import 'package:get/get.dart';

import '../controllers/create_journal_controller.dart';

class CreateJournalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateJournalController>(
      () => CreateJournalController(),
    );
  }
}
