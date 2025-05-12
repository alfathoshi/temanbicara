import 'package:get/get.dart';

class NavigationBarController extends GetxController {
  var args = Get.arguments;
  var selectedindex = 0.obs;

  void changeIndex(int index) {
    selectedindex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    if (args != null) {
      selectedindex.value = args["indexPage"];
    }
  }
}
