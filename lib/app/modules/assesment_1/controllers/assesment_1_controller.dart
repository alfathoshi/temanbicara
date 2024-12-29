import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/colors.dart';

enum Gender { none, male, female }

class Assesment1Controller extends GetxController {
  TextEditingController nameC = TextEditingController();
  TextEditingController nicknameC = TextEditingController();

  GetStorage box = GetStorage();

  var selectedGender = Gender.none.obs;
  void toggleGender(Gender gender) {
    selectedGender.value = gender;
  }

  var selectedDate = DateTime.now().obs;
  void updateDate(DateTime date) {
    selectedDate.value = DateTime(date.year, date.month, date.day);
    ;
  }

  var selectedMBTI = ''.obs;
  void setMBTI(String mbti) {
    selectedMBTI.value = mbti;
  }

  var favoriteTopics = <String>[].obs;
  void toggleFavoriteTopic(String topic) {
    if (favoriteTopics.contains(topic)) {
      favoriteTopics.remove(topic);
    } else {
      favoriteTopics.add(topic);
    }
  }

  var isSportTap = false.obs;
  var isArtTap = false.obs;
  var isPoliticsTap = false.obs;
  var isAnxietyTap = false.obs;
  var isTechTap = false.obs;
  var isInnovationTap = false.obs;
  var isLainnyaTap = false.obs;
  void toggleTopis(String topic) {
    switch (topic) {
      case 'Sport':
        isSportTap.value = !isSportTap.value;
        toggleFavoriteTopic(topic);
        break;
      case 'Art':
        isArtTap.value = !isArtTap.value;
        toggleFavoriteTopic(topic);
        break;
      case 'Politics':
        isPoliticsTap.value = !isPoliticsTap.value;
        toggleFavoriteTopic(topic);
        break;
      case 'Anxiety':
        isAnxietyTap.value = !isAnxietyTap.value;
        toggleFavoriteTopic(topic);
        break;
      case 'Tech':
        isTechTap.value = !isTechTap.value;
        toggleFavoriteTopic(topic);
        break;
      case 'Innovation':
        isInnovationTap.value = !isInnovationTap.value;
        toggleFavoriteTopic(topic);
        break;
      case 'Lainnya':
        isLainnyaTap.value = !isLainnyaTap.value;
        toggleFavoriteTopic(topic);
        break;
    }
  }

  void saveData() {
    box.write('name', nameC.text);
    box.write('nickname', nicknameC.text);
    if (selectedGender == Gender.male) {
      box.write('gender', 'Male');
    } else if (selectedGender == Gender.female) {
      box.write('gender', 'Female');
    }
    box.write('mbti', selectedMBTI.value);
    String topics = favoriteTopics.join(',');
    box.write('topics', topics);
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate.value);
    box.write('birthdate', formattedDate);

    Get.toNamed(Routes.ASSESMENT_2);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
