import 'package:get/get.dart';

class Assesment4Controller extends GetxController {
  var isSelected = (-1).obs; 

  void selectOption(int index) {
    isSelected.value = index;
  }
}
