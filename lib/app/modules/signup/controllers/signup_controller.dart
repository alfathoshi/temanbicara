import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {

  late TextEditingController emailC;
  late TextEditingController passC;
  late TextEditingController confirmPassC;

  var isButtonActive = true.obs;
  var isSecure = true.obs;
  var isSecureC = true.obs;
  
  void isEmpty() {
    if (passC.text.isNotEmpty &&
        emailC.text.isNotEmpty &&
        confirmPassC.text.isNotEmpty) {
      isButtonActive(false);
    } else {
      isButtonActive(true);
    }
  }

  void showPassword() {
    isSecure.value = !isSecure.value;
  }

  void showPasswordC() {
    isSecureC.value = !isSecureC.value;
  }

  @override
  void onInit() {
    emailC = TextEditingController();
    passC = TextEditingController();
    confirmPassC = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    emailC.dispose();
    passC.dispose();
    confirmPassC.dispose();
    super.onClose();
  }
}
