import 'package:get/get.dart';

import '../controllers/assesment_7_controller.dart';

class Assesment7Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Assesment7Controller>(
      () => Assesment7Controller(),
    );
  }
}
