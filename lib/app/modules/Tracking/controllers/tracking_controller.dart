import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';

class TrackingController extends GetxController {
  //TODO: Implement TrackingController
  var selectedKualitasTidur = Rxn<String>();
  var activeIndex = Rxn<int>();

  final box = GetStorage();

  void toggleImage(int index, String kualitas) {
    if (activeIndex.value == index) {
      activeIndex.value = null;
      selectedKualitasTidur.value = null;
      box.write('sleep_quality', selectedKualitasTidur.value);
    } else {
      activeIndex.value = index;
      selectedKualitasTidur.value = kualitas;
      box.write('sleep_quality', selectedKualitasTidur.value);
    }
  }

  Color changeColor(int index) {
    return activeIndex.value == index ? whiteColor : primaryColor;
  }

  Color changeBackgroundColor(int index) {
    return activeIndex.value == index ? primaryColor : whiteColor;
  }

  Widget warningText() {
    return activeIndex.value == null
        ? Padding(
            padding: const EdgeInsets.all(30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.orange,
                ),
                Text(
                  'Silahkan pilih salah satu',
                  style: h5Bold.copyWith(color: Colors.orange),
                )
              ],
            ),
          )
        : const Padding(
            padding: EdgeInsets.all(30.0),
            child: Text(' '),
          );
  }

  final count = 0.obs;
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

  void increment() => count.value++;
}
