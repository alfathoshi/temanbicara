import 'package:get/get.dart';

import 'package:temanbicara/app/modules/edit_profile/controllers/datepicker_controller.dart';

import '../controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DatePickerController>(
      () => DatePickerController(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
  }
}
