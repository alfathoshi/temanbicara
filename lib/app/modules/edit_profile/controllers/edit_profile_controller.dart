import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class EditProfileController extends GetxController {
  final box = GetStorage();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  var selectedDate = DateTime.now().obs;
  void updateDate(DateTime date) {
    selectedDate.value = date;
  }

  var selectedCountry = ''.obs;
  void setCountry(String country) {
    selectedCountry.value = country;
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    nameController.text = box.read('name');
    emailController.text = box.read('email');
    DateTime tanggal = DateTime.parse(box.read('birthdate'));
    print(tanggal.toLocal());
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
