import 'dart:convert';
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

class EditJournalController extends GetxController {
  final box = GetStorage();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  final fetchController = Get.find<JournalController>();
  late int journalId;

  var isLoading = false.obs;

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

  Future<void> updateJournal() async {
    if (titleController.text.isEmpty || bodyController.text.isEmpty) {
      Get.snackbar('Error', 'Title and Body are required');
      return;
    }

    isLoading.value = true;

    try {
      final userId = box.read('id');
      final token = box.read('token');

      final response = await http.put(
        Uri.parse('${Config.apiEndPoint}/journal/$journalId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'title': titleController.text,
          'body': bodyController.text,
          'user_id': userId,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData['status']) {
          Get.back();
          fetchController.fetchJournals();
          Get.snackbar('Success', 'Journal updated successfully',
              backgroundColor: primaryColor.withValues(alpha: 0.6),
              colorText: Colors.white);
        } else {
          Get.snackbar(
              'Error', responseData['message'] ?? 'Failed to update journal');
        }
      } else {
        Get.snackbar('Error', 'Failed to update journal.');
      }
    } catch (e) {
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
      titleController.text = arguments['title'] ?? '';
      bodyController.text = arguments['body'] ?? '';
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    bodyController.dispose();
    super.onClose();
  }
}
