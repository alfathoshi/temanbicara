import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:temanbicara/app/config/config.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  final count = 0.obs;
  File? storedImage;
  RxString name = ''.obs;

  Future pickImage() async {
    try {
      var status = await Permission.photos.request();
      if (status.isGranted) {
        final image =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (image == null) return;
        final imageTemp = File(image.path);
        storedImage = imageTemp;
      }
    } catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<void> changeImage() async {
    try {
      var request = http.MultipartRequest('POST',
          Uri.parse("https://www.temanbicara.web.id/api/v1/profile/image"));

      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          storedImage!.path,
        ),
      );

      request.headers.addAll({
        'Accept': 'application/json',
        'Authorization': 'Bearer ${GetStorage().read('token')}',
      });

      final response = await request.send();
      final res = await http.Response.fromStream(response);
      print(res.statusCode);
      return;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse('${Config.apiEndPoint}/profile'),
        headers: {
          'Authorization': 'Bearer ${GetStorage().read('token')}',
          'Content-Type': 'application/json',
        },
      );

      var data = json.decode(response.body);

      var box = GetStorage();
      box.write('email', data['data']['email']);
      box.write('password', data['data']['password']);
      box.write('phone', data['data']['phone_number']);
      box.write('name', data['data']['name']);
      box.write('nickname', data['data']['nickname']);
      box.write('birthdate', data['data']['birthdate']);
      name.value = data['data']['name'];
      return;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  @override
  void onInit() async {
    // name.value = GetStorage().read('name');
    await fetchData();
    super.onInit();
  }
}
