import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:temanbicara/app/modules/room_chat/controllers/room_chat_controller.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/widgets/chatContainer.dart';

import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  ChatView({super.key});
  final RoomChatController _controller = Get.put(RoomChatController());
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
        SliverList.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Obx(() {
              final deskripsi = _controller.dataChat.isEmpty
                  ? " "
                  : (index < _controller.dataChat.length
                      ? _controller.dataChat[_controller.dataChat.length - 1]
                          ['message']
                      : " ");

              return InkWell(
                onTap: () async {
                  print(_controller.dataChat[_controller.dataChat.length - 1]
                      ['message']);
                  print(_controller.dataChat.length);
                  if (deskripsi == " ") {
                    await _controller.fetchChatForUser(data[index]["nama"]);
                  }
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: Chatcontainer(
                    nama: data[index]["nama"],
                    deskripsi: deskripsi,
                    image: data[index]["image"],
                  ),
                ),
              );
            });
          },
        )
      ]),
    );
  }
}

List<Map<String, dynamic>> data = [
  {
    "image": "article1",
    "nama": "Saskhya Aulia , S.Psi., M.Psi.",
    "deskripsi": "Yuk berbincang dengan Saskhya Aulia",
  },
  {
    "image": "article1",
    "nama": "Alex Tomahawk",
    "deskripsi":
        "The quick brown fox jumps overthe lazydog, and support tailored to your spec-ific needs.",
  },
];
