import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  

  final count = 0.obs;


  @override
  void onClose() {}
  void increment() => count.value++;
}
