import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Authbutton extends StatelessWidget {
  void Function()? onPressed;
  String? buttomName;
  Authbutton({required this.onPressed,this.buttomName,super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 400,
        decoration: BoxDecoration(color: Colors.black,
        borderRadius: BorderRadius.circular(15)),
        child: MaterialButton(onPressed: onPressed,
        child:Text(textAlign: TextAlign.center,buttomName!,style: const TextStyle(color: Colors.white,fontSize: 20),)),
      ),
    );
  }
}