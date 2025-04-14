import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyOtpController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isButtonActive = true.obs;
  RxInt focusedIndex = 0.obs;

  final count = 0.obs;
  List<TextEditingController> controllers =
      List.generate(6, (_) => TextEditingController());

  List<FocusNode> focusNodes = List.generate(
    6,
    (_) => FocusNode(),
  );

  @override
  void onInit() {
    for (int i = 0; i < 6; i++) {
      focusNodes[i].addListener(() {
        if (focusNodes[i].hasFocus) {
          focusedIndex.value = i;
        }
      });
    }
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

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }

    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void increment() => count.value++;
}
