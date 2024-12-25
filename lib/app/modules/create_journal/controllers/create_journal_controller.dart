import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateJournalController extends GetxController {
  final box = GetStorage();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

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
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    if (selectedEmotion.isEmpty) {
      Get.snackbar('Error', 'Please select your emotion',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    final Map<String, dynamic> data = {
      'title': titleController.text,
      'body': bodyController.text,
      'stress_level': sliderValue.value + 1,
      'mood_level': selectedEmotion.value,
    };
    print(data['mood_level'] is String);

    try {
      final userId = box.read('id');
      print(data['title']);
      print("ppk ${userId}");
      final token = box.read('token');
      print("token  ${token}");
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/v1/journal'),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {
          'title': data['title'],
          'body': data['body'],
          'stress_level': data['stress_level'].toString(),
          'mood_level': data['mood_level'],
          'user_id': userId.toString(),
        },
      );

      if (response.statusCode == 200) {
        // Success
        Get.snackbar('Success', 'Journal created successfully',
            snackPosition: SnackPosition.BOTTOM);
        // Clear inputs
        titleController.clear();
        bodyController.clear();
        sliderValue.value = 0;
        selectedEmotion.value = '';
      } else {
        print(response.body);
        var errorData = jsonDecode(response.body);
        print(errorData);
        Get.snackbar(
            'Error', errorData['message'] ?? 'Failed to create journal',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'An error occurred: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
