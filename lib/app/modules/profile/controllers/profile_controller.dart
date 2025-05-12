import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:temanbicara/app/config/config.dart';
import 'package:http/http.dart' as http;
import 'package:temanbicara/app/themes/colors.dart';

class ProfileController extends GetxController {
  final count = 0.obs;
  File? storedImage;
  RxString name = ''.obs;
  var box = GetStorage();
  RxString profileUrl = "".obs;

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
      Get.snackbar(
        'Error',
        'Failed to fetch journal',
        backgroundColor: error.withValues(alpha: 0.6),
        colorText: whiteColor,
      );
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
      if (json.decode(res.body)['status']) {
        Get.snackbar('Success', 'Foto profile berhasil diupdate');
      }
      fetchData();
      return;
    } catch (err) {
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

      box.write('email', data['data']['email']);
      box.write('password', data['data']['password']);
      box.write('phone', data['data']['phone_number']);
      box.write('name', data['data']['name']);
      box.write('nickname', data['data']['nickname']);
      box.write('birthdate', data['data']['birthdate']);
      box.write('profile_image', data['data']['profile_url']);
      name.value = data['data']['name'];
      profileUrl.value = data['data']['profile_url'];
      return;
    } catch (err) {
      Get.snackbar(
        'Error',
        'Failed to fetch profile',
        backgroundColor: error.withValues(alpha: 0.6),
        colorText: whiteColor,
      );
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
