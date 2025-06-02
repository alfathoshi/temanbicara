// ignore_for_file: avoid_print, empty_catches

import 'dart:convert';
import 'dart:math';

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
  var randomShortTermGoal = ''.obs;

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

  Future<void> _updateRandomShortTermGoal() {
    if (_reportController.report.value != null &&
        _reportController.report.value!.shortTerm.isNotEmpty) {
      final shortTermGoals = _reportController.report.value!.shortTerm;
      final randomIndex = Random().nextInt(shortTermGoals.length);
      randomShortTermGoal.value = shortTermGoals[randomIndex];
    } else {
      randomShortTermGoal.value = '“Set your goals and crush them!”';
    }

    return Future.value();
  }

  late final ReportController _reportController;
  late final ProfileController _profileController;
  late final JournalController _journalController;
  Worker? _reportEverWorker;

  Future<void> refreshMentalMatrixData() async {
    isLoading.value = true;
    await _reportController.getMatrix(
      dateToFetch: DateTime.now(),
      showSnackbarOnFailure: false,
    );
    await _reportController.checkTracking();
    _updateRandomShortTermGoal();
    isLoading.value = false;
  }

  @override
  void onInit() async {
    super.onInit();
    _reportController = Get.find<ReportController>();
    _profileController = Get.find<ProfileController>();
    _journalController = Get.find<JournalController>();

    _loadInitialData();
    _reportEverWorker = ever(_reportController.report, (_) {
      _updateRandomShortTermGoal();
    });
  }

  Future<void> _loadInitialData() async {
    try {
      isLoading.value = true;
      await Future.wait([
        _profileController.fetchData(),
        _reportController
            .getMatrix(
          dateToFetch: _reportController.selectedDate.value,
          showSnackbarOnFailure: false,
        )
            .then((_) async {
          await _reportController.checkTracking();
          _updateRandomShortTermGoal();
        }),
        _journalController.fetchJournals(),
        fetchData()
      ]);
    } catch (e) {
      _updateRandomShortTermGoal();
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    _reportEverWorker?.dispose();
    super.onClose();
  }
}
