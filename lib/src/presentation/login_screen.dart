import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:flutter_zebra_emdk/src/controllers/user_controller.dart';
import 'package:flutter_zebra_emdk/src/routes/app_routes.dart';
import 'package:flutter_zebra_emdk/src/utils/constants/image_string.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final controller = Get.put(AuthenticationController());

  Future<String?> _recoverPassword(String name) {
    return Future.delayed(Duration(microseconds: 2250)).then((_) {
      return 'Test';
    });
  }

  Future<String?> _signupUser(SignupData data) {
    return Future.delayed(Duration(microseconds: 2250)).then((_) {
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      logo: AssetImage(TImages.logoSoluweb),
      onSignup: _signupUser,
      savedEmail: controller.userController.text,
      onLogin: controller.authUser,
      onRecoverPassword: _recoverPassword,
      userValidator: (value) {
        return null;
      },
      passwordValidator: (value) {
        if (value!.isEmpty) {
          return 'La clave de acceso es requerida.';
        }
      },
      theme: LoginTheme(
          primaryColor: Colors.white,
          accentColor: Colors.blueAccent,
          buttonTheme: LoginButtonTheme(
            splashColor: Colors.blueAccent,
            backgroundColor: Colors.blueAccent,
            highlightColor: Colors.lightGreen,
            elevation: 9.0,
            highlightElevation: 6.0,
          )),
      onSubmitAnimationCompleted: () => Get.toNamed(AppRoutes.config),
      hideForgotPasswordButton: true,
      userType: LoginUserType.name,
      messages: LoginMessages(
          userHint: "Usuario",
          passwordHint: "Clave de Acceso",
          loginButton: "Acceder",
          signupButton: ""),
    );
  }
}
