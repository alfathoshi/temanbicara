import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ReportController extends GetxController {
  var trackingList = [].obs;
  var avgMood = "Tidak ada data".obs;
  var avgSleep = "Tidak ada data".obs;
  var avgStress = 0.obs;
  var isFetching = false.obs;
  final box = GetStorage();

  Future<void> fetchTracking() async {
    isFetching.value = true;
    try {
      final token = box.read('token');

      var response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/v1/tracking'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        if (data['status']) {
          print(data['data']);
          trackingList.value = data['data'];
          avgMood.value = data['average_mood'];
          avgSleep.value = data['average_sleep_quality'];
          avgStress.value = data['average_stress'];
        } else {
          Get.snackbar('Error', data['message']);
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    } finally {
      isFetching.value = false;
    }
  }

  Future<Map<String, dynamic>> fetchTrackingWithReturn() async {
    try {
      final token = box.read('token');

      var response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/v1/tracking'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        if (data['status']) {
          return data;
        } else {
          Get.snackbar('Error', data['message']);
        }
      } else {
        Get.snackbar('Error', 'Failed to fetch tracking.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    }
    return {};
  }

  @override
  void onInit() {
    fetchTracking();
    super.onInit();
  }
}
