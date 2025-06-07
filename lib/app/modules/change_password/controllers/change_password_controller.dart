// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:temanbicara/app/widgets/custom_snackbar.dart';

import '../../../config/config.dart';

class ChangePasswordController extends GetxController {
  final box = GetStorage();
  final TextEditingController oldPassController = TextEditingController();
  final TextEditingController newPassController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  RxBool isOldPassObscure = true.obs;
  RxBool isButtonActive = false.obs;
  RxBool isNewPassObscure = true.obs;
  RxBool isConfPassObscure = true.obs;
  RxBool isPasswordValid = false.obs;

  var isLoading = false.obs;

  void showPasswordOld() {
    isOldPassObscure.value = !isOldPassObscure.value;
  }

  void showPasswordNew() {
    isNewPassObscure.value = !isNewPassObscure.value;
  }

  void showPasswordConf() {
    isConfPassObscure.value = !isConfPassObscure.value;
  }

  Future<bool> changePassword() async {
    isLoading.value = true;

    try {
      if (oldPassController.text.isEmpty ||
          newPassController.text.isEmpty ||
          confirmPassController.text.isEmpty) {
        CustomSnackbar.showSnackbar(
          title: "Oops!",
          message: "Please Fill the Fields!",
          status: false,
        );
        return false;
      }
      if (newPassController.text != confirmPassController.text) {
        CustomSnackbar.showSnackbar(
          title: "Password Mismatch!",
          message: "New Password don't Match!",
          status: false,
        );
        return false;
      }

      if (!isPasswordValid.value) {
        isLoading.value = false;
        CustomSnackbar.showSnackbar(
            title: "Invalid Password!",
            message: "Not Strong Enough!",
            status: false);
        return false;
      }

      final userId = box.read('id');
      final token = box.read('token');
      final response = await http.post(
        Uri.parse('${Config.apiEndPoint}/change-password'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'old_password': oldPassController.text,
          'new_password': newPassController.text,
          'confirm_password': confirmPassController.text,
          'user_id': userId.toString(),
        }),
      );
      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        box.write('new_password', responseData['new_password']);
        if (responseData['status']) {
          CustomSnackbar.showSnackbar(
            title: "Yeay!",
            message: "Password Changed!",
            status: true,
          );
          await Future.delayed(Duration(milliseconds: 500));
          Get.back();
          return true;
        } else {
          CustomSnackbar.showSnackbar(
            title: "Oops!",
            message: "Please Fill the Fields!",
            status: false,
          );
          return false;
        }
      } else {
        if (responseData['message'] == "Password lama tidak sesuai") {
          CustomSnackbar.showSnackbar(
            title: "Incorrect Password!",
            message: "Please try Again!",
            status: false,
          );
        }
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  final count = 0.obs;

  void increment() => count.value++;
}
