import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:temanbicara/app/config/config.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/widgets/custom_snackbar.dart';

class SendOtpController extends GetxController {
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
        CustomSnackbar.showSnackbar(
          title: "Failed!",
          message: "Invalid Email!",
          status: false,
        );
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
      if (!data['status']) {
        CustomSnackbar.showSnackbar(
          title: "Invalid!",
          message: "Email is not Recognized!",
          status: false,
        );
        isLoading.value = false;
        return;
      }

      if (!isButtonActive.value) {
        CustomSnackbar.showSnackbar(
          title: "Request Sent",
          message: "Please Check your Email",
          status: true,
        );
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
      CustomSnackbar.showSnackbar(
        title: "Error!",
        message: "Failed to Send OTP!",
        status: false,
      );
    }
  }

  final count = 0.obs;

  void increment() => count.value++;
}
