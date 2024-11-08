import 'package:get/get.dart';

import '../controllers/assesment_1_controller.dart';

class Assesment1Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Assesment1Controller>(
      () => Assesment1Controller(),
    );
  }
}
