import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:temanbicara/app/themes/colors.dart';

class ChangePasswordController extends GetxController {
  final box = GetStorage();
  final TextEditingController oldPassController = TextEditingController();
  final TextEditingController newPassController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  var isLoading = false.obs;

  Future<void> changePassword() async {
    isLoading.value = true;

    try {
      final userId = box.read('id');
      final token = box.read('token');

      final response = await http.patch(
        Uri.parse('http://10.0.2.2:8000/api/v1/change-password'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'old_password': oldPassController.text,
          'new_password': newPassController.text,
          'confirm_password': confirmPassController.text,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        box.write('new_password', responseData['new_password']);

        if (responseData['status']) {
          Get.snackbar(
            'Success',
            'Password has changed successfully',
            backgroundColor: primaryColor.withOpacity(0.6),
            colorText: whiteColor,
          );
        } else {
          Get.snackbar(
            'Error',
            responseData['message'] ?? 'Failed to update password 1',
            backgroundColor: error.withOpacity(0.6),
            colorText: whiteColor,
          );
        }
      } else {
        Get.snackbar(
          'Error',
          'Failed to update password.',
          backgroundColor: error.withOpacity(0.6),
          colorText: whiteColor,
        );
      }
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error',
        'An error occurred: $e',
        backgroundColor: error.withOpacity(0.6),
        colorText: whiteColor,
      );
    } finally {
      isLoading.value = false;
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
