import 'package:chat_app/const/routes.dart';
import 'package:chat_app/controller/chatpages/homeChatController.dart';
import 'package:chat_app/widgets/Search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class Homechat extends StatelessWidget {
  Homechatcontroller controller = Get.put(Homechatcontroller());
  Homechat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(
        () => controller.loading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                color: Colors.blue,
                onRefresh: () async {
                  await controller.GetAllUsers();
                  await controller.GetLastMessages(
                      controller.users.cast<Map<String, dynamic>>());
                  await controller.GetLastMessage(
                      controller.users.cast<Map<String, dynamic>>());
                  controller
                      .getTime(controller.messages);
                },
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Text(
                              "Messages",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            const SizedBox(
                              width: 115,
                            ),
                            Stack(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.defaultDialog(
                                      title: 'Update Profile',
                                      titleStyle: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.1,
                                      ),
                                      backgroundColor:
                                          Colors.grey[900]!.withOpacity(0.95),
                                      radius: 16,
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.account_circle,
                                            size: 60,
                                            color: Colors.blueAccent,
                                          ),
                                          const SizedBox(height: 16),
                                          Text(
                                            "Change profile picture?",
                                            style: TextStyle(
                                              color:
                                                  Colors.white.withOpacity(0.9),
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                      confirm: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blueAccent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 24, vertical: 14),
                                          elevation: 2,
                                        ),
                                        onPressed: () {
                                          Get.back();
                                          Get.bottomSheet(
                                            Container(
                                              height: 280,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[850],
                                                borderRadius: const BorderRadius.only(
                                                  topLeft: Radius.circular(24),
                                                  topRight: Radius.circular(24),
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.3),
                                                    blurRadius: 15,
                                                    spreadRadius: 5,
                                                  ),
                                                ],
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(20),
                                                child: Column(
                                                  children: [
                                                    const Text(
                                                      'Select Option',
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 24),
                                                    // Gallery Button
                                                    SizedBox(
                                                      width: double.infinity,
                                                      child:
                                                          ElevatedButton.icon(
                                                        onPressed: () {
                                                          controller
                                                              .pickImageFromGallery(
                                                                  context);
                                                          Get.back();
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              Colors.blueGrey[
                                                                  800],
                                                          padding: const EdgeInsets
                                                              .symmetric(
                                                                  vertical: 16),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                          ),
                                                          elevation: 1,
                                                        ),
                                                        icon: const Icon(
                                                            Icons.photo_library,
                                                            color: Colors
                                                                .blueAccent),
                                                        label: const Text(
                                                          'Choose from Gallery',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 12),
                                                    // Camera Button
                                                    SizedBox(
                                                      width: double.infinity,
                                                      child:
                                                          ElevatedButton.icon(
                                                        onPressed: () {
                                                          controller
                                                              .pickImageFromCamera(
                                                                  context);
                                                          Get.back();
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              Colors.blueGrey[
                                                                  800],
                                                          padding: const EdgeInsets
                                                              .symmetric(
                                                                  vertical: 16),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                          ),
                                                          elevation: 1,
                                                        ),
                                                        icon: const Icon(
                                                            Icons.camera_alt,
                                                            color: Colors
                                                                .tealAccent),
                                                        label: const Text(
                                                          'Take a Photo',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 16),
                                                    Divider(
                                                        color: Colors.grey[700],
                                                        height: 1),
                                                    const SizedBox(height: 12),
                                                    // Close Button
                                                    TextButton(
                                                      onPressed: Get.back,
                                                      child: Text(
                                                        'Cancel',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          color:
                                                              Colors.grey[400],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            isScrollControlled: true,
                                            enterBottomSheetDuration:
                                                const Duration(milliseconds: 250),
                                          );
                                        },
                                        child: const Text(
                                          "CONTINUE",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                      ),
                                      cancel: TextButton(
                                        onPressed: Get.back,
                                        child: Text(
                                          "NOT NOW",
                                          style: TextStyle(
                                            color: Colors.grey[400],
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      contentPadding: const EdgeInsets.all(20),
                                    );
                                  },
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: Image.network(
                                        "https://i.pinimg.com/736x/de/c3/74/dec37423af3c95e0400223801a5e50d2.jpg",
                                        fit: BoxFit.cover,
                                        height: 50,
                                        width: 50,
                                      )),
                                ),
                                Positioned(
                                    bottom: 2,
                                    right: 2,
                                    child: Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                          color: controller.userInfo[0]
                                                  ['status']
                                              ? Colors.green
                                              : Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                    ))
                              ],
                            ),
                            const SizedBox(
                              width: 13,
                            ),
                            IconButton(
                                onPressed: () {
                                  Get.defaultDialog(
                                    title: 'Confirm Exit',
                                    titleStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.2,
                                    ),
                                    backgroundColor:
                                        Colors.grey[900]!.withOpacity(0.9),
                                    radius: 15,
                                    content: Column(
                                      children: [
                                        const Icon(
                                          Icons.exit_to_app,
                                          size: 50,
                                          color: Colors.redAccent,
                                        ),
                                        const SizedBox(height: 20),
                                        Text(
                                          "Are you sure you want to exit?",
                                          style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.9),
                                            fontSize: 16,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 25),
                                      ],
                                    ),
                                    confirm: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.redAccent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 12),
                                        elevation: 2,
                                      ),
                                      onPressed: () {
                                        Get.back();
                                        controller.OnExit();
                                      },
                                      child: const Text(
                                        "EXIT",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                    ),
                                    cancel: TextButton(
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.blueAccent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 12),
                                      ),
                                      onPressed: () => Get.back(),
                                      child: const Text(
                                        "CANCEL",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.all(20),
                                    barrierDismissible: false,
                                  );
                                },
                                icon: const Icon(Icons.exit_to_app,
                                    color: Colors.red, size: 30))
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(children: [
                          Search(
                            controller: controller.search,
                            onPressed: () {
                              controller.Search();
                            },
                          )
                        ]),
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: controller.users.length,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: GestureDetector(
                                onTap: () => Get.toNamed(AppRoutes.chatpage,
                                    arguments: controller.users[index]),
                                child: Container(
                                  width: 150,
                                  height: 80,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.05),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: ListTile(
                                    trailing: Obx(
                                      () => Text(
                                        controller.time[controller.users[index]
                                                ['email']] ??
                                            "",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                    subtitle: Obx(
                                      () => Text(
                                        controller.last_message[controller
                                                .users[index]['email']] ??
                                            "",
                                        style: const TextStyle(
                                            color: Colors.white54),
                                      ),
                                    ),
                                    title: Text(
                                      controller.users[index]['fullName'],
                                      style: const TextStyle(
                                          color: Colors.white54),
                                    ),
                                    leading: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          child: Image.network(
                                            controller.users[index]['avatar']
                                                    .toString()
                                                    .isEmpty
                                                ? "https://i.pinimg.com/736x/07/66/d1/0766d183119ff92920403eb7ae566a85.jpg"
                                                : controller.users[index]
                                                    ['avatar'],
                                            fit: BoxFit.cover,
                                            height: 50,
                                            width: 50,
                                          ),
                                        ),
                                        Positioned(
                                            bottom: 2,
                                            right: 2,
                                            child: Container(
                                              width: 10,
                                              height: 10,
                                              decoration: BoxDecoration(
                                                  color: controller.users[index]
                                                          ['status']
                                                      ? Colors.green
                                                      : Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
      ),
    );
  }
}
