import 'package:flutter_zebra_emdk/src/data/models/product_model.dart';
import 'package:flutter_zebra_emdk/src/repositories/product_repository.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final localStorage = GetStorage();
  final productRepository = Get.put(ProductRepository());

  Future<ProductModel> getProductByCode({required String code}) async {
    try {
      String token = localStorage.read('TOKEN');
      String url = localStorage.read('APIURL');

      final product =
          await productRepository.get(code: code, token: token, url: url);
      return product;
    } catch (e) {
      return ProductModel(name: 'Este codigo de producto no existe.');
    }
  }
}
