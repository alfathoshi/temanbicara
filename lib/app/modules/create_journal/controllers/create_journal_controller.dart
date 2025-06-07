import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:temanbicara/app/widgets/custom_snackbar.dart';
import '../../../config/config.dart';
import '../../journal/controllers/journal_controller.dart';

class CreateJournalController extends GetxController {
  final box = GetStorage();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  final fetchController = Get.find<JournalController>();
  var pickedImage = Rx<File?>(null);
  var isLoading = false.obs;

  Future<void> pickImage() async {
    PermissionStatus status;

      if (Platform.isAndroid) {
        status = await Permission.photos.request();
        if (status.isDenied || status.isPermanentlyDenied) {
          status = await Permission.storage.request();
        }
      } else {
        status = await Permission.photos.request();
      }
    
    if (!status.isGranted) {
      CustomSnackbar.showSnackbar(
        title: "Oops!",
        message: "Gallery Access Required!",
        status: false,
      );
      return;
    }

    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      int fileSize = await imageFile.length();
      if (fileSize > (5 * 1024 * 1024)) {
        CustomSnackbar.showSnackbar(
          title: "Oops!",
          message: "Image Must not Exceed 2MB!",
          status: false,
        );
        pickedImage.value = null;
      } else {
        pickedImage.value = imageFile;
      }
    } else {
      CustomSnackbar.showSnackbar(
        title: "Oops!",
        message: "No Image Selected!",
        status: false,
      );
    }
  }

  Future<bool> submitJournal() async {
    isLoading.value = true;
    if (titleController.text.isEmpty || bodyController.text.isEmpty) {
      CustomSnackbar.showSnackbar(
          context: Get.context!,
          title: 'Oops!',
          message: 'Please Fill the Fields!',
          status: false);
      return false;
    }

    if (titleController.text.length > 255) {
      CustomSnackbar.showSnackbar(
          context: Get.context!,
          title: 'Invalid!',
          message: 'Title too Long!',
          status: false);
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
            title: 'Created!',
            message: 'New Journal Added!',
            status: true);
        isLoading.value = false;
        return true;
      } else {
        CustomSnackbar.showSnackbar(
            context: Get.context!,
            title: 'Oops!',
            message: 'Failed to Create Journal!',
            status: false);
        isLoading.value = false;
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
