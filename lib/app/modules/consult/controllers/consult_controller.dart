import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:temanbicara/app/config/config.dart';

class ConsultController extends GetxController {
  var schedules = {}.obs;
  var isLoading = false.obs;
  var selectedExpertise = <String>[].obs;

  final box = GetStorage();

  Future<void> fetchData() async {
    try {
      final token = box.read('token');

      isLoading.value = true;
      final response = await http.get(
        Uri.parse('${Config.apiEndPoint}/available-schedule'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        schedules.value = json.decode(response.body);
      }
    } catch (e) {
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  void clearExpertiseFilter() {
    selectedExpertise.clear();
  }

  @override
  void onInit() {
    super.onInit();
    clearExpertiseFilter();
  }

  @override
  void onReady() {
    super.onReady();
    clearExpertiseFilter();
    fetchData();
  }

  @override
  void onClose() {
    clearExpertiseFilter();
    super.onClose();
  }
}
