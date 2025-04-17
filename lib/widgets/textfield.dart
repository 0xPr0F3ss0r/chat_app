import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Textfield extends StatelessWidget {
  String? text;
  TextEditingController? controller;
  Textfield({required this.text,this.controller,super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(text!,textAlign:TextAlign.start,style: const TextStyle(color: Colors.black,fontSize: 15),),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.black,
                  width: 0.7,
                ),
              ),
              filled: true,
              fillColor: Colors.white,
              //hintText: hintText,
              //hintStyle: const TextStyle(color: Colors.black),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:const  BorderSide(
                  color: Colors.black,
                  width: 0.5,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
          ),
        ],
      ),
    );
  }
}