import 'package:chat_app/const/routes.dart';
import 'package:chat_app/core/auth_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Logincontroller extends GetxController{
  final Auth = Get.put(AuthService());
  late final TextEditingController emailcontroller;
  late final TextEditingController passwordcontroller;
  RxBool loading = false.obs;
  final db = FirebaseFirestore.instance;
  final Firebaseauth = FirebaseAuth.instance;
  @override
  void onInit() {
    emailcontroller= TextEditingController();
    passwordcontroller = TextEditingController();
    super.onInit();
  }
  @override
  void onClose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.onClose();
  }
  Future<void> UpdateStatus() async{
    await  db.collection("users").doc(Firebaseauth.currentUser!.uid).update({
      "status":true
    });
   }
  Future<void> onLogin()async {    
    if(emailcontroller.text.isEmpty && passwordcontroller.text.isEmpty){
      Get.snackbar("Error", "Please fill all the fields", colorText: Colors.red, duration: const Duration(seconds: 2));
    }else{
      loading.value = true;
      bool login= await Auth.loginUserWithEmailAndPassword(emailcontroller.text, passwordcontroller.text);
      loading.value = Auth.loading.value;
      if(!login){
        return;
      }
      emailcontroller.clear();
      passwordcontroller.clear();
      SharedPreferences sharedpreferences =  await SharedPreferences.getInstance() ;
      sharedpreferences.setString("step","home");
      Get.toNamed(AppRoutes.homechat);
      await UpdateStatus();
    }
  }
}