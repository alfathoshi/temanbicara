import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/colors.dart';

import '../../../config/config.dart';

class SignupController extends GetxController {
  late TextEditingController emailC;
  late TextEditingController phoneC;
  late TextEditingController passC;
  late TextEditingController confirmPassC;

  final box = GetStorage();

  var isButtonActive = true.obs;
  var isSecure = true.obs;
  var isSecureC = true.obs;
  var isLoading = false.obs;
  var isPasswordValid = false.obs;

  Future<void> register() async {
    if (!isPasswordValid.value) {
      Get.snackbar(
        'Invalid Password',
        'Your password is not strong enough',
        backgroundColor: Colors.orange.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
      return;
    }
    isLoading.value = true;

    try {
      if (passC.text == confirmPassC.text) {
        var response = await http.post(
          Uri.parse('${Config.apiEndPoint}/register'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'email': emailC.text,
            'phone_number': '+62',
            'password': passC.text,
          }),
        );

        var data = json.decode(response.body);

        if (response.statusCode == 200 && data['status']) {
          box.write('token', data['token']);
          box.write('id', data['data']['id']);
          box.write('email', data['data']['email']);
          box.write('password', data['data']['password']);
          Get.snackbar(
            'Success',
            'Register berhasil',
            backgroundColor: primaryColor.withValues(alpha: 0.6),
            colorText: Colors.white,
          );
          Get.offAllNamed(
            Routes.ASSESMENT_1,
          );
        } else {
          Get.snackbar('Error', data['message'],
              backgroundColor: error.withValues(alpha: 0.6),
              colorText: whiteColor);
        }
      } else {
        Get.snackbar('Error', 'Password tidak sesuai',
            backgroundColor: error.withValues(alpha: 0.6),
            colorText: whiteColor);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to register',
        backgroundColor: error.withValues(alpha: 0.6),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void isEmpty() {
    if (passC.text.isNotEmpty &&
        emailC.text.isNotEmpty &&
        confirmPassC.text.isNotEmpty) {
      isButtonActive.value = true;
    } else {
      isButtonActive.value = false;
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
    phoneC = TextEditingController();
    passC = TextEditingController();
    confirmPassC = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    emailC.dispose();
    phoneC.dispose();
    passC.dispose();
    confirmPassC.dispose();
    super.onClose();
  }
}
