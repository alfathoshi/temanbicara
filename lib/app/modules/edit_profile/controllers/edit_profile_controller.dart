import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../../../config/config.dart';
import '../../../themes/colors.dart';

class EditProfileController extends GetxController {
  final box = GetStorage();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  String profileUrl = GetStorage().read('profile_image');
  var isLoading = false.obs;
  var selectedDate = DateTime.now().obs;
  void updateDate(DateTime date) {
    selectedDate.value = DateTime(date.year, date.month, date.day);
  }

  Future<void> editProfile() async {
    isLoading.value = true;

    String birthdate = DateFormat('yyyy-MM-dd').format(selectedDate.value);

    try {
      final token = box.read('token');

      final response = await http.post(
        Uri.parse('${Config.apiEndPoint}/profile'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': nameController.text,
          'email': emailController.text,
          'nickname': nicknameController.text,
          'birthdate': birthdate,
        }),
      );
      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        box.write('name', responseData['data']['name']);
        box.write('email', responseData['data']['email']);
        box.write('nickname', responseData['data']['nickname']);
        box.write('birthdate', responseData['data']['birthdate']);

        if (responseData['status']) {
          Get.snackbar('Success', 'Profile data updated successful',
              backgroundColor: primaryColor.withValues(alpha: 0.6),
              colorText: Colors.white);
        } else {
          Get.snackbar(
              'Error', responseData['message'] ?? 'Failed to update profile');
        }
      } else {
        Get.snackbar('Error', 'Failed to update profile.');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    nameController.text = box.read('name');
    nicknameController.text = box.read('nickname');
    emailController.text = box.read('email');
    String storedBirthdate = box.read('birthdate');
    storedBirthdate.isNotEmpty
        ? selectedDate.value = DateTime.parse(storedBirthdate)
        : '';
  }
}
