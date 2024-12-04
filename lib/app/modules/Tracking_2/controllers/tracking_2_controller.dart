import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';

class Tracking2Controller extends GetxController {
  var selectedNumber = 1.obs;
  Color colorNum = Color(0xffC360B7);

  void selectNumber(int number) {
    selectedNumber.value = number;
    colorNumber(selectedNumber.value);
  }

  Color colorNumber(int number) {
    if (selectedNumber.value == 1 || selectedNumber.value == null) {
      return colorNum = Color(0xffC360B7);
    } else if (selectedNumber.value == 2) {
      return colorNum = Color(0xff9CD66A);
    } else if (selectedNumber.value == 3) {
      return colorNum = Color(0xffFFE446);
    } else if (selectedNumber.value == 4) {
      return colorNum = Color(0xffFEB849);
    } else if (selectedNumber.value == 5) {
      return colorNum = Color(0xffFF8F42);
    }
    return Colors.transparent;
  }

  Widget explanationText() {
    if (selectedNumber.value == 0 || selectedNumber.value == null) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(''),
      );
    } else if (selectedNumber.value == 1) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text('Aku merasa depresi', style: h4Bold),
      );
    } else if (selectedNumber.value == 2) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text('Aku merasa sedih', style: h4Bold),
      );
    } else if (selectedNumber.value == 3) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text('Aku merasa tidak apa apa', style: h4Bold),
      );
    } else if (selectedNumber.value == 4) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text('Aku merasa senang', style: h4Bold),
      );
    } else if (selectedNumber.value == 5) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text('Aku merasa bahagia', style: h4Bold),
      );
    }
    return Text('');
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
