import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:temanbicara/app/modules/room_chat/controllers/room_chat_controller.dart';
import 'package:temanbicara/app/themes/fonts.dart';
import 'package:temanbicara/app/widgets/chatContainer.dart';

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
        SliverToBoxAdapter(
          child: FutureBuilder(
            future: controller.fetchData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Align(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else if (snapshot.hasData) {
                final List rawData = snapshot.data!['data'];
                final List<Map<String, dynamic>> listData =
                    rawData.fold([], (List<Map<String, dynamic>> acc, item) {
                  if (acc.indexWhere((element) =>
                          element['counselor_id'] == item['counselor_id']) ==
                      -1) {
                    acc.add(item);
                  }
                  return acc;
                });
                final double containerHeight =
                    listData.length <= 2 ? listData.length * 180.0 : 530.0;
                return Container(
                  constraints: BoxConstraints(
                    maxHeight: containerHeight,
                  ),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: listData.length <= 2 ? listData.length : 3,
                    itemBuilder: (BuildContext context, int index) {
                      var data = listData[index];
                      return Padding(
                          padding: const EdgeInsets.only(left: 24, right: 24),
                          child: Chatcontainer(
                            id: data['counselor_id'],
                            nama: data['counselor_name'],
                            deskripsi: data['description'],
                            image: 'profile', time: data['start_time'],
                          ));
                    },
                  ),
                );
              } else {
                return const Center(child: Text("Tidak Ada Data"));
              }
            },
          ),
        )
      ]),
    );
  }
}
