import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:temanbicara/app/routes/app_pages.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/widgets/history_chatbot.dart';

import '../../../themes/fonts.dart';
import '../controllers/chatbot_controller.dart';

class ChatbotView extends GetView<ChatbotController> {
  const ChatbotView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 85,
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
                side: BorderSide(color: Colors.black12)),
            title: Text(
              'Chatbot',
              style: h3Bold,
            ),
            centerTitle: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.CHATBOT_ROOM);
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(color: border),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: primaryColor,
                              foregroundColor: whiteColor,
                              radius: 16,
                              child: const Icon(
                                Iconsax.add,
                                size: 16,
                              ),
                            ),
                            const SizedBox(
                              width: 24,
                            ),
                            Text(
                              'New Chat',
                              style: h6SemiBold,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'History Chat',
                    style: h5SemiBold,
                  )
                ],
              ),
            ),
          ),
          SliverList.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return const HistoryChatbot();
              })
        ],
      ),
    );
  }
}
