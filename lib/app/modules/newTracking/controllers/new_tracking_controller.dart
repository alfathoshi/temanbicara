import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/widgets/custom_snackbar.dart';
import '../../../config/config.dart';
import '../../home/controllers/home_controller.dart';
import '../../report/controllers/report_controller.dart';

class NewTrackingController extends GetxController {
  var sliderValue = 0.0.obs;
  var selectedEmotion = ''.obs;
  var selectedSleep = ''.obs;
  var selectedScreen = ''.obs;
  var selectedActivity = ''.obs;
  final box = GetStorage();
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

  Future<bool> storeTracking() async {
    isLoading.value = true;
    try {
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
        CustomSnackbar.showSnackbar(
            context: Get.context!,
            title: 'Congrats!',
            message: "Today's Tracking Saved!",
            status: true);
        isLoading.value = false;
        Get.offAllNamed(Routes.NAVIGATION_BAR, arguments: {"indexPage": 0});
        return true;
      } else {
        CustomSnackbar.showSnackbar(
          context: Get.context!,
          title: 'Oops!',
          message: 'Please Fill the Fields!',
          status: false,
        );
        isLoading.value = false;
        return false;
      }
    } catch (e) {
      isLoading.value = false;
      return false;
    }
  }
}
