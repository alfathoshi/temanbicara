import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:temanbicara/app/config/config.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:temanbicara/app/widgets/custom_snackbar.dart';

class LoginController extends GetxController {
  final box = GetStorage();
  late TextEditingController emailC = TextEditingController();
  late TextEditingController passC = TextEditingController();
  var isButtonActive = true.obs;
  var isSecure = true.obs;

  void isEmpty() {
    if (passC.text.isNotEmpty && emailC.text.isNotEmpty) {
      isButtonActive(false);
    } else {
      isButtonActive(true);
    }
  }

  void showPassword() {
    isSecure.value = !isSecure.value;
  }

  var isLoading = false.obs;

  Future<void> login() async {
    if (emailC.text.isEmpty || passC.text.isEmpty) {
      CustomSnackbar.showSnackbar(
        title: "Oops!",
        message: "Please Fill the Fields!",
        status: false,
      );
      return;
    }
    isLoading.value = true;

    try {
      var response = await http.post(
        Uri.parse("${Config.apiEndPoint}/login"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': emailC.text,
          'password': passC.text,
        }),
      );

      var data = json.decode(response.body);
      print(response.body);

      if (response.statusCode == 200 && data['status']) {
        if (data['data']['role'] != 'General') {
          CustomSnackbar.showSnackbar(
            title: "Invalid Credential",
            message: "Please Try Again",
            status: false,
          );
          return;
        }

        box.write('token', data['token']);

        box.write('id', data['data']['id']);
        box.write('email', data['data']['email']);
        box.write('name', data['data']['name']);
        final currentUserID = data['data']['id'].toString();
        await saveFcmToken(currentUserID);
        CustomSnackbar.showSnackbar(
          title: "Success",
          message: "Logged In",
          status: true,
        );

        if (data['data']['name'] == null) {
          Get.toNamed(
            Routes.ASSESMENT_1,
          );
        } else {
          box.write('email', data['data']['email']);
          box.write('password', data['data']['password']);
          box.write('phone', data['data']['phone_number']);
          box.write('name', data['data']['name']);
          box.write('nickname', data['data']['nickname']);
          box.write('birthdate', data['data']['birthdate']);
          box.write('profile_image', data['data']['profile_url']);
          Get.offAllNamed(
            Routes.NAVIGATION_BAR,
            arguments: {"indexPage": 0},
          );
        }
      } else {
        CustomSnackbar.showSnackbar(
          title: "Invalid Credential",
          message: "Please Try Again",
          status: false,
        );
      }
    } catch (e) {
      CustomSnackbar.showSnackbar(
        title: "Error",
        message: "Login Failed",
        status: false,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> saveFcmToken(String userId) async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    if (fcmToken != null) {
      DocumentReference docRef =
          FirebaseFirestore.instance.collection('fcmTokens').doc(userId);

      await docRef.set({
        'tokens': FieldValue.arrayUnion([fcmToken])
      }, SetOptions(merge: true));
    }
  }

  @override
  void onInit() {
    emailC = TextEditingController();
    passC = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    emailC.dispose();
    passC.dispose();
    super.onClose();
  }
}
