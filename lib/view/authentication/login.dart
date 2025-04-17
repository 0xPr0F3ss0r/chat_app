import 'package:chat_app/const/routes.dart';
import 'package:chat_app/controller/authentication/loginController.dart';
import 'package:chat_app/view/authentication/resetPassword.dart';
import 'package:chat_app/widgets/TextButton.dart';
import 'package:chat_app/widgets/authButton.dart';
import 'package:chat_app/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  Logincontroller controller  = Get.put(Logincontroller());
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
            Positioned(
              top: 180,
              child: Image.asset("assets/authentication/logo.JPG",
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.2,
              ),
            ),
             Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.615,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(90),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  )
                ),
                child:  Obx(()
                  => controller.loading.value?const Center(child: CircularProgressIndicator(),): Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                       children: [
                       const SizedBox(height: 50,),
                        const Text("Login",style: TextStyle(color: Colors.black,fontSize: 30),),
                        const SizedBox(height: 20,),
                        Textfield(text: "Email",controller: controller.emailcontroller,),
                        const SizedBox(height:5),
                        Textfield(text: "Password",controller: controller.passwordcontroller,),
                        Padding(
                          padding: const EdgeInsets.only(left: 160),
                          child: TextButton(onPressed: (){
                            Get.to(ResetPassword());
                          },child: Text(textAlign: TextAlign.end,"Forget Password",style: TextStyle(color: Colors.blue),),),
                        ),
                        const SizedBox(height: 1,),
                        Authbutton(buttomName: "Login", onPressed: () {controller.onLogin();},),
                        const SizedBox(height: 5,),
                        TextbuttonLogin(onTap: (){
                          Get.toNamed(AppRoutes.signup);
                        })
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