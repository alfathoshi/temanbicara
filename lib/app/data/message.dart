import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderName;
  final String message;
  final String senderID;
  final String receiverID;
  final Timestamp timestamp;

  Message({
    required this.senderName,
    required this.message,
    required this.senderID,
    required this.receiverID,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderName': senderName,
      'message': message,
      'senderID': senderID,
      'receiverID': receiverID,
      'timestamp': timestamp,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      senderName: map['senderName'] as String? ?? '',
      message: map['message'] as String? ?? '',
      senderID: map['senderID'] as String? ?? '',
      receiverID: map['receiverID'] as String? ?? '',
      timestamp: map['timestamp'] as Timestamp? ?? Timestamp.now(),
    );
  }
}
