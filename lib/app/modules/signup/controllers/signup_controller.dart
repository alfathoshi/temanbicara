import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  //TODO: Implement SignupController

  late TextEditingController emailC;
  late TextEditingController passC;
  late TextEditingController usernameC;
  late TextEditingController confirmPassC;
  var isButtonActive = true.obs;
  var isSecure = true.obs;
  var isSecureC = true.obs;
  void isEmpty() {
    if (passC.text.isNotEmpty &&
        emailC.text.isNotEmpty &&
        usernameC.text.isNotEmpty &&
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
    // TODO: implement onInit
    emailC = TextEditingController();
    passC = TextEditingController();
    usernameC = TextEditingController();
    confirmPassC = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    usernameC.dispose();
    emailC.dispose();
    passC.dispose();
    confirmPassC.dispose();
    super.onClose();
  }
}
