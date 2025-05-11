import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:temanbicara/app/themes/colors.dart';

import '../../../config/config.dart';

class ChangePasswordController extends GetxController {
  final box = GetStorage();
  final TextEditingController oldPassController = TextEditingController();
  final TextEditingController newPassController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  RxBool isOldPassObscure = true.obs;
  RxBool isNewPassObscure = true.obs;
  RxBool isConfPassObscure = true.obs;

  var isLoading = false.obs;

  Future<bool> changePassword() async {
    isLoading.value = true;

    try {
      if (oldPassController.text.isEmpty ||
          newPassController.text.isEmpty ||
          confirmPassController.text.isEmpty) {
        Get.snackbar('Error', "Inputtan tidak boleh kosong!",
            backgroundColor: error.withOpacity(0.6), colorText: whiteColor);
        return false;
      }
      final userId = box.read('id');
      final token = box.read('token');
      print(token);
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
      print(response.body);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        box.write('new_password', responseData['new_password']);

        if (responseData['status']) {
          Get.back();
          return true;
        } else {
          Get.snackbar('Error',
              responseData['message'] ?? 'Gagal memperbaharui password');
          return false;
        }
      } else {
        Get.snackbar('Error', 'Gagal memperbaharui password');
        return false;
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  final count = 0.obs;

  void increment() => count.value++;
}
