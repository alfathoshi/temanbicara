import 'package:get/get.dart';

import '../controllers/room_chat_controller.dart';

class RoomChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RoomChatController>(
      () => RoomChatController(),
    );
  }
}
