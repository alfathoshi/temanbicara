import 'package:get/get.dart';

import '../controllers/assesment_5_controller.dart';

class Assesment5Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Assesment5Controller>(
      () => Assesment5Controller(),
    );
  }
}
