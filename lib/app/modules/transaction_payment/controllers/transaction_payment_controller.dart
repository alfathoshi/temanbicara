import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:temanbicara/app/themes/colors.dart';

import '../../../config/config.dart';

class TransactionPaymentController extends GetxController {
  var isLoading = false.obs;

  Future<void> createConsultation({
    required int scheduleId,
    required int patientId,
    required int amount,
    required String bank,
    String description = "-",
    String problem = "-",
    String summary = "-",
  }) async {
    final url = Uri.parse('${Config.apiEndPoint}/consultation');
    final box = GetStorage();
    final token = box.read('token');

    final Map<String, dynamic> body = {
      'description': description,
      'problem': problem,
      'summary': summary,
      'schedule_id': scheduleId,
      'amount': amount,
      'bank': bank,
    };

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
        // Parse error message from response if possible
        Map<String, dynamic> responseBody = {};
        try {
          responseBody = json.decode(response.body);
        } catch (_) {}

        String errorMessage = responseBody['message'] ??
            'Failed to create consultation. Status code: ${response.statusCode}';

        Get.snackbar(
          'Error',
          errorMessage,
          backgroundColor: Colors.red.withOpacity(0.6),
          colorText: Colors.white,
        );
      }
    } catch (error) {
      Get.snackbar(
        'Error',
        'Error creating consultation: $error',
        backgroundColor: Colors.red.withOpacity(0.6),
        colorText: Colors.white,
      );
    }
  }
}
