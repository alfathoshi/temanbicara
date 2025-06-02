// ignore_for_file: avoid_print

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
  RxString profileUrl = "".obs;
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
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  late final ReportController _reportController;
  late final ProfileController _profileController;
  late final JournalController _journalController;

  Future<void> refreshMentalMatrixData() async {
    isLoading.value = true;
    await _reportController.getMatrix(
      dateToFetch: DateTime.now(),
      showSnackbarOnFailure: false,
    );
    await _reportController.checkTracking();

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
    try {
      await Future.wait([
        _profileController.fetchData(),
        _reportController
            .getMatrix(
          dateToFetch: _reportController.selectedDate.value,
          showSnackbarOnFailure: false,
        )
            .then((matrixSuccess) async {
          await _reportController.checkTracking();
        }),
        _journalController.fetchJournals(),
        fetchData()
      ]);
    } catch (e) {
      isLoading.value = false;
    }
  }
}
