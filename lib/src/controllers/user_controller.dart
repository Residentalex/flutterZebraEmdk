import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:flutter_zebra_emdk/src/routes/app_routes.dart';
import 'package:flutter_zebra_emdk/src/widget/toast/loaders.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../repositories/user_repositories.dart';

class AuthenticationController extends GetxController {
  static AuthenticationController get instance => Get.find();

  final localStorage = GetStorage();
  var userRepository = UserRepository.instance;
  TextEditingController tokenController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  @override
  void onReady() {
    tokenController.text = localStorage.read('TOKEN') ?? '';
    urlController.text = localStorage.read('APIURL') ?? '';
  }

  Future<String?> authUser(LoginData data) async {
    try {
      String password = localStorage.read('PASSWORD');
      String username = localStorage.read('USERNAME');

      if (password == data.password && username == data.name) {
        return Future.delayed(Duration.zero).then((_) {
          return null;
        });
      } else {
        return 'La clave de acceso o el usuario no es correcto';
      }
    } catch (e) {
      return e.toString();
    }
  }

  void setConfig() {
    try {
      bool isFirstTime = localStorage.read('ISFIRSTTIME') ?? true;

      if (isFirstTime) localStorage.write('PASSWORD', passwordController.text);

      localStorage.write('TOKEN', tokenController.text);
      localStorage.write('APIURL', urlController.text);
      localStorage.write('USERNAME', 'admin');
      localStorage.write('ISFIRSTTIME', false);
      localStorage.save();

      TLoaders.successSnackBar(title: "Actualizacion completada");
      Get.toNamed(AppRoutes.home);
    } catch (e) {
      TLoaders.errorSnackBar(title: "Verifique los datos suministrados");
    }
  }
}