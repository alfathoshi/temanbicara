import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:temanbicara/app/widgets/custom_snackbar.dart';
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

  Future<bool> editProfile() async {
    isLoading.value = true;
    String birthdate = DateFormat('yyyy-MM-dd').format(selectedDate.value);

    if (nameController.text.isEmpty || nicknameController.text.isEmpty) {
      Get.snackbar('Error', 'name or nickname are required',
          backgroundColor: Colors.red.withValues(alpha: 0.6),
          colorText: Colors.white);
      return false;
    }

    if (nameController.text.length < 3 || nicknameController.text.length < 3) {
      Get.snackbar('Too short', 'Name & Nickname min 3 characters',
          backgroundColor: Colors.red.withValues(alpha: 0.6),
          colorText: Colors.white);
      return false;
    }

    if (nameController.text.length > 255 ||
        nicknameController.text.length > 255) {
      Get.snackbar('Too long', 'Name & Nickname too long',
          backgroundColor: Colors.red.withValues(alpha: 0.6),
          colorText: Colors.white);
      return false;
    }

    final nameRegExp = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameRegExp.hasMatch(nameController.text) ||
        !nameRegExp.hasMatch(nicknameController.text)) {
      Get.snackbar('Invalid Chars', 'Special Character are not allowed',
          backgroundColor: Colors.red.withValues(alpha: 0.6),
          colorText: Colors.white);
      return false;
    }

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
          CustomSnackbar.showSnackbar(
              context: Get.context!,
              title: 'Congrats',
              message: 'Your Profile has been updated',
              status: true);
          return true;
        } else {
          CustomSnackbar.showSnackbar(
              context: Get.context!,
              title: 'Failed',
              message: 'Failed to create journal',
              status: false);
          return false;
        }
      } else {
        CustomSnackbar.showSnackbar(
            context: Get.context!,
            title: 'Failed',
            message: 'Failed to create journal',
            status: false);
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    nameController.text = box.read('name') ?? '';
    nicknameController.text = box.read('nickname') ?? '';
    emailController.text = box.read('email');
    String storedBirthdate = box.read('birthdate');
    storedBirthdate.isNotEmpty
        ? selectedDate.value = DateTime.parse(storedBirthdate)
        : '';
  }
}
