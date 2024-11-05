import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../themes/colors.dart';
import '../../../themes/fonts.dart';
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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: Container(),
              ),
              TextField(
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    Iconsax.send_1,
                    color: primaryColor,
                  ),
                  hintText: 'Apa yang kamu pikirkan?',
                  hintStyle: h6RegularShade,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: primaryColor, width: 2)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
