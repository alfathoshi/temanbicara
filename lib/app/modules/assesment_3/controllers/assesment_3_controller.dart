import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Assesment3Controller extends GetxController {
  final box = GetStorage();
  var tappedIndex = (-1).obs;

  void toggleTap(int index) {
    tappedIndex.value = tappedIndex.value == index ? -1 : index;

    switch (index) {
      case 0:
        box.write('sleep_quality', '8 - 9 jam');
        break;
      case 1:
        box.write('sleep_quality', '7 - 8 jam');
        break;
      case 2:
        box.write('sleep_quality', '6 - 7 jam');
        break;
      case 3:
        box.write('sleep_quality', '5 - 6 jam');
        break;
      case 4:
        box.write('sleep_quality', 'kurang dari 4 jam');
        break;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print(box.getValues());
  }
}
