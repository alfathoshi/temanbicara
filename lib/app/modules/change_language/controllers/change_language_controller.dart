import 'package:get/get.dart';

enum Lang { bahasa, english }

class ChangeLanguageController extends GetxController {
  var selectedLanguage = Lang.english.obs;
  void toggleLanguage(Lang lang) {
    selectedLanguage.value = lang;
  }

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
}
