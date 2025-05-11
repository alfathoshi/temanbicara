import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:temanbicara/app/themes/fonts.dart';

import '../controllers/room_chat_controller.dart';

class RoomChatView extends GetView<RoomChatController> {
  final String? nama;
  final String? image;
  RoomChatView({this.nama, this.image, super.key});
  final TextEditingController _chatController = TextEditingController();
  @override
  final RoomChatController controller = Get.put(RoomChatController());

  void _sendMessage() {
    final messageText = _chatController.text.trim();
    if (messageText.isEmpty) return;

    // Tambahkan pesan ke daftar observable
    controller.dataChat.add({
      'isMine': true,
      'message': messageText,
    });

    _chatController.clear();

    // Simulasi pesan balasan dari pengguna lain
    Future.delayed(const Duration(seconds: 5), () {
      controller.dataChat.add({
        'isMine': false,
        'message': messageText,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 85, // Tinggi AppBar

        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: Colors.black12),
        ),
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: CircleAvatar(
                radius: 30,
                backgroundImage: image != null
                    ? AssetImage('assets/images/$image.png')
                    : const AssetImage('assets/images/default.png'),
              ),
            ),
            SizedBox(
              width: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nama ?? "Unknown",
                    style: h3Bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 5,
                        backgroundColor: Colors.green,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "online",
                        style: h7Regular,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Menampilkan pesan menggunakan GetX
          Expanded(
            child: Obx(() {
              return ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: controller.dataChat.length, // Jumlah pesan
                itemBuilder: (context, index) {
                  final userLogin = controller.dataChat[index]['isMine'];
                  return Align(
                    alignment: !userLogin
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: !userLogin
                            ? Colors.grey[300]
                            : const Color(0xFFC8DF98),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        controller.dataChat[index]["message"],
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          Container(
            height: 60, // Tinggi TextField
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.black12),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _chatController,
                    decoration: InputDecoration(
                      hintText: "Masukkan pesan ...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    print(controller.dataChat);
                    _sendMessage();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
