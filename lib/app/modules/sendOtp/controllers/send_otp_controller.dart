import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:temanbicara/app/config/config.dart';
import 'package:temanbicara/app/routes/app_pages.dart';

class SendOtpController extends GetxController {
  //TODO: Implement SendOtpController
  RxBool isLoading = false.obs;
  RxBool isButtonActive = true.obs;
  TextEditingController emailController = TextEditingController();

  bool validateEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  Future<void> sendOtp() async {
    isLoading.value = true;
    try {
      if (!validateEmail(emailController.text)) {
        isLoading.value = false;
        Get.snackbar("Invalid Email", "Please enter a valid email");
        return;
      }

      var response = await http.post(
        Uri.parse("${Config.apiEndPoint}/password/otp"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': emailController.text,
        }),
      );

      var data = json.decode(response.body);

      if (!isButtonActive.value) {
        isLoading.value = false;
        Get.toNamed(
          Routes.VERIFY_OTP,
          arguments: {
            "email": emailController.text,
            "user_id": data!['user_id']
          },
        );
      }
      isLoading.value = false;
      return;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

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
