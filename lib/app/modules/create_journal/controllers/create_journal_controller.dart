import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:temanbicara/app/themes/colors.dart';

import '../../../config/config.dart';
import '../../journal/controllers/journal_controller.dart';

class CreateJournalController extends GetxController {
  final box = GetStorage();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  final fetchController = Get.find<JournalController>();
  var pickedImage = Rx<File?>(null);

  Future<void> pickImage() async {
    // ignore: unused_local_variable
    var status = await Permission.photos.request();
    // if (!status.isGranted) {
    //   Get.snackbar('Permission Denied', 'Gallery access is required');
    //   return;
    // }

    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      pickedImage.value = File(pickedFile.path);
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

    try {
      // final userId = box.read('id');
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
        Get.snackbar('Success', 'Journal created successfully',
            backgroundColor: primaryColor.withValues(alpha: 0.6),
            colorText: Colors.white);
        return true;
      } else {
        Get.snackbar('Error', 'Failed to create journal');
        return false;
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
      return false;
    }
  }
}
