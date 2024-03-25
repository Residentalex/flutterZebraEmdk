import 'package:flutter/material.dart';
import 'package:flutter_zebra_emdk/src/utils/validators/validation.dart';

import '../controllers/user_controller.dart';
import '../widget/custom_app_bar.dart';
import '../widget/custom_elevated_button.dart';
import '../widget/text_field_section.dart';

class ConfigScreen extends StatelessWidget {
  const ConfigScreen({Key? key, this.isFirtTime = false}) : super(key: key);

  final bool isFirtTime;

  @override
  Widget build(BuildContext context) {
    var controller = AuthenticationController.instance;
    var _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: CustomAppBar(navigateName: "Configuracion")),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              if (isFirtTime)
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
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: TextFieldSection(
                      controller: controller.imageController,
                      label: "Imagen",
                      hint: "URL de la imagen",
                      readOnly: true,
                      validator: (value) =>
                          TValidator.validateEmptyText('URL', value),
                      inputType: TextInputType.name,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: TextButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.upload),
                        label: Text('Buscar')),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.maxFinite,
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
            ],
          ),
        ),
      ),
    );
  }
}
