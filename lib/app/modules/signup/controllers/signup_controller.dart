import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/widgets/custom_snackbar.dart';

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

  bool validateEmail(String value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value.isNotEmpty && !regex.hasMatch(value);
  }

  Future<void> register() async {
    if (emailC.text.isEmpty ||
        confirmPassC.text.isEmpty ||
        passC.text.isEmpty) {
      CustomSnackbar.showSnackbar(
          title: "Oops!", message: "Please Fill the Fields!", status: false);
      return;
    }

    if (validateEmail(emailC.text)) {
      CustomSnackbar.showSnackbar(
        title: "Invalid!",
        message: "Invalid Email!",
        status: false,
      );
      return;
    }

    if (!isPasswordValid.value) {
      CustomSnackbar.showSnackbar(
          title: "Invalid Password!",
          message: "Not Strong Enough!",
          status: false);
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
        //print(response.body);
        if (response.statusCode == 200 && data['status']) {
          box.write('token', data['token']);
          box.write('id', data['data']['id']);
          box.write('email', data['data']['email']);
          box.write('password', data['data']['password']);
          CustomSnackbar.showSnackbar(
            title: "Success!",
            message: "Registered!",
            status: true,
          );
          Get.offAllNamed(
            Routes.ASSESMENT_1,
          );
        } else {
          CustomSnackbar.showSnackbar(
            title: "Invalid!",
            message: "Invalid Email!",
            status: false,
          );
        }
      } else {
        CustomSnackbar.showSnackbar(
          title: "Password Mismatch!",
          message: "New Password don't Match!",
          status: false,
        );
      }
    } catch (e) {
      CustomSnackbar.showSnackbar(
        title: "Oops!",
        message: "Failed to Register!",
        status: false,
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
