import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:temanbicara/app/config/config.dart';
import 'package:temanbicara/app/routes/app_pages.dart';

class ForgotPasswordController extends GetxController {
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  RxBool isCorrect = true.obs;
  RxBool isLoading = false.obs;
  RxBool isButtonActive = false.obs;
  RxBool isNewPassObscure = true.obs;
  RxBool isConfPassObscure = true.obs;

  Future<void> changePassword() async {
    try {
      isLoading.value = true;
      if (confirmPasswordController.text != newPasswordController.text) {
        isLoading.value = false;
        Get.snackbar(
            "Error Occured", "New and confirm password can't be different");
        return;
      }

      var response = await http.post(
        Uri.parse("${Config.apiEndPoint}/password"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
          {
            "otp": Get.arguments['otp'],
            "user_id": Get.arguments['user_id'],
            "new_password": newPasswordController.text,
            "confirm_password": confirmPasswordController.text,
          },
        ),
      );

      Map<String, dynamic> res = json.decode(response.body);

      print(res);

      isCorrect.value = res['status'];

      if (isCorrect.value) {
        isLoading.value = false;
        Get.offAllNamed(
          Routes.LOGIN,
        );
      }
      return;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  final count = 0.obs;

  void increment() => count.value++;
}
