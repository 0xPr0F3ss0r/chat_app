import 'package:chat_app/const/routes.dart';
import 'package:chat_app/controller/authentication/signupController.dart';
import 'package:chat_app/widgets/TextButton.dart';
import 'package:chat_app/widgets/authButton.dart';
import 'package:chat_app/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

// ignore: must_be_immutable
class Signup extends StatelessWidget {
  Signupcontroller controller = Get.put(Signupcontroller());
  Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
            alignment: Alignment.bottomCenter,
          children: [
            Image.asset("assets/authentication/background.JPG",
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            const Positioned(
              top: 50,
              child: Text("Sign Up",style: 
              TextStyle(
                color: Colors.white,
                fontSize: 30
              ),)
            ),
             Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.80,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(90),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  )
                ),
                child:  Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SingleChildScrollView(
                    child: Column(
                       children: [
                        const SizedBox(height: 30,),
                        Textfield(text: "First name",controller: controller.firstNameController),
                        const SizedBox(height:5),
                        Textfield(text: "Last name",controller: controller.lastNameController),
                        const SizedBox(height: 5,),
                        Textfield(text: "E-mail",controller: controller.emailController),
                        const SizedBox(height:5),
                        Textfield(text: "Password",controller: controller.passwordController),
                        const SizedBox(height:5),
                        Textfield(text: "Confirm password",controller: controller.confirmPasswordController),
                        const SizedBox(height:5),
                        Authbutton(buttomName: "Sign Up", onPressed: () {controller.OnSignUp();},),
                        const SizedBox(height: 15,),
                        TextbuttonSignup(onTap:(){
                          Get.toNamed(AppRoutes.login);
                        },)
                       ],
                    ),
                  ),
                ),
              ),
            
          ],
        ),
      ),
    );
  }
}