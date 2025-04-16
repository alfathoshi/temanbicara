import 'package:get/get.dart';

import '../controllers/send_otp_controller.dart';

class SendOtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SendOtpController>(
      () => SendOtpController(),
    );
  }
}
