import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class JournalController extends GetxController {
  final box = GetStorage();
  var isLoading = false.obs;
  var journalList = [].obs;

  Future<void> fetchJournals() async {
    isLoading.value = true;
    try {
      final userId = box.read('id');
      print("ppk ${userId}");
      final token = box.read('token');
      print("token  ${token}");
      var response = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/v1/journal')
            .replace(queryParameters: {
          'userId': userId.toString(),
        }),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        if (data['status']) {
          journalList.value = data['data'];
        } else {
          Get.snackbar('Error', data['message']);
        }
      } else {
        Get.snackbar('Error', 'Failed to fetch journals.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    fetchJournals();
    super.onInit();
  }
}
