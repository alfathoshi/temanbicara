import 'package:get/get.dart';

import '../controllers/transaction_method_controller.dart';

class TransactionMethodBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionMethodController>(
      () => TransactionMethodController(),
    );
  }
}
