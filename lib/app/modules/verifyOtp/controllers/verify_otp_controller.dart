import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temanbicara/app/config/config.dart';
import 'package:http/http.dart' as http;
import 'package:temanbicara/app/routes/app_pages.dart';

class VerifyOtpController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isButtonActive = true.obs;
  RxInt focusedIndex = 0.obs;
  String email = Get.arguments['email'];
  RxBool isCorrect = true.obs;

  final count = 0.obs;
  List<TextEditingController> controllers =
      List.generate(6, (_) => TextEditingController());

  List<FocusNode> focusNodes = List.generate(
    6,
    (_) => FocusNode(),
  );

  String explodeOtpController(List<TextEditingController> controllers) {
    String text = "";
    for (TextEditingController controller in controllers) {
      text += controller.text;
    }

    return text;
  }

  Future<void> sendOtp() async {
    try {
      var response = await http.post(
        Uri.parse("${Config.apiEndPoint}/password/otp"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': Get.arguments['email'],
        }),
      );
      print(response.body);
    } catch (err) {
      rethrow;
    }
  }

  Future<void> verifyOtp() async {
    try {
      var response = await http.post(
        Uri.parse("${Config.apiEndPoint}/password/otp/valid"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
          {
            "otp": explodeOtpController(controllers),
            "user_id": Get.arguments['user_id'],
          },
        ),
      );

      Map<String, dynamic> res = json.decode(response.body);

      isCorrect.value = res['status'];

      if (isCorrect.value) {
        Get.toNamed(
          Routes.FORGOT_PASSWORD,
          arguments: {
            "otp": explodeOtpController(controllers),
            "user_id": Get.arguments['user_id'],
          },
        );
      }
    } catch (err) {
      print(err);
      rethrow;
    }
  }

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
