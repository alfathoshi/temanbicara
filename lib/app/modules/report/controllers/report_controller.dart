import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../../config/config.dart';
import '../../../data/ReportModel.dart';
import '../../../themes/colors.dart';

class ReportController extends GetxController {
  var trackingList = {}.obs;
  var tracing = [].obs;
  var avgMood = "Tidak ada data".obs;
  var avgSleep = "Tidak ada data".obs;
  var avgScreen = "Tidak ada data".obs;
  var avgActivity = "Tidak ada data".obs;
  var avgStress = 0.obs;
  var isFetching = false.obs;
  final box = GetStorage();
  var isTrackingFilled = false.obs;
  var title = ''.obs;
  var detail = ''.obs;
  var matrixValue = ''.obs;
  var report = Rxn<ReportModel>();
  var isLoading = false.obs;

  final List<String> emotions = [
    'Depressed',
    'Sad',
    'Neutral',
    'Happy',
    'Cheerful'
  ];

  final List<String> sleepQuality = [
    '> 7 hours',
    '5-6 hours',
    '4-5 hours',
    '3-4 hours',
    '< 3 hours'
  ];

  final List<String> Activity = [
    '< 500 steps',
    '500-1k steps',
    '1k-3k steps',
    '3k-5k steps',
    '> 6k steps'
  ];

  final List<String> ScreenTime = [
    '< 1 hours',
    '1-2 hours',
    '2-3 hours',
    '3-4 hours',
    '> 5 hours'
  ];
  var selectedDate = DateTime.now().obs;
  void updateDate(DateTime date) {
    selectedDate.value = DateTime(date.year, date.month, date.day);
  }

  Map<String, String> getMentalMatrixDescription(int score) {
    if (score >= 1 && score <= 20) {
      return {'title': 'Struggling', 'detail': 'Need extra support.'};
    } else if (score >= 21 && score <= 40) {
      return {'title': 'Challenging', 'detail': 'Facing hurdles, manageable.'};
    } else if (score >= 41 && score <= 60) {
      return {'title': 'Balanced', 'detail': 'Stable but improvable.'};
    } else if (score >= 61 && score <= 80) {
      return {'title': 'Energized', 'detail': 'Motivated, can still enhance.'};
    } else if (score >= 81 && score <= 100) {
      return {
        'title': 'Flourishing',
        'detail': 'Healthy mind, positive vibes.'
      };
    } else {
      return {'title': 'Unknown', 'detail': 'No valid data.'};
    }
  }

  final List<Color> chartColors = [
    greenChart,
    blueChart,
    yellowChart,
    orangeChart,
    purpleChart,
  ];

  Future<void> getMatrix() async {
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
          'date_request':
              '${DateFormat('yyyy-MM-dd').format(selectedDate.value)}'
        }),
      );

      var data = json.decode(response.body);

      if (response.statusCode == 200 &&
          data['status'] == true &&
          data['data'] != null) {
        report.value = ReportModel.fromJson(data['data'][0]);
      } else {
        print("error ${data['message']}");
      }
    } catch (e) {
      print('Error getReport: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> checkTracking() async {
    try {
      final token = box.read('token');
      final response = await http.get(
        Uri.parse('${Config.apiEndPoint}/tracking'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['status'] == true && data['data'] != null) {
          List<dynamic> tracing = data['data'];

          DateTime today = DateTime.now();

          var todayTracking = tracing.firstWhereOrNull((item) {
            DateTime createdDate = DateTime.parse(item['created_at']).toLocal();
            return createdDate.year == today.year &&
                createdDate.month == today.month &&
                createdDate.day == today.day;
          });

          if (todayTracking != null) {
            int score = report.value!.matrix;
            final desc = getMentalMatrixDescription(score);

            title.value = '${score} - ${desc['title']}';
            detail.value = desc['detail']!;
            matrixValue.value = score.toString();
            isTrackingFilled.value = true;
          } else {
            isTrackingFilled.value = false;
          }
        }
      }
    } catch (e) {
      print('Error: $e');
      isTrackingFilled.value = false;
    }
  }

  Future<void> fetchStatistik() async {
    try {
      isFetching.value = true;
      final token = box.read('token');

      final response = await http.get(
        Uri.parse('${Config.apiEndPoint}/tracking/last-7-days'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Data status: ${data['status']}');
        print('Data content: ${data['data']}');

        if (data['status']) {
          trackingList.value = data['data'];

          avgMood.value = trackingList['average_mood'] ?? '';
          avgStress.value = trackingList['average_stress_level'] ?? 0;
          avgSleep.value = trackingList['average_bed_time'] ?? '';
          avgScreen.value = trackingList['average_screen_time'] ?? '';
          avgActivity.value = trackingList['average_activity'] ?? '';
        } else {
          print(data['message']);
        }
      } else {
        Get.snackbar('Error', 'Gagal mengambil data statistik');
      }
    } catch (e) {
      print('Error fetchStatistik: $e');
    } finally {
      isFetching.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchStatistik();
    getMatrix();
  }
}
