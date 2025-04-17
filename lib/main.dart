//import 'package:chat_app/core/services/services.dart';
import 'dart:io';

import 'package:chat_app/const/routes.dart';
import 'package:chat_app/core/services/services.dart';
import 'package:chat_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(Firebase.apps.isEmpty){
    await initialServices();
    if(Platform.isAndroid){
      await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'you api key',
      appId: 'your app id in firbase',
      messagingSenderId: 'sender id from your google service.json',
      projectId: 'firebase project id',
    ),
  );
    }else{
      await Firebase.initializeApp();
    }
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      getPages: routes,
      initialRoute:AppRoutes.login,
    );
  }
}
