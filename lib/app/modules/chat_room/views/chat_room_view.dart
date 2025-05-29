import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/widgets/chat_bubble.dart';
import 'package:temanbicara/app/widgets/custom_appbar.dart';

import '../controllers/chat_room_controller.dart';

class ChatRoomView extends GetView<ChatRoomController> {
  const ChatRoomView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: CustomAppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: black,
              radius: 25,
              child: CircleAvatar(
                backgroundColor: whiteColor,
                radius: 24,
                child: Image.asset(
                  'assets/images/profile.png',
                  scale: 3,
                ),
              ),
            ),
            sbX12,
            Text(
              controller.args['name'],
              style: h4Bold,
            )
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: controller.chatService.getMessages(controller.user.id,
            controller.otherUser.id), 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator()); 
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          List<types.TextMessage> newMessages = snapshot.data!.docs.map((doc) {
            var user = types.User(id: doc['senderID']);
            return types.TextMessage(
              id: doc.id,
              author: user,
              text: doc['message'],
              createdAt: doc['timestamp'].millisecondsSinceEpoch,
            );
          }).toList();

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemCount: newMessages.length,
                  itemBuilder: (context, index) {
                    final message = newMessages[index];
                    bool isUserMessage =
                        message.author.id == controller.user.id;

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ChatBubble(
                        text: message.text,
                        isUserMessage: isUserMessage,
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller.messageC,
                        cursorColor: black,
                        decoration: InputDecoration(
                          hintText: 'Tulis pesan disini...',
                          hintStyle: h5Regular.copyWith(color: grey2Color),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: greyColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: primaryColor),
                          ),
                        ),
                        onSubmitted: (text) {
                          controller.handleSendPressed(text);
                          controller.messageC.text = '';
                        },
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Iconsax.send1,
                        color: primaryColor,
                      ),
                      onPressed: () {
                        controller.handleSendPressed(controller.messageC.text);
                        controller.messageC.text = '';
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
