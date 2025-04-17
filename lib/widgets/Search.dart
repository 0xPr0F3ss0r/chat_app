import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Search extends StatelessWidget {
  Function()? onPressed;
  TextEditingController? controller;
  Search({super.key,this.onPressed,this.controller});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        style: const TextStyle(color: Colors.white),
              controller: controller,
              decoration: InputDecoration(
                prefixIcon:  IconButton(onPressed: 
                  onPressed
                , icon:const Icon(Icons.search,color: Colors.grey,size: 30,)),
                hintText: "Search",
                hintStyle: const TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none
                ),
                filled: true,
                fillColor: Colors.grey.withOpacity(0.1),
                //hintText: hintText,
                //hintStyle: const TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide:BorderSide.none
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),

            ),
    );
  }
}