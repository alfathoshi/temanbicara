import 'package:get/get.dart';

class NavigationBarController extends GetxController {
  var selectedindex = 0.obs;
  var community = false.obs;
  void changeIndex(int index) {
    selectedindex.value = index;
    if (selectedindex.value == 3) {
      community.value = true;
    } else {
      community.value = false;
    }
  }
}
