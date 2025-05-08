import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
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

  void toggleEmotion(int index) {
    selectedEmotion.value = emotions[index];
  }

  void toggleSleepQuliaty(int index) {
    selectedSleep.value = sleepQuality[index];
  }

  void toggleScreenTime(int index) {
    selectedScreen.value = ScreenTime[index];
  }

  void toggleActivity(int index) {
    selectedActivity.value = Activity[index];
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
    return selectedScreen.value == ScreenTime[index]
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
    return selectedActivity.value == Activity[index]
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
      print('Error storeTracking: $e');
    }
  }
}
