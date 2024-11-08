import 'package:get/get.dart';

import '../controllers/assesment_3_controller.dart';

class Assesment3Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Assesment3Controller>(
      () => Assesment3Controller(),
    );
  }
}
