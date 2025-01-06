import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:temanbicara/app/themes/colors.dart';

import '../../journal/controllers/journal_controller.dart';

class CreateJournalController extends GetxController {
  final box = GetStorage();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  final fetchController = Get.find<JournalController>();

  var sliderValue = 0.0.obs;
  var selectedEmotion = ''.obs;
  final List<String> emotions = [
    'Depresi',
    'Sedih',
    'Netral',
    'Senang',
    'Bahagia'
  ];

  void toggleEmotion(int index) {
    selectedEmotion.value = emotions[index];
  }

  double getOpacity(int index) {
    return selectedEmotion.value == emotions[index] ? 1.0 : 0.5;
  }

  Future<void> submitJournal() async {
    if (titleController.text.isEmpty || bodyController.text.isEmpty) {
      Get.snackbar('Error', 'Title and Body are required',
          backgroundColor: Colors.red.withOpacity(0.6),
          colorText: Colors.white);
      return;
    }

    if (selectedEmotion.isEmpty) {
      Get.snackbar('Error', 'Please select your emotion',
          backgroundColor: Colors.red.withOpacity(0.6),
          colorText: Colors.white);
      return;
    }

    try {
      final userId = box.read('id');

      final token = box.read('token');

      final response = await http.post(
        Uri.parse('http://10.60.0.64:8000/api/v1/journal'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'title': titleController.text,
          'body': bodyController.text,
          'stress_level': sliderValue.value + 1,
          'mood_level': selectedEmotion.value,
          'user_id': userId,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['status']) {
          titleController.clear();
          bodyController.clear();
          sliderValue.value = 0;
          selectedEmotion.value = '';
          Get.back();
          fetchController.fetchJournals();
          Get.snackbar('Success', 'Journal created successfully',
              backgroundColor: primaryColor.withOpacity(0.6),
              colorText: Colors.white);
        } else {
          Get.snackbar(
              'Error', responseData['message'] ?? 'Failed to created journal');
        }
      } else {
        print(response.body);
        var errorData = jsonDecode(response.body);
        print(errorData);
        Get.snackbar(
            'Error', errorData['message'] ?? 'Failed to create journal');
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }
}
