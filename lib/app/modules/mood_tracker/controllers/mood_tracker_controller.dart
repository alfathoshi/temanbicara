import 'package:get/get.dart';

class MoodTrackerController extends GetxController {
  final count = 0.obs;

  void increment() => count.value++;
}
