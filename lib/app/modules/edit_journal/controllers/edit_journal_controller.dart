import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:temanbicara/app/themes/colors.dart';

import '../../journal/controllers/journal_controller.dart';

class EditJournalController extends GetxController {
  final box = GetStorage();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  final fetchController = Get.find<JournalController>();
  late int journalId;
  var sliderValue = 0.0.obs;
  var selectedEmotion = ''.obs;
  final List<String> emotions = [
    'Depresi',
    'Sedih',
    'Netral',
    'Senang',
    'Bahagia'
  ];

  var isLoading = false.obs;

  void toggleEmotion(int index) {
    selectedEmotion.value = emotions[index];
  }

  double getOpacity(int index) {
    return selectedEmotion.value == emotions[index] ? 1.0 : 0.5;
  }

  Future<void> updateJournal() async {
    if (titleController.text.isEmpty || bodyController.text.isEmpty) {
      Get.snackbar('Error', 'Title and Body are required');
      return;
    }

    if (selectedEmotion.isEmpty) {
      Get.snackbar('Error', 'Please select your emotion');
      return;
    }

    isLoading.value = true;

    try {
      final userId = box.read('id');
      final token = box.read('token');

      final response = await http.put(
        Uri.parse('http://10.60.0.64:8000/api/v1/journal/$journalId'),
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
        print(responseData);

        if (responseData['status']) {
          Get.back();
          fetchController.fetchJournals();
          Get.snackbar('Success', 'Journal updated successfully',
              backgroundColor: primaryColor.withOpacity(0.6),
              colorText: Colors.white);
        } else {
          Get.snackbar(
              'Error', responseData['message'] ?? 'Failed to update journal');
        }
      } else {
        Get.snackbar('Error', 'Failed to update journal.');
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();

    // Initialize the controller with the current journal data passed from previous page
    final arguments = Get.arguments;
    if (arguments != null) {
      journalId = arguments['id'];
      print('Journal ID: $journalId');
      titleController.text = arguments['title'] ?? '';
      bodyController.text = arguments['body'] ?? '';
      sliderValue.value = (arguments['stress_level'] ?? 1).toDouble() - 1;
      selectedEmotion.value = arguments['mood_level'] ?? '';
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    bodyController.dispose();
    super.onClose();
  }
}
