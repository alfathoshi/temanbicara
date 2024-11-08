import 'package:get/get.dart';

class Assesment7Controller extends GetxController {
  
  var selectedNumber = 0.obs;

  void selectNumber(int number) {
    selectedNumber.value = number;
  }
}
