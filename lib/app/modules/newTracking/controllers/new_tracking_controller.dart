import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewTrackingController extends GetxController {
  var sliderValue = 0.0.obs;
  var selectedEmotion = ''.obs;
  var selectedSleep = ''.obs;
  var selectedScreen = ''.obs;
  var selectedActivity = ''.obs;

  final List<String> emotions = [
    'Depresi',
    'Sedih',
    'Netral',
    'Senang',
    'Bahagia'
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
}
