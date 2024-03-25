import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'src/application.dart';
import 'src/repositories/user_repositories.dart';

Future<void> main() async {
  await GetStorage.init();
  Get.put(UserRepository());

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Application();
  }
}
