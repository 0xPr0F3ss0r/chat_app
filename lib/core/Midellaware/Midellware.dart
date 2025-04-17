import 'package:chat_app/const/routes.dart';
import 'package:chat_app/core/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Mymidellware extends GetMiddleware {
   MyServices myServices = Get.find();
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    final step = myServices.sharedpreferences.getString("step");

    // Check the step and current route to avoid redundant navigation
    if ((step == null|| step == "login") && route != AppRoutes.login) {
      return const RouteSettings(name: AppRoutes.login);
    }
    if (step == "home" && route != AppRoutes.homechat) {
      return const RouteSettings(name: AppRoutes.homechat);
    }
    return null;
  }
}