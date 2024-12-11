import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';

class TrackingController extends GetxController {
  //TODO: Implement TrackingController

  var activeIndex = Rxn<int>();

  void toggleImage(int index) {
    if (activeIndex.value == index) {
      // If the same image is clicked again, set it to inactive
      activeIndex.value = null;
    } else {
      // Set the clicked image as active
      activeIndex.value = index;
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
