import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/widgets/chat_container.dart';

import '../../../data/message.dart';
import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: RefreshIndicator(
          color: primaryColor,
          onRefresh: () async {
            await controller.fetchData();
          },
          notificationPredicate: (notification) {
            return notification is ScrollUpdateNotification &&
                notification.metrics.extentBefore == 0;
          },
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                floating: true,
                toolbarHeight: 85,
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black12)),
                title: Text(
                  'Message',
                  style: h3Bold,
                ),
                centerTitle: true,
              ),
              Obx(() {
                if (controller.isLoading.value && controller.listChat.isEmpty) {
                  return SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(color: primaryColor),
                    ),
                  );
                } else if (controller.listChat.isEmpty) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Text(
                        "No chat available",
                        style: h6SemiBold,
                      ),
                    ),
                  );
                } else {
                  final listData = controller.listChat;

                  return SliverList.builder(
                    itemCount: listData.length,
                    itemBuilder: (context, index) {
                      final data = listData[index];
                      final counselorId = data['counselor_id'].toString();
                      final counselorName =
                          data['counselor_name'] ?? 'Counselor';
                      final dateStr = data['date'] as String? ?? '';
                      final startTimeStr = data['start_time'] as String? ?? '';
                      final endTimeStr = data['end_time'] as String? ?? '';
                      final image = data['counselor_profile_url'];

                      final datePart = dateStr.split(' ')[0];
                      final fullStartTime =
                          datePart.isNotEmpty && startTimeStr.isNotEmpty
                              ? "$datePart $startTimeStr"
                              : "";
                      final fullEndTime =
                          datePart.isNotEmpty && endTimeStr.isNotEmpty
                              ? "$datePart $endTimeStr"
                              : "";

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 8),
                        child: StreamBuilder<QuerySnapshot>(
                          stream: controller.getLastMessageStream(counselorId),
                          builder: (context, snapshot) {
                            String lastMessage = "Memuat pesan...";
                            String displayTime = fullStartTime;

                            if (snapshot.hasError) {
                              lastMessage = "Error memuat pesan.";
                            }

                            if (snapshot.hasData &&
                                snapshot.data!.docs.isNotEmpty) {
                              final messageData = snapshot.data!.docs.first
                                  .data() as Map<String, dynamic>?;
                              if (messageData != null) {
                                final messageObj = Message.fromMap(messageData);
                                lastMessage = messageObj.message;
                                displayTime = controller
                                    .formatTimestamp(messageObj.timestamp);
                              } else {
                                lastMessage = "Belum ada percakapan.";
                              }
                            } else if (snapshot.connectionState !=
                                    ConnectionState.waiting &&
                                (snapshot.data == null ||
                                    snapshot.data!.docs.isEmpty)) {
                              lastMessage = "Belum ada percakapan.";
                            }

                            return ChatContainer(
                              id: counselorId,
                              nama: counselorName,
                              deskripsi: lastMessage,
                              image: image,
                              startTime: fullStartTime,
                              endTime: fullEndTime,
                              time: displayTime,
                            );
                          },
                        ),
                      );
                    },
                  );
                }
              }),
            ],
          ),
        ));
  }
}
