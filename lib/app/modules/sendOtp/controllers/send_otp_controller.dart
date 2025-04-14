import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendOtpController extends GetxController {
  //TODO: Implement SendOtpController
  RxBool isLoading = false.obs;
  RxBool isButtonActive = true.obs;
  TextEditingController emailController = TextEditingController();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
