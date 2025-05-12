import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Assesment5Controller extends GetxController {
  final box = GetStorage();
  var isSelected = (-1).obs;

  void selectOption(int index) {
    isSelected.value = index;
    switch (index) {
      case 0:
        box.write('consumed_medicine', 1);
      case 1:
        box.write('consumed_medicine', 0);
    }
  }

}
