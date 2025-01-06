import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/colors.dart';

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

  Future<void> register() async {
    isLoading.value = true;

    try {
      if (passC.text == confirmPassC.text) {
        var response = await http.post(
          Uri.parse('http://10.60.0.64:8000/api/v1/register'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'email': emailC.text,
            'phone_number': phoneC.text,
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
            backgroundColor: primaryColor.withOpacity(0.6),
            colorText: Colors.white,
          );
          Get.offAllNamed(
            Routes.ASSESMENT_1,
          );
        } else {
          Get.snackbar('Error', data['message'],
              backgroundColor: error.withOpacity(0.6), colorText: whiteColor);
        }
      } else {
        Get.snackbar('Error', 'Password tidak sesuai',
            backgroundColor: error.withOpacity(0.6), colorText: whiteColor);
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void isEmpty() {
    if (passC.text.isNotEmpty &&
        phoneC.text.isNotEmpty &&
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
