import 'package:get/get.dart';

class CreateJournalController extends GetxController {
  //TODO: Implement CreateJournalController

  var sliderValue = 0.0.obs;

  var activeIndex = Rxn<int>();

  void toggleImage(int index) {
    if (activeIndex.value == index) {
      activeIndex.value = null;
    } else {
      activeIndex.value = index;
    }
  }

  double getOpacity(int index) {
    return activeIndex.value == index ? 1.0 : 0.5;
  }

  final count = 0.obs;

  @override
  void onClose() {}
  void increment() => count.value++;
}
