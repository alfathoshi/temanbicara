import 'package:get/get.dart';

import '../controllers/assesment_6_controller.dart';

class Assesment6Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Assesment6Controller>(
      () => Assesment6Controller(),
    );
  }
}
