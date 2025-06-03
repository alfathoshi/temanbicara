import 'package:get/get.dart';
import 'package:temanbicara/app/modules/consult/controllers/consult_controller.dart';

import '../../home/controllers/home_controller.dart';
import '../../journal/controllers/journal_controller.dart';
import '../../profile/controllers/profile_controller.dart';
import '../../report/controllers/report_controller.dart';
import '../controllers/navigation_bar_controller.dart';

class NavigationBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavigationBarController>(
      () => NavigationBarController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<ReportController>(
      () => ReportController(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
    Get.lazyPut<JournalController>(
      () => JournalController(),
    );
    Get.lazyPut<ConsultController>(
      () => ConsultController(),
    );
  }
}
