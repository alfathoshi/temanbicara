import 'package:get/get.dart';

enum Gender { none, male, female }

class Assesment1Controller extends GetxController {
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
  void toggleTopis() {
    if (!isSportTap.value) {
      isSportTap.value = !isSportTap.value;
    } else {
      isPoliticsTap.value = !isPoliticsTap.value;
    }
    // isArtTap.value = !isArtTap.value;
    // isTechTap.value = !isTechTap.value;
    // isAnxietyTap.value = !isAnxietyTap.value;
    // isInnovationTap.value = !isInnovationTap.value;
    // isLainnyaTap.value = !isLainnyaTap.value;
  }
}
