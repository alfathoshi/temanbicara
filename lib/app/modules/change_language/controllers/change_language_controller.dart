import 'package:get/get.dart';

enum Lang { bahasa, english }

class ChangeLanguageController extends GetxController {
  var selectedLanguage = Lang.english.obs;
  void toggleLanguage(Lang lang) {
    selectedLanguage.value = lang;
  }
}
