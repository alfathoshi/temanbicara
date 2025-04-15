import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:temanbicara/app/config/config.dart';

class SendOtpController extends GetxController {
  //TODO: Implement SendOtpController
  RxBool isLoading = false.obs;
  RxBool isButtonActive = true.obs;
  TextEditingController emailController = TextEditingController();

  Future<Map<String, dynamic>?> sendOtp() async {
    try {
      var response = await http.post(
        Uri.parse("${Config.apiEndPoint}/password/otp"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': emailController.text,
        }),
      );
      print(response.body);
      return jsonDecode(response.body);
    } catch (err) {
      print(err);
      rethrow;
    }
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
