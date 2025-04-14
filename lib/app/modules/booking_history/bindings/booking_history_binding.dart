import 'package:get/get.dart';

import '../controllers/booking_history_controller.dart';

class BookingHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookingHistoryController>(
      () => BookingHistoryController(),
    );
  }
}
