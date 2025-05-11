import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Assesment2Controller extends GetxController {
  final box = GetStorage();

  var tappedIndex = (-1).obs;

  void toggleTap(int index) {
    tappedIndex.value = tappedIndex.value == index ? -1 : index;
    switch (index) {
      case 0:
        box.write('goal', 'Aku ingin mengurangi stress');
        break;
      case 1:
        box.write('goal', 'Aku ingin punya seorang teman');
        break;
      case 2:
        box.write('goal', 'Aku ingin berinteraksi dengan AI');
        break;
      case 3:
        box.write('goal', 'Aku ingin bertemu orang baru');
        break;
      case 4:
        box.write('goal', 'Hanya iseng mencoba');
        break;
    }
  }
}
