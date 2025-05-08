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

  @override
  void onInit() {
    super.onInit();
    getReport();
  }
}
