import 'package:chat_app/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Chatpage extends GetxController{
  final db = FirebaseFirestore.instance;
  final Firebaseauth = FirebaseAuth.instance;
  TextEditingController message = TextEditingController();
  
   @override
  void onClose() {
    message.dispose();
    super.onClose();
  }
  Future<void> sendMessage(String email,String message) async {
    if(message.isEmpty){
      return;
    }
    final Timestamp timestamp = Timestamp.now();
    final userId = Firebaseauth.currentUser!.uid;
    final userEmail = Firebaseauth.currentUser!.email;
    List chatId = [userEmail.toString().replaceFirst(RegExp(r'@gmail.com'), '012'),email.toString().replaceFirst(RegExp(r'@gmail.com'), '012')];
    chatId.sort();
    await db.collection("chat").doc(chatId.join('*')).collection("messages").add(
      Message(
        senderId: userId, 
        receiverId:email, 
        senderEmail: userEmail!,
         timestamp: timestamp,
          message: message
      ).toJson()
    // ignore: body_might_complete_normally_catch_error
    ).catchError((error) {
      Get.snackbar("error", "try again,later",colorText: Colors.red);
    });
  }

  Stream<QuerySnapshot> GetMessage(String email)  {
    final userEmail = Firebaseauth.currentUser!.email;
    List chatId = [userEmail.toString().replaceFirst(RegExp(r'@gmail.com'), '012'),email.toString().replaceFirst(RegExp(r'@gmail.com'), '012')];
    chatId.sort();
    return  db.collection('chat').doc(chatId.join("*")).collection('messages').orderBy("timestamp",descending: false).snapshots();
  }
  Future<void> DeleteMessage(String message,String email)async{
     final userEmail = Firebaseauth.currentUser!.email;
    List chatId = [userEmail.toString().replaceFirst(RegExp(r'@gmail.com'), '012'),email.toString().replaceFirst(RegExp(r'@gmail.com'), '012')];
    chatId.sort();
    final snapshot= await db.collection('chat').doc(chatId.join("*")).collection('messages').get();
    for(var message_data in snapshot.docs){
     Map<String,dynamic> message_user = message_data.data();
     if(message_user['message'] == message){
      String document_id = message_data.id;
      await db.collection('chat').doc(chatId.join("*")).collection('messages').doc(document_id).delete();
     }
    }
  }
}