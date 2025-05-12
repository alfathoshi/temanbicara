import 'package:get/get.dart';

class StressLevelController extends GetxController {
  final count = 0.obs;

  void increment() => count.value++;
}
