import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:temanbicara/app/modules/profile/controllers/profile_controller.dart';

import '../../../config/config.dart';
import '../../journal/controllers/journal_controller.dart';
import '../../report/controllers/report_controller.dart';

class HomeController extends GetxController {
  final box = GetStorage();
  var isLoading = false.obs;
  var journals = {}.obs;
  var articles = {}.obs;
  RxString name = ''.obs;

  Future<void> fetchData() async {
    final token = box.read('token');
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse('${Config.apiEndPoint}/article'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        articles.value = json.decode(response.body);
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
  void onInit() async {
    await ProfileController().fetchData();
    await ReportController().checkTracking();
    await JournalController().fetchJournals();
    super.onInit();
  }
}
