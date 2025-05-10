import 'dart:async';
import 'package:get/get.dart';

class TransactionSuccessController extends GetxController {
  final countdown = 5.obs;
  late Timer _timer;

  void startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown.value <= 1) {
        timer.cancel();
        countdown.value = 0;
      } else {
        countdown.value--;
      }
    });
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }
}
