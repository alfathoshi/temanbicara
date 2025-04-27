import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:temanbicara/app/config/config.dart';
import 'package:get_storage/get_storage.dart';

class ConsultController extends GetxController {
  var schedules = {}.obs;
  var isLoading = false.obs;
  final box = GetStorage();

  Future<void> fetchData() async {
    try {
      // final userId = box.read('id');
      final token = box.read('token');

      isLoading.value = true;
      final response = await http.get(
        Uri.parse('${Config.apiEndPoint}/available-schedule'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      
      if (response.statusCode == 200) {
        schedules.value = json.decode(response.body);
      }
      // else {
      //   throw Exception('Failed to load schedule');
      // }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  @override
  void onReady() {
    super.onReady();
    fetchData();
  }
}
