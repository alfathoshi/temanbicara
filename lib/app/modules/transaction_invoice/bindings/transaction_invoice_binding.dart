import 'package:get/get.dart';

import '../controllers/transaction_invoice_controller.dart';

class TransactionInvoiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionInvoiceController>(
      () => TransactionInvoiceController(),
    );
  }
}
