import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Assesment6Controller extends GetxController {

  final box = GetStorage();

  final count = 0.obs;

  void increment() => count.value++;
}
