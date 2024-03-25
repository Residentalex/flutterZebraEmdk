import 'package:get/get.dart';

import '../presentation/config_screen.dart';
import '../presentation/home_screen.dart';
import '../presentation/login_screen.dart';

class AppRoutes {
  static const String login = "/login";
  static const String home = "/home";
  static const String config = "/config";

  static final List<GetPage> pages = [
    GetPage(name: login, page: () => LoginScreen()),
    GetPage(name: home, page: () => HomeScreen()),
    GetPage(name: config, page: () => const ConfigScreen()),
  ];
}
