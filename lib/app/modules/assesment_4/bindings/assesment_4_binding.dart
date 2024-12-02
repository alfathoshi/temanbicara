import 'package:get/get.dart';

import '../controllers/assesment_4_controller.dart';

class Assesment4Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Assesment4Controller>(
      () => Assesment4Controller(),
    );
  }
}
