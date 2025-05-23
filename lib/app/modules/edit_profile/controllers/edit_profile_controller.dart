import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:temanbicara/app/config/config.dart';
import 'package:http/http.dart' as http;

class EditProfileController extends GetxController {
  final box = GetStorage();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  String profileUrl = GetStorage().read('profile_image');

  var isLoading = false.obs;
  var selectedDate = DateTime.now().obs;
  void updateDate(DateTime date) {
    selectedDate.value = DateTime(date.year, date.month, date.day);
  }

  var selectedCountry = ''.obs;
  void setCountry(String country) {
    selectedCountry.value = country;
  }

  Future<void> editProfile() async {
    isLoading.value = true;
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate.value);

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
          'birthdate': formattedDate,
        }),
      );
      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        box.write('name', responseData['data']['name']);
        box.write('email', responseData['data']['email']);
        box.write('birthdate', responseData['data']['birthdate']);

        if (responseData['status']) {
          Get.snackbar('Success', 'Profile data updated successful');
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
    emailController.text = box.read('email');
  }
}
