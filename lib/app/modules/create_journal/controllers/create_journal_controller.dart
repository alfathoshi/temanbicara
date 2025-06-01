import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/widgets/custom_snackbar.dart';

import '../../../config/config.dart';
import '../../journal/controllers/journal_controller.dart';

class CreateJournalController extends GetxController {
  final box = GetStorage();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  final fetchController = Get.find<JournalController>();
  var pickedImage = Rx<File?>(null);

  Future<void> pickImage() async {
    var status = await Permission.photos.request();
    if (!status.isGranted) {
      Get.snackbar('Permission Denied', 'Gallery access is required');
      return;
    }

    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      int fileSize = await imageFile.length();
      if (fileSize > (2 * 1024 * 1024)) {
        Get.snackbar('Error', 'Image size is more than 2mb',
            backgroundColor: Colors.red.withValues(alpha: 0.6),
            colorText: Colors.white);
        pickedImage.value = null;
      } else {
        pickedImage.value = imageFile;
      }
    } else {
      Get.snackbar('Cancelled', 'No image selected');
    }
  }

  Future<bool> submitJournal() async {
    if (titleController.text.isEmpty || bodyController.text.isEmpty) {
      Get.snackbar('Error', 'Title and Body are required',
          backgroundColor: Colors.red.withValues(alpha: 0.6),
          colorText: Colors.white);
      return false;
    }

    if (titleController.text.length > 255) {
      Get.snackbar('Invalid Title', 'Title too long',
          backgroundColor: Colors.red.withValues(alpha: 0.6),
          colorText: Colors.white);
      return false;
    }

    try {
      final token = box.read('token');

      var uri = Uri.parse('${Config.apiEndPoint}/journal');
      var request = http.MultipartRequest('POST', uri);

      request.headers['Authorization'] = 'Bearer $token';

      request.fields['title'] = titleController.text;
      request.fields['body'] = bodyController.text;

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

        pickedImage.value = null;
        fetchController.fetchJournals();
        Get.back();
        CustomSnackbar.showSnackbar(
            context: Get.context!,
            title: 'Journal Created',
            message: 'Journal created successfully',
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
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
      return false;
    }
  }
}
