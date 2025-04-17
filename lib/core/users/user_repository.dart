import 'package:chat_app/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/get_rx/get_rx.dart';

class UserRepository extends GetxController{
  RxBool loading = false.obs;
  RxBool isUserCreated = false.obs;
  static UserRepository get instance => Get.find();

  final _db =  FirebaseFirestore.instance;

  createUser(UserModel user,String uid) async{
    loading.value = true;
    isUserCreated.value = false;
    await _db.collection("users").doc(uid).set(user.toJson()).whenComplete(
      () {
        loading.value = false;
        isUserCreated.value = true;
       Get.snackbar("Success", "Your account has been created.",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor:Colors.green.withOpacity(0.1),
      colorText: Colors.green
      );
      }
    )
    .catchError((error, stackTrace){
      print("error is $error");
      loading.value = false;
      Get.snackbar("Error","Something went wrong . Try again",
      snackPosition:SnackPosition.BOTTOM,
      backgroundColor: Colors.redAccent.withOpacity(0.1),
      colorText: Colors.red
      );
    });
  } 
}