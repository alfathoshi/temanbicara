import 'package:get/get.dart';

class JournalController extends GetxController {
  //TODO: Implement JournalController

  final count = 0.obs;


  @override
  void onClose() {}
  void increment() => count.value++;
}
