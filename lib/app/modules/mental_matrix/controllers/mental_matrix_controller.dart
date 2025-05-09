import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../config/config.dart';
import '../../../data/ReportModel.dart';
import 'package:get/get.dart';
import '../../../themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MentalMatrixController extends GetxController {
  var report = Rxn<ReportModel>();
  var isLoading = false.obs;
  final box = GetStorage();
  var title = ''.obs;
  var detail = ''.obs;
  var matrixValue = ''.obs;
  var isTrackingFilled = false.obs;
  final List<String> emotions = [
    'Depressed',
    'Sad',
    'Neutral',
    'Happy',
    'Cheerful'
  ];

  final List<String> sleepQuality = [
    '> 8 Hours',
    '7-8 Hours',
    '6 Hours',
    '4-5 Hours',
    '< 4 Hours'
  ];

  final List<String> Activity = [
    '< 2k \nSteps',
    '2k-5k \nSteps',
    '5k-7.5k \nSteps',
    '7.5k-10k \nSteps',
    '> 10k \nSteps'
  ];

  final List<String> ScreenTime = [
    '< 1 Hours',
    '1-3 Hours',
    '3-5 Hours',
    '5-8 Hours',
    '> 8 Hours'
  ];

  Future<void> getReport() async {
    try {
      isLoading.value = true;
      final userId = box.read('id');
      final token = box.read('token');

      var response = await http.post(
        Uri.parse('${Config.apiEndPoint}/report'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'date_request': "2025-05-08",
        }),
      );

      var data = json.decode(response.body);
      // print('response body: ${response.body}');

      if (response.statusCode == 200 &&
          data['status'] == true &&
          data['data'] != null) {
        report.value = ReportModel.fromJson(data['data'][0]);
      } else {
        Get.snackbar('Error', data['message'] ?? 'Gagal Menyiapkan Report',
            backgroundColor: Colors.red.withOpacity(0.6),
            colorText: whiteColor);
      }
    } catch (e) {
      print('Error getReport: $e');
    } finally {
      isLoading.value = false;
    }
  }

  String getIndexedImage({
    required String? value,
    required List<String> referenceList,
    required String prefix,
  }) {
    if (value == null) return '${prefix}1.png';
    final index = referenceList.indexOf(value.trim());
    if (index != -1) {
      return '$prefix${index + 1}.png';
    }
    return '${prefix}1.png';
  }

  @override
  void onInit() {
    super.onInit();
    getReport();
  }
}
