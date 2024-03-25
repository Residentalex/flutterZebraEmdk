import 'package:flutter_zebra_emdk/src/controllers/product_controller.dart';
import 'package:flutter_zebra_emdk/src/controllers/user_controller.dart';
import 'package:get/get.dart';

class GeneralBindigns extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthenticationController());
    Get.put(ProductController());
  }
}
