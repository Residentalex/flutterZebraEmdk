import 'package:flutter_zebra_emdk/src/presentation/config_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../presentation/home_screen.dart';
import '../presentation/login_screen.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();
  final localStorage = GetStorage();

  @override
  void onReady() {
    screenRedirect();
  }

  screenRedirect() {
    String token = localStorage.read('TOKEN') ?? '';
    String apiURL = localStorage.read('APIURL') ?? '';
    bool isFirstTime = localStorage.read('ISFIRSTTIME') ?? true;

    if (isFirstTime) {
      Get.offAll(() => ConfigScreen(isFirtTime: true));
    } else if (token == '' || apiURL == '') {
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => HomeScreen());
    }
  }
}
