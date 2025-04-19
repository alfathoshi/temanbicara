import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:temanbicara/app/config/config.dart';

class ConsultController extends GetxController {
  var schedules = {}.obs;
  var isLoading = false.obs;

  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse(
          '${Config.apiEndPoint}/available-schedule'));
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
