import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:temanbicara/app/themes/colors.dart';

class TransactionPaymentController extends GetxController {
  var isLoading = false.obs;

  Future<void> updateScheduleStatus(int scheduleId) async {
    final url =
        Uri.parse('https://www.temanbicara.web.id/api/v1/schedule/$scheduleId');
    try {
      final response = await http.put(url);
      if (response.statusCode == 200) {
        Get.snackbar(
          'Success',
          'Schedule booked successfully',
          backgroundColor: primaryColor.withOpacity(0.6),
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Error',
          'Failed to update schedule. Status code: ${response.statusCode}',
        );
      }
    } catch (error) {
      Get.snackbar('Error', 'Error updating schedule status: $error');
    }
  }

  Future<void> createConsultation({
    required int scheduleId,
    required int patientId,
  }) async {
    final url = Uri.parse('https://www.temanbicara.web.id/api/v1/consultation');
    final box = GetStorage();
    final token = box.read('token');
    final Map<String, dynamic> body = {
      'description': "-",
      'problem': "-",
      'summary': "-",
      'schedule_id': scheduleId,
      'patient_id': patientId
    };
    print('Sending request to: $url');
    print('Request body: ${jsonEncode(body)}');

    try {
      final response = await http.post(
        url,
        body: jsonEncode(body),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 201) {
        Get.snackbar(
          'Success',
          'Consultation created successfully.',
          backgroundColor: primaryColor.withOpacity(0.6),
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Error',
          'Failed to create consultation. Status code: ${response.statusCode}',
        );
      }
    } catch (error) {
      Get.snackbar('Error', 'Error creating consultation: $error');
    }
  }

  Future<void> executeTransaction(int scheduleId, int patientId) async {
    isLoading.value = true;
    try {
      await createConsultation(scheduleId: scheduleId, patientId: patientId);
      await updateScheduleStatus(scheduleId);
    } finally {
      isLoading.value = false;
    }
  }
}
