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

  var tappedIndex = (-1).obs;

  void toggleTap(int index) {
    tappedIndex.value = tappedIndex.value == index ? -1 : index;

    switch (index) {
      case 0:
        box.write('sleep_quality', '8 - 9 jam');
        break;
      case 1:
        box.write('sleep_quality', '7 - 8 jam');
        break;
      case 2:
        box.write('sleep_quality', '6 - 7 jam');
        break;
      case 3:
        box.write('sleep_quality', '5 - 6 jam');
        break;
      case 4:
        box.write('sleep_quality', 'kurang dari 4 jam');
        break;
    }
  }

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

  void increment() => count.value++;
}
