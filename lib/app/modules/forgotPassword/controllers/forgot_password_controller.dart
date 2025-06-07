import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:temanbicara/app/config/config.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/widgets/custom_snackbar.dart';

class ForgotPasswordController extends GetxController {
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  RxBool isCorrect = true.obs;
  RxBool isLoading = false.obs;
  RxBool isButtonActive = false.obs;
  RxBool isNewPassObscure = true.obs;
  RxBool isConfPassObscure = true.obs;
  RxBool isPasswordValid = false.obs;

  void showPasswordC() {
    isConfPassObscure.value = !isConfPassObscure.value;
  }

  Future<void> changePassword() async {
    try {
      if (confirmPasswordController.text.isEmpty ||
          newPasswordController.text.isEmpty) {
        isLoading.value = false;
        CustomSnackbar.showSnackbar(
          title: "Oops!",
          message: "Please Fill the Fields!",
          status: false,
        );
        return;
      }

      if (confirmPasswordController.text != newPasswordController.text) {
        isLoading.value = false;
        CustomSnackbar.showSnackbar(
          title: "Password Mismatch!",
          message: "New password doesn't match!",
          status: false,
        );
        return;
      }

      if (!isPasswordValid.value) {
        isLoading.value = false;
        CustomSnackbar.showSnackbar(
            title: "Invalid Password!",
            message: "Not Strong Enough!",
            status: false);
        return;
      }

      isLoading.value = true;

      var response = await http.post(
        Uri.parse("${Config.apiEndPoint}/password"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "otp": Get.arguments['otp'],
          "user_id": Get.arguments['user_id'],
          "new_password": newPasswordController.text,
          "confirm_password": confirmPasswordController.text,
        }),
      );

      Map<String, dynamic> res = json.decode(response.body);
      isCorrect.value = res['status'];

      if (isCorrect.value) {
        CustomSnackbar.showSnackbar(
          title: "Password Changed!",
          message: "Your password has changed",
          status: true,
        );
        Get.offAllNamed(Routes.LOGIN);
      } else {
        CustomSnackbar.showSnackbar(
          title: "Invalid!",
          message: "OTP is Already Expired!",
          status: false,
        );
        Get.toNamed(Routes.LOGIN);
      }
    } catch (err) {
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
