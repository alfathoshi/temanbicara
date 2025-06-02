import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
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
      body: CustomScrollView(slivers: [
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
            return const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            );
          } else if (controller.listChat.isEmpty) {
            return const SliverFillRemaining(
              child: Center(child: Text("Tidak Ada Chat")),
            );
          } else {
            final List<Map<String, dynamic>> listData = controller.listChat;

            // final double containerHeight =
            //     listData.length <= 2 ? listData.length * 180.0 : 530.0;

            return SliverList.builder(
              // itemCount: listData.length <= 2 ? listData.length : 3, // Hapus batasan ini jika ingin semua tampil
              itemCount: listData.length,
              itemBuilder: (BuildContext context, int index) {
                var data = listData[index];
                String counselorId = data['counselor_id'].toString();
                String counselorName = data['counselor_name'] ?? 'Counselor';
                String startTime = data['start_time'] ?? '';

                return Padding(
                  padding: const EdgeInsets.only(
                      left: 24, right: 24, top: 8, bottom: 8),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: controller.getLastMessageStream(counselorId),
                    builder: (context, snapshot) {
                      String lastMessage = "Memuat pesan...";
                      String displayTime = startTime;

                      if (snapshot.hasError) {
                        lastMessage = "Error memuat pesan.";
                        print("Error stream: ${snapshot.error}");
                      }

                      if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                        var messageData = snapshot.data!.docs.first.data()
                            as Map<String, dynamic>?;
                        if (messageData != null) {
                          final messageObj = Message.fromMap(messageData);
                          lastMessage = messageObj.message;
                          displayTime =
                              controller.formatTimestamp(messageObj.timestamp);
                        } else {
                          lastMessage = "Belum ada percakapan.";
                        }
                      } else if (snapshot.connectionState !=
                              ConnectionState.waiting &&
                          (!snapshot.hasData || snapshot.data!.docs.isEmpty)) {
                        lastMessage = "Belum ada percakapan.";
                      }

                      return ChatContainer(
                        id: counselorId,
                        nama: counselorName,
                        deskripsi: lastMessage,
                        image: 'profile',
                        time: displayTime,
                      );
                    },
                  ),
                );
              },
            );
          }
        })
      ]),
    );
  }
}
