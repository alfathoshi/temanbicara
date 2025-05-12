import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/colors.dart';

import '../../../config/config.dart';

class Tracking4Controller extends GetxController {
  final box = GetStorage();

  Future<void> storedTracking() async {
    try {
      final userId = box.read('id');
      final token = box.read('token');

      var response = await http.post(
        Uri.parse('${Config.apiEndPoint}/do-tracking'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'sleep_quality': box.read('sleep_quality'),
          'mood_level': box.read('mood_level').toString(),
          'stress_level': box.read('stress_level'),
          'user_id': userId,
        }),
      );
      var data = json.decode(response.body);

      if (response.statusCode == 200 && data['status']) {
        Get.snackbar(
          'Success',
          'Assesment berhasil',
          backgroundColor: primaryColor.withOpacity(0.6),
          colorText: Colors.white,
        );

        Get.offAllNamed(
          Routes.NAVIGATION_BAR,
          arguments: {"indexPage": 0},
        );
      } else {
        Get.snackbar('Error', data['message'],
            backgroundColor: Colors.red.withOpacity(0.6),
            colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to store tracking',
        backgroundColor: error.withOpacity(0.6),
        colorText: Colors.white,
      );
    }
  }
}
