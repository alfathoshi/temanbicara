import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/colors.dart';

class Assesment7Controller extends GetxController {
  final box = GetStorage();
  var selectedNumber = 0.obs;

  var isLoading = false.obs;

  void selectNumber(int number) {
    selectedNumber.value = number;
    switch (number) {
      case 0:
        box.write('stress_level', 0);
      case 1:
        box.write('stress_level', 1);
      case 2:
        box.write('stress_level', 2);
      case 3:
        box.write('stress_level', 3);
      case 4:
        box.write('stress_level', 4);
      case 5:
        box.write('stress_level', 5);
    }
  }

  Future<void> saveAssesment() async {
    isLoading.value = true;
    try {
      var response = await http.post(
        Uri.parse('http://103.161.185.183:8000/api/v1/do-assessment'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
        body: json.encode({
          'name': box.read('name'),
          'nickname': box.read('nickname'),
          'gender': box.read('gender'),
          'birthdate': box.read('birthdate'),
          'mbti': box.read('mbti'),
          'topics': json.encode(box.read('topics')),
          'goal': box.read('goal'),
          'sleep_quality': box.read('sleep_quality'),
          'have_consulted': box.read('have_consulted'),
          'consumed_medicine': box.read('consumed_medicine'),
          'stress_level': box.read('stress_level'),
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
      Get.snackbar('Error', 'Something went wrong: $e');
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
