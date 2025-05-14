import 'package:get/get.dart';

import '../controllers/mental_matrix_controller.dart';

class MentalMatrixBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MentalMatrixController>(
      () => MentalMatrixController(),
    );
  }
}
