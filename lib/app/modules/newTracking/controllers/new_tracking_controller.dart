import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:temanbicara/app/themes/colors.dart';
import '../../../config/config.dart';

class NewTrackingController extends GetxController {
  var sliderValue = 0.0.obs;
  var selectedEmotion = ''.obs;
  var selectedSleep = ''.obs;
  var selectedScreen = ''.obs;
  var selectedActivity = ''.obs;
  final box = GetStorage();

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

  final List<String> activity = [
    '< 500 steps',
    '500-1k steps',
    '1k-3k steps',
    '3k-5k steps',
    '> 6k steps'
  ];

  final List<String> screenTime = [
    '< 1 hours',
    '1-2 hours',
    '2-3 hours',
    '3-4 hours',
    '> 5 hours'
  ];

  void toggleEmotion(int index) {
    selectedEmotion.value = emotions[index];
  }

  void toggleSleepQuliaty(int index) {
    selectedSleep.value = sleepQuality[index];
  }

  void toggleScreenTime(int index) {
    selectedScreen.value = screenTime[index];
  }

  void toggleActivity(int index) {
    selectedActivity.value = activity[index];
  }

  double getOpacity(int index) {
    return selectedEmotion.value == emotions[index] ? 1.0 : 0.5;
  }

  ColorFilter getColorEmotion(int index) {
    return selectedEmotion.value == emotions[index]
        ? const ColorFilter.mode(Colors.transparent, BlendMode.multiply)
        : const ColorFilter.matrix(<double>[
            0.2126,
            0.7152,
            0.0722,
            0,
            0,
            0.2126,
            0.7152,
            0.0722,
            0,
            0,
            0.2126,
            0.7152,
            0.0722,
            0,
            0,
            0,
            0,
            0,
            1,
            0,
          ]);
  }

  ColorFilter getColorSleep(int index) {
    return selectedSleep.value == sleepQuality[index]
        ? const ColorFilter.mode(Colors.transparent, BlendMode.multiply)
        : const ColorFilter.matrix(<double>[
            0.2126,
            0.7152,
            0.0722,
            0,
            0,
            0.2126,
            0.7152,
            0.0722,
            0,
            0,
            0.2126,
            0.7152,
            0.0722,
            0,
            0,
            0,
            0,
            0,
            1,
            0,
          ]);
  }

  ColorFilter getColorScreen(int index) {
    return selectedScreen.value == screenTime[index]
        ? const ColorFilter.mode(Colors.transparent, BlendMode.multiply)
        : const ColorFilter.matrix(<double>[
            0.2126,
            0.7152,
            0.0722,
            0,
            0,
            0.2126,
            0.7152,
            0.0722,
            0,
            0,
            0.2126,
            0.7152,
            0.0722,
            0,
            0,
            0,
            0,
            0,
            1,
            0,
          ]);
  }

  ColorFilter getColorActivity(int index) {
    return selectedActivity.value == activity[index]
        ? const ColorFilter.mode(Colors.transparent, BlendMode.multiply)
        : const ColorFilter.matrix(<double>[
            0.2126,
            0.7152,
            0.0722,
            0,
            0,
            0.2126,
            0.7152,
            0.0722,
            0,
            0,
            0.2126,
            0.7152,
            0.0722,
            0,
            0,
            0,
            0,
            0,
            1,
            0,
          ]);
  }

  Future<void> storeTracking() async {
    try {
      // ignore: unused_local_variable
      final userId = box.read('id');
      final token = box.read('token');

      var response = await http.post(
        Uri.parse('${Config.apiEndPoint}/do-tracking'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'bed_time': selectedSleep.value,
          'mood_level': selectedEmotion.value,
          'stress_level': sliderValue.value.toInt(),
          'screen_time': selectedScreen.value,
          'activity': selectedActivity.value,
        }),
      );

      var data = json.decode(response.body);

      if (response.statusCode == 200 && data['status']) {
        Get.snackbar(
          'Success',
          'Tracking berhasil disimpan!',
          backgroundColor: primaryColor,
          colorText: Colors.white,
        );
        Get.offAllNamed('/navigation-bar');
      } else {
        Get.snackbar('Error', data['message'] ?? 'Gagal menyimpan tracking',
            backgroundColor: Colors.red.withOpacity(0.6),
            colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar('Error', 'Gagal menyimpan tracking',
          backgroundColor: Colors.red.withOpacity(0.6),
          colorText: Colors.white);
    }
  }
}
