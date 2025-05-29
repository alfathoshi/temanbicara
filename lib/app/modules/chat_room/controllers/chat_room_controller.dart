import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get_storage/get_storage.dart';
import 'package:temanbicara/app/services/chat_services.dart';

class ChatRoomController extends GetxController {
  final box = GetStorage();
  final args = Get.arguments;

  var user = const types.User(id: '');
  var otherUser = const types.User(id: '');

  final messageC = TextEditingController();

  final ChatService chatService = ChatService();
  var canSendMessage = false.obs;

  Future<void> handleSendPressed(String message) async {
    if (message.trim().isNotEmpty) {
      await chatService.sendMessage(otherUser.id, message);
      canSendMessage.value = false; 
    }
  }

  @override
  void onInit() {
    super.onInit();
    user = types.User(
      id: box.read('id').toString(),
      firstName: box.read('nickname'),
    );
    otherUser = types.User(
      id: args['counselor_id'].toString(),
      firstName: args['name'],
    );
  }
}
