import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:temanbicara/app/themes/fonts.dart';

class Tracking2Controller extends GetxController {
  var selectedNumber = ''.obs;
  Color colorNum = const Color(0xffC360B7);
  final box = GetStorage();
  final List<String> emotions = [
    'Depresi',
    'Sedih',
    'Netral',
    'Senang',
    'Bahagia'
  ];

  void selectNumber(int number) {
    selectedNumber.value = emotions[number - 1];
    box.write('mood_level', selectedNumber.value).toString();
  }

  Color colorNumber() {
    if (selectedNumber.value == 'Depresi') {
      return const Color(0xffC360B7);
    } else if (selectedNumber.value == 'Sedih') {
      return const Color(0xff9CD66A);
    } else if (selectedNumber.value == 'Netral') {
      return const Color(0xffFFE446);
    } else if (selectedNumber.value == 'Senang') {
      return const Color(0xffFEB849);
    } else if (selectedNumber.value == 'Bahagia') {
      return const Color(0xffFF8F42);
    } else {
      return Colors.transparent;
    }
  }

  Widget explanationText() {
    if (selectedNumber.value == '') {
      return const Padding(
        padding: EdgeInsets.all(20.0),
        child: Text(''),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text('Aku merasa ${selectedNumber.value}', style: h4Bold),
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
    selectedNumber.value = emotions[0];
  }
}
