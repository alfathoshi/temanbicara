import 'package:get/get.dart';

enum Lang { bahasa, english }

class ChangeLanguageController extends GetxController {
  var selectedGender = Lang.bahasa.obs;
  void toggleGender(Lang lang) {
    selectedGender.value = lang;
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
