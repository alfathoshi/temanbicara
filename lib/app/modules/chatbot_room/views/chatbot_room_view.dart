import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../themes/colors.dart';
import '../controllers/chatbot_room_controller.dart';

class ChatbotRoomView extends GetView<ChatbotRoomController> {
  const ChatbotRoomView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        toolbarHeight: 85,
        backgroundColor: whiteColor,
        shape: UnderlineInputBorder(
          borderSide: BorderSide(
            color: border,
          ),
        ),
        title: CircleAvatar(
          backgroundColor: primaryColor,
          radius: 24,
          child: Image.asset(
            'assets/icons/chatbot.png',
            scale: 5,
          ),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Icon(Iconsax.message_question),
          )
        ],
      ),
      body: Obx(
        () => Chat(
          messages: controller.messages.toList(),
          showUserAvatars: true,
          showUserNames: true,
          onSendPressed: controller.handleSendPressed,
          user: controller.user,
          avatarBuilder: (user) {
            return Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: primaryColor, width: 1),
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.asset(
                  'assets/images/logo.png',
                  scale: 8,
                ),
              ),
            );
          },
          theme: DefaultChatTheme(
            inputBackgroundColor: Colors.white,
            inputMargin: const EdgeInsets.all(8),
            inputTextColor: Colors.black,
            inputBorderRadius: BorderRadius.circular(50),
            inputContainerDecoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(50),
            ),
            sendButtonIcon: Icon(
              Iconsax.send1,
              color: primaryColor,
            ),
            userAvatarNameColors: [
              primaryColor,
              whiteColor,
            ],
            primaryColor: primaryColor,
          ),
        ),
      ),
    );
  }
}
