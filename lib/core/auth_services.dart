import 'dart:developer';

import 'package:chat_app/core/services/services.dart';
import 'package:chat_app/core/users/user_repository.dart';
import 'package:chat_app/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AuthService extends GetxController {
  Map<String, dynamic>? MyuserData;
  //AccessToken? MyaccessToken;
  //final _auth = FirebaseAuth.instance;
  final  firebaseUser = FirebaseAuth.instance.currentUser;
  var verificationId = ''.obs; 
  //bool checking = true;
  RxBool loading = false.obs;
  MyServices myservice = Get.put(MyServices());
  final auth = FirebaseAuth.instance;
  final userRepo = Get.put(UserRepository());
  @override
  void onInit() {
    super.onInit();
    // Binding the firebaseUser stream to listen to auth changes
    //firebaseUser!.bindStream(FirebaseAuth.instance.userChanges());
  }

  Future<User?> createUserWithEmailAndPassword(String email, String password) async {
    try {
      final cred = await auth.createUserWithEmailAndPassword(email: email, password: password);
      return cred.user;
    } catch (e) {
      log("Something went wrong");
    }
    return null;
  }

  //   Future<void> checkEmailVerified() async {
  //     User? user = FirebaseAuth.instance.currentUser;

  //     if (user != null) {
  //       await user.reload(); // Reload the user's data from Firebase
  //       if (user.emailVerified) {
  //         Get.snackbar("Success", "Successfully signed in with Google",
  //         colorText: Colors.blue, duration: Duration(seconds: 2));
  //         myservice.sharedpreferences.setString("step",'2');
  //         uid = FirebaseAuth.instance.currentUser!.uid;
  //       // Create user in your app's database
  //         final user = UserModel(
  //           email: email,
  //           fullName: name,
  //           firstName: FirstName,
  //           secondName: SecondName,
  //         );
  //           await createUser(user, uid);

  //         Get.offAllNamed(AppRoute.navigation); 
  //       } else {
  //         Get.snackbar(
  //           "Email Not Verified",
  //           "Please check your inbox and verify your email.",
  //           colorText: Colors.red,
  //         );
  //       }
  //     }
  // }
  


  Future<bool> loginUserWithEmailAndPassword(String email, String password) async {
    try {
      loading.value = true;
      await auth.signInWithEmailAndPassword(email: email, password: password);
      loading.value = false;
      Get.snackbar("Success", "Successfully login",
          colorText: Colors.blue,snackPosition:SnackPosition.TOP,duration: const Duration(seconds: 3));
      update();
      return true;
    } catch (e) {
      loading.value = false;
      Get.snackbar("Error", "Email or Password incorrect",snackPosition:SnackPosition.TOP,colorText: Colors.red, barBlur: 10.0,duration: const Duration(seconds: 3));
      return false;
    }
  }

  // Future<void> unlinkGoogleAccount() async {
  //   try {
  //     User? user = FirebaseAuth.instance.currentUser;
  //     if (user != null) {
  //       await user.unlink(GoogleAuthProvider.PROVIDER_ID);
  //       Get.snackbar("Success", "Successfully unlinked Google account", colorText: Colors.green, duration: Duration(seconds: 20));
  //     } else {
  //       Get.snackbar("Error", "No user is currently signed in", colorText: Colors.red, duration: Duration(seconds: 20));
  //     }
  //   } catch (e) {
  //     Get.snackbar("Error", "Failed to unlink Google account: $e", colorText: Colors.red, duration: Duration(seconds: 20));
  //   }
  // }

  // Future<void> sendEmailVerification() async {
  //   User? user = _auth.currentUser;

  //   if (user != null && !user.emailVerified) {
  //     await user.sendEmailVerification();;
  //   } else {
  //     Get.snackbar("Error", "Error user is not verified or is not login!",colorText: Colors.red);
  //   }
  // }

  Future<void> signout() async {
    try {
      await auth.signOut();
    } catch (e) {
      Get.snackbar("Error", "ERROR occurred, please try again", colorText: Colors.red, barBlur: 10.0);
    }
  }

   Future<void> createUser(UserModel user, String? uid) async {
     await userRepo.createUser(user,uid!);
   }
}