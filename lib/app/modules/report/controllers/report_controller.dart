import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../config/config.dart';

class ReportController extends GetxController {
  var trackingList = [].obs;
  var avgMood = "Tidak ada data".obs;
  var avgSleep = "Tidak ada data".obs;
  var avgStress = 0.obs;
  var isFetching = false.obs;
  final box = GetStorage();
  var isTrackingFilled = false.obs;
  var title = ''.obs;
  var detail = ''.obs;
  var matrixValue = ''.obs;

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
          List<dynamic> trackingList = data['data'];

          DateTime today = DateTime.now();

          var todayTracking = trackingList.firstWhereOrNull((item) {
            DateTime createdDate = DateTime.parse(item['created_at']);
            return createdDate.year == today.year &&
                createdDate.month == today.month &&
                createdDate.day == today.day;
          });

          if (todayTracking != null) {
            int score = calculateScore(todayTracking);
            final desc = getMentalMatrixDescription(score);

            isTrackingFilled.value = true;
            title.value = '${score} - ${desc['title']}';
            detail.value = desc['detail']!;
            matrixValue.value = score.toString();
          } else {
            isTrackingFilled.value = false;
          }
        } else {
          isTrackingFilled.value = false;
        }
      } else {
        isTrackingFilled.value = false;
      }
    } catch (e) {
      print('Error: $e');
      isTrackingFilled.value = false;
    }
  }

  int calculateScore(Map<String, dynamic> data) {
    // Buat rumus scoring berdasarkan data tracking
    int stressLevel = int.parse(data['stress_level'].toString());

    // Contoh logika scoring sederhana (bisa disesuaikan ya)
    int score = 100 - (stressLevel * 10);
    if (score < 0) score = 0;
    if (score > 100) score = 100;
    return 24;
  }

  Future<void> fetchTracking() async {
    isFetching.value = true;
    try {
      final token = box.read('token');

      var response = await http.get(
        Uri.parse('${Config.apiEndPoint}/tracking'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        if (data['status']) {
          trackingList.value = data['data'];
          avgMood.value = data['average_mood'];
          avgSleep.value = data['average_sleep_quality'];
          avgStress.value = data['average_stress'];
        } else {
          Get.snackbar('Error', data['message']);
        }
      }
    } catch (e) {
      print(e);
    } finally {
      isFetching.value = false;
    }
  }

  Future<Map<String, dynamic>> fetchTrackingWithReturn() async {
    try {
      final token = box.read('token');

      var response = await http.get(
        Uri.parse('${Config.apiEndPoint}/tracking'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        if (data['status']) {
          return data;
        } else {
          Get.snackbar('Error', data['message']);
        }
      } else {
        Get.snackbar('Error', 'Failed to fetch tracking.');
      }
    } catch (e) {
      print(e);
    }
    return {};
  }

  @override
  void onInit() {
    fetchTracking();
    checkTracking();
    super.onInit();
  }
}
