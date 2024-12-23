import 'package:get/get.dart';

class EditProfileController extends GetxController {
  var selectedDate = DateTime.now().obs;
  void updateDate(DateTime date) {
    selectedDate.value = date;
  }

  var selectedDateOfBirth = ''.obs;
  void setDateOfBirth(String date) {
    selectedDateOfBirth.value = date;
  }

  var selectedCountry = ''.obs;
  void setCountry(String country) {
    selectedCountry.value = country;
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
