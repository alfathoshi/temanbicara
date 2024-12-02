import 'package:get/get.dart';

import '../controllers/transaction_payment_controller.dart';

class TransactionPaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionPaymentController>(
      () => TransactionPaymentController(),
    );
  }
}
