import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyServices extends GetxService{
  late SharedPreferences sharedpreferences;
  // instance of shared preferences
  Future<MyServices> init() async{
    //await Firebase.initializeApp();
    sharedpreferences = await SharedPreferences.getInstance();
    return this;
  }
}
// inject shared preferences when function called
initialServices() async{
 await Get.putAsync(() => MyServices().init());
}