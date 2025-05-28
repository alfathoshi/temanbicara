import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:temanbicara/app/themes/colors.dart';

import '../../../config/config.dart';

class JournalController extends GetxController {
  final box = GetStorage();
  var isLoading = false.obs;
  var journalList = [].obs;

  String formatDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  }

  var selectedDate = DateTime.now().obs;
  void updateDate(DateTime date) {
    selectedDate.value = DateTime(date.year, date.month, date.day);
  }

  Future<void> fetchJournals() async {
    isLoading.value = true;
    journalList.clear();
    try {
      final userId = box.read('id');

      final token = box.read('token');
      var response = await http.post(
        Uri.parse('${Config.apiEndPoint}/journal/get')
            .replace(queryParameters: {
          'id': userId.toString(),
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'date_request': DateFormat('yyyy-MM-dd').format(selectedDate.value)
        }),
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['status']) {
          journalList.value = data['data'];
          // print(journalList.value);
        } else {
          Get.snackbar('Not Found', 'Journal Not Found',
              backgroundColor: error.withValues(alpha: 0.6),
              colorText: Colors.white);
        }
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to fetch journal',
        backgroundColor: error.withValues(alpha: 0.6),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteJournal(int journalId) async {
    try {
      final token = box.read('token');

      var response = await http.delete(
        Uri.parse('${Config.apiEndPoint}/journal/$journalId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['status']) {
          Get.snackbar(
            'Success',
            'Journal deleted successfully',
            colorText: whiteColor,
            backgroundColor: primaryColor.withValues(alpha: 0.6),
          );
          journalList
              .removeWhere((journal) => journal['journal_id'] == journalId);
        } else {
          Get.snackbar(
            'Error',
            data['message'],
            colorText: whiteColor,
            backgroundColor: error.withValues(alpha: 0.6),
          );
        }
      } else {
        Get.snackbar(
          'Error',
          'Failed to delete journal.',
          colorText: whiteColor,
          backgroundColor: error.withValues(alpha: 0.6),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to delete journal',
        backgroundColor: error.withValues(alpha: 0.6),
        colorText: Colors.white,
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchJournals();
  }
}
