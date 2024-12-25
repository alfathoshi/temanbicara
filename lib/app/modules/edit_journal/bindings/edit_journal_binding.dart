import 'package:get/get.dart';

import '../controllers/edit_journal_controller.dart';

class EditJournalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditJournalController>(
      () => EditJournalController(),
    );
  }
}
