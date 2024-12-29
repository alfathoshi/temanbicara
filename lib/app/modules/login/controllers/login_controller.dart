import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/colors.dart';

class LoginController extends GetxController {
  final box = GetStorage();
  late TextEditingController emailC;
  late TextEditingController passC;
  var isButtonActive = true.obs;
  var isSecure = true.obs;

  void isEmpty() {
    if (passC.text.isNotEmpty && emailC.text.isNotEmpty) {
      isButtonActive(false);
    } else {
      isButtonActive(true);
    }
  }

  void showPassword() {
    isSecure.value = !isSecure.value;
  }

  var isLoading = false.obs;

  Future<void> login() async {
    isLoading.value = true;

    try {
      var response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/v1/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': emailC.text,
          'password': passC.text,
        }),
      );

      var data = json.decode(response.body);

      if (response.statusCode == 200 && data['status']) {
        box.write('token', data['token']);
        box.write('id', data['data']['id']);
        Get.snackbar(
          'Success',
          'Login berhasil',
          backgroundColor: primaryColor.withOpacity(0.6),
          colorText: Colors.white,
        );
        // Get.offAllNamed(
        //   Routes.NAVIGATION_BAR,
        //   arguments: {"indexPage": 0},
        // );

        if (data['data']['name'] == null) {
          Get.toNamed(
            Routes.ASSESMENT_1,
          );
        } else {
          box.write('email', data['data']['email']);
          box.write('password', data['data']['password']);
          box.write('phone', data['data']['phone_number']);
          box.write('name', data['data']['name']);
          box.write('nickname', data['data']['nickname']);
          box.write('birthdate', data['data']['birthdate']);

          Get.offAllNamed(
            Routes.NAVIGATION_BAR,
            arguments: {"indexPage": 0},
          );
        }
      } else {
        Get.snackbar('Error', data['message'],
            backgroundColor: error.withOpacity(0.6), colorText: whiteColor);
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    emailC = TextEditingController();
    passC = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    emailC.dispose();
    passC.dispose();
    super.onClose();
  }
}
