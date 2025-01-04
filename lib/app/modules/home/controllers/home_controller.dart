import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../journal/controllers/journal_controller.dart';

class HomeController extends GetxController {
  final box = GetStorage();
  var isLoading = false.obs;
  var journals = {}.obs;
  var articles = {}.obs;

  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      final response =
          await http.get(Uri.parse('http://10.0.2.2:8000/api/v1/article'));
      if (response.statusCode == 200) {
        articles.value = json.decode(response.body);
        print(articles);
      } else {
        throw Exception('Failed to load schedule');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchData();
  }
}
