import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zebra_emdk/src/utils/constants/image_string.dart';
import 'package:flutter_zebra_emdk/src/utils/validators/validation.dart';
import 'package:get/get.dart';

import '../controllers/user_controller.dart';
import '../routes/app_routes.dart';
import '../widget/custom_elevated_button.dart';
import '../widget/text_field_section.dart';

import 'dart:io' show Platform, exit;

class ConfigScreen extends StatelessWidget {
  const ConfigScreen({Key? key, this.isFirtTime = false}) : super(key: key);

  final bool isFirtTime;

  @override
  Widget build(BuildContext context) {
    var controller = AuthenticationController.instance;
    var _formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(20.00),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Image(
                  height: 40,
                  image: AssetImage(TImages.logoSoluweb),
                  fit: BoxFit.fitHeight),
              const SizedBox(
                height: 20,
              ),
              TextFieldSection(
                controller: controller.userController,
                label: "Nombre de Usuario",
                hint: "Digite la nombre de usuario",
                validator: (value) =>
                    TValidator.validateEmptyText('nombre de usuario', value),
                inputType: TextInputType.visiblePassword,
                readOnly: true,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldSection(
                controller: controller.passwordController,
                label: "Contraseña Maestra",
                hint: "Digite la contraseña Maestra",
                validator: (value) => TValidator.validatePassword(value),
                inputType: TextInputType.visiblePassword,
              ),
              SizedBox(
                height: isFirtTime ? 40 : 20,
              ),
              TextFieldSection(
                controller: controller.tokenController,
                label: "Token",
                hint: "Digite el Token de la API",
                validator: (value) =>
                    TValidator.validateEmptyText('Token', value),
                inputType: TextInputType.name,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldSection(
                controller: controller.urlController,
                label: "ApiURL",
                hint: "Digite el URL de la API",
                validator: (value) =>
                    TValidator.validateEmptyText('URL', value),
                inputType: TextInputType.name,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.maxFinite,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: CustomElevatedButton(
                      buttonName: "Actualizar",
                      showToast: () {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        } else {
                          controller.setConfig();
                        }
                      }),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: CustomElevatedButton(
                      buttonName: "Cancelar",
                      showToast: () {
                        Get.toNamed(AppRoutes.home);
                      }),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: CustomElevatedButton(
                      buttonName: "Salir",
                      showToast: () {
                        if (Platform.isAndroid) {
                          SystemNavigator.pop();
                        } else if (Platform.isIOS) {
                          exit(0);
                        }
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
