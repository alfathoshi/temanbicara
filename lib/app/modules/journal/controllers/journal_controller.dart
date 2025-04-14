import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:temanbicara/app/themes/colors.dart';

class JournalController extends GetxController {
  final box = GetStorage();
  var isLoading = false.obs;
  var journalList = [].obs;
  final List<String> emotions = [
    'Depresi',
    'Sedih',
    'Netral',
    'Senang',
    'Bahagia'
  ];

  String formatDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  }

  final List<Color> emotionColors = [
    Colors.purpleAccent,
    Colors.lightGreen,
    Colors.yellow,
    Colors.orange,
    Colors.redAccent,
  ];

  Future<void> fetchJournals() async {
    isLoading.value = true;
    try {
      final userId = box.read('id');

      final token = box.read('token');

      var response = await http.get(
        Uri.parse('https://www.temanbicara.web.id/api/v1/journal')
            .replace(queryParameters: {
          'id': userId.toString(),
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['status']) {
          journalList.value = data['data'];
        }
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong: $e',
        colorText: whiteColor,
        backgroundColor: error.withOpacity(0.6),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteJournal(int journalId) async {
    try {
      final token = box.read('token');
      print("Token: $token");

      var response = await http.delete(
        Uri.parse('https://www.temanbicara.web.id/api/v1/journal/$journalId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        if (data['status']) {
          Get.snackbar(
            'Success',
            'Journal deleted successfully',
            colorText: whiteColor,
            backgroundColor: primaryColor.withOpacity(0.6),
          );
          journalList
              .removeWhere((journal) => journal['journal_id'] == journalId);
        } else {
          Get.snackbar(
            'Error',
            data['message'],
            colorText: whiteColor,
            backgroundColor: error.withOpacity(0.6),
          );
        }
      } else {
        print(response.body);
        Get.snackbar(
          'Error',
          'Failed to delete journal.',
          colorText: whiteColor,
          backgroundColor: error.withOpacity(0.6),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong: $e',
        colorText: whiteColor,
        backgroundColor: error.withOpacity(0.6),
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchJournals();
  }
}
