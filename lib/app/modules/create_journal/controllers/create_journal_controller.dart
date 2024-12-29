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

    // final Map<String, dynamic> data = {
    //   'title': titleController.text,
    //   'body': bodyController.text,
    //   'stress_level': sliderValue.value + 1,
    //   'mood_level': selectedEmotion.value,
    // };
    // print(data['mood_level'] is String);

    try {
      final userId = box.read('id');
      print("ppk ${userId}");
      final token = box.read('token');
      print("token  ${token}");
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/v1/journal'),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {
          'title': titleController.text,
          'body': bodyController.text,
          'stress_level': (sliderValue.value + 1).toString(),
          'mood_level': selectedEmotion.value,
          'user_id': userId.toString(),
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['status']) {
          Get.snackbar(
            'Success',
            'Journal created successfully',
          );
          titleController.clear();
          bodyController.clear();
          sliderValue.value = 0;
          selectedEmotion.value = '';
          Get.back();
        } else {
          Get.snackbar(
              'Error', responseData['message'] ?? 'Failed to created journal');
        }
        // Get.snackbar('Success', 'Journal created successfully');
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
