import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextbuttonLogin extends StatelessWidget {
  void Function()? onTap;
  TextbuttonLogin({this.onTap,super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: const Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: "Don't have an account?",
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
              ),
            ),
            TextSpan(
              text: " Sign up",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 15,
              ),
            ),
          ]
        )
      ),
    );
  }
}

// ignore: must_be_immutable
class TextbuttonSignup extends StatelessWidget {
  void Function()? onTap;
  TextbuttonSignup({this.onTap,super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: "Already have any account?",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            TextSpan(
              text: "Sign in",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ]
        )
      ),
    );
  }
}