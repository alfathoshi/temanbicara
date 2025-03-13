import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:temanbicara/app/modules/edit_profile/controllers/datepicker_controller.dart';
import 'package:http/http.dart' as http;

class EditProfileController extends GetxController {
  final box = GetStorage();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final DatePickerController dateController = Get.put(DatePickerController());

  var isLoading = false.obs;

  var selectedDate = DateTime.now().obs;
  // void updateDate(DateTime date) {
  //   selectedDate.value = date;
  // }

  var selectedCountry = ''.obs;
  void setCountry(String country) {
    selectedCountry.value = country;
  }

  Future<void> editProfile() async {
    print(nameController.text);
    print('asdas ${box.read('name')}');
    isLoading.value = true;
    String formattedDate =
        DateFormat('yyyy-MM-dd').format(dateController.selectedDate.value);

    try {
      final userId = box.read('id');
      final token = box.read('token');

      final response = await http.put(
        Uri.parse('http://www.temanbicara.web.id/api/v1/edit-profile'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': nameController.text,
          'email': emailController.text,
          'birthdate': formattedDate,
          'user_id': userId.toString(),
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print(responseData);
        box.write('name', responseData['name']);
        box.write('email', responseData['email']);
        box.write('birthdate', responseData['birthdate']);

        if (responseData['status']) {
          Get.back();
        } else {
          Get.snackbar(
              'Error', responseData['message'] ?? 'Failed to update profile');
        }
      } else {
        Get.snackbar('Error', 'Failed to update profile.');
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading.value = false;
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    nameController.text = box.read('name');
    emailController.text = box.read('email');
    DateTime tanggal = DateTime.parse(box.read('birthdate'));
    print('asdas ${box.read('name')}');
    // print(dateController.selectedDate.value);
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
