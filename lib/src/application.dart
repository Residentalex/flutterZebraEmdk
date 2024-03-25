import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bindings/general_binding.dart';
import 'routes/app_routes.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Reader',
      debugShowCheckedModeBanner: false,
      initialBinding: GeneralBindigns(),
      initialRoute: AppRoutes.home,
      getPages: AppRoutes.pages,
    );
  }
}
