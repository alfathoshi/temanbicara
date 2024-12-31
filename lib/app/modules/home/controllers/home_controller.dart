import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../journal/controllers/journal_controller.dart';

class HomeController extends GetxController {
  final box = GetStorage();
  var isLoading = false.obs;
  var journalList = [].obs;

  final fetchJournalController = Get.find<JournalController>();

  Future<void> fetchDataJornal() async {
    fetchJournalController.fetchJournals();
  }

  Future<Map<String, dynamic>> fetchData() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/v1/article'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(response.body);
      throw Exception('Failed to load article');
    }
  }
}
