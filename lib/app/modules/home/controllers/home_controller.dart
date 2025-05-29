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
        print(articles.values);
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

  late final ReportController _reportController;
  late final ProfileController _profileController;
  late final JournalController _journalController;

  Future<void> refreshMentalMatrixData() async {
    isLoading.value = true; // jika ada state loading
    await _reportController.getMatrix();
    await _reportController
        .checkTracking(); // _reportController dari Get.find()
    // Mungkin perlu update() jika tidak semua state reaktif atau ada kalkulasi manual
    isLoading.value = false;
  }

  @override
  void onInit() async {
    super.onInit();
    _reportController = Get.find<ReportController>();
    _profileController = Get.find<ProfileController>();
    _journalController = Get.find<JournalController>();

    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    // Anda bisa menambahkan indikator loading di sini jika perlu
    // isLoading.value = true;
    try {
      // Jalankan secara paralel jika memungkinkan untuk performa lebih baik
      await Future.wait([
        _profileController.fetchData(),
        _reportController.getMatrix().then((_) async {
          // Memastikan getMatrix selesai sebelum checkTracking
          await _reportController.checkTracking();
        }),
        _journalController.fetchJournals(),
        fetchData()
      ]);
    } catch (e) {
      print("Error loading initial data for Home: $e");
      // Handle error
    }
  }
}
