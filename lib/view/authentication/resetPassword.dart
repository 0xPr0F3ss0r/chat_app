import 'package:chat_app/const/routes.dart';
import 'package:chat_app/controller/authentication/resetPasswordController.dart';
import 'package:chat_app/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({super.key});
  final rsetpasswordcontroller controller = Get.put(rsetpasswordcontroller());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            // Background Decoration
         
            
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  
                  // Back Button
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 28),
                      onPressed: () {
                        Get.toNamed(AppRoutes.login);
                        controller.onclear();
                      },
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Title
                  Text(
                    "Reset Password",
                    style: TextStyle(
                      color: Colors.blue[200],
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                      letterSpacing: 1.2,
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Subtitle
                  Text(
                    "Enter your email to receive a password reset link",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 16,
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Email Input Field
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Textfield(text: "Email",controller: controller.email,),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Reset Password Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                          controller.resetPassword(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[700],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 5,
                        shadowColor: Colors.blue.withOpacity(0.4),
                      ),
                      child: const Text(
                        "SEND RESET LINK",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          letterSpacing: 1.1,
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // Additional Help Text
                  TextButton(
                    onPressed: () {
                      // Add support contact action
                    },
                    child: Text(
                      "Need help? Contact support",
                      style: TextStyle(
                        color: Colors.blue[300],
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}