import 'package:cloud_firestore/cloud_firestore.dart';

class Message{
  final String senderId;
  final String receiverId;
  final String senderEmail;
  final Timestamp timestamp;
  final String message;

  Message({required this.senderId, required this.receiverId, required this.senderEmail, required this.timestamp, required this.message});
  
  Map<String,dynamic> toJson(){
    return {
      'message': message,
      'senderId': senderId,
      'timestamp': timestamp,
      'receiverId': receiverId,
      'senderEmail': senderEmail,
    };
  }
}