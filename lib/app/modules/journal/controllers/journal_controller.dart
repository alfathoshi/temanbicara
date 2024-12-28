import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

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
      final journalId = box.write('journal_id', 'journal_id');
      print("ppk ${userId}");
      final token = box.read('token');
      print("token  ${token}");
      var response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/v1/journal/$userId')
            .replace(queryParameters: {
          'userId': userId.toString(),
        }),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        if (data['status']) {
          journalList.value = data['data'];
        } else {
          Get.snackbar('Error', data['message']);
        }
      } else {
        Get.snackbar('Error', 'Failed to fetch journals.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteJournal(int journalId) async {
    try {
      final token = box.read('token');
      print("Token: $token");

      var response = await http.delete(
        Uri.parse('http://10.0.2.2:8000/api/v1/journal/$journalId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        if (data['status']) {
          Get.snackbar('Success', 'Journal deleted successfully');
          journalList
              .removeWhere((journal) => journal['journal_id'] == journalId);
        } else {
          Get.snackbar('Error', data['message']);
        }
      } else {
        print(response.body);
        Get.snackbar('Error', 'Failed to delete journal.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    }
  }

  @override
  void onInit() {
    fetchJournals();
    super.onInit();
  }
}
