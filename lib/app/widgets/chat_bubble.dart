import 'package:flutter/material.dart';
import 'package:temanbicara/app/themes/colors.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isUserMessage; 

  const ChatBubble({
    super.key,
    required this.text,
    required this.isUserMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isUserMessage ? primaryColor : grey4Color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isUserMessage ? whiteColor : black,
          ),
        ),
      ),
    );
  }
}
