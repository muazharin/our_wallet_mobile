import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  void setLocalStorage() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.clear();
    Get.offAllNamed("/auth_login");
  }
}
