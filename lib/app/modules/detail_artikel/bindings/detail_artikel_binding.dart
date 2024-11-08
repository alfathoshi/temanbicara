import 'package:get/get.dart';

import '../controllers/detail_artikel_controller.dart';

class DetailArtikelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailArtikelController>(
      () => DetailArtikelController(),
    );
  }
}
