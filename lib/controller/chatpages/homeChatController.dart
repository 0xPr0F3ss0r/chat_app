import 'dart:io';
import 'package:chat_app/const/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:quickalert/models/quickalert_type.dart';

//import 'package:quickalert/widgets/quickalert_dialog.dart';
class Homechatcontroller extends GetxController {
  List<Map<String, dynamic>> messages = [];
  RxMap<dynamic, dynamic> last_message = {}.obs;
  RxMap<dynamic, dynamic> time = {}.obs;
  RxList<dynamic> users = [].obs;
  List<Map<String, dynamic>> userInfo = [];
  TextEditingController search = TextEditingController();
  String? downloadUrl;
  String? Image;
  RxBool loading = false.obs;
  final db = FirebaseFirestore.instance;
  final Firebaseauth = FirebaseAuth.instance;
  @override
  void onInit() async {
    await GetUserInfo();
    await GetAllUsers();
    await GetLastMessages(users.cast<Map<String, dynamic>>());
    await GetLastMessage(users.cast<Map<String, dynamic>>());
    getTime(messages);
    super.onInit();
  }

  Future<void> Search() async {
    try {
      loading.value = true;
      // Create a filtered list (assuming `users` is a global list)
      final List<Map<String, dynamic>> filteredUsers = users
          .where((user) => user['fullName'].toString().contains(search.text))
          .toList()
          .cast<Map<String, dynamic>>();
      // Update the list (if needed)
      users.clear();
      users.addAll(filteredUsers);

      loading.value = false;
    } catch (e) {
      Get.snackbar("Error", "Try again..!",
          snackPosition: SnackPosition.TOP, snackStyle: SnackStyle.FLOATING);
      loading.value = false;
    }
  }

  Future<void> OnExit() async {
    try {
      SharedPreferences sharedpreferences =
          await SharedPreferences.getInstance();
      sharedpreferences.setString("step", "login");
      Get.toNamed(AppRoutes.login);
      Get.snackbar("info", "you have exit the app", colorText: Colors.blue);
      await UpdateStatus();
    } catch (e) {
      Get.snackbar("error", "error login , try again please ..",
          snackPosition: SnackPosition.TOP);
    }
  }

  Future<void> UpdateStatus() async {
    await db
        .collection("users")
        .doc(Firebaseauth.currentUser!.uid)
        .update({"status": false});
  }

  Future<void> GetAllUsers() async {
    users.clear();
    try {
      loading.value = true;
      await db
          .collection("users")
          .get()
          .then((QuerySnapshot<Map<String, dynamic>> snapshot) {
        for (var doc in snapshot.docs) {
          final data = doc.data();
          Map<String, dynamic> Data = {
            "avatar": data['avatar'],
            "firstName": data['firstName'],
            "secondName": data['secondName'],
            "email": data['email'],
            "fullName": data['fullName'],
            "status": data['status']
          };
          users.add(Data);
          loading.value = false;
        }
      });
    } catch (e) {
      Get.snackbar("error", "try again..!",
          snackPosition: SnackPosition.TOP, snackStyle: SnackStyle.FLOATING);
      loading.value = false;
    }
    users.removeWhere(
        (element) => element['email'] == Firebaseauth.currentUser!.email);
  }

  Future<void> GetAllUsersOrdered() async {
    try {
      loading.value = true;
      users.clear();

      // First get all users
      final snapshot = await db.collection("users").get();

      // Then sort them locally based on last message time
      final sortedUsers = snapshot.docs
          .map((doc) {
            final data = doc.data();
            if (data['email'] == Firebaseauth.currentUser!.email) {
              return null; // Skip the current user
            }
            return {
              "avatar": data['avatar'],
              "firstName": data['firstName'],
              "secondName": data['secondName'],
              "email": data['email'],
              "fullName": data['fullName'],
              "status": data['status']
            };
          })
          .where((user) => user != null)
          .toList();

      // Sort by last message time (if available)
      sortedUsers.sort((a, b) {
        final timeA = messages.firstWhere(
          (msg) => msg['email'] == a!['email'],
          orElse: () => {'time': Timestamp(0, 0)},
        )['time'] as Timestamp;

        final timeB = messages.firstWhere(
          (msg) => msg['email'] == b!['email'],
          orElse: () => {'time': Timestamp(0, 0)},
        )['time'] as Timestamp;

        return timeB.compareTo(timeA);
      });

      users.assignAll(sortedUsers);
      loading.value = false;
    } catch (e) {
      loading.value = false;
      Get.snackbar("Error", "Failed to load users: ${e.toString()}");
    }
    users.removeWhere(
        (element) => element['email'] == Firebaseauth.currentUser!.email);
  }

  Future<void> GetUserInfo() async {
    loading.value = true;
    userInfo.clear();
    final snapshot =
        await db.collection("users").doc(Firebaseauth.currentUser!.uid).get();
    if (snapshot.exists) {
      final Map<String, dynamic>? data = snapshot.data();
      userInfo.add(data!);
    }
    loading.value = false;
  }

  Future<void> GetLastMessages(List<Map<String, dynamic>> usersList) async {
    messages.clear();
    for (int i = 0; i < usersList.length; i++) {
      String email = usersList[i]['email'];
      final userEmail = Firebaseauth.currentUser!.email;
      List chatId = [
        userEmail.toString().replaceFirst(RegExp(r'@gmail.com'), '012'),
        email.toString().replaceFirst(RegExp(r'@gmail.com'), '012')
      ];
      chatId.sort();
      final snapshot = await db
          .collection('chat')
          .doc(chatId.join("*"))
          .collection('messages')
          .orderBy("timestamp", descending: false)
          .get();
      if (snapshot.docs.isNotEmpty) {
        final data = snapshot.docs.map((doc) => doc.data()).toList().last;
        Map<String, dynamic> messages_data = {
          "email": data['receiverId'],
          "message": data["message"],
          "time": data['timestamp']
        };
        messages.add(messages_data);
      }
    }
  }

  Future<void> GetLastMessage(List<Map<String, dynamic>> data) async {
    last_message.clear();
    int index = 0;
    for (var user in data) {
      last_message[user['email']] = messages[index]['message'];
      index += 1;
    }
    await GetAllUsersOrdered();
  }

  void getTime(List<Map<String, dynamic>> data) {
    try {
      time.clear();
      for (var messages in data) {
        Timestamp timestamp = messages['time'];
        int microseconds = timestamp.microsecondsSinceEpoch;
        DateTime utcDateTime =
            DateTime.fromMicrosecondsSinceEpoch(microseconds, isUtc: true);
        DateTime utcMinus11 = utcDateTime.subtract(const Duration(hours: 11));
        String formattedTime = DateFormat('h:mm a').format(utcMinus11);
        String message_time = formattedTime.contains("PM")?formattedTime.replaceFirst(RegExp(r'PM'), ''):formattedTime.replaceFirst(RegExp(r'AM'), '');
        time[messages['email']] = message_time;
      }
    } catch (e) {
      Get.snackbar("error", "error get time message",colorText: Colors.red);
    }
  }

  Future<void> pickImageFromGallery(BuildContext context) async {
    await _pickImage(ImageSource.gallery, context);
  }

  Future<void> pickImageFromCamera(BuildContext context) async {
    await _pickImage(ImageSource.camera, context);
  }

  Future<void> _pickImage(ImageSource source, BuildContext context) async {
    try {
      final returnImage = await ImagePicker().pickImage(source: source);
      if (returnImage == null) return;
      Image = returnImage.path;
      await uploadImageToStorageAndFirestore(context);
      Get.back();
    } catch (e) {
      Get.snackbar("error", "error change picture , try again later",colorText: Colors.red);
    }
  }

  Future<void> uploadImageToStorageAndFirestore(BuildContext context) async {
    if (Image == null) {
      Get.snackbar("Error", "No image selected.",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    try {
      final storageRef = FirebaseStorage.instance.ref().child(
          "profile_pictures/${FirebaseAuth.instance.currentUser!.uid}.jpg");
      try {
        TaskSnapshot snapshot = await storageRef.putFile(File(Image!));
        downloadUrl = await snapshot.ref.getDownloadURL();
      } catch (e) {
        Get.snackbar("Error", "Error uploading image ,please try again!",
            colorText: Colors.red);
      }

      Image = downloadUrl; // Assign the download URL to selectedImage
      await updateUserAvatarInFirestore();
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        text: "Image uploaded successfully!",
        title: 'Success',
        autoCloseDuration: const Duration(seconds: 5),
        showConfirmBtn: false,
      );
    } catch (e) {
      Get.snackbar("Error", "Error uploading image ,please try again!",
          colorText: Colors.red);
    }
  }

  Future<void> updateUserAvatarInFirestore() async {
    QuerySnapshot querySnapshot = await db
        .collection("users")
        .where("Email", isEqualTo: userInfo[0]['email'])
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      String UID = Firebaseauth.currentUser!.uid;

      // Update the user's document in Firestore with the new avatar URL
      await db
          .collection('users')
          .doc(UID)
          .update({'avatar': Image}); // Save download URL to Firestore
    } else {
      Get.snackbar("Error", "No information found for this email.",
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
