import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Assesment4Controller extends GetxController {
  final box = GetStorage();
  var isSelected = (-1).obs;

  void selectOption(int index) {
    isSelected.value = index;
    switch (index) {
      case 0:
        box.write('have_consulted', 1);
      case 1:
        box.write('have_consulted', 0);
    }
  }

}
