import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MessageType extends StatelessWidget {
  void Function()? onPressed;
  TextEditingController? controller;
  MessageType({super.key,this.onPressed,this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              constraints: const BoxConstraints(
                maxHeight: 120, 
              ),
              child: TextField(
                controller: controller,
                maxLines: null, // Allows unlimited lines
                minLines: 1, // Starts with one line
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  hintText: "Type your message...",
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                //onSubmitted: (_) => _sendMessage(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            //onTap: _hasText ? _sendMessage : null,
            child: Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                //color: _hasText ? Colors.blue : Colors.blue.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child:  IconButton(
                onPressed:onPressed,
                icon:Icon(Icons.send),
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}