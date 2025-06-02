import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:temanbicara/app/data/message.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/themes/spaces.dart';
import 'package:temanbicara/app/widgets/chat_bubble.dart';
import 'package:temanbicara/app/widgets/custom_appbar.dart';

import '../../../widgets/date_separator.dart';
import '../controllers/chat_room_controller.dart';

abstract class ChatDisplayItem {}

class MessageDisplayItem extends ChatDisplayItem {
  final Message message;
  MessageDisplayItem(this.message);
}

class DateSeparatorDisplayItem extends ChatDisplayItem {
  final DateTime date;
  DateSeparatorDisplayItem(this.date);
}

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
        stream: controller.chatService
            .getMessages(controller.user.id, controller.otherUser.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final messagesDocs = snapshot.data!.docs;
          List<Message> chronologicalMessages = messagesDocs
              .map((doc) => Message.fromMap(doc.data() as Map<String, dynamic>))
              .toList()
              .reversed
              .toList();

          List<ChatDisplayItem> displayItems = [];
          DateTime?
              lastDisplayedDateHeader; // Untuk melacak tanggal terakhir header yang ditampilkan

          for (var message in chronologicalMessages) {
            DateTime messageDay = DateTime(
                message.timestamp.toDate().year,
                message.timestamp.toDate().month,
                message.timestamp.toDate().day);

            if (lastDisplayedDateHeader == null ||
                !isSameDay(lastDisplayedDateHeader, messageDay)) {
              displayItems.add(DateSeparatorDisplayItem(messageDay));
              lastDisplayedDateHeader = messageDay;
            }

            displayItems.add(MessageDisplayItem(message));
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemCount: displayItems.length,
                  itemBuilder: (context, index) {
                    final item = displayItems[displayItems.length - 1 - index];

                    if (item is DateSeparatorDisplayItem) {
                      return DateSeparatorWidget(date: item.date);
                    } else if (item is MessageDisplayItem) {
                      final message = item.message;
                      bool isUserMessage =
                          message.senderID == controller.user.id;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ChatBubble(
                          text: message.message,
                          isUserMessage: isUserMessage,
                          timestamp: message.timestamp,
                        ),
                      );
                    }
                    return const SizedBox.shrink();
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
