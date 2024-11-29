import 'package:get/get.dart';

import '../controllers/assesment_2_controller.dart';

class Assesment2Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Assesment2Controller>(
      () => Assesment2Controller(),
    );
  }
}
