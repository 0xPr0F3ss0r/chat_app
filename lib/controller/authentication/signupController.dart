import 'package:chat_app/const/routes.dart';
import 'package:chat_app/core/auth_services.dart';
import 'package:chat_app/core/users/user_repository.dart';
import 'package:chat_app/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Signupcontroller extends GetxController{
  final Auth = Get.put(AuthService());
  final userRepo = Get.put(UserRepository());
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;
  RxBool accountCreated = false.obs;
  RxBool loading = false.obs;
  @override
  void onInit() {
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.onInit();
  }
  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  Future<void> OnSignUp() async {
    if(firstNameController.text.isEmpty && lastNameController.text.isEmpty && emailController.text.isEmpty && passwordController.text.isEmpty && confirmPasswordController.text.isEmpty){
      Get.snackbar("Error", "Please fill all the fields", colorText: Colors.red, duration: const Duration(seconds: 2));
    }else if(passwordController.text != confirmPasswordController.text){
      Get.snackbar("Error", "Passwords do not match", colorText: Colors.red, duration: const Duration(seconds: 2));
    }else{
      loading.value =  Auth.userRepo.loading.value;
     final User? user = await Auth.createUserWithEmailAndPassword(emailController.text, passwordController.text);
     if(user != null){
      final USER = UserModel(
        email:emailController.text.trim(),
        firstName: firstNameController.text.trim(),
        secondName: lastNameController.text.trim(),
        fullName: "${firstNameController.text} ${lastNameController.text}",
        avatar: ""
      );
      String uid = user.uid;
      await Auth.createUser(USER, uid);
      loading.value =  Auth.userRepo.loading.value;
      accountCreated.value = Auth.userRepo.isUserCreated.value;
      if(accountCreated.value == true){
        Get.toNamed(AppRoutes.login);
      }
  }
    Get.snackbar("Error", "ERROR occurred when create user, please try again", colorText: Colors.red, barBlur: 10.0);
    }
  }
}