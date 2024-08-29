import 'package:get/get.dart';

import '../controllers/chatbot_room_controller.dart';

class ChatbotRoomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatbotRoomController>(
      () => ChatbotRoomController(),
    );
  }
}
