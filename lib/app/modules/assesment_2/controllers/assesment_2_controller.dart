import 'package:get/get.dart';

class Assesment2Controller extends GetxController {
   var tappedIndex = (-1).obs;

  void toggleTap(int index) {
    tappedIndex.value = tappedIndex.value == index ? -1 : index;
  }
}
