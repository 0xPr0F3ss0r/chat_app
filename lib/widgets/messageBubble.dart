import 'package:flutter/material.dart';

class Messagebubble extends StatelessWidget {
  final String message;
  final String email;
  final String currentEmail;
  final  Function()? onLongPress;
  const Messagebubble({super.key,required this.message,required this.onLongPress,required this.email, required this.currentEmail});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Align(
        alignment: email==currentEmail?Alignment.centerRight: Alignment.centerLeft,
        child: GestureDetector(
          onLongPress: onLongPress,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(children:[ Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                message,
                style:const  TextStyle(color: Colors.white,fontSize: 20),),
            )]),
          ),
        ),
      ),
    );
  }
}