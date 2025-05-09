import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:temanbicara/app/config/config.dart';
import 'package:temanbicara/app/modules/edit_profile/controllers/datepicker_controller.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/colors.dart';

enum Gender { none, male, female }

class Assesment1Controller extends GetxController {
  final DatePickerController dateController = Get.put(DatePickerController());

  TextEditingController nameC = TextEditingController();
  TextEditingController nicknameC = TextEditingController();
  TextEditingController phoneC = TextEditingController();

  var isLoading = false.obs;

  GetStorage box = GetStorage();

  var selectedGender = Gender.none.obs;
  void toggleGender(Gender gender) {
    selectedGender.value = gender;
  }

  var isSportTap = false.obs;
  var isArtTap = false.obs;
  var isPoliticsTap = false.obs;
  var isAnxietyTap = false.obs;
  var isTechTap = false.obs;
  var isInnovationTap = false.obs;
  var isLainnyaTap = false.obs;

  bool isFilled() {
    return nameC.text.isNotEmpty &&
        nicknameC.text.isNotEmpty &&
        phoneC.text.isNotEmpty &&
        selectedGender != Gender.none;
  }

  Future<void> saveAssesment() async {
    if (isFilled()) {
      box.write('name', nameC.text);
      box.write('nickname', nicknameC.text);
      box.write('phone', phoneC.text);
      if (selectedGender == Gender.male) {
        box.write('gender', 'male');
      } else if (selectedGender == Gender.female) {
        box.write('gender', 'female');
      }
      String formattedDate =
          DateFormat('yyyy-MM-dd').format(dateController.selectedDate.value);
      box.write('birthdate', formattedDate);
      isLoading.value = true;
      try {
        var response = await http.post(
          Uri.parse("${Config.apiEndPoint}/do-assessment"),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${box.read('token')}',
          },
          body: json.encode({
            'name': box.read('name'),
            'nickname': box.read('nickname'),
            'gender': box.read('gender'),
            'birthdate': box.read('birthdate'),
            'phone_number': box.read('phone'),
          }),
        );

        var data = json.decode(response.body);
        if (response.statusCode == 200 && data['status']) {
          Get.snackbar(
            'Success',
            'Akun berhasil dibuat',
            backgroundColor: primaryColor.withOpacity(0.6),
            colorText: Colors.white,
          );
          Get.toNamed(Routes.ASSESMENT_2);
        } else {
          Get.snackbar('Error', data['message'],
              backgroundColor: Colors.red.withOpacity(0.6),
              colorText: Colors.white);
        }
      } catch (e) {
        Get.snackbar('Error', e.toString(),
            backgroundColor: Colors.red.withOpacity(0.6),
            colorText: Colors.white);
      } finally {
        isLoading.value = false;
      }
    } else {
      Get.snackbar(
        'Error',
        'Silahkan isi data diri',
        colorText: whiteColor,
        backgroundColor: error.withOpacity(0.6),
      );
    }
  }
}
