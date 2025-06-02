import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:temanbicara/app/themes/colors.dart'; // Pastikan whiteColor dan black terdefinisi di sini

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isUserMessage;
  final Timestamp timestamp;

  const ChatBubble({
    super.key,
    required this.text,
    required this.isUserMessage,
    required this.timestamp,
  });

  String _formatChatTimestamp(Timestamp ts) {
    DateTime dateTime = ts.toDate();
    // Hanya tampilkan jam dan menit
    return DateFormat('HH:mm').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    CrossAxisAlignment bubbleCrossAxisAlignment =
        isUserMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    Alignment bubbleAlignmentContainer =
        isUserMessage ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: bubbleAlignmentContainer,
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Column(
        crossAxisAlignment: bubbleCrossAxisAlignment,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75),
            decoration: BoxDecoration(
              color: isUserMessage ? primaryColor : grey4Color,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(12),
                topRight: const Radius.circular(12),
                bottomLeft: isUserMessage
                    ? const Radius.circular(12)
                    : const Radius.circular(0),
                bottomRight: isUserMessage
                    ? const Radius.circular(0)
                    : const Radius.circular(12),
              ),
            ),
            child: Text(
              text,
              style: TextStyle(
                color: isUserMessage ? whiteColor : black,
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(height: 3),
          Padding(
            padding: isUserMessage
                ? const EdgeInsets.only(right: 2.0)
                : const EdgeInsets.only(left: 2.0),
            child: Text(
              _formatChatTimestamp(timestamp),
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
