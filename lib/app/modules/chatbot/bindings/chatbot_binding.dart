import 'package:get/get.dart';

import '../controllers/chatbot_controller.dart';

class ChatbotBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatbotController>(
      () => ChatbotController(),
    );
  }
}
