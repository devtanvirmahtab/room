import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel{
  final String content;
  final String senderId;
  final DateTime timestamp;

  MessageModel({
    required this.content,
    required this.senderId,
    required this.timestamp,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      content: json['content'],
      senderId: json['senderId'],
        timestamp: json['timestamp'] != null
    ? (json['timestamp'] as Timestamp).toDate()
        : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'senderId': senderId,
      'timestamp': timestamp,
    };
  }
}
