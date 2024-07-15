import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/chatbot_controller.dart';

class ChatbotView extends GetView<ChatbotController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChatbotView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ChatbotView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
