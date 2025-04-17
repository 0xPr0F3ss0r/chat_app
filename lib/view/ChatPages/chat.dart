import 'package:chat_app/controller/chatpages/chatPage.dart';
import 'package:chat_app/widgets/messageBubble.dart';
import 'package:chat_app/widgets/message_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class Chat extends StatelessWidget {
  Chatpage controller = Get.put(Chatpage());
  Chat({super.key});

  @override
  Widget build(BuildContext context) {
    dynamic data = Get.arguments;
    String email = data['email'];
    String avatar = data['avatar'];
    String fullName = data['fullName'];
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 3,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(
                avatar.toString().isEmpty
                    ? "https://i.pinimg.com/736x/55/80/5e/55805e4aa3c42e91d39d1e1fd2013e60.jpg"
                    : avatar,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fullName,
                  style: const TextStyle(fontSize: 16),
                ),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      "Online now",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
        child: Column(
          children: [
            const Divider(
              color: Colors.black26,
              height: 7,
              thickness: 2,
            ),
            Expanded(
              child: ListView(
                children: [
                  StreamBuilder(
                      stream: controller.GetMessage(email),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text("ERROR"),
                          );
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return Column(
                          children: [
                            Column(
                              children: snapshot.data!.docs.map((document) {
                                Map<String, dynamic> data =
                                    document.data() as Map<String, dynamic>;
                                return Messagebubble(
                                  message: data['message'] ?? "",
                                  email: data['senderEmail'],
                                  currentEmail: controller
                                      .Firebaseauth.currentUser!.email!,
                                  onLongPress: () {
                                    Get.bottomSheet(
                                      Container(
                                        padding: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                            color: Get.theme.cardColor,
                                            borderRadius: const BorderRadius.vertical(
                                                top: Radius.circular(20))),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.delete_outline,
                                                size: 48,
                                                color: Colors.red[400]),
                                            const SizedBox(height: 16),
                                            const Text(
                                              "Delete this message?",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            const SizedBox(height: 8),
                                            const Text(
                                              "This action cannot be undone",
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                            const SizedBox(height: 24),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Expanded(
                                                  child: OutlinedButton(
                                                    onPressed: () => Get.back(),
                                                    style: OutlinedButton
                                                        .styleFrom(
                                                            padding: const EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        16),
                                                            side: BorderSide(
                                                                color: Colors
                                                                    .grey
                                                                    .shade300)),
                                                    child: Text("CANCEL",
                                                        style: TextStyle(
                                                            color: Colors.grey
                                                                .shade700)),
                                                  ),
                                                ),
                                                const SizedBox(width: 16),
                                                Expanded(
                                                  child: ElevatedButton(
                                                      onPressed: () async{
                                                        await controller.DeleteMessage(data['message'], email);
                                                        Get.back();
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              backgroundColor:
                                                                  Colors
                                                                      .red[400],
                                                              padding: const EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          16)),
                                                      child: const Text("DELETE",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white))),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                                height:
                                                    MediaQuery.of(Get.context!)
                                                        .viewInsets
                                                        .bottom),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            )
                          ],
                        );
                      })
                ],
              ),
            ),
            MessageType(
              controller: controller.message,
              onPressed: () async {
                await controller.sendMessage(email, controller.message.text);
                controller.message.clear();
              },
            ),
          ],
        ),
      ),
    );
  }
}
