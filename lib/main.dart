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
      apiKey: 'AIzaSyClWNRExqIGtz8UwpiPYEIk4QnAJCOTP9g',
      appId: '1:973328440753:android:09ca9cb6dd6d54d40eb190',
      messagingSenderId: '973328440753',
      projectId: 'chatapp-e6660',
    ),
  );
    }else{
      await Firebase.initializeApp();
    }
  }
  
  // if(Firebase.apps.isEmpty){
  //   await initialServices();
  // }else{
  //   await Firebase.initializeApp();
  // }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
