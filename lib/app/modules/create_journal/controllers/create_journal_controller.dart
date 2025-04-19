import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:convert';

import 'package:temanbicara/app/themes/colors.dart';

import '../../../config/config.dart';
import '../../journal/controllers/journal_controller.dart';

class CreateJournalController extends GetxController {
  final box = GetStorage();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  final fetchController = Get.find<JournalController>();

  var sliderValue = 0.0.obs;
  var selectedEmotion = ''.obs;
  var pickedImage = Rx<File?>(null);
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

  Future<void> pickImage() async {
    var status = await Permission.photos.request();
    if (!status.isGranted) {
      Get.snackbar('Permission Denied', 'Gallery access is required');
      return;
    }

    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      pickedImage.value = File(pickedFile.path);
    } else {
      Get.snackbar('Cancelled', 'No image selected');
    }
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

      var uri = Uri.parse('${Config.apiEndPoint}/journal');
      var request = http.MultipartRequest('POST', uri);

      request.headers['Authorization'] = 'Bearer $token';

      request.fields['title'] = titleController.text;
      request.fields['body'] = bodyController.text;
      request.fields['stress_level'] =
          (sliderValue.value + 1).toInt().toString();
      request.fields['mood_level'] = selectedEmotion.value;

      // Kalau ada image
      if (pickedImage.value != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'image',
          pickedImage.value!.path,
        ));
      }

      var response = await request.send();

      if (response.statusCode == 200) {
        titleController.clear();
        bodyController.clear();
        sliderValue.value = 0;
        selectedEmotion.value = '';
        pickedImage.value = null;
        fetchController.fetchJournals();
        Get.back();
        Get.snackbar('Success', 'Journal created successfully',
            backgroundColor: primaryColor.withOpacity(0.6),
            colorText: Colors.white);
      } else {
        var body = await response.stream.bytesToString();
        print(body);
        Get.snackbar('Error', 'Failed to create journal');
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }
}
