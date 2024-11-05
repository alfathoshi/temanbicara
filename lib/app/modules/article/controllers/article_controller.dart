import 'package:get/get.dart';

class ArticleController extends GetxController {
  //TODO: Implement ArticleController

  final count = 0.obs;


  @override
  void onClose() {}
  void increment() => count.value++;
}
