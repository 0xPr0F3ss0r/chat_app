import 'package:chat_app/const/routes.dart';
import 'package:chat_app/core/Midellaware/Midellware.dart';
import 'package:chat_app/view/ChatPages/HomeChat.dart';
import 'package:chat_app/view/ChatPages/chat.dart';
import 'package:chat_app/view/authentication/SignUp.dart';
import 'package:chat_app/view/authentication/login.dart';
import 'package:chat_app/view/authentication/resetPassword.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';


List<GetPage<dynamic>> routes = [
  GetPage(
    name: AppRoutes.login, page: ()=> LoginScreen(),middlewares: [Mymidellware()]),
  GetPage(
    name: AppRoutes.signup, page: ()=> Signup()),
  GetPage(name: AppRoutes.homechat, page: () => Homechat()),
  GetPage(name: AppRoutes.chatpage, page: () => Chat()),
  GetPage(name: AppRoutes.resetPassword, page: () => ResetPassword())
];