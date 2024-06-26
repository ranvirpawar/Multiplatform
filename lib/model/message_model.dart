import 'package:cloud_firestore/cloud_firestore.dart';

class Message{
  final String senderEmail;
  final String receiverId;
  final String senderId;
  final String message;
  final Timestamp timestamp;
  Message({
    required this.senderEmail,
    required this.receiverId,
    required this.senderId,
    required this.message,
    required this.timestamp,
  });

  /// cconvert to map
  Map<String, dynamic> toMap(){
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'receiverId': receiverId,
      'message': message,
      'timestamp': timestamp,
    };
  } 

}